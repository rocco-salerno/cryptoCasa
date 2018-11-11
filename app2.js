//1. Import
var express = require('express');
var path = require('path');
var routes = require('./routes/route.js');
// Import Admin SDK
var admin = require("firebase-admin");
// var web3 = require("web3");

//2. Initiate
var app = express();


//3. Configure
app.set("view engine","ejs");
app.use(express.static(path.join(__dirname, 'public')));
app.get("/",routes.home);


//4. Listen
var port = process.env.PORT || 8080;
var server = app.listen(port,
    function(request,response)
    {
        console.log("Catch the action at http://localhost:" + port);
    }
);

//5. Get a database reference to our posts

// Load database instance
admin.initializeApp({
  credential: admin.credential.cert({
    projectId: 'cryptocasa-be005',
    clientEmail: 'firebase-adminsdk-12zqi@cryptocasa-be005.iam.gserviceaccount.com',
    privateKey: '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBPxhY9SJNPPDt\nFC/zZCBoXQKZ2HmcbYEHjmDKxQ7IejWoXMRQSrz8YQfYAKR9e7Bq9g5ab5DecfWf\nVPcz/6qB/iqvXP2o0WzqaqjhhP9AB2EXF/AUy+7NMEVbO+lfFC5GwBXNt6Jforvd\n9t5uTuUvDti+5Dl596u4i32ca/aamTcNvw1DUd/epKoMZcp3WtQhjPrhD9fr8gP3\n6NU9GtjE2GPfqhNOhYARA+CsBm+SDXyaiwPoKRY0VrEsO39FmO9rK6Vzs4mTyhqP\noOxwzZCU4zFpR6iI+VGVqVgPdLON/NAE/gpVfWc38j8jvklT2xi0bROghV5yI5/y\nSh2jz2lnAgMBAAECggEADy4Bn5tB4odS9YyMZ7YJxajot2UFyH/hjtJkUAlCrATN\nijgfQ59bUQfeMd17DlBU/1HstrXkz1RsUuO9t1vx7NwmRjgrxMMOpytRsMVdt43c\n1o+O0FNkosGT8SK3pjxTlkMoc0xleNWzpC/sMQYJgrTL2dLboPUPjCOI7mycpnAX\nj4pFfnEhrdbHd/Wfi8G3ZjZCBjEiNQLcMrldpQij1X+/ioc3Zhs/Yrz2s/zNlMKS\nCtImHuLI918S4oPHKBMB2h/a44BO2SXhmxYPRSIrjQTDoEm4xwiSD/3a3LDOme9i\nKeABDwM5qItcTqWDPvPqHddlfVaB9/5DILuPbMQ5oQKBgQDxY0w0PMN7po8+ffeP\nXJh9FK6oavKNxozMTCIBA32esQJxjkowj8oOzpJ0sXVTrZbd5rMMKDBm/qZor3Lv\nR4qgasiF29KdNjqP2zWlfdjMB+FqAXhDSgevt/FGQ7K3bs2Xnzr7cM9y4eYhoRdr\nkkldeP2oqwYyjbXfIbSFfRnIowKBgQDM8cRZr7MvKSR48jrvpe9WDyxIsTu0D0NX\nnflVmPp5OaZa1R3ARHfv3iyGyN0D8ftamvhX+NC13ZGJ2b3v4ByI1CTQQmLlIdnM\nTDSodMYwM+DtJYFecf9Nf9Ypie8sUjTI8bA27GxHsRkzfWO9HIOOMNFQ3W2zn/3P\nL7rIeHrUbQKBgFNAhwjBKD6ePGs2MMqeCe2h03c8o3koUGkpnNSyqoGv1QLrK0VC\nYlLnBfX/OlLo3M6dgYUg20i6bRRP5pkGGJapHY2lOieEi4AP/5mbJMmBsknIRf0X\nLD17eFheguXm7jtr7IDJ8JJTvPY+RACSzIDTeNDSY2nOHDrfug4MDnd3AoGBAMj0\nQ0iBvJwApo+lTN7RgRWMeSqqBlWvJaQS9XnWL7uQKKsmDy8Is+XSnyxmZjjJHGKi\nU+LGybeaE2vswo4j3TbZdWNzxM7R22K0UmnfXrnDFMjTnr+B3gka0V8XrhpyXOmv\n+s5QEnhVkdVoHNVA0UoqWgQFqtyXg2KVdXu+jwodAoGAb5K4K2SfeAkLDbuGwm0w\nER2WgAUWriCLMTTZkHciW3xbKGnZtJvlWUQPu7kACbQzZUIZqWjdCwCbnm0koJDs\nCGkWVYNPbjDWsoYQwBwbrVDUOaqzc+LY0aajZdZpgLuut63y0Vx1BZ+hqJ/uzoiL\ncaXm3AAPAYY7YZCUEza1ILg=\n-----END PRIVATE KEY-----\n'
  }),
  databaseURL: "https://cryptocasa-be005.firebaseio.com"
});

var db = admin.database();
var ref = db.ref("Customers"); // The Database table
//ref.child is the home we will be renting
ref.child("g2bQU9N9JpPU4YSSY5BI7yntBp23").child("Price").on("value", function(price) {
  ref.child("g2bQU9N9JpPU4YSSY5BI7yntBp23").child("WalletID").on("value", function(walletID) {
    // Create contract
    console.log(price.val());
    console.log(walletID.val());

  });


});
// Attach an asynchronous callback to read the data at our posts reference
// ref.once("value", function(snapshot) {
//   console.log(snapshot.val());
// }, function (errorObject) {
//   console.log("The read failed: " + errorObject.code);
// });
