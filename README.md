# Halo 3 MCC Albatross

[![NEXUS MODS](https://img.shields.io/badge/NEXUS-MODS-orange)](https://www.nexusmods.com/halothemasterchiefcollection/mods/1566)

The albatross is a flying mobile base vehicle, and this project is intended to make it easily accessible to modders so it may be treated as another tool in Halo 3's sandbox

## Table of contents

- [Features](#features)
- [Implementation instructions](#implementation-instructions)
  - [Adding to a scenario](#adding-to-a-scenario)
  - [Optional: Adding to forge palette](#optional-adding-to-forge-palette)
- [Build Instructions](#build-instructions)
- [Compiling the sample maps](#compiling-the-sample-maps)
- [Contribution guidelines](#contribution-guidelines)

## Features

### Fully localized physics (localized physics, "mega physics", early mover):

- Players and vehicles can move inside the cargo area using the albatross as a frame of reference
- Goal markers such as flag and assault goal/spawns and king of the hill markers can be placed within the cargo area in forge
- Turrets can be mounted to the cargo area in forge
- Objects such as crates and fusion coils can be placed in forge and set to respawn within the cargo area
- Doors collide with players, vehicles, etc, but not with the environment, allowing for smooth vehicle entry

### Multiple variants

- **Default:** Static physics for multiplayer. Doors open and close with landing and takeoff respectively
- **Commando:** No doors
- **Scripted:** Works best for singleplayer but can be done with two players. Doors close and open when a player enters or exits the vehicle. A script uses this same trigger to toggle the albatross's physics model between an open and closed permutation. This update will only take effect for the host, so if playing with another player, the host must be the passenger.

### Graphical tweaks

- Doors restored from Halo 2
- Cut decal restoration
- Custom engine and door animations
- Model tweaks to maximize animation support
- Engine thrust and hover fx

### Sample Maps

- **Sandtrap:** All variants pre-placed, and attacker team goal markers default position moved into cargo area of doorless albatross
- **Sandbox:** All variants pre-placed
- **Rat's Nest:** Scripted variant pre-placed where scenery pelican ordinarily would be. All variants in forge palette

## Implementation instructions

### Adding to a scenario

Start by installing the `tags` folder from this mod to your `H3EK` directory

Open your scenario in Sapien, and navigate the hierarchy view to `scenario` &#8594; `objects` &#8594; `units` &#8594; `vehicles`

Click `edit types` &#8594; `add`, then navigate to `tags\objects\vehicles\albatross`

Double click on the variant(s) you want included, then click `done`

Right click anywhere to create a new vehicle, then adjust the properties pallet to match your desired variant config:

#### **Default**

Simply set the `type` to `albatross`

#### **Doorless**

Set the `type` to `albatross_commando`

#### **Scripted**

For this to function as intended, a modification to the scenario script is required

Start by copying the original script info for the map you intend to replace from `data/data/levels/<map_type>/<map_name>` to `data/levels/<map_type>/<map_name>`

> **Note:** `<map_name>` refers to the original map name (e.g. `shrine`)

Now within that directory, open the `./scripts/<map_name>_main.hsc` file in the editor of your choice

> **Note:** If the base map does not have scripts, create the scripts directory, and populate it with files `<map_name>_main.hsc` and `<map_name>_fragments.hsc`

Now follow this format, and save

```lisp
(script startup <map_name>_main
	; no need to change anything here
)

(script continuous update_albatross_physics
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_rear blocked)
		(object_set_permutation albatross doorway_rear clear)
	)
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_left blocked)
		(object_set_permutation albatross doorway_left clear)
	)
	(if (player_in_vehicle albatross)
		(object_set_permutation albatross doorway_right blocked)
		(object_set_permutation albatross doorway_right clear)
	)
)
```

Back in sapien, set your vehicle type to `albatross_scripted` and the name to `albatross`

Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd> to compile scripts

Optional: Press <kbd>Alt</kbd>+<kbd>G</kbd> to enable/disable scripts in Sapien

Save your scenario and give it a name

If you would like to add more than one scripted albatross to a scenario, give it a new name such as `albatross_001`, then add a new set of if statements to the function with all references to `albatross` replaced with the new unit name

### Optional: Adding to forge palette

In Guerilla, open `tags/levels/<map_type>/<map_name>/<your_scenario_name>.scenario`

Navigate down to `MV VEHICLE palette` and click add

Click the <kbd>...</kbd> for `name` and navigate to `tags/objects/vehicles/albatross` and select the vehicle tag for the variant you want to add. Leave the display name blank, and fill in the price and limit info for forge. Repeat this process for any other variants you want to be usable in forge

> **Note:** It is useful to add the scripted variant here just to be able to move it around in forge, but note that deleting and and respawning it in forge will cause it to lose the name we gave it in Sapien, and thus will no longer be able to update its physics state in response to the script

_Save_.

Your scenario can now be compiled into a map using Tool:

`tool build-cache-file "levels\<map_type>\<map_name>\<scenario_name>"`

## Build Instructions

Start by installing both the `data` and `tags` folders from this mod to your `H3EK` directory

The `render_model`, `collision_model`, and `physics_model` can each be opened either through the included blender project file, or by importing them one at a time as JMS from the `data` folder in a new blender instance

To export modified versions of each from blender, use the [Halo Asset Blender Development Toolset](https://github.com/General-101/Halo-Asset-Blender-Development-Toolset). Export as a JMS, select Halo 3, select uncheck the model types that aren't currently being modified, set the name to `albatross` and save in the correct folder within the `data/objects/vehicles/albatross` directory to match the model type

### Animations

Start with the render model open in blender

Animations can be imported as JMA from the `data/objects/vehicle/albatross/animations` directory

Modifications can then be exported as JMA, but be sure to configure the exporter to have the actual extension match (JMA or JMO)

Run `tool model-animations "objects\vehicles\albatross"`

Navigate to `tags\objects\vehicles\albatross` and copy `albatross.model_animation_graph` to `albatross_scripted.model_animation_graph`

In Guerilla, open both `albatross.model_animation_graph` and `albatross_scripted.model_animation_graph`, and enable `expert mode` in the `edit` menu

#### **albatross.model_animation_graph**

Navigate to the `MODE-n_STATE GRAPH` section

Under MODES `any`, open the dropdown for OVERLAYS and select `throttle`. Click the `Delete` button

Open the MODES dropdown and select `combat`. Delete all the OVERLAYS

_Save now_.

Scroll down to `SPECIAL CASE ANIMS` and click the `add` button for `VEHICLE SUSPENSION`. Configure like so:
| | |
|-------------------------------|---------------------|
| label | combat:fully_opened |
| graph index | -1 |
| animation | combat:fully_opened |
| marker name | landing_tires |
| mass point offset | 0 |
| full extension ground_depth | 2 |
| full compression ground_depth | 0 |

Click the `add` button for `OBJECT OVERLAYS`. Configure like so:
| | |
|-------------------|------------------|
| label | vehicle:throttle |
| graph index | -1 |
| animation | vehicle:throttle |
| function controls | frame |
| function | thrust |

_Save_.

#### **albatross_scripted.model_animation_graph**

Navigate to the `MODE-n_STATE GRAPH` section

Under MODES `any`, open the dropdown for OVERLAYS and select `throttle`. Click the `Delete` button

_Save now_.

Scroll down to `SPECIAL CASE ANIMS` and click the `add` button for `OBJECT OVERLAYS`. Configure like so:
| | |
|-------------------|------------------|
| label | vehicle:throttle |
| graph index | -1 |
| animation | vehicle:throttle |
| function controls | frame |
| function | thrust |

_Save_.

### Render Model

Run `tool render "objects\vehicles\albatross" draft`

### Collision Model

Run `tool collision "objects\vehicles\albatross"`

### Physics Model

Run `tool physics "objects\vehicles\albatross"`

### Bulk

To update the render, collision, and physics models all at once, run

`tool bulk-import-model-folder "objects\vehicles\albatross"`

## Compiling the sample maps

Copy the contents of the `sample` folder from this repo into your `H3EK` directory

Make any desired edits to the scripts for the sample scenarios in `data/levels/<map_type>/<map_name>/scripts/<map_name>_main.hsc`. If you choose to do so, remember to open the scenario in Sapien and compile the scripts with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd>

Now to compile each of the maps, run the following Tool commands for each respective map:

- **Sandtrap:** `tool build-cache-file "levels\multi\shrine\shrine"`
- **Sandbox:** `tool build-cache-file "levels\dlc\sandbox\sandbox"`
- **Rat's Nest:** `tool build-cache-file "levels\dlc\armory\armory"`
- **The Storm:** `tool build-cache-file "levels\solo\040_voi"`

Now just move the maps from your `H3EK/maps` directory into your `<mcc_path>/halo3/maps` directory

## Contribution guidelines

1. Fork this repo
2. Follow the steps in [Build Instructions](#build-instructions) to make changes
3. Make sure they worked
4. Make a pull request back to this repo with a description of what your change does

thats it, nothing special ¯\\_(ツ)_/¯
