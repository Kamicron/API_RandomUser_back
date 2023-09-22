import express from 'express';
import pnjRouter from './pnjRouter'; // Import en tant qu'export par défaut

const router = express.Router();

// Utilisez pnjRouter pour gérer toutes les routes commençant par '/pnj'
router.use('/pnj', pnjRouter);

export default router;
