const controller = {};
const Cart = require('../models/cart');

controller.list = (req, res) => {
    var cart = new Cart(req.session.cart ? req.session.cart : {});

    if (cart.keyCheck()){
        req.getConnection((err, conn) =>{
            conn.query('CALL listado_participantes', (err, list_p) =>{
                if(err){
                    res.json(err);
                    console.log(err);  
                    return;
                }
                console.log(list_p)
                res.render('staff_participants.html', {
                    data: list_p[0],
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