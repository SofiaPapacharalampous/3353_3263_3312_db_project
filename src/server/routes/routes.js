const express = require('express');
const router = express.Router();
const appController = require('../controllers/appController');

router.get('/', appController.home);

router.post('/timeline', appController.timeline);
router.get('/timeline-options', appController.renderTLOptions);

router.post('/barchart', appController.barchart);
router.get('/barchart-options', appController.renderBCOptions);

router.get('/scatterplot-options', appController.renderSPOptions);
router.post('/scatterplot', appController.scatterplot);

module.exports = router;