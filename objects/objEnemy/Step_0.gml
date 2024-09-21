if(objPlayer.restarting_room == 0) {

	var _oldx = x;
	var _newx = _oldx;
	var _tilemap = layer_tilemap_get_id("lyr_tiles");
	
	if(image_xscale == 1) { //Facing right
		_newx += 2;
		if(!tilemap_get_at_pixel(_tilemap, _newx + 3, y + 8) || tilemap_get_at_pixel(_tilemap, _newx + 4, y + 7) ) { //No tile below the new position or tile to the right
			image_xscale = -1; //Change direction
			_newx = _oldx; //Reset position
		}
	} else { //Facing left
		_newx -= 2;
		if(!tilemap_get_at_pixel(_tilemap, _newx - 4, y + 8) ||  tilemap_get_at_pixel(_tilemap, _newx - 5, y + 7)) { //No tile below the new position or tile to the left
			image_xscale = 1; //Change direction
			_newx = _oldx; //Reset position
		}		
	}

	x = _newx; //Modify y position based on newy
	if(image_xscale == 1) { //Facing right
		image_index = ((_newx + 2) mod 8) / 2;
	} else { //Facing left
		image_index = ((_newx - 1) mod 8) / 2;
	}

}