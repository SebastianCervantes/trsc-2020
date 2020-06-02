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
router.post('/login', staff_indexController.login);

const staff_dashboardController = require('../controllers/staff_dashboardController');
router.get('/staff/dashboard', staff_dashboardController.list);

const staff_participantsController = require('../controllers/staff_participantsController');
router.get('/staff/listado-participantes', staff_participantsController.list);

const staff_activitiesController = require('../controllers/staff_activitiesController');
router.get('/staff/listado-actividades/:actividad', staff_activitiesController.list);

const staff_single_participantController = require('../controllers/staff_single_participantController');
router.get('/staff/participante/:persona', staff_single_participantController.list);
router.get('/staff/participante/', staff_single_participantController.list);
router.post('/update', staff_single_participantController.save);

//End Session
const endSessionController = require('../controllers/endSessionController');
router.post('/endSession', endSessionController.close);

module.exports = router;