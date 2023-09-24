import * as mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config({ path: './.env' });
let connection: mysql.Connection | null = null;

export const initializeConnection = async () => {
  const isLaptop = process.env.IS_LAPTOP === 'true';

  const connectionConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: parseInt(isLaptop ? process.env.DB_PORT_LAPTOP! : process.env.DB_PORT_DESKTOP!, 10),
  };

  connection = await mysql.createConnection(connectionConfig);
  return connection;
};

export const getConnection = () => {
  if (connection === null) {
    throw new Error('Database connection has not been initialized. Please call initializeConnection first.');
  }
  return connection;
};

