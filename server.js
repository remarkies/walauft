let express = require("express");
let app = express();
let http = require("http").Server(app);
let path = require("path");
let serveStatic = require("serve-static");
let fs = require("fs");

// serve the index.html as starting page
app.get("/", function(req, res) {
  res.sendFile(path.join(__dirname, "dist", "index.html"));
});

// serve all files in dist
app.use(express.static("dist"));

http.listen(process.env.PORT || 3000, function() {
  console.log(`listening on *: ${http.address().port}`);
});