const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');

//sign up
authRouter.post('/api/signup', async (req, res) => {
    try {

        //get the data from the client
        const { name, email, password } = (req.body);

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: 'User with the same email already exists' });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email, password: hashedPassword, name,
        });
        //     console.log(user);
        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

    //post that data to the database

    //return that data to the user
});

// signin route
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = (req.body);
        const user = await User.findOne({ email });
        if (!user) {
            return res
                .status(400)
                .json({ msg: 'User with the this email does not exists!', },);
        }
        const isMatch = await bcryptjs.compare(password, user.password,);
        if (!isMatch) {
            return res
                .status(400)
                .json({ msg: 'Incorrect password.', },);
        }

const token = jwt.sign({id: user._id},'passwordKey');
res.json({token,...user._doc});
    } catch (error) {
        res.status(500).json({ error: e.message });

    }
});


module.exports = authRouter;