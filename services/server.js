
const express = require('express')
const app = express()
const bodyParser = require('body-parser');
const port = 7788

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));


app.post("/api/login", function (request, response) {
    if(!request.body) return response.sendStatus(400);
    response.json(
        {
            status : "success",
            statusCode : 200,
            body : request.body.username
        }
    )
});

app.get("/api", function(require,response) {
   console.log("dasdasdasd");
});

app.listen(port, function() {
    console.log(`Express server listening on port ${port}`);

});