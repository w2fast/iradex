This is NASM syntax, so it is recommended you use the NASM assembler. I reccomend MSYS2 in specific if you're going to emulate the environment
I recommend using QEMU to emulate this bootloader because the bootloader can be both assembled and run in the same interface when using MSYS2
DO NOT PUT THIS ON REAL HARDWARE, even though it will work with some hardware, that does not mean it will with most!

For those that know this type of stuff:
This activates a mode 13h like VGA mode with very specific VGA assumptions. The lists at the bottom are lists of bytes being put into the VGA registers in each loop to set up the VGA mode. After the initial loops are finished, it draws an initial 2x2 pixel square in the top left before jumping to the polling loop. Given that the input was one of the four arrow key makecodes(any other scancode falls onto the jump back to the polling loop) it jumps to an arrow code label which then checks the boundries needed to avoid going past the screen then sets dx to its desired movement in pixels(given that it's in a 320x200 environment, up/down is +- 320) then jumps to the drawing label which erases the current 4 pixels, adds dx to di, then draws 4 pixels based off the new di.

Sorry for the way I'm describing it, as I have a very specific mental model of it. Feel free to do anything you want with the code and use your own mental model

This will be adapted to run on older hardware and likely be built for a non-BIOS environment. I will post the new code here after I am done. It will likely use EGA video card assumptions



*Edit:
I've decided to purely focus on making a BIOS, so this probably won't be adapted. 
