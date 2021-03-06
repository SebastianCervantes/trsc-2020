const controller = {};
const Cart = require('../models/cart');

controller.list = (req, res) => {
    
    const actividad = req.params.actividad;
    const consulta = 'CALL listado_'+actividad+'';

    var cart = new Cart(req.session.cart ? req.session.cart : {});

    if (cart.keyCheck()){
        req.getConnection((err, conn) =>{
            conn.query(consulta, (err, list_p) =>{
                if(err){
                    res.json(err);
                    console.log(err);  
                    return;
                }
                console.log(list_p)
                res.render('staff_activities.html', {
                    data: list_p[0],
                    selected: actividad,
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

module.exports = controller;