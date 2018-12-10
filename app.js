//1. Import
var Tx = require('ethereumjs-tx');
var express = require('express');
var path = require('path');
var admin = require("firebase-admin");
var Web3 = require("web3");
var bodyParser = require("body-parser");

//2. Initiate
const app = express();
const web3 = new Web3('https://ropsten.infura.io/v3/0227709e2cbe46c0bc6224e55a068a03');

//3. Configure
app.set("view engine","ejs");
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

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
    privateKey: '-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDBPxhY9SJNPPDt\nFC/zZCBoXQKZ2HmcbYEHjmDKxQ7IejWoXMRQSrz8YQfYAKR9e7Bq9g5ab5DecfWf\nVPcz/6qB/iqvXP2o0WzqaqjhhP9AB2EXF/AUy+7NMEVbO+lfFC5GwBXNt6Jforvd\n9t5uTuUvDti+5Dl596u4i32ca/aamTcNvw1DUd/epKoMZcp3WtQhjPrhD9fr8gP3\n6NU9GtjE2GPfqhNOhYARA+CsBm+SDXyaiwPoKRY0VrEsO39FmO9rK6Vzs4mTyhqP\noOxwzZCU4zFpR6iI+VGVqVgPdLON/NAE/gpVfWc38j8jvklT2xi0bROghV5yI5/y\nSh2jz2lnAgMBAAECggEADy4Bn5tB4odS9YyMZ7YJxajot2UFyH/hjtJkUAlCrATN\ni'
    +'jgfQ59bUQfeMd17DlBU/1HstrXkz1RsUuO9t1vx7NwmRjgrxMMOpytRsMVdt43c\n1o+O0FNkosGT8SK3pjxTlkMoc0xleNWzpC/sMQYJgrTL2dLboPUPjCOI7mycpnAX\nj4pFfnEhrdbHd/Wfi8G3ZjZCBjEiNQLcMrldpQij1X+/ioc3Zhs/Yrz2s/zNlMKS\nCtImHuLI918S4oPHKBMB2h/a44BO2SXhmxYPRSIrjQTDoEm4xwiSD/3a3LDOme9i\nKeABDwM5qItcTqWDPvPqHddlfVaB9/5DILuPbMQ5oQKBgQDxY0w0PMN7po8+ffeP\nXJh9FK6oavKNxozMTCIBA32esQJxjkowj8oOzpJ0sXVTrZbd5rMMKDBm/qZor3Lv\nR4qgasiF29KdNjqP2zWlfdjMB+FqAXhDSgevt/FGQ7K3bs2Xnzr7cM9y4eYhoRdr\nkkldeP2oqw'
    +'YyjbXfIbSFfRnIowKBgQDM8cRZr7MvKSR48jrvpe9WDyxIsTu0D0NX\nnflVmPp5OaZa1R3ARHfv3iyGyN0D8ftamvhX+NC13ZGJ2b3v4ByI1CTQQmLlIdnM\nTDSodMYwM+DtJYFecf9Nf9Ypie8sUjTI8bA27GxHsRkzfWO9HIOOMNFQ3W2zn/3P\nL7rIeHrUbQKBgFNAhwjBKD6ePGs2MMqeCe2h03c8o3koUGkpnNSyqoGv1QLrK0VC\nYlLnBfX/OlLo3M6dgYUg20i6bRRP5pkGGJapHY2lOieEi4AP/5mbJMmBsknIRf0X\nLD17eFheguXm7jtr7IDJ8JJTvPY+RACSzIDTeNDSY2nOHDrfug4MDnd3AoGBAMj0\nQ0iBvJwApo+lTN7RgRWMeSqqBlWvJaQS9XnWL7uQKKsmDy8Is+XSnyxmZjjJHGKi\nU+LGybeaE2vswo4j3Tb'
    +'ZdWNzxM7R22K0UmnfXrnDFMjTnr+B3gka0V8XrhpyXOmv\n+s5QEnhVkdVoHNVA0UoqWgQFqtyXg2KVdXu+jwodAoGAb5K4K2SfeAkLDbuGwm0w\nER2WgAUWriCLMTTZkHciW3xbKGnZtJvlWUQPu7kACbQzZUIZqWjdCwCbnm0koJDs\nCGkWVYNPbjDWsoYQwBwbrVDUOaqzc+LY0aajZdZpgLuut63y0Vx1BZ+hqJ/uzoiL\ncaXm3AAPAYY7YZCUEza1ILg=\n-----END PRIVATE KEY-----\n'
  }),
  databaseURL: "https://cryptocasa-be005.firebaseio.com"
});
var db = admin.database();
var ref = db.ref("Listings"); // The Database table

