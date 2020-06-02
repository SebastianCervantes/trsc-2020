const controller = {};
const Cart = require('../models/cart');

controller.close = (req, res) => {
    var cart = new Cart(req.session.cart ? req.session.cart : {});
    cart.endSession();
    req.session.cart = cart;
    console.log(cart);

    res.redirect('/staff');
};

module.exports = controller;