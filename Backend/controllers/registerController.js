const connect = require('../models/base')
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.register = async (req, res) => {
    const {username, email, password} = req.body;
    try {
        const hashedPassword = await bcrypt.hash(password, 15);
        const query = 'INSERET INTO users (username, email, passsword) VALUES (?,?,?)';
        connect.query(query [username, email, hashedPassword], (err)=> {
            if(err) {
                return res.status(500).json({message :'Erreur serveur'});
            }
            res.status(201).json({message : 'Utilisateur créé avec succès'});
        })
    } catch (error) {
        res.status(500).json({message : 'Erreur lors de l\'incription '})
    }
}