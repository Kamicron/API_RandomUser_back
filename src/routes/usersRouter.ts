import express from 'express';
import { getConnection } from '../config/db';
import { RowDataPacket } from 'mysql2';
import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid'; // Assurez-vous que c'est installé
import nodemailer from 'nodemailer';

const router = express.Router();

// La fonction pour inscrire un nouvel utilisateur
export const registerUser = async (login: string, email: string, password: string): Promise<void> => {
  const connection = await getConnection();
  
  // Vérifier si l'utilisateur existe déjàd
  const [userResult] = await connection.execute('SELECT id_users FROM users WHERE email = ?', [email]);
  if (Array.isArray(userResult) && userResult.length > 0) {
    throw new Error('Un utilisateur avec cet email existe déjà.');
  }

  // Hacher le mot de passe
  const saltRounds = 10; // Vous pouvez augmenter pour plus de sécurité
  const passwordHash = await bcrypt.hash(password, saltRounds);

  // Générer un token de vérification
  const verificationToken = uuidv4();

  // Insérer le nouvel utilisateur dans la base de données
  const insertQuery = `
    INSERT INTO users (login, email, password, verification_token)
    VALUES (?, ?, ?, ?)
  `;
  await connection.execute(insertQuery, [login, email, passwordHash, verificationToken]);

  // Configurer le transporter de nodemailer
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com', // Remplacez par votre serveur de messagerie
    port: 587,
    secure: false, // true pour le port 465, false pour les autres ports
    auth: {
      user: 'apirandomuser@gmail.com', // Remplacez par votre email
      pass: 'K4m!2022_Dzns32..' // Remplacez par votre mot de passe
    }
  });

  // Envoyer l'email de vérification
  const mailOptions = {
    from: '"Votre Nom ou Compagnie" <your_email>', // Remplacez par votre email
    to: email,
    subject: 'Vérification de votre compte',
    text: `Veuillez utiliser le code suivant pour vérifier votre compte : ${verificationToken}`,
    html: `<p>Veuillez utiliser le code suivant pour vérifier votre compte : <b>${verificationToken}</b></p>`,
  };

  await transporter.sendMail(mailOptions);
};


router.post('/inscription', async (req, res) => {
  try {
    console.log(req.body); // Log pour le débogage

    // Valider que toutes les données nécessaires sont présentes
    const { login, email, password } = req.body;
    console.log('login', login);
    console.log('email', email);
    console.log('password', password);
    
    
    
    if (!login || !email || !password) {
      return res.status(400).send('Tous les champs sont requis.');
    }

    // Puis appeler registerUser avec ces paramètres
    await registerUser(login, email, password);
    res.status(201).send('Inscription réussie');
  } catch (error) {
    console.error(error); // Log de l'erreur
    res.status(500).send('Erreur lors de l’inscription: ' + error.message);
  }
});


// CONNEXION

export const loginUser = async (email: string, password: string): Promise<any> => {
  const connection = await getConnection();

  // Trouver l'utilisateur par email
  const [users] = await connection.execute('SELECT * FROM users WHERE email = ?', [email]);
  const user = Array.isArray(users) ? users[0] : null;

  // Vérifier si l'utilisateur existe et si le mot de passe est correct
  if (user && await bcrypt.compare(password, user.password)) {
    // L'utilisateur est authentifié, retournez les informations nécessaires (sans le mot de passe)
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  } else {
    throw new Error('Email ou mot de passe incorrect.');
  }
};

router.post('/connexion', async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).send('Email et mot de passe sont requis.');
    }

    const user = await loginUser(email, password);
    res.status(200).json(user);
  } catch (error) {
    res.status(401).send('Connexion échouée: ' + error.message);
  }
});
export default router;
