#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# The private key and address of the owner
# Swap these into program.json, when running transactions as the owner.
# "private_key": "APrivateKey1zkp92o16EwBQ9M5a7LpLR1Kvq7v8QfzQoz755gGaErydn1x"
# "address": aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv



echo "
###############################################################################
########                                                               ########
########            STEP 0: TEST FAUCET PROGRAM (ALEO(*), USDT)         ########
########                                                               ########
########                ------------------------------------           ########
########                |  FAUCET   |    ALEO    |   USDT  |           ########
########                -----------------------------------            ########
########                |   OWNER   |    ----    |   ----  |           ########
########                ------------------------------------           ########
########                                                               ########
###############################################################################
"

leo run main aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv 0u64 1000000u64 0u64

echo "{
  \"program\": \"test_faucet.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp92o16EwBQ9M5a7LpLR1Kvq7v8QfzQoz755gGaErydn1x\",
      \"address\": \"aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv\"
  },
  \"license\": \"MIT\"
}" > program.json

# Have the owner request faucet of 100ALEO.
echo "
###############################################################################
########                                                               ########
########          STEP 1: The owner request faucet of 100USDT          ########
########                                                               ########
########                ------------------------------------           ########
########                |  FAUCET   |    ALEO    |   USDT  |           ########
########                -----------------------------------            ########
########                |   OWNER   |    100    |    ---   |           ########
########                ------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run faucet
"{
  owner: aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv.private,
  gates: 0u64.private,
  amount: 100u64.private,
  supply: 999900u64.private,
  fee: 0u64.private,
  _nonce: 1672960003947430820803598529849642319510714751154563310725562967280627389991group.public
}" > program.json


# The owner stake the 100ALEO token.
echo "
###############################################################################
########                                                               ########
########                  STEP 2: The owner stake 100USDT              ########
########                                                               ########
########                ------------------------------------           ########
########                |  STAKE   |    ALEO    |   USDT   |           ########
########                ------------------------------------           ########
########                |  OWNER   |    ----    |   ----   |           ########
########                ------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run stake aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv 100u64 999900u64 0u64

echo "{
  \"program\": \"test_faucet.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp92o16EwBQ9M5a7LpLR1Kvq7v8QfzQoz755gGaErydn1x\",
      \"address\": \"aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv\"
  },
  \"license\": \"MIT\"
}" > program.json


# The owner unstake the 100ALEO token to earn 10ALEO reward
echo "
###############################################################################
########                                                               ########
########                 STEP 4: The owner unstake 100USDT             ########
########                          (** REWARD: 10ALEO **)               ########
########                                                               ########
########                ------------------------------------           ########
########                |  unSTAKE   |    ALEO    |   USDT |           ########
########                ------------------------------------           ########
########                |  OWNER     |    110    |    ---- |           ########
########                ------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run unstake aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv 100u64 999900u64 0u64


echo "{
  \"program\": \"test_faucet.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp92o16EwBQ9M5a7LpLR1Kvq7v8QfzQoz755gGaErydn1x\",
      \"address\": \"aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv\"
  },
  \"license\": \"MIT\"
}" > program.json


# The owner borrows 50ALEO token from the supply:).
echo "
###############################################################################
########                                                               ########
########                 STEP 5: The owner borrows 50USDT              ########
########                                                               ########
########                ------------------------------------           ########
########                |  BORROW   |    ALEO    |   USDT  |           ########
########                ------------------------------------           ########
########                |  OWNER    |    160      |  ----  |           ########
########                ------------------------------------           ########
########                                                               ########
###############################################################################
"
leo run borrow aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv 110u64 999900u64 0u64


echo "{
  \"program\": \"test_faucet.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp92o16EwBQ9M5a7LpLR1Kvq7v8QfzQoz755gGaErydn1x\",
      \"address\": \"aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv\"
  },
  \"license\": \"MIT\"
}" > program.json


# The owner test-transfer 10ALEO token to the receiver, records proceeds from supply :).
echo "
###############################################################################
########                                                               ########
########                 STEP 6: The owner transfers 10USDT            ########
########                                                               ########
########                ------------------------------------           ########
########                |  TRANFER |    ALEO    |   USDT   |           ########
########                ------------------------------------           ########
########                |  OWNER   |    148     |   ----   |           ########
########                ------------------------------------           ########
########                | RECEIVER |   → 10 ←   |   ----   |           ########    
########                ------------------------------------           ########
                        |__FEE_____|___→ 2 ←____|___----___|           ########
########                                                               ########
###############################################################################
"

leo run transfer  "{
  owner: aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv.private,
  gates: 0u64.private,
  amount: 148u64.private,
  supply: 999842u64.private,
  fee: 0u64.private,
  _nonce: 1982264224922187878315073316897804794220176039455619949026356733178606786094group.public
}" "{
  owner: aleo1mgfq6g40l6zkhsm063n3uhr43qk5e0zsua5aszeq5080dsvlcvxsn0rrau.private,
  gates: 0u64.private,
  amount: 10u64.private,
  supply: 999842u64.private,
  fee: 0u64.private,
  _nonce: 3267398896806104901147172582329212921690819846899902557192790399079265278693group.public
}"


# Here lastly is the SWAP  function... SWAPPING DEFAULT TOKEN -> TOKEN
echo "
###############################################################################
########                                                               ########
########                 STEP 7: The owner swaps 10USDT - 1DAI         ########
########                                                               ########
########                ------------------------------------           ########
########                |  SWAP     |    ALEO    |   USDT  |           ########
########                ------------------------------------           ########
########                |  OWNER    |    139     |  → 1 ←  |           ########
########                ------------------------------------           ########
########                |___FEE:_____|__→ 1 ←____|___----__|           ########
########                                                               ########
###############################################################################
"
leo run swap  "{
  owner: aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv.private,
  gates: 0u64.private,
  amount: 139u64.private,
  supply: 999911u64.private,
  fee: 1u64.private,
  _nonce: 246131085273363883358123166467312691400367354439298798858966341450804875869group.public
}" "{
  owner: aleo1avesdzv3cj3e8f6n62k0e90wwd0zkrk6lkl57z7lsun64gsf4qqswftphv.private,
  gates: 0u64.private,
  amount: 1u64.private,
  supply: 9999u64.private,
  fee: 0u64.private,
  _nonce: 4344586489202162738883664601409501695354182485443851916879820224929778495591group.public
}"

# comes to an end :)
echo "
###############################################################################
########                                                               ########
########                    STEP 8: END OF PROGRAM...                  ########
########                                                               ########
########                -------------------------------                ########
########                    **  FOUND ANY BUGS   **                    ########
########                -------------------------------                ########
########              SEND A DM VIA DISCORD ALEO-LANGUAGE              ########
########                -------------------------------                ########
########                                                               ########
###############################################################################
"






