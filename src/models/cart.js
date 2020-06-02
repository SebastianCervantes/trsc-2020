module.exports = function Cart(cart) {
    this.items = cart.items || {};
    this.session = cart.session || null;
    this.sessionKey = 'Session20T';

    this.add = function(id) {
       this.items[0] = id;
    };

    this.remove = function() {
        delete this.items[0];
    };

    this.getId = function() {
        return this.items[0];
    };

    this.startSession = function() {
        this.session = 'Session20T';
    };

    this.endSession = function() {
        this.session = null;
    };

    this.getSession = function() {
        return this.session;
    };

    this.getSessionKey = function() {
        return this.sessionKey;
    };

    this.keyCheck = function() {
        if(this.session == this.sessionKey) {
            return true;
        } else {
            return false;
        }
    };
};

// module.exports = function Cart(cart) {
//     this.items = cart.items || {};
//     this.totalItems = cart.totalItems || 0;
//     this.totalPrice = cart.totalPrice || 0;

//     this.add = function(item, id) {
//         var cartItem = this.items[id];
//         if (!cartItem) {
//             cartItem = this.items[id] = {item: item, quantity: 0, price: 0};
//         }
//         cartItem.quantity++;
//         cartItem.price = cartItem.item.price * cartItem.quantity;
//         this.totalItems++;
//         this.totalPrice += cartItem.item.price;
//     };

//     this.remove = function(id) {
//         this.totalItems -= this.items[id].quantity;
//         this.totalPrice -= this.items[id].price;
//         delete this.items[id];
//     };
    
//     this.removeOne = function(id) {
//         this.items[id].quantity --;
//         this.items[id].price -=this.items[id].item.price;
//         this.totalItems --;
//         this.totalPrice -= this.items[id].item.price;
//     };

//     this.addOne = function(id) {
//         this.items[id].quantity ++;
//         this.items[id].price +=this.items[id].item.price;
//         this.totalItems ++;
//         this.totalPrice += this.items[id].item.price;
//     };

//     this.getItems = function() {
//         var arr = [];
//         for (var id in this.items) {
//             arr.push(this.items[id]);
//         }
//         return arr;
//     };
// };