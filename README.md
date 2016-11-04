# breakout
Recreation of the classic game "Breakout!", built in Processing

Assignment Description:

The following requirements are adapted from the gameplay description found at the above link.

Breakout begins with eight rows of bricks, with each two rows a different colour (the colour order from the bottom up is yellow, green, orange and red). You will track information about the bricks’ x/y coordinates and colours using three parallel arrays. If you need more arrays to track information using additional arrays, that is fine.

Using a single ball, the player must knock down as many bricks as possible by using the walls and/or the paddle below to ricochet the ball against the bricks and eliminate them. As such, the ball will need to bounce off the side and top walls, and the player must be able to control a paddle at the bottom off of which the ball can bounce.

If the player's paddle misses the ball's rebound (i.e. hitting the bottom wall), he or she loses a turn. The player has three turns to try to clear all the bricks on the screen, after which a game over message will be displayed. The number of turns remaining should be visible on the screen.

Breaking a yellow brick earns one point each, a green brick earns three points, orange bricks earn five points and the top-level red bricks score seven points each. The current score should be displayed on the screen.

Ball speed increases at specific intervals: after four hits on the bricks, after twelve hits on the bricks, and after making contact with the orange and red rows.  After starting again when you lose a turn, the speed should return back to normal.
