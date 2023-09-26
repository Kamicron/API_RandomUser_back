import express from 'express';
import { getConnection } from '../config/db'; // Import corrigé
import { RowDataPacket } from 'mysql2';
interface RowData {
  firstname: string;
}

const router = express.Router();

router.get('/get-all-pnj', async (req, res) => {
  try {
    // Récupérez la connexion à la base de données
    const connection = getConnection(); // Utilisation de getConnection()

    let sql = `
    SELECT
        pnj.id_pnj AS _id,
        lastname.label AS nom,
        firstname.label AS prenom,
        pnj.level AS level,
        pnj.exp AS exp,
        skills.strength AS strength,
        skills.accuracy AS accuracy,
        skills.perception AS perception,
        skills.intelligence AS intelligence,
        skills.agility AS agility,
        skills.charisma AS charisma,
        skills.stealth AS stealth,
        skills.survival AS survival,
        ethnicity.label AS label_ethnicite,
        ethnicity.display_name AS display_name_ethnicite,
        gender.label AS label_genre,
        gender.display_name AS display_name_genre,
        photo.src AS nom_photo,
        photo.alt AS alt_photo,
        list_gender_work.work_name AS work_name,
        work.logo_work AS work_logo
    FROM
        apocalypse_reborn.pnj
        INNER JOIN apocalypse_reborn.ethnicity ON pnj.ethnicity_id_ethnicity = ethnicity.id_ethnicity
        INNER JOIN apocalypse_reborn.gender ON pnj.gender_id_gender = gender.id_gender
        INNER JOIN apocalypse_reborn.photo ON pnj.photo_id_photo = photo.id_photo
        INNER JOIN apocalypse_reborn.firstname ON pnj.firstname_id_firstname = firstname.id_firstname
        INNER JOIN apocalypse_reborn.lastname ON pnj.lastname_id_lastname = lastname.id_lastname
        INNER JOIN apocalypse_reborn.skills ON pnj.id_pnj = skills.pnj_id_pnj
        INNER JOIN apocalypse_reborn.work ON pnj.work_id_work = work.id_work
        INNER JOIN apocalypse_reborn.list_gender_work ON list_gender_work.work_id_work = work.id_work
    WHERE	
        pnj.gender_id_gender = list_gender_work.gender_id_gender`;

    const [rows]: any[] = await connection.query(sql);

    // Transformation des données en un tableau d'objets
    const pnjs = rows.map(row => {
      return {
        _id: row._id,
        nom: row.nom,
        prenom: row.prenom,
        level: row.level,
        exp: row.exp,
        strength: row.strength,
        accuracy: row.accuracy,
        perception: row.perception,
        intelligence: row.intelligence,
        agility: row.agility,
        charisma: row.charisma,
        stealth: row.stealth,
        survival: row.survival,
        label_ethnicite: row.label_ethnicite,
        display_name_ethnicite: row.display_name_ethnicite,
        label_genre: row.label_genre,
        display_name_genre: row.display_name_genre,
        nom_photo: row.nom_photo,
        alt_photo: row.alt_photo,
        work_name: row.work_name,
        work_logo: row.work_logo,
      };
    });

    // Envoi du tableau d'objets en réponse
    res.json(pnjs);

  } catch (error) {
    console.error('Erreur lors de la récupération des PNJ : ', error);
    res.status(500).send('Erreur interne du serveur');
  }
});

// router.post('/create-random-pnj', async (req, res) => {
//   try {
//     // Récupérez la connexion à la base de données
//     const connection = getConnection();

//     // Ici, appeler la fonction SQL stockée pour créer un PNJ aléatoire
//     await connection.query('CALL CreateRandomPNJ()');

//     // Renvoyer une réponse
//     res.status(200).json({ message: 'PNJ créé avec succès.' });
//   } catch (error) {
//     console.error('Erreur lors de la création du PNJ :', error);
//     res.status(500).send('Erreur interne du serveur');
//   }
// });

