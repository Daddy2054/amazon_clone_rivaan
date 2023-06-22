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
mongoose.connect('mongodb+srv://m201-user:mq244nt64wguvuhe@cluster0.tnppbvu.mongodb.net/?retryWrites=true&w=majority').then(() => {
    console.log('Connection Successful');
}).catch((e) => { console.log(e); });


app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});