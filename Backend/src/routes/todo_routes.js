const router = require('express').Router();
const TodoController = require('../controller/todo_controller');

router.post('/todoCreate', TodoController.createTodo);
router.post('/getTodo', TodoController.getTodo);
router.post('/deleteTodo', TodoController.deleteTodo);



module.exports = router;