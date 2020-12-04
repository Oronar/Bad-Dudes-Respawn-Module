# Bad Dudes Respawn Module

The Bad Dudes Repsawn Module (BDRM) is a set of scripts for configuring respawn mechanics for missions of the Bad Dudes ARMA group.

In addition, BDRM provides a workaround for the incompatibility of the `MenuPosition` and `ace_specatator` respawn templates. This allows the use of the ACE Specator camera with a player triggered respawn, mimicing the use of the `MenuPosition` and `Spectator` respawn templates.

[Github Repository](https://github.com/Oronar/bad-dudes-respawn-module)

## Basic Setup
### Mission Setup
1. Copy the `bdrm` folder to your mission's root directory.
2. Copy the `Description.ext`, `initPlayerLocal.sqf` and `initServer.sqf` files to your mission's root directory.
    * Note if you already have any of these files for your mission you will need to merge the contents instead.
3. In Eden add a marker to your mission with the variable name for the players' side.
    * `respawn_west` for BLUFOR
    * `respawn_east` for REDFOR
    * `respawn_guerrila` for GREENFOR
    * `respawn_civilian` for civilians
    * Note that this marker should be placed at the mission start or an alternative safe location. It determines where dead/spectating players will be located until they respawn.

### Configuration
1. In `Description.ext` locate the `sideRespawnMarkerName` value and set it to the respawn marker set in Basic Setup (e.g. `respawn_west`, `respawn_east` etc.)
    * Note the default value is `respawn_west` and does not need to be changed if players are BLUFOR.

# Alternative Setups

## Object Location Respawn (aka Box Respawn)
An alternative configuration where players will respawn near the location of an object. This object can be mobile and moved via ACE cargo loading and ACE carry/drag to allow players to relocate their respawn position.

### Mission Setup
1. Follow the steps for **Mission Setup** in **Basic Setup**
2. Add an object in Eden that cannot be picked up but can be moved via ACE carry/drag mechanics, such as an ammo box.
3. Set the object's `Variable Name` to the value indicated by the `respawnMarkerName` configuration value in `Description.ext`. By default this value is `bdrm_respawn`.

### Configuration
1. Follow the steps for **Configuration** in **Basic Setup**
  
## Object Action Respawn (aka Flag Respawn)  
An alternative configuration where players respawn at the latest object activated by an action. Players interact with the object via an action to relocate the respawn position to their current position. This respawn method is intended to be used with flag poles but can be used with any object.

### Mission Setup
1. Follow the steps for **Mission Setup** in **Basic Setup**
2. Add a distinguishable object, such as a flag, at each point that will be a respawn location in Eden.
3. Edit each flag object and in the `init` field of each execute the script show in the examples below.
    * This script has three optional arguments for the name of the action and activation distance.
    * `[this, "Claim Flag", 25, ""]` are the default values
    * The last argument is a texture that the flag will be set to when activated. When omitted or set to `""` the flag texture will not change.

```[this] execVM "bdrm\scripts\helpers\addSetRespawnPositionAction.sqf";```

```[this, "Capture the Flag", 25, "bdrm\assets\bad_dudes_head.paa"] execVM "bdrm\scripts\helpers\addSetRespawnPositionAction.sqf";```

### Configuration
1. Follow the steps for **Configuration** in **Basic Setup**

## Enter Vehicle Type Respawn (aka Dude Tube)
An alternative configuration intended to be used with the ACE Spotting Scope. When a unit enters a configured vehicle type the respawn position is relocated to the vehicle's position. When used with the ACE spotting scope this provides a respawn position that can be carried in a player's inventory.

### Mission Setup
1. Follow the steps for **Mission Setup** in **Basic Setup**
2. Add an ACE spotting scope (`ace_spottingscopeobject`) to the starting location or to a player unit's inventory.

### Configuration
1. Follow the steps for **Configuration** in **Basic Setup**
2. In `Description.ext` set the `EnterVehicleTypeRespawn.active` value to `1`

## ACE Tagging Respawn
An alternative configuration that uses ACE spray cans to mark respawn positions. When the configured spray can is used to spray a `Bad Dudes Respawn` tag on the ground or object the respawn position will be relocated to the tag's position.

### Mission Setup
1. Follow the steps for **Mission Setup** in **Basic Setup**
2. Add a red spray paint can at the starting location or to a player unit's inventory.

### Configuration
1. Follow the steps for **Configuration** in **Basic Setup**
2. In `Description.ext` set the `ACETaggingRespawn.active` configuration value to `1`
3. Optionally set the `ACE_Tags.BDRM_bad_dude_tag.requiredItem` configuration value to an alternative item. (e.g. `ACE_SpraypaintBlack`, `ACE_SpraypaintRed`, `ACE_SpraypaintGreen`, `ACE_SpraypaintBlue`). This item will need to be added to the mission in place of the red spray paint can.

## In Development
* Flare Respawn

## Parachute Respawn
Parachute respawn is used in conjunction with the above respawn mechanics. Players will respawn in the air above the respawn position with a deployed parachute.

### Mission Setup
1. Follow the steps for **Mission Setup** in any of the above sections.

### Configuration
1. Follow the steps for **Configuration** in any of the above sections.
2. In `Description.ext`:
    * set the `ParachuteRespawn.aboveTerrainLevel` to the height above terrain level that players will respawn.
    * set the `ParachuteRespawn.vehicleType` value to desired parachute's vehicle type or leave the default `rhs_d6_Parachute` value.
    * increase the `respawnDistanceMinimum` and `respawnDistanceMaximum` to suit your spawn location.
    * increasing these values will increase the radius players' potential spawn but allow for safer descent with more seperation.

# Configuration Values
* `respawnMarkerName` - variable name of marker used for respawn location
* `sideRespawnMarkerName` - variable name of the sided ARMA respawn marker
* `loadoutVariableName` - variable name used internally for saving loadouts
* `respawnDistanceMinimum` - minimum distance to search for a safe position to respawn near current respawn position
* `respawnDistanceMaximum` - maximum distance to search for a safe position to respawn near current respawn position
* `showRespawnNotification` - 1: enables notifications of respawn position updates, 0: disables
* `EnterVehicleTypeRespawn.active` - 1: enables EnterVehicleTypeRespawn, 0: disables
* `EnterVehicleTypeRespawn.vehicleType` - vehicle type used for EnterVehicleTypeRespawn
* `ParachuteRespawn.aboveTerrainLevel` - height above terrain level players will respawn
* `ParachuteRespawn.vehicleType` - vehicle class used for player parachute if `aboveTerrainLevel` is greater than 0
* `ACETaggingRespawn.active` - 1: enables ACETaggingRespawn, 0: disables;
* `ACETaggingRespawn.respawnTexture` - texture file name of tag that will be used to mark respawn location

# Configuration Notes
1. If the ARMA respawn marker (e.g. `respawn_west`) is placed at an alternate location because the mission start is not a safe location then the BDRM respawn marker should be manually created in Eden and placed at the starting location.
    * The name of this marker is controlled by the `sideRespawnMarkerName` configuration value and is `bdrm_respawn` by default.
2. Using an object respawn setup will override the BDRM respawn marker. If the object is destroyed respawns will default to the marker location.
3. If a BDRM respawn marker is not created manually in Eden then one will be created at the position of the marker indicated by `respawnMarkerName` at mission start.
4. Object Respawn (aka Box Respawn) will continue to work even if the object is loaded into a vehicle.
