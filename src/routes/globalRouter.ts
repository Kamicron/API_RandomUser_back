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

async function queryEthnicDistribution(connection: any): Promise<any> {
  try {
    const query = `
    SELECT 
    eth.label AS ethnicity_label,
    eth.display_name AS ethnicity_display_name_fr,
    nat.label AS nationality_label,
    nat.display_name_fr AS nationality_display_name_fr,
    nat.flag AS nationality_flag,
    edn.percentage AS percentage
  FROM 
    ethnicdistributionbynationality edn
  JOIN 
    nationality nat ON edn.nationality_id_nationnality = nat.id_nationnality
  JOIN 
    ethnicity eth ON edn.ethnicity_id_ethnicity = eth.id_ethnicity
  ORDER BY 
    nat.label, eth.label
    `;
    
    const [rows]: any[] = await connection.query(query);
    
    return rows.reduce((acc, row) => {
      const nationality = row.nationality_label;
      
      if (!acc[nationality]) {
        acc[nationality] = {
          flag: row.nationality_flag,
          language: {
            display_name_fr: row.nationality_display_name_fr
          },
          ethnicities: []
        };
      }
      
      acc[nationality].ethnicities.push({
        label: row.ethnicity_label,
        percentage: row.percentage,
        language: {
          display_name_fr: row.ethnicity_display_name_fr
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
  const nationalityCount = await countEntries(connection, 'nationality');
  const ethnicityCount = await countEntries(connection, 'ethnicity');
  const workCount = await countEntries(connection, 'work');
  const photoCount = await countEntries(connection, 'photo');
  const genderCount = await countEntries(connection, 'gender');

  const maxPnj = firstnameCount * lastnameCount * photoCount;

  return {
    firstname: firstnameCount,
    lastname: lastnameCount,
    nationality: nationalityCount,
    ethnicity: ethnicityCount,
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
  result.ethnicity = await queryData(connection, 'ethnicity');
  result.nationality = await queryData(connection, 'nationality');
  result.work = await queryData(connection, 'work');
  result.ethnicDistribution = await queryEthnicDistribution(connection);
  result.stats = await getStats(connection);
  res.json(result);
});

router.get('/information-table/gender', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.gender = await queryData(connection, 'gender');

  res.json(result);
});

router.get('/information-table/ethnicity', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.ethnicity = await queryData(connection, 'ethnicity');

  res.json(result);
});

router.get('/information-table/nationality', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.nationality = await queryData(connection, 'nationality');

  res.json(result);
});

router.get('/information-table/work', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.work = await queryData(connection, 'work');

  res.json(result);
});

router.get('/information-table/ethnic-distribution-by-nationality', async (req, res) => {
  const connection = getConnection();
  const result = await queryEthnicDistribution(connection);
  
  res.json(result);
});


router.get('/information-table/stats', async (req, res) => {
  const connection = getConnection();
  const result = await getStats(connection);
  
  res.json(result);
});
export default router;
