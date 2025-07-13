# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **2D Godot Template** (version 4.4) that combines a general 2D game framework with a pirate-themed platformer demo. The project serves as a starting template for 2D games with built-in systems for audio management, scene transitions, and interactive gameplay mechanics.

## Common Commands

### Running the Project
```bash
# Open project in Godot Editor
godot project.godot

# Run project directly from command line
godot --main-pack project.godot

# Run in debug mode
godot --debug project.godot

# Export project (requires export templates)
godot --headless --export-debug "platform_name" output_path
```

### Development Workflow
- Open `project.godot` in Godot Editor to work on the project
- Main scene is `res://globals/game_manager.tscn`
- Use F5 to run the project from the editor
- Use F6 to run the current scene being edited

## Architecture Overview

### Core Systems Architecture

**Global Autoload Singletons:**
- `AudioStreamManager` - Pooled audio system for sound effects and music
- `Globals` - Global state management (item interactions, drag/drop state)

**Main Scene Flow:**
1. `game_manager.tscn` loads with introduction screen
2. Start button transitions to `demo_world/world.tscn`
3. Demo world contains multiple gameplay examples

### Character System Architecture

**Dual Character Systems:**
- **Legacy system** in `characters/` - UI-focused with drag/drop mechanics
- **Primary system** in `platformer/` - Full 2D platformer implementation

**Player State Machine (platformer/scripts/player.gd):**
```gdscript
enum player { IDLE, RUNNING, ATTACKING, TRANSITION_TO_JUMPING, JUMPING, FALLING }
enum WEAPON { NONE, SWORD }
```

**Key Patterns:**
- Enum-driven finite state machines for character behavior
- CharacterBody2D with physics-based movement using `move_and_slide()`
- RayCast2D nodes for combat and collision detection
- Extensive SpriteFrames with animation state management

### Enemy System
- Simple AI with edge detection and directional movement
- Collision-based turning using RayCast2D
- Player interaction through stomping mechanics
- Automatic destruction with sound effects

### Interactive Objects
- **Chest System** - Weapon acquisition with state management
- **Kill Zones** - Player death triggers with time scale effects and scene reloading
- **Item System** - Mouse-based interaction with shader effects and health

## Project Structure

```
/globals/              # Global managers and autoloads
/characters/           # Legacy character system (UI-focused)
/platformer/          # Primary 2D platformer system
  /scenes/            # Scene files for game objects
  /scripts/           # GDScript files for game logic
  /assets/            # Sprites, audio, and art assets
/levels/demo_world/   # Level and world structure
/assets/              # Legacy assets being moved to platformer/
```

## Input Configuration

**Control Scheme:**
- Movement: A/D keys, gamepad D-pad/analog stick
- Jump: Space/W keys, gamepad A button  
- Action: E key, gamepad X button
- Mouse: Left click for UI interactions

**Input Actions (defined in project.godot):**
- `move_left`, `move_right` - Horizontal movement
- `jump` - Jumping action
- `action` - General interaction
- `left_click` - Mouse interactions

## Technical Configuration

**Display Settings:**
- Base resolution: 640x360
- Stretch mode: canvas_items
- Texture filter: nearest neighbor (pixel art style)

**Asset Organization:**
- Pirate-themed sprite collections (Captain Clown Nose character)
- Background elements (palm trees, terrain, water effects)
- Wood and Paper UI theme
- Audio files organized by type (music/sound effects)

## Development Notes

**Collision Layers:**
- Layer 2: Player character
- Layer 4: Enemies and interactive objects

**Key Code Patterns:**
- Use `queue_free()` for object destruction
- Connect signals in `_ready()` functions
- Implement `_process(delta)` for frame-based updates
- Use `preload()` for scene references
- Leverage autoload singletons for cross-scene functionality

**Audio System Usage:**
```gdscript
# Play a sound effect
AudioStreamManager.play("res://path/to/sound.mp3")
```

**Scene Management:**
```gdscript
# Load and instantiate new scenes
var new_scene = SCENE_RESOURCE.instantiate()
add_child(new_scene)
```

## Asset Pipeline

The project is currently undergoing reorganization from root `assets/` to `platformer/assets/`. When adding new assets:
- Place new assets in `platformer/assets/` following the existing structure
- Maintain the pirate theme for consistency
- Use nearest neighbor filtering for pixel art assets
- Organize by asset type (Background, Characters, Audio, etc.)