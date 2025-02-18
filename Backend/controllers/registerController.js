const db = require('../models/base');
const bcrypt = require('bcrypt');

// Inscription
exports.register = async (req, res) => {
  const { username, email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const query = 'INSERT INTO users (username, email, password) VALUES (?, ?, ?)';
    db.query(query, [username, email, hashedPassword], (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ message: 'Utilisateur créé avec succès' });
    });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de l’inscription' });
  }
};