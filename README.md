# TerritoryWars

A comprehensive territory control and group management system for Garry's Mod, featuring dynamic group mechanics, role-based upgrades, quest systems, and territory capture gameplay.

## Overview

TerritoryWars transforms your GMod server into a persistent territorial conflict simulation. Players can form groups, capture territories, manage diplomacy, upgrade roles, complete quests, and build their influence through strategic gameplay.

## Features

### Group System
- **Group Creation**: Register groups with custom colors and names
- **Group Life Timer**: Groups have limited lifespans that can be extended through quests or purchased with points
- **Voting System**: Democratic leadership transitions when the leader leaves
- **MOTD**: Customizable message of the day for group members
- **Diplomacy**: Complex relationship system between groups (Ally/Neutral/Enemy)

### Territory Control
- **Capture System**: Claim territories and flags for your group
- **Territory Bonuses**: Territories provide various bonuses when captured:
  - Income generation (passive points)
  - Shop item unlocks
- **Map Interface**: Visual territory map with zoom/pan controls
- **Territory Retainer**: Special entities that protect territories from capture

### Role System
- **Custom Roles**: Create and customize roles with permissions
- **Role Upgrades**: Extensive upgrade tree for roles including:
  - Health/Armor enhancements
  - Speed/Jump modifications
  - Regeneration abilities
  - Dodge/Evasion mechanics
  - Critical hit chances
  - Damage multipliers
  - Stealth capabilities
  - Medic/Armorer auras
  - Tank (damage-to-armor conversion)
  - Adrenaline (emergency healing)
  - Runner (speed boost on low health)
- **Slot Management**: Purchase additional slots for roles

### Quest System
- **Individual Quests**: Personal objectives with point rewards
  - Territory capture missions
  - Flag capture missions
  - Defense objectives
  - Scout/reconnaissance missions
  - Assassination contracts
  - Intel delivery
- **Group Quests**: Collective objectives for the entire group
  - Alliance formation
  - Enemy destruction
  - Territory holding challenges
  - Quest completion goals
  - Case delivery quotas

### Economy & Points
- **Group Points**: Shared currency for group upgrades and purchases
- **Personal Points**: Individual currency earned through activities
- **Salary System**: Automated periodic payments to group members
- **Income Generation**: Passive income from controlled territories

### Shop System
- **Item Purchasing**: Buy weapons and items using points
- **Unlock System**: Territory bonuses can unlock shop items
- **Queue System**: Purchased items can be spawned later
- **Custom Categories**: Organize shop items by category

### Progression
- **Role Upgrades**: Invest points to enhance individual capabilities
- **Group Upgrades**: Permanent improvements for the entire group:
  - Income multipliers
  - Quest reward bonuses
  - Time length adjustments
  - Upgrade discounts
  - Shop discounts
- **Cooldown System**: Strategic waiting periods for upgrades

### Technical Features
- **Persistent Saving**: All group data, territories, and progress saved between server restarts
- **Multi-language Support**: Built-in Russian/English translations
- **Custom GUI**: Full Derma-based interface system
- **Networking**: Optimized net messages for smooth multiplayer experience
- **Modular Design**: Features can be enabled/disabled via configuration

## Installation

1. Download the repository
2. Place the `TerritoryWars-master` folder in your `garrysmod/addons/` directory
3. Configure the addon by editing `lua/autorun/config/territorywars.config.lua`
4. Restart your server or change the map

## Configuration

The addon is highly configurable through `territorywars.config.lua`. Key settings include:

- `TW.Changeable`: Allow superadmins to change settings in-game
- `TW.TerritoryCaptureTime`: Time required to capture territories
- `TW.RoleUpgrading`: Enable/disable the entire role upgrade system
- `TW.QuestsAvailable`: Toggle quest system
- `TW.ShopActivated`: Enable/disable shop
- Extensive upgrade-specific configuration options
- Point costs and rewards
- Cooldown timers

## Usage

### Getting Started
1. Find a group register computer to create your group
2. Place your main computer in a secure location
3. Set up your shop
4. Invite members and assign roles
5. Capture territories and complete quests to earn points
6. Upgrade your group and roles to become stronger

### Commands
- `/territorywars.help` - Display help information

## Dependencies

- Garry's Mod (required)
- Optional: DarkRP integration for money-based group creation

## License

MIT License. Happiness to everyone!
