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

#### User Interactions
We implemented functions to handle user interactions like feeding, playing, and taking the pet to the doctor. Each interaction affects the pet's attributes.

**Example:**
```lua
function feedPet()
    pet.hunger = pet.hunger - 10
    pet.happiness = pet.happiness + 5
end

