# BitRunner


BitRunner is simple “Frogger” style game, in which a player-controlled block attempts to vertically pass through the paths of 6 other blocks, which are scrolling horizontally across the screen, without being touched. The 6 environmental blocks travel at varying speeds, with the top three blocks scrolling towards the right, and the bottom three scrolling towards the left. The controls are simple, there are 4 directional buttons (up, down, left, right) that choose which direction the block will travel, a “stop” button, which tells the player-controlled block to stop moving until another directional button is hit, and a “pause” switch to stop movement and control of all blocks in case the user needs to do something else. Finally, once the player-controlled block has reached the other side, the block is reset to the beginning. 


Due to the nature of multiple items moving at once as well as controls being asynchronously sent in, I felt it was necessary that the programming behind this be mostly in concurrent form. Some of the structure was based off a few VGA tutorials I found on Youtube, which allowed me to originally be able to set up the MY package in order to create the sizing for all the blocks. I also utilized Quartus’ Megawizard function to create my PLL entity. In regards to cost, outside of requiring a DE1 and the Quartus software to program everything, the project also requires a PS/2 keyboard and a monitor that has a VGA input and is capable of 1280 x 1024 resolution.


The largest challenge with this project was the hit detection logic for the blocks, this was resolved through tinkering with some IF...THEN statements until eventually I was able to set it the correct parameters, allowing the program to reset the player-controlled block if it breaches any part of the horizontal or vertical vectors of the other blocks. Some other issues I faced were things such as making sure the old location of a moving block was changed to black while coloring in the pixels in the new location with the block’s specific color. This was resolved through utilizing a DRAW variable, which was returned from the MY package when a new location was set. In regards to the amount of hours spent programming/designing, I spent around 30 hours designing and programming the entire system.


This project, with some refinement, has all the marketable attributes of a basic arcade game. But barring a new trend where Arcades become popular again, this game does not have much opportunity for commercialization. 


What I learned most from this project is that even though a task like making a functional video game seems intimidating, it’s not built all at once. I started with simply being able to move a single block across a black screen, and then slowly implemented more blocks and complexities into the logic of both the blocks and the borders of the screen until I felt I had created a finished project.


Requirements:

Altera DE1 Board

Quartus II 

PS/2 keyboard

Keyboard used for development: http://www.amazon.com/gp/product/B007R9YV0C/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1

Monitor (VGA 1280 x 1024 capable)

Monitor used for development: http://www.amazon.com/gp/product/B005BZNDOO/ref=oh_aui_detailpage_o08_s00?ie=UTF8&psc=1

Setup:

Open BitRunner in Quartus II

Connect DE1 Board to PS/2 Keyboard

Connect DE1 Board to Monitor with VGA cable

Use the Programmer to upload code to DE1 

