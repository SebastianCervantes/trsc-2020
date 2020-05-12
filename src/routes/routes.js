const express = require ('express');
const router = express.Router();

const indexController = require('../controllers/indexController');
router.get('/', indexController.list);

const actividadesController = require('../controllers/actividadesController');
router.get('/actividades', actividadesController.list);

const registroController = require('../controllers/registroController');
router.get('/registro', registroController.list);
router.post('/add', registroController.save);

module.exports = router;