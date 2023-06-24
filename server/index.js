// imports from packages
const express = require('express');
const mongoose = require('mongoose');
//imports from other files

const authRouter = require('./routes/auth');

// init
const PORT = 3000;
const app = express();

//middleware
//client -> middleware -> server -> client
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect('mongodb://mongoadmin:secret@127.0.0.1:27017/?authMechanism=DEFAULT').then(() => {
    
    console.log('Connection Successful');
}).catch((e) => { console.log(e); });


app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});