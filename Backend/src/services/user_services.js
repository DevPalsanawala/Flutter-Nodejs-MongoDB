const UserModel = require('../model/user');
const JWT = require('jsonwebtoken');


// class and function for save or store data 
class UserService {
    // register
    static async registerUser(email, password) {
        try {
            const createUser = new UserModel({ email, password });
            return await createUser.save();
        } catch (e) {
            throw e;
        }
    }
    //login
    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (e) {
            throw e;
        }
    }

    static async generateToken(tokenData, secretkey, jwt_expire) {
        return JWT.sign(tokenData, secretkey, { expiresIn: jwt_expire });

    }
}

module.exports = UserService;