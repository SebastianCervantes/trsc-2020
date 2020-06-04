const controller = {};
var dateFormat = require('dateformat');
const Cart = require('../models/temporal');
var date = dateFormat("isoDate") + 'T' + dateFormat("isoTime");

controller.list = (req, res) => {
    res.render('registro.html', {
        data: null,
        title: 'Trascendencias'
    });
};

controller.store = (req, res, next) => {
    var cart = new Cart(req.session.cart ? req.session.cart : {});
    const data = req.body;

    cart.add (
        data.nombre,
        data.apellidos,
        data.correo,
        data.telefono,
        data.edad,
        data.sexo,
        data.carrera,
        data.campus,
        data.sem,
        data.talla,
        data.veget,
        data.alergias,
        data.tipo
    );

    req.session.cart = cart;
    console.log(cart.getData());

    if(data.tipo == 'paypal') {
        req.flash('paypal', 'Tu registro se ha completado');
        res.render('registro.html', {
            data: cart.getData(),
            title: 'Trascendencias'
        });
    } else {
        req.flash('dep-efec', 'Tu registro se ha completado');
        res.render('registro.html', {
            data: cart.getData(),
            title: 'Trascendencias'
        });
    }

}

controller.save = (req, res) =>{
    var cart = new Cart(req.session.cart ? req.session.cart : {});
    var data = cart.getData();

    const data_query = [
        data[0],
        data[1],
        data[2],
        data[3],
        data[4],
        data[5],
        data[6],
        data[7],
        data[8],
        data[9],
        data[10],
        data[11],
        data[12],
        date,
        0,
        950,
        'Pendiente'
    ];
    console.log(data_query);
    req.getConnection((err, conn) =>{
        conn.query('CALL registro(?)', [data_query], (err, contact) =>{
            if(err){
                res.json(err);
                console.log(err);
                console.log(data);
                return;
            }
            req.flash('complete', 'Tu registro se ha completado');
            res.redirect('/');
        })
    });
};

controller.ppResp = (req, res) =>{
    var response = req.params.resp;

    var cart = new Cart(req.session.cart ? req.session.cart : {});
    var data = cart.getData();

    const data_query = [
        data[0],
        data[1],
        data[2],
        data[3],
        data[4],
        data[5],
        data[6],
        data[7],
        data[8],
        data[9],
        data[10],
        data[11],
        data[12],
        date,
        950,
        0,
        'Pagado'
    ];


    console.log(data);
    console.log(data_query);
    if(response == "success") {
        req.getConnection((err, conn) =>{
            conn.query('CALL registro(?)', [data_query], (err, contact) =>{
                if(err){
                    res.json(err);
                    console.log(err);
                    console.log(data);
                    return;
                }
                req.flash('complete', 'Tu registro se ha completado');
                res.redirect('/');
            })
        });
    } else {
        if(response == "canceled"){
            req.flash('canceled', 'Se interrumpio el proceso');
            res.render('registro.html', {
                data: cart.getData(),
                title: 'Trascendencias'
            });
        }
    }
};

module.exports = controller;