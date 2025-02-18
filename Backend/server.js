const express = require ('express')
const app = express()
const cors = require('cors')
const dotenv =  require('dotenv')
const port = 3000


dotenv.config();
const authRoutes = require ('./routes/auth')

app.use(cors());
app.use(express.json());

app.use('/api/auth', authRoutes);


app.listen(port, () => {
    console.log(`le server a démarré sur le port ${port}`);
})