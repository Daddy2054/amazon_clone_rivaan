// imports from packages
const express = require('express');
//imports from other files

const authRouter = require('./routes/auth');
// init
const PORT = 3000;
const app = express();


app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});