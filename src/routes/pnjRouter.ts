import express from 'express';
import { getConnection } from '../config/db'; // Import corrigé

interface RowData {
  firstname: string;
}

const router = express.Router();

router.get('/random-firstname', async (req, res) => {
  try {
    // Récupérez la connexion à la base de données
    const connection = getConnection(); // Utilisation de getConnection()

    // Exécutez votre requête SQL pour récupérer un prénom aléatoire
    const [rows]: any[] = await connection.query('SELECT label FROM `firstname` WHERE 1 ORDER BY RAND() LIMIT 1');

    // Pas besoin de fermer la connexion dans ce cas

    // Envoyez le prénom aléatoire en réponse
    res.json({ firstname: rows[0].label });
  } catch (error) {
    console.error('Erreur lors de la récupération du prénom : ', error);
    res.status(500).send('Erreur interne du serveur');
  }
});

export default router;
