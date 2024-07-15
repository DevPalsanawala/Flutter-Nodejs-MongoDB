const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/ToDoDatabase').on('open', () => {
    console.log("Mongodb connected");
}).on('error', () => {
    console.log("Mongodb connection error");
});

module.exports = connection;