# MTG Simulator
A command-line Magic: The Gathering battle simulator built in Elixir, using GenServers to model game state and turn-based combat.

## Overview
MTG Simulator lets you simulate card battles from the terminal. Game state (players, life totals, hands, battlefield, turn phases) is managed through OTP GenServers, giving each match a supervised, stateful process that handles actions like casting spells, attacking, and resolving combat.

## Features
- CLI-driven gameplay loop
- GenServer-backed battle state management
- Turn/phase progression (main phase, combat, etc.)
- Player actions: play cards, attack, block, pass priority
- (add/remove as accurate: card database, deck loading, damage resolution, etc.)
- Core battle logic on battle_server.ex

## Tech Stack
- **Language:** Elixir
- **Concurrency model:** OTP GenServer
- **Interface:** CLI
