import express from 'express';
import { getConnection } from '../config/db'; // Import corrigé
import { RowDataPacket } from 'mysql2';
interface RowData {
  firstname: string;
}

const router = express.Router();

// router.get('/get-all-pnj', async (req, res) => {
//   try {
//     // Récupérez la connexion à la base de données
//     const connection = getConnection(); // Utilisation de getConnection()

//     let sql = `
//     SELECT
//         pnj.id_pnj AS _id,
//         lastname.label AS nom,
//         firstname.label AS prenom,
//         pnj.level AS level,
//         pnj.exp AS exp,
//         skills.strength AS strength,
//         skills.accuracy AS accuracy,
//         skills.perception AS perception,
//         skills.intelligence AS intelligence,
//         skills.agility AS agility,
//         skills.charisma AS charisma,
//         skills.stealth AS stealth,
//         skills.survival AS survival,
//         suborigin.label AS label_suborigin,
//         suborigin.display_name AS display_name_suborigin,
//         gender.label AS label_genre,
//         gender.display_name AS display_name_genre,
//         photo.src AS nom_photo,
//         photo.alt AS alt_photo,
//         list_gender_work.work_name AS work_name,
//         work.logo_work AS work_logo
//     FROM
//         apocalypse_reborn.pnj
//         INNER JOIN apocalypse_reborn.suborigin ON pnj.suborigin_id_suborigin = suborigin.id_suborigin
//         INNER JOIN apocalypse_reborn.gender ON pnj.gender_id_gender = gender.id_gender
//         INNER JOIN apocalypse_reborn.photo ON pnj.photo_id_photo = photo.id_photo
//         INNER JOIN apocalypse_reborn.firstname ON pnj.firstname_id_firstname = firstname.id_firstname
//         INNER JOIN apocalypse_reborn.lastname ON pnj.lastname_id_lastname = lastname.id_lastname
//         INNER JOIN apocalypse_reborn.skills ON pnj.id_pnj = skills.pnj_id_pnj
//         INNER JOIN apocalypse_reborn.work ON pnj.work_id_work = work.id_work
//         INNER JOIN apocalypse_reborn.list_gender_work ON list_gender_work.work_id_work = work.id_work
//     WHERE	
//         pnj.gender_id_gender = list_gender_work.gender_id_gender`;

//     const [rows]: any[] = await connection.query(sql);

//     // Transformation des données en un tableau d'objets
//     const pnjs = rows.map(row => {
//       return {
//         _id: row._id,
//         nom: row.nom,
//         prenom: row.prenom,
//         level: row.level,
//         exp: row.exp,
//         strength: row.strength,
//         accuracy: row.accuracy,
//         perception: row.perception,
//         intelligence: row.intelligence,
//         agility: row.agility,
//         charisma: row.charisma,
//         stealth: row.stealth,
//         survival: row.survival,
//         label_suborigin: row.label_suborigin,
//         display_name_suborigin: row.display_name_suborigin,
//         label_genre: row.label_genre,
//         display_name_genre: row.display_name_genre,
//         nom_photo: row.nom_photo,
//         alt_photo: row.alt_photo,
//         work_name: row.work_name,
//         work_logo: row.work_logo,
//       };
//     });

//     // Envoi du tableau d'objets en réponse
//     res.json(pnjs);

//   } catch (error) {
//     console.error('Erreur lors de la récupération des PNJ : ', error);
//     res.status(500).send('Erreur interne du serveur');
//   }
// });


