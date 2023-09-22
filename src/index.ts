import express from 'express';
import router from './routes';
import { verifyToken } from './middlewares/verifyToken';

const app = express();
const port = 3001;

app.use(verifyToken);
app.use('/api', router);

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
