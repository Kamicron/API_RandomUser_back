import { Request, Response, NextFunction } from 'express';

export const verifyToken = (req: Request, res: Response, next: NextFunction) => {
  const token = req.headers['x-access-token'];
  
  if (token === "public") {
      next();
  } else {
      res.status(403).send('Unauthorized');
  }
};
