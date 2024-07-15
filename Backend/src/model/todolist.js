const mongoose = require('mongoose');
const db = require('../conn/db');
const UserModel = require('../model/user')

const { Schema } = mongoose;

const todoschema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName,
    },
    title: {
        type: String,
        required: true,
    },
    desc: {
        type: String,
        required: true,
    },

});

const TodoModel = db.model('ToDo', todoschema);

module.exports = TodoModel;