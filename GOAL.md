# yo
so my goal is to have a cool waybar right
## goals and stuff:
most of the concept is stolen from [this one reddit post](https://www.reddit.com/r/unixporn/comments/1wtdcwy/hyprland_replaced_ewwwaybarrofidunst_with/) but i couldnt get theirs working thus i started work on this.
i want it to be efficient, as in to be responsive and not use much resources. basically i want the work that goes into this to be invisible as if it was meant to be like it. this also means multiple ways to close/access stuff, and general accessability and whatever makes sense.
## rn i have these ideas for its function and looks:
- itll sit on the top edge of the scren
- there will be 2 background which are masked dynamically. a bg-1 and a bg-2.
    - bg-1 is the main background. that takes up most the screen usually.
    - bg-2 is on screen as an accent or to signify importance.
        - instead of having backgrounds for each elements in the bar, it will mask bg-2 as its background, as if it was a window into the other bg. this means when each element expands, it reveals more of the bg-2, and when the main menu is in the center its background shows bg-2. (this could be very cool if you had 2 images with matching scenes but different lighting for example.)
        - it also goes around the edges kinda like the example
- itll have 3 parts left center right
- the left part is a simple workspace switcher
- the middle is gonna be a pill with the time as the default look:
    - when you hover it, it extends downwards and outwards to show the date too under it.
    - when you click it, it morphs into this huge menu in the center of the screen. the menu is called main-menu btw:
        - main menu stuff goes here
- the right part is gonna be a settings and stuff menu idk:
    - im thinking rn it will have an options button, a power-thingie, and maybe other stuff too. these are the tabs for the submenu called right-menu (very creative):
        - the right menu will extend downwards when a tab is hovered, with its contents on the expanded part.
        - (when you hover a different tab with one already open, it will just transition the size, and move the contents the correct way and slide in the new contents from the newly hovered tab (like its right next to it just off screen)
## vvv TO-DO list goes here vvv
[ ] make it
## credits
shoutouts to [Mugiwaraa](https://www.reddit.com/user/Weak_Avocado_4905/) for the idea and i looks
shoutouts to myself for this file
Haiku 5.5 for the actual work lmfao
