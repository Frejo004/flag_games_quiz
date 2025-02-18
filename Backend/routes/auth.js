const express = require('express')
const routes = require('./routes')
const {login, register}  = require('/controllers/login')
const {login, register}  = require('/controllers/register')

 routes.post('/login', login);
 routes.post('/register', register);

 export default routes;