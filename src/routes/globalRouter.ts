import express from 'express';
import { getConnection } from '../config/db';
import { RowDataPacket } from 'mysql2';

const router = express.Router();

// Fonction utilitaire pour exécuter une requête SQL et retourner les résultats
async function queryData(connection: any, tableName: string, transformFunction?: (data: any) => any): Promise<any> {
  try {
    const queryResult = await connection.query(`SELECT * FROM ${tableName} WHERE 1`);
    let data = queryResult[0] as RowDataPacket[];
    // Appliquer la fonction de transformation si elle est fournie
    if (transformFunction) {
      data = transformFunction(data);
    }
    return data;
  } catch (error) {
    console.error(`Erreur lors de la récupération des données de ${tableName}:`, error);
    return undefined;
  }
}

function transformGeneral(data: any[]) {
  return data.map(item => {
    // Création d'un nouvel objet pour les langues
    const language: any = {};

    // Filtrer les clés qui commencent par "display_name_" et les ajouter à l'objet language
    for (const [key, value] of Object.entries(item)) {
      if (key.startsWith('display_name_')) {
        const langKey = key.split('display_name_')[1]; // obtenir la partie langue de la clé
        language[langKey] = value;
        delete item[key]; // supprimer la clé originale de l'objet item
      }
    }

    // Retourner l'objet restructuré avec l'objet language ajouté
    return {
      ...item,
      language
    };
  });
}


// function transformSuborigin(data: any[]) {
//   return data.map(item => {
//     // Créer un nouvel objet pour les langues
//     const language: any = {};

//     // Filtrer les clés qui commencent par "display_name_" et les ajouter à l'objet language
//     for (const [key, value] of Object.entries(item)) {
//       if (key.startsWith('display_name_')) {
//         const langKey = key.split('display_name_')[1]; // obtenir la partie langue de la clé
//         language[langKey] = value;
//         delete item[key]; // supprimer la clé originale de l'objet item
//       }
//     }

//     // Retourner l'objet restructuré avec uniquement les propriétés nécessaires et l'objet language ajouté
//     return {
//       id_suborigin: item.id_suborigin,
//       label: item.label,
//       language // ajouter l'objet language ici
//     };
//   });
// }

function transformOrigin(data: any[]) {
  return data.map(item => {
    // Créer un nouvel objet pour les langues
    const language: any = {};

    // Filtrer les clés qui commencent par "display_name_" et les ajouter à l'objet language
    for (const [key, value] of Object.entries(item)) {
      if (key.startsWith('display_name_')) {
        const langKey = key.split('display_name_')[1]; // obtenir la partie langue de la clé
        language[langKey] = value;
        delete item[key]; // supprimer la clé originale de l'objet item
      }
    }

    // Retourner l'objet restructuré avec les propriétés nécessaires et l'objet language ajouté
    return {
      id_origin: item.id_origin,
      label: item.label,
      flag: item.flag,
      species_id: item.species_id,
      has_suborigin: item.has_suborigin,
      language // ajouter l'objet language ici
    };
  });
}

function transformWork(rows: any[]): any {
  return rows.reduce((acc, row) => {
    // Assurez-vous que le travail est initialisé dans l'accumulateur
    if (!acc[row.id_work]) {
      acc[row.id_work] = {
        id_work: row.id_work,
        label: row.label,
        logo_work: row.logo_work,
        genders: []
      };
    }

    // Trouver ou créer l'entrée de genre correspondante
    let genderEntry = acc[row.id_work].genders.find(g => g.gender_id === row.gender_id_gender);
    if (!genderEntry) {
      genderEntry = { gender_id: row.gender_id_gender, language: {} };
      acc[row.id_work].genders.push(genderEntry);
    }

    // Ajouter les traductions dans l'objet language pour le genre correspondant
    Object.keys(row).forEach(key => {
      if (key.startsWith('display_name_')) {
        const lang = key.split('_').pop(); // Extrait la partie langue de la clé
        genderEntry.language[lang] = row[key];
      }
    });

    return acc;
  }, {});
}


