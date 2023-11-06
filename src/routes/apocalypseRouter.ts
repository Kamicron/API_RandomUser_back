import express from 'express';
import { getConnection } from '../config/db'; // Import corrigé
import { RowDataPacket } from 'mysql2';
import { log } from 'console';

const router = express.Router();

interface LangageEntry {
  [key: string]: any; // Cela permet d'utiliser cette interface pour n'importe quel objet.
}

function formatLanguageFields(entry: LangageEntry): LangageEntry {
  const entryCopy = { ...entry };
  const languageFields: LangageEntry = {};

  // Ici, nous parcourons toutes les clés de l'objet
  Object.keys(entryCopy).forEach((key) => {
    if (key.startsWith('display_name_')) {
      const languageKey = key.replace('display_name_', ''); // Nous obtenons la partie langue de la clé
      languageFields[languageKey] = entryCopy[key]; // Nous ajoutons la valeur à l'objet des langues
      delete entryCopy[key]; // Nous supprimons la clé originale
    }
  });

  entryCopy.language = languageFields; // Nous ajoutons l'objet des langues sous la clé 'language'

  return entryCopy;
}


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
    } else {
      // Vérifier que le systemId est un nombre valide et qu'il existe dans la base de données
      const [systemCheckResult]: any[] = await connection.query('SELECT 1 FROM system WHERE id_system = ?', [systemId]);
      if (systemCheckResult.length === 0) {
        return res.status(400).send('Système non valide');
      }
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
      console.log('y a originId');
      // Assurez-vous que l'origine est compatible avec l'espèce spécifiée
      const [queryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM origin WHERE species_id = ? AND id_origin = ?', [speciesId, originId]);
      origin = queryResult.map(entry => formatLanguageFields(entry));
    } else {
      console.log('pas originId');
      // Sélectionnez une origine aléatoire qui est compatible avec l'espèce spécifiée
      const [queryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM origin WHERE species_id = ? ORDER BY RAND() LIMIT 1', [speciesId]);
      origin = queryResult.map(entry => formatLanguageFields(entry));
    }
    
    originId = origin[0].id_origin
    console.log('====origin====', origin)
    console.log('=============');
    
    // Si l'origine a une sous-origine
    let suboriginId = req.query.suborigin || '';
    let suboriginData;

    if (suboriginId) {
      // Si suboriginId est fourni dans la requête, récupérer et formater les données correspondantes.
      const [suboriginQueryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM suborigin WHERE id_suborigin = ?', [suboriginId]);
      suboriginData = suboriginQueryResult.map(entry => formatLanguageFields(entry));
    } else {
      // Si suboriginId n'est pas fourni, vérifier si l'origine a une sous-origine et la choisir aléatoirement si c'est le cas.
      const [originQueryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM origin WHERE id_origin = ?', [originId]);
      const originData = originQueryResult;

      if (originData[0].has_suborigin) {
        const [rows]: any[] = await connection.query('SELECT * FROM suborigindistributionbyorigin WHERE origin_id_origin = ?', [originId]);
    
        let totalPercentage = 0;
        let wheel = [];
        for (const row of rows) {
          wheel.push({
            id: row.suborigin_id_suborigin,
            min: totalPercentage,
            max: totalPercentage + row.percentage,
          });
          totalPercentage += row.percentage;
        }

        const rand = Math.random() * totalPercentage;
        for (const segment of wheel) {
          if (rand >= segment.min && rand < segment.max) {
            suboriginId = segment.id;
            break;
          }
        }

        if (suboriginId) {
          const [suboriginQueryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM suborigin WHERE id_suborigin = ?', [suboriginId]);
          suboriginData = suboriginQueryResult.map(entry => formatLanguageFields(entry));
        }
      }
    }

    console.log('suboriginId', suboriginId);


    // Choix du genre
    let genderId = req.query.gender || '';
    if (!genderId) {
      const [queryResult] = await connection.query('SELECT * FROM gender ORDER BY RAND() LIMIT 1');
      gender = queryResult.map(entry => formatLanguageFields(entry));
    } else {
      const [queryResult] = await connection.query('SELECT * FROM gender WHERE id_gender = ?', [genderId]);
      gender = queryResult.map(entry => formatLanguageFields(entry));
    }

    // gender = queryResult[0] as RowDataPacket[];
    genderId = gender[0].id_gender;

    // Choix du prénom et du nom
    const [firstname]: any[] = await connection.query('SELECT firstname.label AS prenom FROM firstname WHERE gender_id_gender = ? AND suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [genderId, suboriginId]);
    const [lastname]: any[] = await connection.query('SELECT lastname.label AS nom FROM lastname WHERE suborigin_id_suborigin = ? ORDER BY RAND() LIMIT 1', [suboriginId]);

    // Choix de la photo
    const [photo]: any[] = await connection.query('SELECT * FROM photo ORDER BY RAND() LIMIT 1');

    // Choix du travail
    const [workQueryResult] = await connection.query<RowDataPacket[]>('SELECT id_work, label, logo_work FROM work ORDER BY RAND() LIMIT 1');
    const workData = workQueryResult[0]; // Supposons que workQueryResult ne soit jamais vide.
    
    // Obtenez les noms de travail pour tous les langages de la table 'list_gender_work' pour le 'workId' spécifique.
    const [namesQueryResult] = await connection.query<RowDataPacket[]>('SELECT * FROM list_gender_work WHERE work_id_work = ?', [workData.id_work]);
    
    // Créez un objet qui contiendra les noms de travail formatés pour tous les langages.
    let workNamesFormatted = {};
    
    // S'il existe des noms de travail, appliquez la fonction formatLanguageFields.
    if (namesQueryResult.length > 0) {
      workNamesFormatted = formatLanguageFields(namesQueryResult[0]);
    }
    
    console.log('namesFormatted', workNamesFormatted);
    
    // Construisez l'objet de sortie pour 'work', incluant maintenant les champs de langue.
    const workOutput = {
      id: workData.id_work,
      label: workData.label,
      logo: workData.logo_work,
      language: workNamesFormatted.language // Cela contiendra des clés comme 'fr', 'en', etc.
    };
    // Choix du système
    const [system]: any[] = await connection.query('SELECT * FROM system WHERE id_system = ?', [systemId]);
    const formattedSystem: LangageEntry[] = system.map(entry => formatLanguageFields(entry));

    // Choix des espèces
    const [species]: any[] = await connection.query('SELECT * FROM species WHERE id_species = ?', [speciesId]);
    const formattedSpecies: LangageEntry[] = species.map(entry => formatLanguageFields(entry));


    result = {
      system: formattedSystem,
      personalInfo: {
        firstname: firstname[0].prenom,
        lastname: lastname[0].nom,
        gender: gender,
        lineage: {
          species: formattedSpecies,
          origin: origin,
          suborigin: suboriginData,
        }
      },
      photo: photo[0],
      work: workOutput,
    };
    console.log('===============');

    res.json(result);
  } catch (error) {
    console.error('Erreur lors de la création du PNJ :', error);
    res.status(500).send('Erreur interne du serveur');
  }
});




export default router;