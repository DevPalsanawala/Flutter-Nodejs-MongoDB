const router = require('express').Router();
const UserController = require('../controller/user_controller');


// user registration route
router.post('/registration', UserController.register); // called user registration fuction from controller
router.post('/login', UserController.login); // called user login fuction from controller


module.exports = router;