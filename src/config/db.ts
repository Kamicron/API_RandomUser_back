require('dotenv').config({ path: '../.env' });
const mysql = require('mysql2');

let connection;

const isLaptop = process.env.IS_LAPTOP === 'true'; // Assurez-vous de définir cette variable d'environnement comme une chaîne ('true' ou 'false')

if (isLaptop) {
  // Configuration pour un PC portable
  connection = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT_LAPTOP,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });
} else {
  // Configuration pour un PC fixe
  connection = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT_DESKTOP,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  });
}

module.exports = connection;
