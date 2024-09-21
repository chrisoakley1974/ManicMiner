var _key_right = keyboard_check(vk_right);
var _key_left = keyboard_check(vk_left);

if(objPlayer.y + 7 < y && objPlayer.jumpcount == 0) { //The player y position is less than the floor and not jumping
	if(place_meeting(x+(objPlayer.image_xscale == 1 ? -1 : 1), y-1, objPlayer)){ //The player is on the moving walkway
		if(image_speed == 1) { //Walkway moving left
			if(!objPlayer.previoushit) { //Only just hit the moving walkway
				if(objPlayer.image_xscale == 1 && _key_right) { //Player is facing right
					objPlayer.forcex = (objPlayer._falling ? 2 : 1);
				} else { //Player is facing left
					objPlayer.forcex = -1; //Set this so player auto walks left
				}
				objPlayer.previoushit = true; //Set
			}
			if(objPlayer.forcex >= 1 && !_key_right) { //Currently being forced right but not pressing key right
				objPlayer.forcex = -1; //Force walk left
			}
		} else { //Walkway moving right
			if(!objPlayer.previoushit) { //Only just hit the moving walkway
				if(objPlayer.image_xscale == -1 && _key_left) { //Player is facing left
					objPlayer.forcex = (objPlayer._falling ? 2 : -1);
				} else { //Player is facing right
					objPlayer.forcex = 1; //Set this so player auto walks right
				}
				objPlayer.previoushit = true; //Set
			}
			if((objPlayer.forcex == -1 || objPlayer.forcex == 2) && !_key_left) { //Currently being forced left but not pressing key left
				objPlayer.forcex = 1; //Force walk right
			}	
		}
	} else { //Not on the moving walkway
		objPlayer.previoushit = false //Reset	
		objPlayer.forcex = 0;
	}
} else {
	objPlayer.previoushit = false; //Reset
}