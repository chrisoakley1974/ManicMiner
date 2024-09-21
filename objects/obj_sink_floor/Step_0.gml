if(objPlayer.y + 7 < y && objPlayer.jumpcount == 0) { //The player y position is less than the floor
	if(place_meeting(x+(objPlayer.image_xscale == 1 ? -1 : 1), y-1, objPlayer)){ //The player is over the top
		image_index += 1; //Increase image
	}
}
if(image_index > 8) { //Hit the last image
	instance_destroy(self);	 //Destroy self
}