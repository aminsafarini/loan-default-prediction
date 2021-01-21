# loan-default-prediction

8 datasets from a bank are used to determine the likelihood of a load default. 

The data about the clients and their accounts consist of following relations:
- <b>account</b> (4500 objects in the file ACCOUNT.ASC) - each record describes static characteristics of an account
- <b>client</b> (5369 objects in the file CLIENT.ASC) - each record describes characteristics of a client
- <b>disposition</b> (5369 objects in the file DISP.ASC) - each record relates together a client with an account i.e. this relation describes the rights of clients to operate accounts,
- <b>permanent order</b> (6471 objects in the file ORDER.ASC) - each record describes characteristics of a payment order,
- <b>transaction</b> (1056320 objects in the file TRANS.ASC) - each record describes one transaction on an account
- <b>loan</b> (682 objects in the file LOAN.ASC) - each record describes a loan granted for a given account
- <b>credit card</b> (892 objects in the file CARD.ASC) - each record describes a credit card issued to an account
- <b>demographic data</b> (77 objects in the file DISTRICT.ASC) - each record describes demographic characteristics of a district.

