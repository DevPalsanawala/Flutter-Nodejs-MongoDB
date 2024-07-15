const app = require('./app');
const db = require('./src/conn/db');
const UserModel = require('./src/model/user');
const TodoModel = require('./src/model/todolist');


const port = 2000;

app.get('/', (req, res) => {
    res.send("hello world!");
});

app.listen(port, () => {
    console.log(`listening on port http://localhost:${port}`);
});