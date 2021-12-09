const express = require('express');
const exphbs = require('express-handlebars');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Parse application/json 
app.use(require("body-parser").urlencoded({extended:true}));

// Static files
app.use(express.static(__dirname + '/public'));

// Templating engine 
app.engine('hbs', exphbs( {extname: 'hbs'}));
app.set('view engine', 'hbs');

const routes = require('./server/routes/routes');
app.use('/', routes);

app.listen(port, () => console.log(`Listening on port ${port}`));
