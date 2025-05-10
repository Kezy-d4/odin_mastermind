# Mastermind
A CLI based Mastermind game developed as part of 
[The Odin Project](https://www.theodinproject.com) curriculum and programmed
in Ruby. 

# Video Demo
[kezy_odin_mastermind_video_demo.webm](https://github.com/user-attachments/assets/06e3e93f-55b2-464c-94f0-57d4a8a68f53)

# How to Install and Use
To install, first clone this repository onto your local machine. Then, using 
Bundler, install and configure the necessary gems and dependencies. Finally, 
use Bundler to run the main file in the root of the repository, `mastermind.rb`.

Please note, the game has been optimized for "dark" or "classic" command line
color themes (white text on a black background.) To ensure that the colors and
characters used in the game display as intended, please set your terminal color
theme accordingly before running the game. 

Finally, know that the default game parameters are as follows: ten 
available attempts for the Code Breaker, a secret code length of four digits, 
and a secret code range of one through six. The game has been programmed such 
that these specific parameters can be adjusted in the code without inhibiting 
core functionality.

# The Computer Code Breaker Solving Algorithm
The computer Code Breaker will only employ its intelligent solving algorithm
assuming all default game parameters as specified in the "How to Install and 
Use" section above. Otherwise, it will simply guess randomly without making use 
of any systematic strategy.

Assuming all default game parameters, the computer Code Breaker will enact the 
following algorithm to try and crack your chosen secret code:

Its first five attempts will consist of a sequence of four identical digits
corresponding to the attempt: \
attempt#1: 1 1 1 1 \
attempt#2: 2 2 2 2 \
attempt#3: 3 3 3 3 \
attempt#4: 4 4 4 4 \
attempt#5: 5 5 5 5 

From these hardcoded initial guesses, the algorithm is guaranteed to have enough 
information to know each specific digit present in the code. From there, it 
repeatedly guesses a random combination of the known digits, never guessing the
same code twice. 

This algorithm is far from perfect and there is a fairly high chance that your 
secret code will not be cracked. The algorithm is more effective at guessing 
codes that contain duplicates, as this reduces the number of possible codes to 
randomly try once each digit is known. 
