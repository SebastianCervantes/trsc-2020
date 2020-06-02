const controller = {};
const crypto = require('crypto');
const Cart = require('../models/cart');

controller.list = (req, res) => {
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    if (cart.keyCheck()){
        req.getConnection((err, conn) =>{
            conn.query('CALL dashboard_queries', (err, data_dashboard) =>{
                if(err){
                    res.json(err);
                    console.log(err);  
                    return;
                }
                console.log(data_dashboard)
                res.render('staff_dashboard.html', {
                    data: data_dashboard[0],
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

controller.login = (req, res, next) => {
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    //Obteniendo los datos ingresados
    const data = req.body;
    const user_server = data.user;
    const psw_server = data.password;

    //Encriptando la contraseña
    const key = 'trsc2020';
    const psw_hash = crypto.createHmac('sha256', key).update(psw_server).digest('hex');

    //Verificacion con base de
    req.getConnection((err, conn) =>{
        conn.query('CALL login(?)',[user_server], (err, data) =>{

            const psw_data = data[0][0].password;
            console.log(psw_data);

            if(err || psw_hash !== psw_data){
                req.flash('error', 'El usuario y contraseña no coinciden');
                res.redirect('back');
            } else {
                cart.startSession();
                req.session.cart = cart;
                console.log(cart);

                req.flash('success', 'Bienvenido');
                res.redirect('/staff');
            }
        });
    });
}

module.exports = controller;