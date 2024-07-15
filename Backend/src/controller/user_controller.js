const UserService = require('../services/user_services');


// function that call registerUser from service file and req,res for routes
exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const successRes = await UserService.registerUser(email, password);
        res.status(200).json({ status: true, success: "User Registered Successfully" });
    } catch (e) {
        console.error(e);
        res.status(500).json({ status: false, message: "An error occurred during registration", error: e.message });
    }
};

// function that call loginUser from service file and req,res for routes
exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserService.checkUser(email);
        console.log(user);

        if (!user) {
            return res.status(404).json({ status: false, message: "User not found" });
        }

        const isMatch = await user.comparePasswords(password);

        if (!isMatch) {
            return res.status(401).json({ status: false, message: "Password is incorrect" });
        }

        let tokenData = { _id: user._id, email: user.email };

        const token = await UserService.generateToken(tokenData, "DevPalsanawala", '1h');
        res.status(200).json({ status: true, token: token });
    } catch (e) {
        console.error(e);
        res.status(500).json({ status: false, message: "An error occurred", error: e.message });
    }
};

