console.log('hello world');
const express = require('express');

const PORT = 3000;
const app = express();

//creating an api
//get,put,post,delete,update -> CRUD
app.get('/hello-world', (req, res) => {
    res.send('hello-world');
//    res.json({hi:'hello-world'});

});
app.get('/hi-world', (req, res) => {
    res.send('hi-world');
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`connected at port ${PORT}`);
});