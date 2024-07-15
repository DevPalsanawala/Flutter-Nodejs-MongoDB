const express = require('express');
const bodyParser = require('body-parser');
const userRoute = require('./src/routes/user_routes');
const todoRoute = require('./src/routes/todo_routes');

const app = express();

app.use(bodyParser.json());
app.use("/", userRoute);
app.use("/", todoRoute);


module.exports = app;