const express = require('express')
const app = express();
const bodyParser = require('body-parser')
//const responseHelper = require('express-response-helper').helper();
const port = process.env.PORT || 8080;
const resepRouter = require('./routes/resep')



app.use(bodyParser.json());
app.use(responseHelper);

app.use(resepRouter);


app.get("/", async (req, res) => {
    res.json({ status: "Response to this server is success" });
});

app.get("*", async (req, res) => {
    res.json({ status: "Route doesn't exist!"})
})


app.listen(port, () => {
    console.log(`This server is running on port ${port}`)
});
