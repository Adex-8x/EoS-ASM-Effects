# Usage
**Important!** Call Irdkwia's ["Remove Party" process](https://github.com/SkyTemple/eos-move-effects/blob/master/example/process/remove_party.asm) before using these! Be sure to call a team setup process afterwards!

`Add or Sub Mentry Level` is unfortunately unstable at the moment when trying to change to a decrease a member's level. Once changed to a lower level, the "To Next Level" EXP value will reach a negative value. As such, when the Pokémon gains EXP, they will slowly level-up (gaining stat buffs in the process) until it reaches its original level.