// router.get('/random-pnj', async (req, res) => {
//   try {
//     const connection = getConnection();
//     let result: any = {};

//     const [gender]: any[] = await connection.query(`
//       SELECT *
//       FROM gender 
//       ORDER BY RAND() LIMIT 1`
//     );
//     const genderId = gender[0].id_gender; // Remplacer par le vrai champ identifiant du genre dans votre base de données

//     const [nationality]: any[] = await connection.query(`
//       SELECT *
//       FROM nationality 
//       ORDER BY RAND() LIMIT 1
//     `);
//     console.log("Nationalité :", nationality);
//     const nationalityId = nationality[0].id_nationnality;
//     console.log("Nationalité :", nationalityId);

//     // Première requête pour définir la variable aléatoire
//     // let rand = Math.random() * 100;
//     // console.log('rand', rand);


//     // // Deuxième requête pour récupérer l'ethnie
//     // const [ethnicityChosen]: any[] = await connection.query(`
//     //   SELECT *
//     //   FROM ethnicdistributionbynationality
//     //   WHERE nationality_id_nationnality = ? AND ? <= percentage
//     //   ORDER BY RAND()
//     //   LIMIT 1
//     // `, [nationalityId, rand]);

//     const [rows]: any[] = await connection.query(`
//       SELECT *
//       FROM ethnicdistributionbynationality
//       WHERE nationality_id_nationnality = ?
//     `, [nationalityId]);

//     let totalPercentage = 0;
//     let wheel = [];

//     console.log('rows',rows);
    

//     for (const row of rows) {
//       wheel.push({
//         name: row.ethnicity_id_ethnicity,
//         min: totalPercentage,
//         max: totalPercentage + row.percentage
//       });
//       totalPercentage += row.percentage;
//     }

//     console.log('wheel',wheel);
    
//     const rand = Math.random() * totalPercentage;

//     let ethnicityId = "Unknown";
//     for (const segment of wheel) {
//       if (rand >= segment.min && rand < segment.max) {
//         ethnicityId = segment.name;
//         break;
//       }
//     }

//     console.log("ethnicityChosen",ethnicityId);
    

//     console.log("éthnicité :", ethnicityId);

//     const [ethnicity]: any[] = await connection.query(`
//       SELECT *
//       FROM ethnicity 
//       WHERE id_ethnicity = ?
//     `, [ethnicityId]);

//     const [firstname]: any[] = await connection.query(`
//       SELECT firstname.label AS prenom
//       FROM firstname
//       WHERE gender_id_gender = ? AND ethnicity_id_ethnicity = ?
//       ORDER BY RAND() LIMIT 1
//       `, [genderId, ethnicityId]);

//     const [lastname]: any[] = await connection.query(`
//       SELECT lastname.label AS nom
//       FROM lastname
//       WHERE ethnicity_id_ethnicity = ?
//       ORDER BY RAND() LIMIT 1
//     `, [ethnicityId]);

//     const [photo]: any[] = await connection.query(`
//       SELECT *
//       FROM photo
//       ORDER BY RAND() LIMIT 1
//       `);

//     const [work]: any[] = await connection.query(`
//       SELECT id_work, label, logo_work
//       FROM work
//       ORDER BY RAND() LIMIT 1
//     `);
//     const workId = work[0].id_work;

//     const [workName]: any[] = await connection.query(`
//       SELECT work_name
//       FROM list_gender_work
//       WHERE gender_id_gender = ? AND work_id_work = ?
//       `, [genderId, workId]
//     );

//     result = {
//       personalInfo: {
//         firstname: firstname[0].prenom,
//         lastname: lastname[0].nom,
//         gender: gender[0],
//         ethnicity: ethnicity[0],
//         nationality: nationality[0]
//       },
//       photo: photo[0],
//       work: {
//         ...work[0],
//         displayName: workName[0].work_name
//       }
//     };

