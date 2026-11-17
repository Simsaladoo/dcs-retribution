[![Logo](https://github.com/dcs-retribution/dcs-retribution/raw/main/resources/ui/splash_screen.png)](https://shdwp.github.io/ukraine/)

(Github Readme Banner and Splash screen Artwork by Andriy Dankovych, CC BY-SA 4.0)

[![Download](https://img.shields.io/github/downloads/dcs-retribution/dcs-retribution/total?label=Download)](https://github.com/dcs-retribution/dcs-retribution/releases)

[![Discord](https://img.shields.io/discord/1015931619187621999?label=Discord&logo=discord)](https://discord.gg/b4x34Bg4We)

[![GitHub pull requests](https://img.shields.io/github/issues-pr/dcs-retribution/dcs-retribution)](https://github.com/dcs-retribution/dcs-retribution/pulls)
[![GitHub issues](https://img.shields.io/github/issues/dcs-retribution/dcs-retribution)](https://github.com/dcs-retribution/dcs-retribution/issues)
![GitHub stars](https://img.shields.io/github/stars/dcs-retribution/dcs-retribution?style=social)

## About DCS Retribution 
(Last update: 2026-03-22)

DCS Retribution was forked in 2022 from [DCS Liberation](https://github.com/dcs-liberation/dcs_liberation),
which is a [DCS World](https://www.digitalcombatsimulator.com/en/products/world/) turn based single-player or co-op dynamic campaign. 
It is an external program that generates full and complex DCS missions and manage a persistent combat environment.

![Screenshot](https://user-images.githubusercontent.com/315852/120939254-0b4a9f80-c6cc-11eb-82f5-ce3f8d714bfe.png)

DCS Retribution is no longer relying on DCS Liberation updates,
though occasionally we might still sync a feature to our fork.
However, we are no longer backwards compatible with Liberation, and will no longer attempt to do so.

Instead, we are focussing on keeping our campaigns forward compatible so that you as a user
can continue on whatever campaign you had going on.
Please keep in mind that once you save a campaign that was started
in a previous (save-compatibility breaking) build, your save file
will have been migrated and thus no longer compatible with the previous build.
Therefore, we recommend backing up your saves and perhaps organizing them by version/build number.

In the past, we've relied very little on GitHub's "Releases" since our setup is rather based on
preview builds which are made easily available through our Discord server, where a channel
will trigger a message with a link to the latest preview build whenever we push a commit to the dev branch.
However, we're planning to change this strategy and attempt to publish a new release whenever DCS releases a new
version, unless it's a minor patch which doesn't require any changes on our end.

Over the years we've extended the original DCS Liberation with a lot of features, 
such as support for road-bases, neutral bases, weapon-settings, additional mission types, etc.
For a more complete overview of our features, check the
[changelog](https://github.com/dcs-retribution/dcs-retribution/blob/main/changelog.md).

## Downloads

Latest release is available here : https://github.com/dcs-retribution/dcs-retribution/releases

To download preview builds of the next version of DCS Retribution, see https://github.com/dcs-retribution/dcs-retribution/wiki/Betas.

## DCS bugs

~~These DCS bugs prevent us from improving AI behavior. Please upvote them! (But please
_don't_ spam them with comments):~~

* ~~[A2A and SEAD escorts don't escort](https://forums.eagle.ru/topic/251798-options-for-alternate-ai-escort-behavior/?tab=comments#comment-4668033)~~
* ~~[DEAD can't use mixed loadouts effectively](https://forums.eagle.ru/topic/271941-ai-rtbs-after-firing-decoys-despite-full-load-of-bombs/)~~

While DCS bugs are still a thing, we don't quite agree with the ones stated above.
We believe to have addressed these, although some quirks still exist.
For example, SEAD Escorts tend to be a little picky with what they engage,
especially with older SAM systems.

## Bugs and feature requests

If you need to report a bug or want to suggest a new feature, you can do this on our 
[bug tracker](https://github.com/dcs-retribution/dcs-retribution/issues).
In either case, please use the search bar at the top of the page to see if it has already been reported.
Note that you may need to remove the filter for open bugs if it's something we've recently fixed.

## Roadmap

Our plans for future releases can be found on our
[Projects page](https://github.com/dcs-retribution/dcs-retribution/projects).
Each planned release has a Project, and the page for that project has columns for to do,
in progress, and done. Items in the Done column are in the
[preview build](https://github.com/dcs-retribution/dcs-retribution/wiki/Preview-builds)
for that release. Items in the To do column are planned to be added to that release.

## Quick Start: Local Multiplayer Server Setup

### Prerequisites
- DCS World installed with required maps/modules (Normandy Map + WW2 Assets Pack for WW2 campaigns)
- Python 3.11+
- Git

### 1. Clone & Install Dependencies
```cmd
git clone https://github.com/dcs-retribution/dcs-retribution.git
cd dcs-retribution
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 2. Configure DCS Paths (First Run)
```cmd
python -m qt_ui.main
```
The first-run wizard will prompt for:
- **DCS Saved Games folder** (e.g., `C:\Users\<you>\Saved Games\DCS` or `DCS.openbeta`)
- **DCS Installation directory** (e.g., `C:\Program Files\Eagle Dynamics\DCS World`)

> Retribution automatically patches `MissionScripting.lua` to allow external scripting.

### 3. Enable LAN Access for Backend API
Create `serverconfig.env` in the repo root:
```cmd
echo SERVER_BIND_ADDRESS=0.0.0.0 > serverconfig.env && echo SERVER_PORT=16880 >> serverconfig.env && echo CORS_ALLOW_DEBUG_SERVER=true >> serverconfig.env
```

### 4. Generate a Campaign

**Normandy WW2 (Caen to Evreux, July 1944):**
```cmd
python -m qt_ui.main new-game "resources/campaigns/caen_to_evreux.yaml" --blue "Allies 1944" --red "Germany 1944" --date 1944-07-04 --auto-procurement
```

**Caucasus Modern (Georgia, 2008):**
```cmd
python -m qt_ui.main new-game "resources/campaigns/Caucasus_Multi_Georgia.yaml" --blue "USA 2005" --red "Russia 2010" --auto-procurement
```

**Other campaigns:** See `resources/campaigns/*.yaml` for available theaters and factions.

### 5. Run the Campaign Manager
```cmd
python -m qt_ui.main
```
- **Campaign → Load Campaign** → select your save
- Plan turns, assign flights, purchase units
- Click **Generate Mission** → saves `.miz` to `%LOCALAPPDATA%\DCSRetribution\Missions\`

---

### Hosting Multiplayer Missions

1. **Install DCS Dedicated Server** (separate from client):
   ```cmd
   steamcmd +login anonymous +app_update 1048720 validate +quit
   ```

2. **Copy generated mission** to server's `Missions/` folder

3. **Patch MissionScripting.lua** on dedicated server:
   ```cmd
   copy resources\scripts\MissionScripting.lua "DCS_SERVER\Scripts\MissionScripting.lua"
   ```

4. **Start dedicated server:**
   ```cmd
   DCS_server.exe --mission="Missions\your_mission.miz" --webgui --port=10308
   ```

5. **Connect clients** via DCS Multiplayer browser

---

### Turn-Based Workflow
| Step | Action |
|------|--------|
| 1 | Players fly mission on DCS server |
| 2 | Mission ends (land/RTB) |
| 3 | Retribution UI: **Pass Turn** → processes results |
| 4 | **Generate Mission** for next turn |
| 5 | Copy new `.miz` to dedicated server |
| 6 | Restart DCS server with new mission |
| 7 | Repeat |

---

## Resources

Tutorials, contributors and developer's guides are available in the project's
[Wiki](https://github.com/dcs-retribution/dcs-retribution/wiki/)

(Some historical information is also availabe on
[Liberation's Wiki](https://github.com/dcs-liberation/dcs_liberation/wiki/))

## Special Thanks

First, a big thanks to shdwp, for starting the original DCS Liberation project. 

Then, DCS Liberation/Retribution uses [pydcs](https://github.com/pydcs/dcs) for mission generation, and nothing would be possible without this.
It also uses the popular [Mist](https://github.com/mrSkortch/MissionScriptingTools) lua framework for mission scripting. Support for the 
impressive [Moose](https://github.com/FlightControl-Master/MOOSE) framework was also introduced,
allowing for even more customization.

Excellent lua scripts DCS Liberation/Retribution uses as plugins:

* For the JTAC feature, DCS Retribution embeds Ciribob's JTAC Autolase [script](https://github.com/ciribob/DCS-JTACAutoLaze).
* Walder's [Skynet-IADS](https://github.com/walder/Skynet-IADS) is used for Integrated Air Defense System.
* Carstens Arty Spotter https://www.digitalcombatsimulator.com/en/files/3339128/ is an amazing force multiplyer to drop the hammer on enemies.
* MBot's [Call Artillery Script](https://forum.dcs.world/topic/310506-call-artillery-script/) uses in-map artillery and forward observers to enable artillery fire missions.

Please also show some support to these projects ! 
