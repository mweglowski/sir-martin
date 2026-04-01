# ⚔ Sir Martin

A precision-platformer built with **Godot 4.6.1** where every jump counts. Navigate slippery surfaces, collect coins to unlock magical barriers, and reach the Princess in the fastest time possible!

---

## Overview
In this challenge-driven platformer, you control a character with a unique **hold-to-charge** jump mechanic. Inspired by games like *Jump King*, the physics are demanding: you must master your horizontal momentum and vertical power to climb the environment and avoid falling into the "Mushroom".

---

## Key Features
* **Charge-Jump Physics:** Variable jump heights and distances based on how long you hold the spacebar.
* **Dynamic Tile Logic:** Navigate different ground types including **Normal** platforms and **Slippery** ice that affects your friction and movement.
* **Global Progression:** A persistent `Global` system that tracks your coins, deaths, and time across scene reloads.
* **Interactive Environments:** Collectible coins and **Magic Wall** that only vanish once you’ve gathered enough loot.
* **Particle Effects:** Custom pixel-art dust clouds for landing to give the movement "juice."
* **Complete UI System:** Includes a Main Menu, Pause Menu (ESC), Controls Guide, and a Final Results Screen.

---

## How to Play
1.  **Move:** Use `Arrow Keys` to walk.
2.  **Jump:** Hold `Spacebar` to charge your jump. Release to launch! 
    * *Tip: Move while charging to leap horizontally.*
3.  **Unlock:** Collect **5 Coins** to open the Magic Wall blocking the path to the Princess.
4.  **Pause:** Press `ESC` at any time to check controls or quit.
5.  **Goal:** Reach the Princess! Your final time and death count will be displayed at the end.

---

## Technical Details
* **Engine:** Godot (GDExtension/GDScript)
* **Architecture:** * Uses **Autoload (Singleton)** for global data management.
    * **GPUParticles2D** for optimized pixel-art effects.
    * **Signal-based UI** for decoupled communication between game objects and menus.
    * **Custom TileData:** Leverages Godot's TileSet patterns to identify surface types.

---

## Getting Started
1. Clone this repository.
2. Open `project.godot` in **Godot 4.x**.
3. Press **F5** to start from the Main Menu.

---

*Created as a learning project in Godot Game Development with Brackeys youtube video help and usage of his assets*
