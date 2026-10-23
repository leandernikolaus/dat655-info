# Blockchain in Finance – Speaker notes

Speaker notes extracted from the Keynote deck (blockchain-finance-with-notes.key), one section per slide.

## 1. Blockchain in Finance

Welcome to this lecture on blockchain and finance.  
We will look at some examples of adoption and application of blockchain technology in the financial sector.

## 2. Disclaimer – I am no finance expert

A disclaimer: I'm no finance expert.  
This lecture is mostly based on my research on the web.  
I did a lot of reading on this, but much of what happens in this area is not very well documented and especially academic sources are limited.  
There are usually more and better resources on public sector projects than on private sector projects.  
That's why private sector projects are a bit underrepresented here.

## 3. Blockchain and finance

So what about blockchain and finance?  
The expectations are definitely high.  
Here are two citations from 2015 and 2016.  
The first says that Bitcoin is not just a minor incremental change, not just a payment network: Bitcoin is one of the most fundamental transformations of the basis of money.  
The other says that rather than stay at the margins of the finance industry, blockchain will become the beating heart of it.  
So some people certainly expect blockchain to be a fundamental part of finance.  
We are going to look at where, how and why blockchain or similar technology is used today.

## 4. Blockchain and finance – Potential of tokenisation

When talking about blockchain and finance, we often hear about tokenisation.  
Tokenisation means having a digital representation of claims on a programmable ledger: creating tokens out of some asset, which can be securities, financial obligations, real money and so on.

Instead of "blockchain", these documents nowadays often talk about DLT, which stands for distributed ledger technology.

What are the potentials of tokenisation?  
Based on the recent reports from the BIS, the Bank for International Settlements, tokenisation has the potential to enable atomic settlement, that is atomic swaps of tokenised assets.  
It can make services available 24/7 rather than during fixed office hours, increase transparency, and avoid manual handling.  
Manual handling is exactly the opposite of atomic settlement: I send something to you, and then you manually sends something back.  
So manual handling creates delay, and when sending you my asset, I cannot be certain when or if I get the agreed response.

The 2025 BIS report highlighted all these advantages.  
In the 2026 report they wrote that programmability does not strictly require DLT.  
Many functions can be implemented on traditional infrastructures, but combining DLT with tokenisation can deliver notable benefits.  
So you can implement atomic settlement on a database rather than on a ledger as well.  
We will talk more about this later.

## 5. Blockchain and finance – Examples

Here are the examples we will look at: the Bakong payment system in Cambodia, the Pontes system in the EU, mBridge, which is a system developed by several national banks in Asia together with the Bank for International Settlements, and some private platforms, not in too much detail.  
We will also quickly touch on what is happening in Norway.

## 6. Some Concepts

Before we start, here are some concepts that will appear later and that may be useful as an introduction.

## 7. Concepts

First, central bank money and commercial money.  
Central bank money is money issued by a central bank; think of it as cash.  
Commercial money is essentially the balance on a bank account.  
What's the difference?  
If you have a balance on your bank account, the bank promises to give you that money in cash if you want to withdraw it.  
But banks also give loans, and when they give you a loan and increase your balance, they don't necessarily have the same amount in cash.  
They don't have a vault holding all the money on their accounts in cash.  
That's why there is a difference between the two.

A CBDC is a central bank digital currency: the idea that central banks, rather than only issuing cash, issue a digital form of central bank money.

For CBDCs we distinguish between wholesale and retail.  
When the digital cash the central bank gives out is used only by banks and financial institutions we say it is a wholesale CBDC.  
When it is used by households, businesses and essentially everybody, we say it is a retail CBDC.

## 8. Bakong

Next, let's look at Bakong.

## 9. Bakong – What

Bakong is a payment and settlement system run by Cambodia's central bank.  
Banks and payment providers in Cambodia can join the system, and users can send money using it.  
The project started in 2016, was in production in 2020 and has quite good adoption.  
People in Cambodia and some neighbouring countries use it to pay online, to send money to friends, and to pay in shops.

You can use Bakong even if you don't have a bank account, for some limited transactions.  
For more transactions you need a bank account, and the bank performs KYC know-your-customer and money-laundering checks.

## 10. Bakong – What

Here is a figure from Bakong.  
There is a Bakong app you can use to send money back and forth, but you can also use Bakong through your online banking, since the banks are connected to it.

