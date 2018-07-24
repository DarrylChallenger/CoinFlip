pragma solidity ^0.4.19;

contract CoinFlip
{
    uint counter=0;

    function flip() payable external {
        // Don't gamble with a ton of money!
        require(msg.value > 0 && msg.value <= 1 ether, "You must gamble with some ether, but no more than one.");
        
        uint rnd = uint(keccak256(abi.encodePacked(now, msg.sender, counter)));
        uint payout = msg.value * 2;
        counter++;
        //uint rnd = counter;
        // use the 6th bit - (why not?)
        rnd = rnd/32;
        rnd = rnd % 2;
        address myaddr = this;
        uint bal = myaddr.balance;
        if ( bal >= payout) {
            if (rnd == 1)
            {
                // heads, I win - keep the ether!
            } else {
                // tails, I lose - pay user 2x their bet  
                msg.sender.transfer(payout);
            }
        } else {
            // House has no money!
        }
    }
    
}
