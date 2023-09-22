import { Personnage } from '../models/personnage';
import { db } from '../config/db';

export const generateRandomPersonnage = async (): Promise<Personnage> => {
  const personnage = {
    id: 1,
    prenom: "Ludovic",
    nom: "Chevroulet",
    photo: "image.png",
    nationalite: "Francaise",
  }
    // Logique pour générer un personnage
    // ...
    // Insertion dans la base de données
    // ...
    
    return personnage;
};