What is interesting is that you can send money both in riel, the Cambodian currency, and in US dollars.  
That is an interesting point, because it is essentially the National Bank of Cambodia creating a digital dollar.

## 11. Bakong – How

How does the system work?  
There is a blockchain, running Hyperledger Iroha, which records all transactions.  
The blockchain runs on multiple nodes, but all nodes are run at the national (central) bank.  
Transactions are recorded using pseudonyms, so they carry no personal information.  
The system processes roughly 2,000 transactions per second with about 5 seconds latency per transaction, significantly more than we see on Bitcoin or Ethereum.

This is a retail system, since it is used by end users and not just banks.  
It is actually disputed whether it is a central bank digital currency, since what you send around is money from your bank account.  
It does not have to be issued by the central bank; it is more like a payment system for commercial bank money, created by the central bank.

## 12. Bakong – Questions

Some questions about the blockchain architecture.  
How decentralised is it?  
There is certainly blockchain technology here, running on multiple nodes, but all nodes are run and controlled by the central bank.  
So it is not very decentralised, neither geographically nor in control.  
You could run it on a single database instead.  
Distributed ledger technology does add a certain amount of security: if one node is compromised, the others still function correctly.  
But if they all run the same software, at the same location, probably in the same network, a common failure mode is quite likely.

Censorship resistance is often named as one of the big advantages of blockchain technology.  
How censorship resistant is this system?  
On one hand, individuals can get access through different banks, so in terms of access it is somewhat censorship resistant.  
But if the central bank, which runs all the nodes, decided for example that a political party should no longer receive funding through the system, it would probably be possible.  
So it relies heavily on the central bank being an independent and trusted entity.

Note also that this is a payment-only system; there is no smart contract aspect here.

## 13. Pontes

The next system we look at is quite different: Pontes.

## 14. Pontes – What

What is Pontes?  
Pontes is built by the Eurosystem, that is the central banks using the Euro currency.  
It is a service from these central banks that lets DLT-based trading platforms settle in central bank money.  
So it is not so much about building one ledger, but about connecting external ledgers to central bank money.  
The idea is that if you have a tokenised bond or security, you can pay for it with safe central bank cash.

The system is only accessible to banks and financial institutions and launched in September this year.  
Interestingly, and contrary to the claimed benefits of DLT, it is open Monday to Friday, 9 to 4.  
So there is strict control here.  
The Eurosystem organisation describes Pontes as a preliminary system, and they hope to build a more integrated DLT-based system later.

## 15. Pontes – What

How does Pontes work?  
Here is a architectural overview.  
There is a lot on this slide; I will mostly focus on the right side.  
On the far right we see the different DLT platforms.  
These are third-party platforms where assets and bonds can be tokenised.  
They connect via an interface, the Extended Interoperability Interface (EII), or API Gateway, to the Eurosystem DLT.  
This Eurosystem DLT is also a blockchain run by the Eurosystem, and the Eurosystem DLT again connects through an interface to the existing services for transferring central bank money.  
These are labeled as TARGET in the figure.

## 16. Pontes – What

Let's look at the internal Eurosystem blockchain.  
It uses Hyperledger Fabric, which lets you run multiple nodes that build a shared ledger, and it supports smart contracts.  
The different central banks run individual nodes, one per national central bank, which validate, sign and store transactions and manage participant data.  
In addition, the ECB in Frankfurt runs an issuer node that issues and redeems cash tokens.  
The native token on this blockchain represents central bank money, euros.  
The ECB node issues these tokens onto the blockchain and burns them when cash is transferred back into the existing system.

## 17. Pontes – Hash-lock protocol

As I said, this is mostly about interoperability.  
One interesting thing is the hash-lock protocol, or hash time-lock contracts.  
This is a zoom-in on the figure from before, showing the interaction between the Eurosystem blockchain and the external market blockchains.

The idea is delivery versus payment.  
You want to transfer a security, bond or other asset from one participant to another.  
The asset is represented as a token on one of the market DLTs, and in exchange for transferring ownership you want to receive payment in central bank money on the Eurosystem DLT.  
In effect, this creates a bridge between the Eurosystem blockchain and the market blockchains.

