# LoRaWAN protocol

## Message flow

### Joining

Before communicating, *Nodes* must be associated or activated using either the
Over-the-air-activation (*OTAA*) or Activation by personalization (*ABP*). OTAA
uses the *AppKey* which is shared between the *Node* and the
*Application Server*. During joining, the *Node* and the *Application Server*
exchange inputs to generate
* the network session key (*NwkSKey*) for MAC command encryption
* the application session key (*AppSKey*) for application data encryption

ABP uses an *NwkSKey* and an *AppSKey* that are already stored on the *Node*.

### Data transfer

*Nodes* can transmit data either using confirmed-data or unconfirmed-data
messages. The former requires an `Ack`, while the latter doesn't. To send a
confirmed-data request, the *Node* sends data with `Ackreq = 1` and must wait
for the duration `AckWaitDuration` for the `Ack`. For unconfirmed-data
requests, data is sent with `Ackreq = 0`.

### Data flow

Between the *Node* and the *LNPN*, the MAC payload data is encrypted using the
*NwkSKey*. This ensures integrity of the network data.

Between the *Node* and the *Application Server*, the application payload data
is encrypted using the *AppSKey*. This ensures that application data can't be
read by the *LPNP*.

### Services

* MCPS (MAC Common Part Sublayer): used for data transmission and reception
* MLME (MAC Layer Management Entity): used for managing the LoRaWAN network
* MIB (MAC Information Base): used for storing information and configuration
