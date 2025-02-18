const connect = require('../models/base')

exports.login = (req, res) => {
  const { email, password } = req.body
  const query = 'SELECT * FROM users WHERE email = ? AND password = ?'

  //Verification des champs email et password
  //si le champs email est vide ou null
  connect.query(query, [email], async (err, resultat) => {
    if (err) {
      console.log(err)
      return res.status(500).json({ message: 'Erreur serveur' })
    }
    if (resultat.length === 0) {
      return res
        .status(404)
        .json({
          message: "Email n'existe pas ou l'Utilisateur n'est pas trouvé"
        })
    };

    //verification du mot de passe
    const user = resultat[0]
    const PasswordValid = await bcrypt.compare(password, user.password)
    if (!PasswordValid) {
      return res.status(401).json({ message: 'Mot de passe incorrect' }) 
    };

    //création du token 
    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
        expresIn: '2h'
      });
    res.status(200).json({message: 'Connexion réussie', token: token})
  })
}
