import express from 'express';
import { getConnection } from '../config/db';
import { RowDataPacket } from 'mysql2';

const router = express.Router();

// Fonction utilitaire pour exécuter une requête SQL et retourner les résultats
async function queryData(connection: any, tableName: string): Promise<RowDataPacket[] | undefined> {
  try {
    const queryResult = await connection.query(`SELECT * FROM ${tableName} WHERE 1`);
    return queryResult[0] as RowDataPacket[];
  } catch (error) {
    console.error(`Erreur lors de la récupération des données de ${tableName}:`, error);
    return undefined;
  }
}

async function querysuboriginDistribution(connection: any): Promise<any> {
  try {
    const query = `
    SELECT 
    eth.label AS suborigin_label,
    eth.display_name AS suborigin_display_name_fr,
    nat.label AS origin_label,
    nat.display_name_fr AS origin_display_name_fr,
    nat.flag AS origin_flag,
    edn.percentage AS percentage
  FROM 
    suborigindistributionbyorigin edn
  JOIN 
    origin nat ON edn.origin_id_origin = nat.id_nationnality
  JOIN 
    suborigin eth ON edn.suborigin_id_suborigin = eth.id_suborigin
  ORDER BY 
    nat.label, eth.label
    `;
    
    const [rows]: any[] = await connection.query(query);
    
    return rows.reduce((acc, row) => {
      const origin = row.origin_label;
      
      if (!acc[origin]) {
        acc[origin] = {
          flag: row.origin_flag,
          language: {
            display_name_fr: row.origin_display_name_fr
          },
          suboriginities: []
        };
      }
      
      acc[origin].suboriginities.push({
        label: row.suborigin_label,
        percentage: row.percentage,
        language: {
          display_name_fr: row.suborigin_display_name_fr
        }
      });
      
      return acc;
    }, {});
  } catch (error) {
    console.error('Erreur lors de la récupération des données de la distribution ethnique : ', error);
    return {};
  }
}

async function countEntries(connection: any, tableName: string): Promise<number> {
  try {
    const [result]: any[] = await connection.query(`SELECT COUNT(*) as count FROM \`${tableName}\``);
    return result[0].count;
  } catch (error) {
    console.error(`Erreur lors de la récupération du nombre d'entrées de ${tableName} :`, error);
    return 0;
  }
}

async function getStats(connection: any): Promise<any> {
  const firstnameCount = await countEntries(connection, 'firstname');
  const lastnameCount = await countEntries(connection, 'lastname');
  const originCount = await countEntries(connection, 'origin');
  const suboriginCount = await countEntries(connection, 'suborigin');
  const workCount = await countEntries(connection, 'work');
  const photoCount = await countEntries(connection, 'photo');
  const genderCount = await countEntries(connection, 'gender');

  const maxPnj = firstnameCount * lastnameCount * photoCount;

  return {
    firstname: firstnameCount,
    lastname: lastnameCount,
    origin: originCount,
    suborigin: suboriginCount,
    work: workCount,
    photo: photoCount,
    gender: genderCount,
    maxPnj: maxPnj
  };
}

// Route pour obtenir toutes les informations
router.get('/information-table', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.gender = await queryData(connection, 'gender');
  result.suborigin = await queryData(connection, 'suborigin');
  result.origin = await queryData(connection, 'origin');
  result.work = await queryData(connection, 'work');
  result.suboriginDistribution = await querysuboriginDistribution(connection);
  result.stats = await getStats(connection);
  res.json(result);
});

router.get('/information-table/gender', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.gender = await queryData(connection, 'gender');

  res.json(result);
});

router.get('/information-table/suborigin', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.suborigin = await queryData(connection, 'suborigin');

  res.json(result);
});

router.get('/information-table/origin', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.origin = await queryData(connection, 'origin');

  res.json(result);
});

router.get('/information-table/work', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.work = await queryData(connection, 'work');

  res.json(result);
});

router.get('/information-table/suborigin-distribution-by-origin', async (req, res) => {
  const connection = getConnection();
  const result = await querysuboriginDistribution(connection);
  
  res.json(result);
});


router.get('/information-table/stats', async (req, res) => {
  const connection = getConnection();
  const result = await getStats(connection);
  
  res.json(result);
});
export default router;
