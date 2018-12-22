pragma solidity ^0.5.1;


contract Transfer {

    address payable contractCreator;
    address payable public destinationAddress;
    //uint public price;
    // Event trigger
    event LogChangedAddress(address indexed destination);
    event LogChangedPrice(uint price);
    event LogPayout(uint amount);
    event LogRefund(uint amount);
    //Transaction log
    mapping (address => uint) public costOfStay;

    constructor(address payable homeOwner) public {
        contractCreator = msg.sender;
        destinationAddress = homeOwner;
        //price = homePrice * 1e18; // convert to ether
        costOfStay[msg.sender] = 1e18;
    }

    function () payable external {
        require(msg.value < 0);
    }
    /* Assures that the renter has sent adequate payment */
    function payContract(uint totalPrice) payable public{
        //costOfStay[msg.sender] = price * daysReserved[msg.sender]; // calculate cost of the stay
        require(msg.value >= totalPrice * 1e18); // enforce that the sender sent the price of the stay
        costOfStay[msg.sender] = totalPrice * 1e18; // price in ether
        contractCreator.transfer(3 finney); // Take about a $3 fee to be able to continue running the contract
        if(address(this).balance >= costOfStay[msg.sender]){
            msg.sender.transfer(address(this).balance - costOfStay[msg.sender]); // return any extra funds
        }
    }

    /* Payout to the home owner*/
    function payout(address renter) public{
        require(msg.sender == contractCreator);// only the contractCreator can change values-
        emit LogPayout(costOfStay[renter]);

        destinationAddress.transfer(costOfStay[renter]);

    }

    /* Refund to the buyer */
    function refund(address payable renter) public{
        // ensure that the renter has sent funds to the contract
        require(msg.sender == contractCreator && costOfStay[renter] != 0 && costOfStay[renter] <= address(this).balance);// only the contractCreator can change values
        emit LogRefund(costOfStay[renter]);

        renter.transfer(costOfStay[renter]);


    }

    /* Set the home owner address*/
    function setDestination(address payable newDest) public {
        require(msg.sender == contractCreator); // only the contractCreator can change values
        emit LogChangedAddress(newDest);
        destinationAddress = newDest;
    }
}
