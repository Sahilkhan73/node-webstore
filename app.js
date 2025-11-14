// app.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Welcome to Sahil\'s Web Store!');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
