const controller = {};
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

module.exports = controller;