How does it work?  
To perform such a trade, you register it with the interface, the EII, which returns two hashes: a cancellation hash and an execution hash.  
On the market DLT you create a smart contract and the seller transfers the asset into it.  
If the buyer makes the corresponding payment on the Eurosystem DLT and the payment is registered, the EII releases the pre-image of the execution hash.  
The smart contract on the market DLT checks that the input hashes to the execution hash, and if so, transfers the asset to the buyer.

If instead a timeout happens and the EII has not detected the payment in time, it releases the pre-image of the cancellation hash.  
When that preimage is submitted to the smart contract, the smart contract sends the asset back to the seller.

This ensures that the buyer only receives the asset if payment is made on the Eurosystem DLT, and that if payment is made in time, the buyer is guaranteed to receive the asset.

An important point: the EII is a trusted oracle.  
It must create the random values for cancellation and execution, hash them, keep them secret and release them later, and it is trusted to do this correctly.  
The EII is run by the central banks.

## 18. Pontes – Questions

Some questions again:  
How decentralised is the Eurosystem DLT in Pontes?  
Certainly more decentralised than Bakong.  
In Bakong all nodes are run by the central bank; here different nodes are run by different central banks.  
But the ECB has a special role, as the only node that can issue new money, and it is where the interaction with central bank money happens.  
So it is more decentralised than Bakong, but there are limits.  
They also all run the same software, so you could argue there is a common failure mode, but at least they run at different locations.

Does it give censorship resistance?  
Probably one central bank alone would not be able to censor your transactions if the others wanted them to go through.  
It is not perfectly censorship resistant, but probably better than Bakong.

How does the hash lock compare to a bridge as we discussed in the previous lecture?  
The hash lock provides the same functionality as a bridge.  
The difference is the trusted component, the interface.  
Rather than proving to the smart contract that the payment has actually been executed and included on the Eurosystem blockchain, there is a trusted entity that monitors the Eurosystem blockchain and releases the pre-image when the payment is executed.  
So the functionality is very similar to what is used in decentralised blockchains, but trusted agents are included, which makes it much simpler.  
I guess this is typical for these more centralised, institutional ecosystems.

## 19. mBridge

The next system we look at is mBridge.

## 20. mBridge – What

mBridge is a system for cross-border payments.  
Here is a citation from a report about mBridge.  …  
So it is a platform for international money transfer.

Similar to before, it is to a large extent about atomic swaps.  
In this case we typically want to trade different currencies, one central bank money against another, and again we want atomicity: if I send you my currency, I should receive the agreed amount of your currency.

## 21. mBridge – What

Why these international payments?  
Here are two citations from the same report, explaining pain points of cross-border payments in current corresponding banking.  
They describe that corresponding banks often act as centralised intermediaries.  
Often you would not exchange two currencies directly; you would first exchange one currency to dollars and then dollars to the other currency, with an intermediary in between.  
And again there is the question of the operating hours of that central point.

This results in high costs, low speed and complexity, especially for less traded currencies.  
If the intermediate currency is always the dollar, trading dollars is very convenient.  
But if you want to trade two currencies that are both not the dollar, there is a lot of friction and cost involved.

## 22. mBridge – How

How does mBridge work?  
It runs a private permissioned blockchain.  
Their documents say they use the HotStuff+ or Dashing consensus protocol.  
Different central banks each run a validating node.

What is interesting is that they aim for privacy.  
They want to keep the identities of payer and payee, and the amount transferred, private: visible only to the payer and payee and their corresponding central banks.

Again, this is a system designed only for actors in the financial sector, not for use by the general public.

## 23. mBridge – Example

Here is a graphic they published on these private transactions.  
Two banks want to interact, with the central banks running the mBridge ledger in between.  
Transaction 1 contains the initiator's public key, payment info, compliance results (compliance and anti-money-laundering checks are always important in these systems) and a request for the recipient's address.  
These are encrypted.  
Once transaction 1 is added to the ledger, the counterparty, bank B, receives it and adds transaction 2 with payment info, compliance result and receiving address, again encrypted and added to the ledger by consensus.  
The initiator can decrypt it and then send the final transaction with only the payment info, which executes the payment.

Based on the available information, it is actually unclear how the payment can be executed without all central banks having access to the payment amount.  
But certainly the encryption probably hides the values from other banks that are clients on this blockchain.

