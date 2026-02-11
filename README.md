# 🐶🎮 Dog Platformer

**Dog Platformer** is a **2D platformer** game where you control a dog that jumps between platforms, collects coins, and faces enemies until reaching the final boss — an orange cat. 🐱

---

## ⭐ Main Features

- Classic-style **2D platforms** with a linear map from start to finish.  
- Gameplay inspired by **classic platformers like Mario**.  
- **Life system**, traps, and collectibles.  
- Basic user interface scenes: **pause**, **options**, **victory**, and **defeat**.

---

## 🕹️ Gameplay Mechanics

- The dog can **jump** to move through the level and reach platforms.  
- It can **defeat enemies by jumping on their heads**.  
- The **boss (cat)** takes damage when the player jumps on its head and needs **3 hits** to be defeated.  
- The player has **3 lives** ❤️. After taking 3 hits, the game is lost.  

**Traps**
- Pits that cause instant death.  
- Spikes and saws that reduce 1 life.  

**Coins**
- Collecting **100 coins** restores 1 life point. 🪙  
- Coins could later be used to **buy skins** for the dog.

---

## 🧩 User Interface

**Visible elements during gameplay**
- **Coin counter** 🪙  
- **Lives indicator** ❤️  

**Implemented UI scenes**
- `pause.tscn` – Pause menu ⏸️  
- `options.tscn` – Options (master volume, fullscreen, and Back button) ⚙️  
- `winner.tscn` – Victory screen with Next Level and Return to Menu buttons 🏆  
- `loser.tscn` – Defeat screen with Retry and Return to Menu buttons 💀  

---

## 👾 Enemies

**Basic enemies**
- Frog  
- Fox  

**Boss**
- Orange cat with **3 lives**, takes damage when jumped on 😼  

---

## 🎞️ Character Animations

The dog includes:
- **Idle** animation, alternating between pooping and barking while standing still.  
- **Walk** animation to move across the map.  
- **Jump** animation to progress and attack enemies.  

---

## 📦🎵 Art and Sound Resources

**Characters and enemies**
- [Frogs Pixel Asset Pack – Pop Shop Packs](https://pop-shop-packs.itch.io/frogs-pixel-asset-pack)  
- [Cats Pixel Asset Pack – Pop Shop Packs](https://pop-shop-packs.itch.io/cats-pixel-asset-pack)  
- [2D Pixel Art Fox Sprites – Elthen](https://elthen.itch.io/2d-pixel-art-fox-sprites)

**Tilesets and environments**
- [Treasure Hunters – Pixel Frog](https://pixelfrog-assets.itch.io/treasure-hunters)  
- [Brackeys Platformer Bundle – Brackeys Games](https://brackeysgames.itch.io/brackeys-platformer-bundle)  
- [Pixel Adventure 1 – Pixel Frog](https://pixelfrog-assets.itch.io/pixel-adventure-1)  
- [Pixel Platformer – Kenney](https://kenney-assets.itch.io/pixel-platformer)

**Sound and music**
- [Main music track (Mureka)](https://www.mureka.ai/song-detail/PMXyW9MFANUs5W9SqRiDqr?is_from_share=1)

> ✅ Make sure to review each asset license before publishing the game.

---

## 🚧 Project Status

**Current phase**
- Engine: **Godot 4**  
- Implemented: Menu scenes (Pause, Options, Victory, Defeat)  

**Pending**
- Level design  
- Implementation of all enemies and the boss  
- Complete coin, life, and skin system  

---
