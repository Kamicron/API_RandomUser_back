import express from 'express';
import { getConnection } from '../config/db';

const router = express.Router();

router.get('/ethnic-distribution-by-nationality', async (req, res) => {
  try {
    const connection = getConnection();
    
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
    
    const result = rows.reduce((acc, row) => {
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
    
    res.json(result);
  } catch (error) {
    console.error('Erreur lors de la récupération des données : ', error);
    res.status(500).send('Erreur interne du serveur');
  }
});

export default router;
