const express = require ('express');
const router = express.Router();

//Trascendencias Main Site
const indexController = require('../controllers/indexController');
router.get('/', indexController.list);

const actividadesController = require('../controllers/actividadesController');
router.get('/actividades', actividadesController.list);

const registroController = require('../controllers/registroController');
router.get('/registro', registroController.list);
router.post('/add', registroController.save);

//Staff DataBase Interface
const staff_indexController = require('../controllers/staff_indexController');
router.get('/staff', staff_indexController.list);

module.exports = router;