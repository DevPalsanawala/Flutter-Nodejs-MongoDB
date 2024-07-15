const TodoServices = require('../services/todo_services');

exports.createTodo = async (req, res, next) => {
    try {
        const { userId, title, desc } = req.body;

        // Validate request body
        if (!userId || !title || !desc) {
            return res.status(400).json({ status: false, message: 'Missing required fields' });
        }

        let todo = await TodoServices.createTodo(userId, title, desc);
        res.status(200).json({ status: true, success: todo });
    } catch (error) {
        console.error('Error creating todo:', error);
        res.status(500).json({ status: false, message: 'Failed to create todo', error: error.message });
    }
};

exports.getTodo = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let todo = await TodoServices.getTodo(userId);
        res.status(200).json({ status: true, success: todo });
    } catch (error) {
        console.error('Error geting todo:', error);
        res.status(500).json({ status: false, message: 'Failed to get todo', error: error.message });
    }
};

exports.deleteTodo = async (req, res, next) => {
    try {
        const { id } = req.body;
        let deletetodo = await TodoServices.deleteTodo(id);
        res.status(200).json({ status: true, success: deletetodo });
    } catch (error) {
        console.error('Error deleting todo:', error);
        res.status(500).json({ status: false, message: 'Failed to delete todo', error: error.message });
    }
};