Another very interesting point is that the initiator and counterparty essentially communicate via the blockchain.  
This is quite different from decentralised ledgers, where we try to do as much as possible off the main chain and only record the final result.  
Think of payment channels, where we send money back and forth and only register the final payout on chain.  
Or a Bitcoin transaction with inputs from several owners: you first create the transaction off chain, collect everybody's signatures, and only then submit it.  
Here, even the request for an address and the reply ("send the money to this address") are recorded on chain.  
You could argue this information could be exchanged off chain, and it seems suboptimal since it results in more on-chain data, but it might be relevant data for ensuring compliance.

## 24. mBridge – Status

On the status of mBridge:  
mBridge ran a pilot with the BIS and the central banks of Thailand, China and others.  
In a way it was an attempt to reduce the role of the dollar in international transactions.  
To what extent it is still used is not easy to say; I did not find much good data on that.  
I know that the Bank for International Settlements stopped its participation, because there seemed to be a tendency to use it to avoid sanctions.

## 25. mBridge – Questions

Let's ask the same questions.  
How decentralised is this?  
As with all these systems there is a single software that everyone runs, but here it is run by different central banks, which are definitely independent entities.

Regarding censorship resistance.  
I think censorship resistance is actually a relevant point here.  
Transactions involving only two central banks or two currencies should be able to execute even without the knowledge of the other central banks, which is definitely an aspect of censorship resistance.  
And the whole idea of avoiding the dollar and centralised, dollar-based settlement is, I guess, at least in the spirit of decentralisation and censorship resistance.

## 26. Commercial platforms

Finally, let me quickly touch on commercial platforms.  
Generally I found it difficult to get good information on what these commercial platforms do, mostly because there is a lot of advertising and system details.

## 27. Commercial platforms – What

Commercial platforms in this sector often do payment versus payment, meaning currency exchange, or delivery versus payment: you have a tokenised asset and want to send it and receive payment for it.  
In both cases atomic exchange is the important property: you get the thing you want and pay for it, and you can be sure that if you pay, you get the thing, and if the other party doesn't pay, you get it back.

## 28. Commercial platforms – Examples

Examples are JP Morgan Kinexys and Partior.  
It is not easy to get information on how these blockchains are actually run.  
I think they are often either a multi-bank organisation or a single organisation running the ledger, similar to the central bank in the Bakong example.

## 29. Other projects

Finally, I want to recommend the CBDC tracker from the Atlantic Council, a nice website where you can look into different CBDC projects.  
You also see there that the number of CBDCs actually launched is not very large.  
There have been a lot of research, pilot and development projects, but more projects have been moved to inactive than have actually launched.

## 30. Norway

In Norway, the Norwegian central bank (Norges Bank) has for quite some years investigated CBDCs and blockchain technology and has run multiple test cases.  
But they concluded that at the current stage, this is not the way they need to go.  
They also say that it might be more relevant to be included in a system like Pontes that the Eurosystem runs.

## 31. Takeaway 1

So to summarise this lecture, we have seen that adoption exists but is limited, and many CBDC projects never got past the pilot stage.  
Where blockchain is used, it’s mostly for added security rather than decentralisation.  
Finally, atomic swaps and cross platform interaction are similar to their counterparts in public blockchains, but also may be simplified by relying trusted third parties, like the EII in Pontes.

## 32. Takeaway 2 – Options

Continuing on our summary we see that options a range from a single database to a single-organisation blockchain (like Bakong) to multi-organisation blockchains.  
A single organisation blockchain essentially adds a byzantine failure model, so resilience to attacks where individual machines are compromised.  
However, to be useful, different machines should not have a common failure mode.  
Also, of cause, it may give you benefits in your communication to claim using a blockchain.

A multi organisation blockchain can give you additional benefits like transparency and in some cases censorship resistance.

## 33. Takeaway 3 – Do you need a blockchain?

Since we talked about blockchain vs a database I wanted to go through this nice flowchart from a Paper from 2018.  
Here we see, the authors distinguish whether you need a blockchain based on who writes data.  
If you do not need to write new data, you do not need a blockchain.  
If these is a single writer, you anyway have to trust this writer and he can store the data instead.  
Similarly, if there is a trusted third party, that party can run a database for us.  
Only if there is multiple distrusting writers do we need a blockchain.  
And only if we want to allow people to write to our state, which we do not know yet, do we need a permissionless blockchain.  
So, according to this, the benefit of a permissionless blockchain like Ethereum or Bitcoin is that it allows unknown third parties to interact with your application and write to your data.