//6. Set Web3 information for function executions
// The account initiating transactions
const account = '0xf47823540093Ef501f24217AF427cd4D388cc138';
const privateKey = Buffer.from('2B606F269D2E820B7373A1BB19C1A5E36972DC756386476D181E8FB34C26DCB5', 'hex');
web3.eth.defaultAccount = account;
const abi =[{"constant":false,"inputs":[{"name":"newDest","type":"address"}],"name":"setDestination","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"renter","type":"address"}],"name":"payout","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"costOfStay","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"totalPrice","type":"uint256"}],"name":"payContract","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"destinationAddress","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"renter","type":"address"}],"name":"refund","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"homeOwner","type":"address"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"destination","type":"address"}],"name":"LogChangedAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"price","type":"uint256"}],"name":"LogChangedPrice","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"amount","type":"uint256"}],"name":"LogPayout","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"amount","type":"uint256"}],"name":"LogRefund","type":"event"}];
const byteCode ='0x608060405234801561001057600080fd5b50604051602080610a268339810180604052602081101561003057600080fd5b8101908080519060200190929190505050336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550670de0b6b3a7640000600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200190815260200160002081905550506109088061011e6000396000f3fe608060405260043610610072576000357c0100000000000000000000000000000000000000000000000000000000900480630a0a05e6146100835780630b7e9c44146100d45780633468c2ce14610125578063c31d8a821461018a578063ca325469146101b8578063fa89401a1461020f575b60003410151561008157600080fd5b005b34801561008f57600080fd5b506100d2600480360360208110156100a657600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610260565b005b3480156100e057600080fd5b50610123600480360360208110156100f757600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610342565b005b34801561013157600080fd5b506101746004803603602081101561014857600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506104be565b6040518082815260200191505060405180910390f35b6101b6600480360360208110156101a057600080fd5b81019080803590602001909291905050506104d6565b005b3480156101c457600080fd5b506101cd6106ae565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34801561021b57600080fd5b5061025e6004803603602081101561023257600080fd5b81019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506106d4565b005b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415156102bb57600080fd5b8073ffffffffffffffffffffffffffffffffffffffff167fce09005f55ddcf8c5440222499ad1d769b4e6d10258d06fbdbdb1f9c1f81024560405160405180910390a280600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555050565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561039d57600080fd5b7fa618b3c1f51d8c11458f5dc932e499ace1f605df16ed8292dd173844ffe8ac08600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546040518082815260200191505060405180910390a1600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc600260008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549081150290604051600060405180830381858888f193505050501580156104ba573d6000803e3d6000fd5b5050565b60026020528060005260406000206000915090505481565b670de0b6b3a7640000810234101515156104ef57600080fd5b670de0b6b3a76400008102600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020819055506000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc660aa87bee5380009081150290604051600060405180830381858888f193505050501580156105ab573d6000803e3d6000fd5b50600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020543073ffffffffffffffffffffffffffffffffffffffff16311015156106ab573373ffffffffffffffffffffffffffffffffffffffff166108fc600260003373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020543073ffffffffffffffffffffffffffffffffffffffff1631039081150290604051600060405180830381858888f193505050501580156106a9573d6000803e3d6000fd5b505b50565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614801561077057506000600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205414155b80156107d257503073ffffffffffffffffffffffffffffffffffffffff1631600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020016000205411155b15156107dd57600080fd5b7f9759512babe20034ffd67382ea5b66e115df6139eadf0e074da360eddf984c36600260008373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020546040518082815260200191505060405180910390a18073ffffffffffffffffffffffffffffffffffffffff166108fc600260008473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff168152602001908152602001600020549081150290604051600060405180830381858888f193505050501580156108d8573d6000803e3d6000fd5b505056fea165627a7a7230582019d717466384b313c9feeecefefe62dd9a8907ceaefd669b4e8513da4e9832d30029';
//7. POST Requests come in frmo Swift and execute contract transaction
app.post('/create', function(req, res){

  /* Format the JSON string properly b/c it comes in broken for whatever reason */
  var listing = JSON.stringify(req.body, null, ' ').slice(2,-6);
  listing = JSON.parse(JSON.parse(listing)); // JSON { ListingID, PrivateKey }
  /* Get the home owners' walletID from firebase */
  ref.child(listing.ListingID).child("WalletID").on("value", function(walletID) {
    /*Send the transaction fee to the function caller account(~$1) and deploy the contract*/
    web3.eth.getTransactionCount(walletID.val(), (err, txCount) => {
      const txObject = {
        nonce: web3.utils.toHex(txCount),
        gasLimit: web3.utils.toHex(2000000),
        gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
        to: account,
        value: web3.utils.toHex(web3.utils.toWei('1', 'finney'))
      }

      /* Sign the transaction with the pk*/
      const tx = new Tx(txObject);
      tx.sign(Buffer.from(listing.PrivateKey, 'hex'));
      const serializeTx = tx.serialize();
      const raw = '0x' + serializeTx.toString('hex');

      /* Send the dollar to the function caller wallet */
      web3.eth.sendSignedTransaction(raw, (err, txHash) => {
        if(err == null){
          console.log('txHash:', txHash);
        }
        else {
          console.log("error:", err)
        }
      });

      /* contract deployment information*/
      var arguments = [walletID.val()];
      console.log(arguments);
      var contractOptions = {data: byteCode, arguments: arguments}

      /* Make the contract*/
      var transferContract = new web3.eth.Contract(abi);
      var deploy = transferContract.deploy(contractOptions).encodeABI()
      web3.eth.getTransactionCount(account, (err, txCount) => {
        const txObject = {
          nonce: web3.utils.toHex(txCount),
          gasLimit: web3.utils.toHex(2000000),
          gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
          data: deploy
        }
        const tx = new Tx(txObject);
        tx.sign(privateKey);
        const serializeTx = tx.serialize();
        const raw = '0x' + serializeTx.toString('hex');

        /*Deploy contract*/
        var errMsg;
        web3.eth.sendSignedTransaction(raw, (err, txHash) => {
          errMsg = err;
          if(err == null){
            console.log('txHash:', txHash);
            res.send("true");
          }
          else {
            console.log("error:", err);
            res.send("false");
          }
        }).on('receipt', (receipt) => {
          console.log(receipt.contractAddress);
          ref.child(listing.ListingID).update({
            "ContractID": receipt.contractAddress
          });
        }); // When the contract execution succeeds get the address of the contract and save to firebase
      }); // getTransactionCount 2
    }); // getTransactionCount 1
  }); // walletID
}); // post

