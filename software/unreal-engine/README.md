# Unreal Engine

## Terminology

* Object: Base class of everything, implements GC, metadata, serialization
* Class: Defines behaviour and properties of Actor or Object
* Actor: Object which can be placed in a level, implements transformation, rotation, scale
* Component: Provides functionality for an Actor, e.g. emit light, play sound
* Pawn: Subclass of Actor, player or non-player character
* Character: Subclass of Pawn for the player. Includes collisions, controller movement
* PlayerController: Takes player input and translates it into game interactions. Network interface for multiplayer games
* AIController: Equivalent to PlayerController for NPC. Guides all AI pawns
* Brush: Actor which describes a 3D volume placed in a level
* Level: Area of gameplay, also known as Map
* World: Container for Levels
* GameMode: Ruleset for the game, e.g. win conditions, level transitions
* GameState: State of the game, replicated for all connected clients, e.g. scores, number of players
* PlayerState: State of a player, replicated, e.g. health points
