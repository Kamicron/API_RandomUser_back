import express from 'express';
import cors from 'cors';
import { initializeConnection } from './config/db'; // Mettez à jour le chemin si nécessaire
import mainRouter from './routes';



const app = express();
const port = process.env.PORT; // Vous pouvez changer le port selon vos besoins
app.use(cors());
app.use(express.static('public'))

const startServer = async () => {
  try {
    await initializeConnection(); // Initialise la connexion à la base de données
    console.log('Base de données initialisée');

    // Configuration d'Express ici
    app.use(express.json());
    
    // Utilisation des routeurs
    app.use('/', mainRouter);


    app.listen(port, () => {
      console.log(`Serveur en écoute sur http://localhost:${port}/`);
    });
  } catch (error) {
    console.error('Erreur lors de l\'initialisation de la base de données:', error);
  }
};

startServer(); // Démarrer le serveur
