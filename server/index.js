const  express = require('express');
const http = require('http');
const  app = express();
const PORT = process.env.PORT || 5050

const { users } = require('./collections/users.js')
app.get('/users', users);

const { main } = require('./services/haversine_service.js');
app.get('/vendors', main);

app.get('/', (req, res) => {
    res.send('This is my demo project')
    })

    app.listen(PORT, function () {
    console.log(`Demo project at: ${PORT}!`);});