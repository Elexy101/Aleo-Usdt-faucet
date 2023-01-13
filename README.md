# Aleo-Usdt-faucet
The core idea behind this project is to provide testing ground for faucet using two record(ALEO, USDT) token. owner can request faucet and test the faucet amount by testing other functionalities in the program 

# PROJECT SAMPLE:
* Get ALEO token faucet to begin testing
* STake/unStake faucet amount gotten 
* Borrow additional amount to the owner address
* Transfer ALEO token to another ALEO address from the owner with 2ALEO FEE
* SWAP ALEO/USDT token WITH 1ALEO GAS FEE


### User Flow
1. The supply issues owners tokens via the `faucet` function.
2. A owner stake tokens via the `stake` function.
3. A owner unstake tokens via the `unstake` function.
4. A owner can `borrow` token to add to its amount
5. A owner can `transfer` token -> USDT to a specific receiver and vice versa
6. A owner can `swap` token (DEFAULT token: ALEO) to (token: USDT)

## Bugs

- Help me find a bug?


## Future Update
- Able to transfer token to two or more receivers
- Able to swap token(USDT) back to Default token(ALEO)
- I'm thinking haha...

## Language Features and Concepts
- `record` declarations
- `assert_eq`
- record ownership
- selective statement -> Faucet


## Running the Program

Leo provides users with a command line interface for compiling and running Leo programs.
Users may either specify input values via the command line or provide an input file in `inputs/`.

### Configuring Accounts
The `program.json` file contains a private key and address.
This is the account that will be used to sign transactions and is checked for record ownership.
When executing programs as different parties, be sure to set the `private_key` and `address` fields in `program.json` to the appropriate values.


See `./run.sh` for an example of how to run the program as different parties.


The [Aleo SDK](https://github.com/AleoHQ/leo/tree/testnet3) provides a command line interface for generating new accounts.
To generate a new account, run
```
leo account new
```


### Providing inputs via the command line.
1. Run
```bash
leo run <function_name> <input_1> <input_2> ...
```
See `./run.sh` for an example.


### Using an input file.
1. Modify `inputs/test_faucet.in` with the desired inputs.
2. Run
```bash
leo run <function_name>
```
For example,
```bash
leo run set
leo run faucet
leo run transfer
leo run stake
leo run unstake
leo run borrow
leo run swap
```



# TEAM CHALLENGES
* try swap_reverse USDT/ALEO WITH 2 ALEO GAS FEE
* try transferring ALEO token to two ALEO addresses from the owner with a 3ALEO FEE
