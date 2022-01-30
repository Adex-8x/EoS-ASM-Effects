# EoS Custom Special Processes
This repository contains my custom special processes for PMD: Explorers of Sky!
# Usage
Before importing, please be sure to uncomment/comment the proper regional labels for your ROM.

To import these successfully into EoS via SkyTemple (on 1.3+), first apply the ExtractSPCode patch in *ASM Patches -> Utility*. Once the ROM is reloaded, you can edit the game's special processes under *Lists -> Special Process Effects*. When importing a new special process, you must first add a new effect in the *Effects Code* tab with the "+" button. Next, click on *Import Code* and select any ".asm" file. In the *Special Process Effects* tab, add a new process and assign it the effect of the imported file.

Once the ROM is saved, you can now call this special process when scripting via `ProcessSpecial(ID, arg1, arg2);`! You can also use this in a switch-statement to get the return value, if one is defined.
# Credits
All of this was based off of pre-existing research and the efforts of others. Massive thanks to End45 and Irdkwia for their extensive knowledge of the game and for providing a template to create special processes!
