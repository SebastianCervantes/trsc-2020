const express = require ('express');
const morgan = require ('morgan');
const mysql = require ('mysql');
const myConnection = require('express-myconnection');
const path = require ('path');

//Este modulo nos permite mostrar mensajes
//https://github.com/visionmedia/express-messages
var flash = require('connect-flash');

//checkout session -- modulos para guardar nuestras sesiones y utilizarlas para distintos fines
//https://www.npmjs.com/package/express-session
const session = require('express-session');

//mysql session sirve para guardar la informacion de las sesiones en una tabal dentro de nuestra base de datos
//https://www.npmjs.com/package/express-mysql-session
const MySQLStore = require( 'express-mysql-session')(session);

//La constante sessionStore sera nuestra conexion para la session exclusivamente
//(mmismas credenciales que en la conexion que ya hicimos)
const sessionStore = new MySQLStore ({
    host: 'localhost',
    user: 'root',
    password: 'root',
    port: 3306,
    database: 'trascendencias'
});

const app = express();

//settings
app.set('port', process.env.PORT || 8080);
app.set('view engine', 'ejs');
app.set('views', path.join (__dirname, 'views'));
app.set('public', path.join(__dirname, 'public'));
app.engine('html', require('ejs').renderFile); //usa archivos html en formato ejs

//middlewares
app.use(morgan('dev'));
app.use(myConnection(mysql, {
    host: 'localhost',
    user: 'root', 
    password: 'root',
    port: 3306,
    multipleStatements: true,
    database: 'trascendencias'
}, 'single' ));
app.use(session({
    secret: 's3cur3',
    store: sessionStore,
    resave: false,
    saveUninitialized: true //true para empezar a guardar informacion
}))

//Extender datos de formularios
app.use(express.urlencoded({
    extended: false
}));

//Estas funciones nos sirven para poder utilizar informacion atraves de nuestra proyecto
app.use(function(req,res,next){
    res.locals.cart = req.session.cart; //utilizar la informacion del carrito en toda la navegacion
    console.log(res.locals.cart);
    next();
});
app.use(require('connect-flash')());
app.use(function (req, res, next){
    res.locals.messages = require('express-messages')(req, res); //mensajes que quisieramos mostrar
    next();
});

//Routes (secciones del servidor)
app.use(require('./routes/routes'));

//static files
app.use(express.static(path.join(__dirname, 'public')));

app.listen (app.get('port'),() => {
    console.log('server on port');
});