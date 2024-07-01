const  express = require('express');
const http = require('http');
const  app = express();
const PORT = process.env.PORT || 5050

// Middleware to parse JSON bodies
app.use(express.json());

const { users } = require('./collections/users.js')
app.get('/users', users);

const { main } = require('./services/haversine_service.js');
const { vendors } = require('./collections/vendors.js');


// const listOfRestaurants = new Set();
// module.exports = {listOfRestaurants};

app.get('/vendors', vendors);

app.get('/', async (req, res) => {
    await res.send('This is my demo project')
    });

    app.post("/api/sending_location", async(req, res) => {
        console.log("Result", req.body);

        const locationData = {
            "lat": req.body.lat,
            "long": req.body.long
        }

        const array = await main(req.body.lat, req.body.long);
        console.log(array);

        res.status(200).send({
            "status-code" : '200', 
            "message" : "Location send successfully and got the list of vectorIds within 10km of range",
            "location" : locationData,
            "listOfRestaurants" : array
        })
    });

    app.listen(PORT, function () {
    console.log(`Demo project at: ${PORT}!`);});