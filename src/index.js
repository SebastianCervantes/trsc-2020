const express = require ('express');
const morgan = require ('morgan');
const mysql = require ('mysql');
const myConnection = require('express-myconnection');
const path = require ('path');

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
    database: 'trascendencias'
}, 'single' ));

//Extender datos de formularios
app.use(express.urlencoded({
    extended: false
}));

//Routes (secciones del servidor)
app.use(require('./routes/routes'));

//static files
app.use(express.static(path.join(__dirname, 'public')));

app.listen (app.get('port'),() => {
    console.log('server on port');
});