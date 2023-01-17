# Usage
Before importing, please be sure to uncomment/comment the proper regional labels for your ROM.

To import these successfully into EoS via SkyTemple (on 1.3+), first apply the ExtractMoveCode patch in *ASM Patches -> Utility*. Once the ROM is reloaded, you can edit the game's moves under *ASM -> Move Effects* (or if on a version pre 1.4, *Moves -> Move Effects*). When importing a new move, you can choose to replace an effect or add a new one in the *Effects Code* tab with the "+" button. Next, click on *Import Code* and select any ".asm" file. In the *Move Effects* tab, assign a move to the effect of the imported file.

Once the ROM is saved, try the move out! You will still have to edit some of the move's properties of your own, such as type, range, power, and more. If you want to edit the move's animation, you can apply the ExtractAnimData patch in *ASM Patches -> Utility*, then edit the move's animation(s) in *Lists -> Animation*, under the Move tab.