/* Take funds from the renter and send to the contract */
app.post('/payContract', function (req, res) {
 //  var rentalInfo =
 //  {
 //    PrivateKey: '18F1CB0F03207F6CE9ED3B8D7B8FEDB06C12667CEDF32C1EB8B4D26BC8873F14',
 //    ContractID: '0xB762635e98165d540a36e34B9a1E272DF852687D',
 //    WalletID: '0x28C96cA35019E4A7f161c8dF4F7c3247B4EA8479',
 //    Price: '1'
 // };
  var rentalInfo = JSON.stringify(req.body, null, ' ').slice(2,-6); // Need to fix the JSON, object for whatever stupid reason it comes in broken
  rentalInfo = JSON.parse(JSON.parse(rentalInfo)); // JSON { TotalPrice, Renter, PrivateKey, ContractiD }
  console.log(rentalInfo);
  /* Pay the smart contract the cost of the stay */
  const casaContract = new web3.eth.Contract(abi, rentalInfo.ContractID);
  var data = casaContract.methods.payContract(rentalInfo.Price).encodeABI();
  var payment = parseInt(rentalInfo.Price) + 0.003;
  payment = payment.toString();
  web3.eth.getTransactionCount(rentalInfo.WalletID, (err, txCount) => {
    const txObject = {
      nonce: web3.utils.toHex(txCount),
      gasLimit: web3.utils.toHex(2000000),
      gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
      to: rentalInfo.ContractID,
      data: data,
      value: web3.utils.toHex(web3.utils.toWei(payment, 'ether'))
    }
    const tx = new Tx(txObject);
    tx.sign(Buffer.from(rentalInfo.PrivateKey, 'hex'));
    const serializeTx = tx.serialize();
    const raw = '0x' + serializeTx.toString('hex');

    /*Pay contract*/
    web3.eth.sendSignedTransaction(raw, (err, txHash) => {
      if(err == null){
        console.log('txHash:', txHash);
      }
      else {
        console.log("error:", err)
      }
    }).then(function(payout){
      /* Call the payout function --- */
      data = casaContract.methods.payout(rentalInfo.WalletID).encodeABI();
      web3.eth.getTransactionCount(account, (err, txCount) => {
        const txObject = {
          nonce: web3.utils.toHex(txCount),
          gasLimit: web3.utils.toHex(200000),
          gasPrice: web3.utils.toHex(web3.utils.toWei('10', 'gwei')),
          to: rentalInfo.ContractID,
          data: data
        }
        const tx = new Tx(txObject);
        tx.sign(privateKey);
        const serializeTx = tx.serialize();
        const raw = '0x' + serializeTx.toString('hex');
        /*Payout*/
        web3.eth.sendSignedTransaction(raw, (err, txHash) => {
          if(err == null){
            console.log('txHash:', txHash);
            res.send("true");
          }
          else {
            console.log("error:", err);
            res.send("false");
          }
        });

      }); //getTransactionCount // call payout after we receive funds
    }); // .then
  }); // getTransactionCount
}); // post
