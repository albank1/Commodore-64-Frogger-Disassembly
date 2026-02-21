# Commodore-64-Frogger-Disassembly

<img width="714" height="540" alt="Frogger" src="https://github.com/user-attachments/assets/298dd71c-76a7-4104-8d71-d0b491de54d3" />

I have disassembled the 1983 Frogger cartridge game. Again the idea was to be able to introduce cheats:
increase the number of lives or have infinite lives.

This was my 2nd successful disassembly. I mainly used JC64dis, the VICE monitor. ChatGPT was helpful
in understand the code but less so in producing the code.

If you look at the code you can see where you need to make changes to either increase the initial number
of frogs or give yourself infinite lives.

To compile this code you will have to use dasm (a Windows 8 bit assembler) with this command:
dasm FroggerInfLives.asm -o frogger.bin -f3
The use the VICE cartconv utility stand alone program that comes with VICE
cartconv -t normal -i frogger.bin -o frogger.crt
You now have a cartridge game which you can just drag into VICE to play or with modern hardware run on 
a real Commodore 64.
