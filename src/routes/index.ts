import express from 'express';
import personnageRoutes from './personnageRoutes';

const router = express.Router();

router.use('/personnage', personnageRoutes);

export default router;