//     res.json(result);

//   } catch (error) {
//     console.error('Erreur lors de la génération du PNJ aléatoire :', error);
//     res.status(500).send('Erreur interne du serveur');
//   }
// });

router.get('/random-pnj', async (req, res) => {
  try {
    const connection = getConnection();
    let result: any = {};

    const chosenEthnicity = req.query.ethnicity || '';
    let nationalityId = req.query.nationality || '';
    let genderId = req.query.gender || '';

    let nationality: RowDataPacket[] | undefined;
    let gender: RowDataPacket[] | undefined;


    if (genderId) {
      const queryResult = await connection.query('SELECT * FROM gender WHERE id_gender = ?', [genderId]);
      gender = queryResult[0] as RowDataPacket[];
    } else {
      const queryResult = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');
      
      gender = queryResult[0] as RowDataPacket[];

      genderId = gender[0].id_gender;
    }

    // const [gender]: any[] = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');
    // const genderId = gender[0].id_gender;


    if (nationalityId) {
      const queryResult = await connection.query('SELECT * FROM nationality WHERE id_nationnality = ?', [nationalityId]);
      nationality = queryResult[0] as RowDataPacket[];
    } else {
      const queryResult = await connection.query('SELECT * FROM nationality ORDER BY RAND() LIMIT 1');
      nationality = queryResult[0] as RowDataPacket[];
      nationalityId = nationality[0].id_nationnality;
    }
    
    // const [nationality]: any[] = await connection.query('SELECT * FROM nationality ORDER BY RAND() LIMIT 1');

    let ethnicityId;
    if (chosenEthnicity) {
      ethnicityId = chosenEthnicity;
    } else {
      const [rows]: any[] = await connection.query('SELECT * FROM ethnicdistributionbynationality WHERE nationality_id_nationnality = ?', [nationalityId]);
      
      let totalPercentage = 0;
      let wheel = [];
      for (const row of rows) {
        wheel.push({
          name: row.ethnicity_id_ethnicity,
          min: totalPercentage,
          max: totalPercentage + row.percentage,
        });
        totalPercentage += row.percentage;
      }

      const rand = Math.random() * totalPercentage;
      for (const segment of wheel) {
        if (rand >= segment.min && rand < segment.max) {
          ethnicityId = segment.name;
          break;
        }
      }
    }

    const [ethnicity]: any[] = await connection.query('SELECT * FROM ethnicity WHERE id_ethnicity = ?', [ethnicityId]);
    const [firstname]: any[] = await connection.query('SELECT firstname.label AS prenom FROM firstname WHERE gender_id_gender = ? AND ethnicity_id_ethnicity = ? ORDER BY RAND() LIMIT 1', [genderId, ethnicityId]);
    const [lastname]: any[] = await connection.query('SELECT lastname.label AS nom FROM lastname WHERE ethnicity_id_ethnicity = ? ORDER BY RAND() LIMIT 1', [ethnicityId]);
    const [photo]: any[] = await connection.query('SELECT * FROM photo ORDER BY RAND() LIMIT 1');
    const [work]: any[] = await connection.query('SELECT id_work, label, logo_work FROM work ORDER BY RAND() LIMIT 1');
    const workId = work[0].id_work;
    const [workName]: any[] = await connection.query('SELECT work_name FROM list_gender_work WHERE gender_id_gender = ? AND work_id_work = ?', [genderId, workId]);

    result = {
      personalInfo: {
        firstname: firstname[0].prenom,
        lastname: lastname[0].nom,
        gender: gender[0],
        ethnicity: ethnicity[0],
        nationality: nationality[0],
      },
      photo: photo[0],
      work: {
        ...work[0],
        displayName: workName[0].work_name,
      },
    };

    res.json(result);
  } catch (error) {
    console.error('Erreur lors de la génération du PNJ aléatoire :', error);
    res.status(500).send('Erreur interne du serveur');
  }
});



export default router;