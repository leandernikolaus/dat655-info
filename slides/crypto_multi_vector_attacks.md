# Multi-Vector Attacks in the Cryptocurrency Market: Three Case Studies

All three cases have detailed public documentation and combine several attack vectors. All three are attributed to North Korean state-linked groups (Lazarus / TraderTraitor). For Drift and KelpDAO the attribution is still preliminary.

---

## 1. Drift Protocol (Solana), 1 April 2026, about $285M

At the time of writing, this is the largest DeFi hack of 2026 and the second-largest exploit on Solana after the 2022 Wormhole hack.

### Attack vectors

| Vector | Description |
|---|---|
| **Long-term social engineering** | The attackers posed as a quant trading firm and built relationships with Drift contributors over about six months. |
| **Endpoint compromise** | Contributors' devices were reportedly compromised through a code-editor vulnerability, a malicious TestFlight app and a cloned repository. |
| **Governance weakness** | On 27 March, Drift moved its Security Council multisig to a 2-of-5 threshold with **no timelock**. This removed the window in which anyone could detect and stop the attack. |
| **Misused protocol feature** | Using Solana *durable nonce* accounts, the attackers got signers to pre-sign transactions that looked routine but hid admin permissions. The transactions could be executed later. |
| **Fake collateral and price manipulation** | The attacker minted a fake token (CVT), gave it a few thousand dollars of liquidity on Raydium and wash-traded it to build a price history near $1. |

### Execution

On 1 April the pre-signed transactions were executed. They listed CVT as valid collateral and raised withdrawal limits. CVT was then deposited at its inflated price, and 31 withdrawals over about 12 minutes drained USDC, JLP and other assets. Most of the funds were bridged to Ethereum within hours.

**Key lesson:** There was no smart-contract bug. Compromised people and weak governance were enough to abuse legitimate protocol features.

### Sources

