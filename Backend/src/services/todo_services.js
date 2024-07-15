const TodoModel = require('../model/todolist');

class TodoServices {
    static async createTodo(userId, title, desc) {
        try {
            const createTodo = new TodoModel({ userId, title, desc });
            return await createTodo.save();
        } catch (error) {
            throw error;
        }

    }
    static async getTodo(userId) {
        try {
            const getTodo = await TodoModel.find({ userId });
            return getTodo;
        } catch (error) {
            throw error;
        }


    }
    static async deleteTodo(id) {
        try {
            const Tododata = await TodoModel.findOneAndDelete({ _id: id });
            return Tododata;
        } catch (error) {
            throw error;
        }

    }
}

module.exports = TodoServices;