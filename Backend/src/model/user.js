const mongoose = require('mongoose');
const db = require('../conn/db');
const bcrypt = require('bcrypt');

const { Schema } = mongoose;

const userschema = new Schema({
    email: {
        type: String,
        lowercase: true,
        require: true,
        unique: true
    },
    password: {
        type: String,
        require: true
    }
});

// encryption of password and store it
userschema.pre('save', async function () {
    try {
        var user = this; // get userschema in user
        const salt = await (bcrypt.genSalt(10)); //encryption algorithm
        const hashpass = await bcrypt.hash(user.password, salt);//hash function for encrypting password
        user.password = hashpass; //store in database
    }
    catch (e) {
        throw e;
    }
});

userschema.methods.comparePasswords = async function (userPassword) {
    try {
        const isMatch = await bcrypt.compare(userPassword, this.password);
        return isMatch;
    }
    catch (e) {
        throw e;

    }
}

const UserModel = db.model('User', userschema);

module.exports = UserModel;