- [TRM Labs – North Korean hackers attack Drift Protocol in $285M heist](https://www.trmlabs.com/resources/blog/north-korean-hackers-attack-drift-protocol-in-285-million-heist)
- [CoinDesk – Drift says $270M exploit was a six-month North Korean intelligence operation](https://www.coindesk.com/markets/2026/04/05/drift-says-usd270-million-exploit-was-a-six-month-north-korean-intelligence-operation) (reports Drift's own incident update on X, 5 April 2026)
- [Rekt – Drift Protocol](https://alpha.rekt.news/drift-protocol-rekt)

---

## 2. Bybit (centralized exchange), 21 February 2025, about $1.5B

This is the largest crypto theft on record.

### Attack vectors

| Vector | Description |
|---|---|
| **Social engineering / supply chain** | The attackers compromised a developer machine at Safe{Wallet}, a third-party multisig wallet provider. |
| **Cloud infrastructure compromise** | From that machine they reached Safe's AWS infrastructure. |
| **Front-end code injection** | Malicious JavaScript was injected into the Safe web interface and set to activate only for Bybit's cold-wallet address. |
| **Blind signing** | Bybit's multisig signers, using hardware wallets, approved what looked like a routine transfer. It was actually a `delegatecall` that replaced the wallet's implementation contract with one the attacker controlled. |
| **Rapid laundering** | The attackers emptied the wallet and laundered the funds quickly across chains and swap services. |

**Key lesson:** Hardware wallets and multisig don't protect against a compromised signing interface. Signers have to be able to check independently what they are actually signing.

### Sources

- [SlowMist – Bybit's $1.5B theft: Safe{Wallet} front-end code tampered](https://slowmist.medium.com/bybits-1-5-billion-theft-unveiled-safe-wallet-front-end-code-tampered-84b78f0fa9c2)
- [Cointelegraph – Safe{Wallet} releases Bybit hack post-mortem](https://cointelegraph.com/news/safe-wallet-releases-bybit-hack-post-mortem)
- [Cointelegraph – Safe post-mortem update](https://cointelegraph.com/news/safe-releases-post-mortem-update-cz-criticizes-response)
- [Decrypt – What caused Bybit's Ethereum hack? New details revealed](https://decrypt.co/309018/what-caused-bybit-ethereum-hack-new-details)
- [Four Pillars – Safe / Bybit hack research](https://research.4pillars.io/en/research/safe-bybit-hack)

---

## 3. KelpDAO rsETH and LayerZero bridge, 18 April 2026, about $292M

### Attack vectors

| Vector | Description |
|---|---|
| **Infrastructure poisoning** | The attackers compromised two RPC nodes that LayerZero's verifier (DVN) used to read source-chain data. The nodes gave false data to the verifier and correct data to everyone else, which hid the attack from monitoring. |
| **Denial of service** | A DDoS attack on the healthy RPC nodes made the verifier fall back to the poisoned ones. |
| **Insecure configuration** | KelpDAO's bridge used a **1-of-1 DVN** setup with a single verifier, so one false attestation was enough. |
| **Forged cross-chain message** | A forged message claiming to come from Unichain released 116,500 rsETH from the Ethereum escrow. |
| **Composability / lending abuse** | The attacker didn't sell the rsETH. They deposited it on Aave, Compound and Euler and borrowed about $236M in WETH and wstETH. Aave's E-Mode allowed up to 93% loan-to-value on rsETH. |

### Aftermath

KelpDAO paused its contracts after 46 minutes, and Aave's guardian froze the rsETH markets after 77 minutes. Aave was left with an estimated $124–230M in bad debt, and about $15B left DeFi. Arbitrum's Security Council later recovered 30,766 ETH. LayerZero has said it will no longer sign messages for 1-of-1 DVN configurations.

**Note on disputed facts:** LayerZero's post-mortem calls this RPC poisoning "rather than key theft, social engineering, or a protocol bug". Some secondary reports say a LayerZero developer was socially engineered. KelpDAO and LayerZero also blame each other over the insecure default configuration.

**Key lesson:** A bridge is only as secure as its weakest verification dependency, and an exploit on one protocol can spread to lending markets that accept its token as collateral.

### Sources

- [Galaxy Research – The KelpDAO / LayerZero exploit](https://www.galaxy.com/insights/research/kelpdao-layerzero-exploit-defi)
- [CoinDesk – Kelp DAO claims LayerZero's default settings caused the $290M disaster](https://www.coindesk.com/tech/2026/04/20/kelp-dao-claims-layerzero-s-default-settings-are-what-actually-caused-the-usd290-million-disaster)
- [Rekt – KelpDAO](https://rekt.news/kelpdao-rekt)
- [DeFiPrime – The KelpDAO rsETH exploit: $292M minted from a 1-of-1 bridge](https://defiprime.com/kelpdao-rseth-exploit)
- [KuCoin – How the KelpDAO exploit created $177M bad debt on Aave](https://www.kucoin.com/blog/my-kelpdao-rseth-exploit-how-292m-layerzero-bridge-attack-created-177m-bad-debt-on-aave)

---

## Comparison

| | Drift | Bybit | KelpDAO / LayerZero |
|---|---|---|---|
| Date | April 2026 | February 2025 | April 2026 |
| Loss | about $285M | about $1.5B | about $292M |
| Social engineering | Yes (six months) | Yes (third-party developer) | Disputed |
| Key / signer compromise | Signers tricked into pre-signing | Signers tricked by a manipulated interface | No (verifier keys intact) |
| Smart-contract bug | No | No (legitimate `delegatecall` misused) | No (configuration weakness) |
| Infrastructure attack | Contributor devices | Developer machine and AWS | RPC poisoning and DDoS |
| Economic manipulation | Fake collateral token, wash trading | – | Borrowing against unbacked collateral |
| Attribution | DPRK (preliminary) | DPRK / Lazarus (confirmed by FBI) | DPRK / TraderTraitor (preliminary) |

### Further reading (H1 2026 overviews)

- [The Crypto Times – Top 10 crypto hacks of H1 2026](https://www.cryptotimes.io/insights/top-10-crypto-hacks-of-h1-2026-how-hackers-drained-972-million-in-six-months/)
- [Sherlock – Web3 Security Report Q1 2026](https://sherlock.xyz/post/the-sherlock-web3-security-report-q1-2026-every-major-hack-exploit-and-trends)
