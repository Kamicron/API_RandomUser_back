import express from 'express';
import { getConnection } from '../config/db'; // Import corrigé

const router = express.Router();

router.get('/count-entries', async (req, res) => {
  try {
    // Récupérez la connexion à la base de données
    const connection = getConnection(); // Utilisation de getConnection()

    // Exécutez plusieurs requêtes SQL pour compter le nombre d'entrées
    const [firstname]: any[] = await connection.query('SELECT COUNT(*) as count FROM `firstname`');
    const [lastname]: any[] = await connection.query('SELECT COUNT(*) as count FROM `lastname`');
    const [nationality]: any[] = await connection.query('SELECT COUNT(*) as count FROM `nationality`');
    const [ethnicity]: any[] = await connection.query('SELECT COUNT(*) as count FROM `ethnicity`');
    const [work]: any[] = await connection.query('SELECT COUNT(*) as count FROM `work`');
    const [photo]: any[] = await connection.query('SELECT COUNT(*) as count FROM `photo`');

    const maxPnj = firstname[0].count * lastname[0].count * photo[0].count

    // Aggrégation des résultats dans un objet unique
    const result = {
      stats: {
        firstname: firstname[0].count,
        lastname: lastname[0].count,
        nationality: nationality[0].count,
        ethnicity: ethnicity[0].count,
        work: work[0].count,
        photo: photo[0].count,
        maxPnj: maxPnj  
      }
    };

    // Envoyez le résultat en réponse
    res.json(result);

  } catch (error) {
    console.error('Erreur lors de la récupération du nombre d\'entrées : ', error);
    res.status(500).send('Erreur interne du serveur');
  }
});

export default router;