async function querysuboriginDistribution(connection: any): Promise<any> {
  try {
    const query = `
    SELECT 
    eth.label AS suborigin_label,
    eth.display_name_fr AS suborigin_display_name_fr,
    nat.label AS origin_label,
    nat.display_name_fr AS origin_display_name_fr,
    nat.flag AS origin_flag,
    edn.percentage AS percentage
  FROM 
    suborigindistributionbyorigin edn
  JOIN 
    origin nat ON edn.origin_id_origin = nat.id_origin
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
          language: {},
          suboriginities: []
        };

        // Extraire les langues pour l'origin
        for (const key in row) {
          if (key.startsWith('origin_display_name_')) {
            const lang = key.replace('origin_display_name_', '');
            acc[origin].language[lang] = row[key];
          }
        }
      }

      // Créer un nouvel objet pour le suborigin avec les langues
      const suborigin = {
        label: row.suborigin_label,
        percentage: row.percentage,
        language: {}
      };

      // Extraire les langues pour le suborigin
      for (const key in row) {
        if (key.startsWith('suborigin_display_name_')) {
          const lang = key.replace('suborigin_display_name_', '');
          suborigin.language[lang] = row[key];
        }
      }

      acc[origin].suboriginities.push(suborigin);

      return acc;
    }, {});
  } catch (error) {
    console.error('Erreur lors de la récupération des données de la distribution ethnique : ', error);
    return {};
  }
}

async function queryDataWithJoin(connection: any, baseTable: string, joinTable: string, transform?: Function): Promise<any> {
  try {
    const query = `
      SELECT w.*, lgw.display_name_fr, lgw.gender_id_gender
      FROM ${baseTable} w
      LEFT JOIN ${joinTable} lgw ON w.id_work = lgw.work_id_work
    `;
    const [rows]: any[] = await connection.query(query);
    return transform ? transform(rows) : rows;
  } catch (error) {
    console.error(`Erreur lors de la récupération des données avec jointure entre ${baseTable} et ${joinTable} : `, error);
    throw error;
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

  result.gender = await queryData(connection, 'gender', transformGeneral);
  result.suborigin = await queryData(connection, 'suborigin', transformGeneral);
  result.origin = await queryData(connection, 'origin', transformOrigin);
  result.work = await queryDataWithJoin(connection, 'work', 'list_gender_work', transformWork);
  result.suboriginDistribution = await querysuboriginDistribution(connection);
  result.stats = await getStats(connection);
  res.json(result);
});

router.get('/information-table/system', async (req, res) => {
  const connection = getConnection();

  const systemData = await queryData(connection, 'system', transformGeneral);

  // Ajouter le résultat restructuré à l'objet result
  const result = { system: systemData };

  res.json(result);
});

router.get('/information-table/species', async (req, res) => {
  const connection = getConnection();

  const speciesData = await queryData(connection, 'species', transformGeneral);

  // Ajouter le résultat restructuré à l'objet result
  const result = { species: speciesData };

  res.json(result);
});

router.get('/information-table/gender', async (req, res) => {
  const connection = getConnection();

  const genderData = await queryData(connection, 'gender', transformGeneral);

  // Ajouter le résultat restructuré à l'objet result
  const result = { gender: genderData };

  res.json(result);
});

router.get('/information-table/suborigin', async (req, res) => {
  const connection = getConnection();

  const suboriginData = await queryData(connection, 'suborigin', transformGeneral);

  // Ajouter les données transformées à l'objet result
  const result = { suborigin: suboriginData };

  res.json(result);
});

router.get('/information-table/origin', async (req, res) => {
  const connection = getConnection();
  const result: any = {};

  result.origin = await queryData(connection, 'origin', transformOrigin);

  res.json(result);
});

router.get('/information-table/work', async (req, res) => {
  const connection = getConnection();
  const rawWorkData = await queryDataWithJoin(connection, 'work', 'list_gender_work'); // Obtenez les données jointes
  const transformedWorkData = transformWork(rawWorkData); // Transformez les données
  res.json({ work: transformedWorkData });
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
