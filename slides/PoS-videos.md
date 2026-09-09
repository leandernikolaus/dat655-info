### Video sources for PoS
*This is a selection of videos from Tim Roughgarden.
Additional videos from the same [lecture series](https://youtube.com/playlist?list=PLEGCF-WLh2RLOHv_xUGLqRts_9JxrckiA) are good sources.*


- [12.3 PoS High level](https://youtu.be/NkiZWHN6Xd0?si=zDH2xV7ryZJ6Zzli)
- [12.4 Why PoS](https://youtu.be/OVhhBIqvx7Y?si=_C9trsS3Geh3ZewK)
- [12.5 Staking](https://youtu.be/bEO2WKUOqlM?si=hPiKCqnZdzYC1dyg) 
- [12.6 PoS is Hard](https://youtu.be/RF-BriKS5WI?si=MVYTtgA3Eo3zkDRX)
- [12.7 Weighted RR](https://youtu.be/hOQWUN7ZLxg?si=bk-f4mmwdRRBXiNA)
- [12.8 Ideal random beacon](https://youtu.be/au-pyenGexg?si=pJLkIR6AEv7EFj70)
- [12.11 Pseudorandomness beacon](https://youtu.be/-niJOGoxwZw?si=JOEI2DmSAGN6CAee)
- [12.21 Long Range Attacks](https://youtu.be/WRoCc2s3HPk?si=KMnKxBMvoalgJHQI)

### Some glossary that may be useful:
- **Permissioned**: A system where only a limited well known number of people may participate.
- **Permissionless*: A system like bitcoin, where everyone can download the software and participate.
Especially, a single person can create multiple nodes and ids, called sybils.
- **Sybil attack**: An attack where a single person or organization creates multiple identities in a system.
- **Consensus**: A mechanism or algorithm to agree. 
E.g. agreeing on what is the next block to be added to the chain.
- **Tendermint**: A consensus algorithm in a permissioned system, where one leader proposes a block and multiple validators need to vote for the block by singing it. Similar to Paxos, but the nodes can misbehave or attack the protocol.
- **BFT-Type consensus**: A consensus algorithm like Tendermint.
- **Nakamoto consensus**: Also longest chain type consensus, where one fork is selected based on longest chain rule. 
- **Security parameter k**: How many blocks should be added on top in nakamoto consensus, before it is considered final. 6 in bitcoin.