# Tamagotchi Game

## Introduction
Welcome to this game project we created! This project was developed by our team as part of our effort to create a girl simulation game as an ode to the WOMEN ENGINEER'S PROGRAM. The game is implemented in Lua, and this README provides a comprehensive guide to how the game was developed, including our learning process and the specific Lua concepts we utilized.

## Learning Process

### Getting Started with Lua

#### Understanding the Basics
We began by familiarizing ourselves with the basics of Lua, including syntax, variables, loops, and functions. Resources like the official Lua documentation and online tutorials were invaluable.

#### Setting Up the Development Environment
We set up our development environment using tools like LuaRocks for package management and ZeroBrane Studio as our IDE for Lua development.

### Figuring Out Different Sections of the Code

#### Game Structure
We structured our game into multiple modules, each handling a specific aspect of the game. This modular approach made the codebase more manageable and easier to debug.

#### Pet Attributes and Behaviors
We defined various attributes for the Tamagotchi pet, such as hunger, happiness, and health. Each attribute was implemented as a variable that could change over time based on player interactions.

**Example:**
```lua
pet = {
    hunger = 100,
    happiness = 100,
    health = 100
}
```

#### User Interactions
We implemented functions to handle user interactions like feeding, playing, and taking the pet to the doctor. Each interaction affects the pet's attributes.

**Example:**
```lua
function feedPet()
    pet.hunger = pet.hunger - 10
    pet.happiness = pet.happiness + 5
end
```

## Lua Concepts Used In This Game

### Tables
Tables are a fundamental part of Lua and were used extensively to manage the pet's attributes and game states.

**Example:**
```lua
pet = {
    hunger = 100,
    happiness = 100,
    health = 100
}
```
### Functions
We used functions to encapsulate behaviors and actions within the game. This made our code modular and reusable.

**Example:**
```lua
function playWithPet()
    pet.happiness = pet.happiness + 10
    pet.health = pet.health - 5
end
```
### Loops and Conditionals
Loops and conditionals were used to manage the game flow and update the pet's status over time.

**Example:**
```lua
while true do
    updatePetStatus()
    if pet.hunger > 50 then
        print("Your pet is hungry!")
    end
end
```
###Coroutines
We explored coroutines to handle time-based events and asynchronous tasks within the game. This was particularly useful for creating a responsive and interactive game experience.

## Key Components and Functionalities

### 1. `animation.lua`

Handles character animations based on the character's state and interactions.

- **Properties and Variables:**
  - `girlSprites`: Table holding the character's sprite images.
  - `currentSprite`: Currently displayed sprite.
  - `showAnimation`: Flag to control animation display.
  - `animationTimer`, `animationSpeed`, `animationIndex`: Control animation timing and frame switching.
  - `sleep`: Sprite for the sleeping state.

- **Functions:**
  - `anim.load()`: Loads the sprites.
  - `anim.update(dt)`: Updates the animation frame based on the timer and light state.
  - `anim.draw()`: Draws the current sprite or sleep sprite based on the light state.

### 2. `eat.lua`

Manages the eating animation and logic for the character.

- **Properties and Variables:**
  - `chaiSprites`, `cookiesSprites`, `girlEatSprites`: Tables holding different animation frames for eating actions.
  - `currentChaiSprite`, `currentCookiesSprite`, `currentGirlEatSprite`: Currently displayed sprites.
  - `showChai`, `showCookies`, `showGirlEat`, `showGirlSatisfied`: Flags to control the display of different animations.
  - `eatTimer`, `eatDuration`: Control the duration of the eating process.
  - `jumpYPositions`, `jumpTimer`, `jumpDuration`, `jumpIndex`: Control the "satisfied jump" animation.

- **Functions:**
  - `eat.load()`: Loads the sprites and initializes positions for jump animation.
  - `eat.start()`: Randomly starts either chai or cookies animation and initiates the eating process.
  - `eat.update(dt)`: Updates the animation frames and timers.
  - `eat.draw()`: Draws the appropriate sprites based on the current animation state.

### 3. `energy_meter.lua`

Controls the energy meter, which decreases over time and can be replenished.

- **Properties and Variables:**
  - `energy_meter`: Table holding the sprites for different energy levels.
  - `energy_meter_percent`: Current energy percentage.
  - `current_energy_meter_sprite`: Sprite representing the current energy level.

- **Functions:**
  - `energy.load()`: Loads the energy meter sprites.
  - `energy.update(dt)`: Updates the energy level and corresponding sprite based on time and interactions.
  - `increaseEnergy(amount)`: Increases the energy level by a specified amount.
  - `energy.draw()`: Draws the current energy meter sprite.

### 4. `game.lua`

Implements a mini-game where the character dodges falling ducks.

- **Properties and Variables:**
  - `background`, `girl`, `duck`: Sprites for the game.
  - `girlX`, `girlY`, `girlWidth`, `girlHeight`, `girlSpeed`: Properties controlling the girl's position and movement.
  - `ducks`, `duckWidth`, `duckHeight`, `duckSpeed`, `duckSpawnTime`, `duckTimer`: Control the ducks' properties and spawning mechanics.
  - `score`, `gameFont`, `gameMessage`: Game score and messaging.
  - `scaleX`, `scaleY`: Scaling factors for the background.

- **Functions:**
  - `game.load()`: Loads game assets and initializes properties.
  - `game.start()`: Initializes the game state and starts the game.
  - `game.update(dt)`: Updates the game logic, including movement and collision detection.
  - `game.draw()`: Draws the game elements on the screen.
