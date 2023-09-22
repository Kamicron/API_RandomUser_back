import express from 'express';
import { generateRandomPersonnage } from '../utils/randomGenerator';

const router = express.Router();

router.get('/generate', async (req, res) => {
    const personnage = await generateRandomPersonnage();
    res.json(personnage);
});

export default router;