router.get('/random-pnj', async (req, res) => {
  try {

    const connection = getConnection();
    let result: any = {};
    // let suboriginData = null;
    let gender: RowDataPacket[] | undefined;
    let origin: RowDataPacket[] | undefined;
    let queryResult: any;


    // Choix du système
    let systemId = req.query.system || '';
    if (!systemId) {
      const queryResult = await connection.query('SELECT * FROM system ORDER BY RAND() LIMIT 1');
      const system = queryResult[0] as RowDataPacket[];
      systemId = system[0].id_system;
    }

    console.log('systemId', systemId);


    // Choix de l'espèce compatible avec le système
    let speciesId = req.query.species || '';
    if (!speciesId) {
      const queryResult = await connection.query('SELECT * FROM system_species WHERE system_id = ? ORDER BY RAND() LIMIT 1', [systemId]);
      const species = queryResult[0] as RowDataPacket[];
      speciesId = species[0].species_id;
    }
    console.log('speciesId', speciesId);

    // Choix de l'origine compatible avec l'espèce
    let originId = req.query.origin || '';
    console.log('originId', originId);
    
    if (originId) {
      console.log('y aoriginId');
      
      queryResult = await connection.query('SELECT * FROM origin WHERE species_id = ? AND id_origin = ?', [speciesId, originId]);
    } else {
      console.log('pas originId');

      queryResult = await connection.query('SELECT * FROM origin ORDER BY RAND() LIMIT 1');
    }
    
    origin = queryResult[0] as RowDataPacket[];

    console.log('origin', origin);
    
    
    originId = origin[0].id_origin;
    console.log('originId', originId);

    // Si l'origine a une sous-origine
    let suboriginId = req.query.suborigin || '';
    if (!suboriginId) {
      const queryResult = await connection.query('SELECT * FROM origin WHERE id_origin = ?', [originId]);
      const origin = queryResult[0] as RowDataPacket[];

      if (origin[0].has_suborigin) {
        // Inutile de redéclarer suboriginId ici
        if (!suboriginId) {
          const [rows]: any[] = await connection.query('SELECT * FROM suborigindistributionbyorigin WHERE origin_id_origin = ?', [originId]);

          let totalPercentage = 0;
          let wheel = [];
          for (const row of rows) {
            wheel.push({
              name: row.suborigin_id_suborigin,
              min: totalPercentage,
              max: totalPercentage + row.percentage,
            });
            totalPercentage += row.percentage;
          }

          const rand = Math.random() * totalPercentage;
          for (const segment of wheel) {
            if (rand >= segment.min && rand < segment.max) {
              suboriginId = segment.name;
              break;
            }
          }
        }
      }

      const suboriginQueryResult: any[] = await connection.query('SELECT * FROM suborigin WHERE id_suborigin = ?', [suboriginId]);
      const suboriginData = suboriginQueryResult[0][0];

    }
    console.log('suboriginId', suboriginId);


    // Choix du genre
    let genderId = req.query.gender || '';
    if (!genderId) {
      queryResult = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');
    } else {
      queryResult = await connection.query('SELECT * FROM gender WHERE id_gender = ?', [genderId]);
    }

    gender = queryResult[0] as RowDataPacket[];
    genderId = gender[0].id_gender;

    // Choix du prénom et du nom
    const [firstname]: any[] = await connection.query('SELECT firstname.label AS prenom FROM firstname WHERE gender_id_gender = ? AND suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [genderId, suboriginId]);
    const [lastname]: any[] = await connection.query('SELECT lastname.label AS nom FROM lastname WHERE suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [suboriginId]);

    // Choix de la photo
    const [photo]: any[] = await connection.query('SELECT * FROM photo ORDER BY RAND() LIMIT 1');

    // Choix du travail
    const [work]: any[] = await connection.query('SELECT id_work, label, logo_work FROM work ORDER BY RAND() LIMIT 1');
    const workId = work[0].id_work;
    const [workName]: any[] = await connection.query('SELECT work_name FROM list_gender_work WHERE gender_id_gender = ? AND work_id_work = ?', [genderId, workId]);

    const [system]: any[] = await connection.query('SELECT * FROM system WHERE id_system = ?', [systemId]);
    const [species]: any[] = await connection.query('SELECT * FROM species WHERE id_species = ?', [speciesId]);

    result = {
      system: system,
      personalInfo: {
        firstname: firstname[0].prenom,
        lastname: lastname[0].nom,
        gender: gender,
        lineage: {
          species,
          origin: origin,
          suborigin: suboriginData,
        }
      },
      photo: photo[0],
      work: {
        id: workId,
        label: work[0].label,
        logo: work[0].logo_work,
        displayName: workName[0].work_name,
      },
    };

    res.json(result);
  } catch (error) {
    console.error('Erreur lors de la création du PNJ :', error);
    res.status(500).send('Erreur interne du serveur');
  }
});


// router.get('/random-pnj', async (req, res) => {
//   try {
//     const connection = getConnection();
//     let result: any = {};

//     const chosensuborigin = req.query.suborigin || '';
//     let originId = req.query.origin || '';
//     let genderId = req.query.gender || '';

//     let origin: RowDataPacket[] | undefined;
//     let gender: RowDataPacket[] | undefined;


//     if (genderId) {
//       const queryResult = await connection.query('SELECT * FROM gender WHERE id_gender = ?', [genderId]);
//       gender = queryResult[0] as RowDataPacket[];
//     } else {
//       const queryResult = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');

//       gender = queryResult[0] as RowDataPacket[];

//       genderId = gender[0].id_gender;
//     }

//     // const [gender]: any[] = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');
//     // const genderId = gender[0].id_gender;


//     if (originId) {
//       const queryResult = await connection.query('SELECT * FROM origin WHERE id_origin = ?', [originId]);
//       origin = queryResult[0] as RowDataPacket[];
//     } else {
//       const queryResult = await connection.query('SELECT * FROM origin ORDER BY RAND() LIMIT 1');
//       origin = queryResult[0] as RowDataPacket[];
//       originId = origin[0].id_origin;
//     }

//     // const [origin]: any[] = await connection.query('SELECT * FROM origin ORDER BY RAND() LIMIT 1');

//     let suboriginId;
//     if (chosensuborigin) {
//       suboriginId = chosensuborigin;
//     } else {
//       const [rows]: any[] = await connection.query('SELECT * FROM suborigindistributionbyorigin WHERE origin_id_origin = ?', [originId]);

//       let totalPercentage = 0;
//       let wheel = [];
//       for (const row of rows) {
//         wheel.push({
//           name: row.suborigin_id_suborigin,
//           min: totalPercentage,
//           max: totalPercentage + row.percentage,
//         });
//         totalPercentage += row.percentage;
//       }

//       const rand = Math.random() * totalPercentage;
//       for (const segment of wheel) {
//         if (rand >= segment.min && rand < segment.max) {
//           suboriginId = segment.name;
//           break;
//         }
//       }
//     }

//     const [suborigin]: any[] = await connection.query('SELECT * FROM suborigin WHERE id_suborigin = ?', [suboriginId]);
//     const [firstname]: any[] = await connection.query('SELECT firstname.label AS prenom FROM firstname WHERE gender_id_gender = ? AND suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [genderId, suboriginId]);
//     const [lastname]: any[] = await connection.query('SELECT lastname.label AS nom FROM lastname WHERE suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [suboriginId]);
//     const [photo]: any[] = await connection.query('SELECT * FROM photo ORDER BY RAND() LIMIT 1');
//     const [work]: any[] = await connection.query('SELECT id_work, label, logo_work FROM work ORDER BY RAND() LIMIT 1');
//     const workId = work[0].id_work;
//     const [workName]: any[] = await connection.query('SELECT work_name FROM list_gender_work WHERE gender_id_gender = ? AND work_id_work = ?', [genderId, workId]);

//     result = {
//       personalInfo: {
//         firstname: firstname[0].prenom,
//         lastname: lastname[0].nom,
//         gender: gender[0],
//         suborigin: suborigin[0],
//         origin: origin[0],
//       },
//       photo: photo[0],
//       work: {
//         ...work[0],
//         displayName: workName[0].work_name,
//       },
//     };

//     res.json(result);
//   } catch (error) {
//     console.error('Erreur lors de la génération du PNJ aléatoire :', error);
//     res.status(500).send('Erreur interne du serveur');
//   }
// });



export default router;