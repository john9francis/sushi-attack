# sushi-attack
Sushi themed tower defense game, coded in Godot

# Todo June 2024
- Get levels loading from a level folder
- json for the path
- json for the tower platform positions
- pic for the background
- txt/json dialogue for the level

# To do for verticle slice (DECEMBER 9):
- [x] Get the sushi rolls animated, at least 3
- [x] Complete enemy animation in all directions
- [x] Get all 4 towers animated
- [x] Get the towerGui to display the price
- [ ] Get the towerGui to show range
- [x] Get the path to show up
- [x] Get a background
- [x] Get the towerPlatforms to look like plates
- [x] Get a wave bar showing up
- [ ] Get lives looking like the happiness of grandma
- [x] Get sushi rolls with health bars
- [ ] Spruce up main menu, pause, game over, success menus
- [x] Redo the chopsticks skins


# Multiple godot apps to streamline the process
1. Sushi attack level runner
2. level creator
- UI to create levels, returns a json file with the level
- includes a simple level runner to test the level
- includes an enemy builder to know the possible enemies that have been created.
3. Enemy builder
- Ask for an enemy and it returns it.
- Also ask for all the options and it returns a string with all the options.
4. SUSHI ATTACK!
- level runner
- a bunch of premade levels from the level creator
- enemy builder
- other add ons like the progress and some menus
- infinite mode
- level creator? for sharing levels with others
- connection to internet for sharing levels
