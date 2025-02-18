const express = require('express')
const routes = express.Router()
const {login}  = require('../controllers/loginController')
const {register}  = require('../controllers/registerController')

routes.post('/login', login);
routes.post('/register', register);

module.exports = routes;