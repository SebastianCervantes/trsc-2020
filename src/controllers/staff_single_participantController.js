const controller = {};
const Cart = require('../models/cart');
var dateFormat = require('dateformat');
var date = dateFormat("isoDate") + 'T' + dateFormat("isoTime");

controller.list = (req, res) => {

    //Obtiene Id
    const persona = req.params.persona;

    //Id se ingresa en el carrito
    var cart = new Cart(req.session.cart ? req.session.cart : {});
    cart.remove();
    cart.add(persona);
    req.session.cart = cart;

    if (cart.keyCheck()){
    //Se renderiza la pagina con las consultas realizadas
        req.getConnection((err, conn) =>{
            conn.query('CALL datos_usuario(?); CALL selecciona_visita(); CALL selecciona_taller()',[persona], (err, data) =>{
                if(err){
                    res.json(err);
                    console.log(err);  
                    return;
                }
                console.log(persona);
                console.log(data[0]);
                console.log(data[2]);
                console.log(data[4]);
                res.render('staff_single_participant.html', {
                    data: data[0],
                    visita: data[2],
                    taller: data[4],
                    title: 'Staff'
                });
            });
        });
    } else {
        res.render('staff_index.html', {
            title: 'Staff'
        });
    }
};

controller.save = (req, res, next) =>{
    const data = req.body;
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    const data_query = [
    data.cantidad,
    data.deuda,
    data.visita,
    data.taller1,
    data.taller2,
    cart.getId(),
    date,
    ];

    req.getConnection((err, conn) =>{
        conn.query('CALL insertar_pago_actividades(?)', [data_query], (err, contact) =>{
            if(err){
                res.json(err);
                console.log(err);
                console.log(data);
                return;
            } else {
                req.flash('success', 'Se actualizaron los datos');
                res.redirect('back');
            }
        })
    });
};

module.exports = controller;