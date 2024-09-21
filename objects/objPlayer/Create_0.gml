jumpdirection = 0; //The direction the player is jumping in.
jumpcount = 0; //The decreasing jump counter. When 0 - not jumping.
jump_y_start = 0; //The y axis of player when jump is started
forcex = 0; //When set to 1 or -1 it treats it like the user has pressed left or right.
previoushit = false; //Used for when a player lands on a moving walkway.
restarting_room = 0; //For the restart room counter. When this is not 0 we know we shouldn't animate or move anything.
_falling = false; //When this is true the player is falling. This isn't true when the player is jumping but is falling back down.

jmps = []; //Hold the jump y axis steps.
for(ang=0;ang<181;ang++){ //Loop through 180 steps.
	jmps[ang] = -(sin(ang * pi / 180) * 18); //Work out the y axis step for this x position for the jump.
}

depth = 5; //Set the depth of the player to 5.

objDot.depth = 1; //Put the debugging tracking dot infront of the player
objDot.visible = false; //Hide the debugging tracking dot. I use this dot when trying to get collisions pixel perfect.
