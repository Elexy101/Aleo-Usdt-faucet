//===================================================================================================|
//===================================================================================================|
//======================================= ALEO TEST FAUCET PROGRAM ==================================|
//========================================   VERSION 0.0.0 ==========================================|
//============================================= ALEO/USDT ===========================================|




//This is a simple implementation of faucet, stake, unstake, borrow, transfer and swap functionalities

// The 'usdt-test faucet' program.
program test_faucet.aleo {
    // On-chain storage of an `account` map, with `address` as the key and `u64` as the value.
    mapping account: address => u64;

    //ALEO token -> supply: 1000000 ALEO
    record ALEO{
        //owner address
        owner: address,
        gates: u64,
        amount: u64,
        supply: u64,
        fee: u64
    }

    //USDT token -> supply: 10000 USDT
    record USDT{
        owner: address,
        gates: u64,
        amount: u64,
        supply: u64,
        fee: u64
    }


//=============================================================================================
//============================== SETTING DEFAULT TOKEN <ALEO> =================================
//=============================================================================================

    //setting token amount and owner -> ALEO
    transition main(owner: address, amount:u64, supply: u64, fee: u64) -> ALEO {
        assert_eq(self.caller,aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv);
        
        return ALEO {
            owner: owner,
            gates: 0u64,
            supply: supply,
            amount: amount,
            fee: fee
        };
    }


//===========================================================================================
//================================= GET OWNER FAUCET ========================================
//===========================================================================================

    //faucet to receive 100 ALEO for each owner address 
    //the faucet request is sent to owner address with 0 ALEO
    transition faucet(faucet_reset: ALEO, faucet_set: ALEO) -> ALEO {
        // checks if faucet is sent to owner or not, if not, faucet is **SET**.
        if (faucet_reset.amount == 0u64) {
            return faucet_set;
        } else {
            return faucet_set;
        }
    }


//==============================================================================================
//================================ STAKING FUNCTION ============================================
//==============================================================================================

    //stake all owner's ALEO token to try and earn more 10 ALEO for owner
    transition stake(owner: address, amount: u64, supply: u64, fee: u64) -> ALEO {
        //owner amount is deducted all back to the supply
        let stake_amt: u64 = amount - 100u64;
        let supply_default: u64 = supply +100u64;
        return ALEO {
            owner: owner,
            gates: 0u64,
            amount: stake_amt,
            supply: supply_default,
            fee: fee
        };
    }

//================================================================================================
//==================================== UNSTAKING FUNCTION ========================================
//================================================================================================

    //unstake the ALEO token to get reward of 10ALEO back to the owner amount
    transition unstake(owner: address, amount: u64, supply: u64, fee: u64) -> ALEO {
        //earn 10ALEO per record calculated
        let unstake_amt: u64 = amount + 10u64;
        return ALEO {
            owner: owner,
            gates: 0u64,
            amount: unstake_amt,
            supply: supply - unstake_amt,
            fee: fee
        };
    }


//==============================================================================================================
//========================================= BORROW FUNCION =====================================================
//==============================================================================================================

    //the owner address can borrow up to 50 ALEO token from the ALEO token
    //supply token will be reduced after each borrow and will be recorded
    transition borrow(owner: address, amount: u64, supply: u64, fee: u64) -> ALEO {
        //earn 1 ALEO per record calculated
        let borrow_amt: u64 = amount + 50u64;
        let supply_amt: u64 = (supply) - (amount + 50u64);
        return ALEO {
            owner: owner,
            gates: 0u64,
            amount: borrow_amt,
            supply: supply_amt,
            fee: fee 
        };
    }


//================================================================================================================
//============================================== TRANSFER FUNCTION ===============================================
//================================================================================================================

// The function `transfer` sends the specified token amount to the token receiver from the specified token record.
// For each transfer, a fee charge of 2ALEO is executed from the owner address
    transition transfer(sender: ALEO, receiver: address, amount: u64, supply: u64, fee: u64) -> (ALEO, ALEO) {
        // Checks the given token record has sufficient balance.
        // This `sub` operation is safe, and the proof will fail if an overflow occurs.
        // `difference` holds the change amount to be returned to sender.
        let difference: u64 = sender.amount.sub(amount) - 2u64; // the 2u64 -> TRANSFER FEE CHARGE
        let supply_amt: u64 = (supply).sub((amount + 50u64)) + 2u64; // the 2u64 -> TRANSFEE FEE GOES BACK TO SUPPLY

        // Produce a token record with the change amount for the sender.
        let remaining: ALEO = ALEO {
            owner: sender.owner,
            gates: sender.gates,
            amount: difference,
            supply: supply_amt,
            fee: fee
        };

        // Produce a token record for the specified receiver.
        let transferred: ALEO = ALEO {
            owner: receiver,
            gates: 0u64,
            amount: amount,
            supply: supply_amt,
            fee: fee
        };

        // Output the sender's change record and the receiver's record.
        return (remaining, transferred);
    }


//======================================================================================================
//======================================= SWAP FUNCTION ================================================
//======================================================================================================

// The function `swap` is just a simple swap implementation of two token as a sample
//for each swap, a fee charge of 1ALEO is charged from the owner address
    transition swap(swapper: ALEO, swapper2: USDT) -> (ALEO, USDT) {

        //algorithm for the swap protocol -> ALEO, the owner wish to swap 10ALEO for 
        let new_aleo: u64 = (swapper.amount.sub(10u64)) - 1u64; //the 1u64 -> SWAP FEE CHARGE
        let new_supply_aleo: u64 = ((swapper.supply).add(10u64)) + 1u64; //the 1u64 -> FEE CHARGE GOES BACK TO SUPPLY

        //algorithm for the swap protocol -> USDT
        let new_usdt: u64 = swapper2.amount.add(1u64);
        let new_supply_usdt: u64 = (swapper2.supply).sub(1u64);

        let swap_aleo: ALEO = ALEO {
            owner: swapper.owner,
            gates: swapper.gates,
            amount: new_aleo,
            supply: new_supply_aleo, 
            fee: swapper.fee,
        };

        let swap_usdt: USDT = USDT {
            owner: swapper2.owner,
            gates: swapper2.gates,
            amount: new_usdt,
            supply: new_supply_usdt,
            fee: swapper2.fee,
        };

        return (swap_aleo, swap_usdt);
    }
// Awaiting more progress...
}
