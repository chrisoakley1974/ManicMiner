if(restarting_room == 0) { //Not restarting the room

	var _oldx = x; //Get the current x position
	var _newx = _oldx; //New x
	var _oldy = y; //Get the current y position
	var _newy = _oldy; //New y
	var _key_right = keyboard_check(vk_right);
	var _key_left = keyboard_check(vk_left);
	_falling = false;
	if(forcex == 1) { //Force walk right
		_key_right = true;
		_key_left = false;
	}
	if(forcex == -1) { //Force walk left
		_key_right = false;
		_key_left = true;		
	}
	if(forcex == 2) { //Prevent character movement
		_key_right = false;
		_key_left = false;
	}
	
	var _key_jump = keyboard_check(vk_space);
	var _jump_step = 180 / 15;
	
	//Work out where to move horizontally
	var _tilemap = layer_tilemap_get_id("lyr_tiles");
	var _collide_left = false;
	var _collide_right = false;
	var _collide_bottom = false;
	for(_y=-8;_y<8;_y++){
		if(tilemap_get_at_pixel(_tilemap, _newx+6, _newy+_y) == 1){ //There's a collision on the right
			_collide_right = true; //Set to true
		}		
		if(tilemap_get_at_pixel(_tilemap, _newx-7, _newy+_y) == 1){ //There's a collision on the left
			_collide_left = true; //Set to true
		}
	}
	
	if(jumpcount == 0) { //Not jumping
		
		if(image_xscale == 1) { //Facing right
			if (!tilemap_get_at_pixel(_tilemap, _newx-4, _newy+8) && !tilemap_get_at_pixel(_tilemap, _newx+4, _newy+8) && !position_meeting(_newx-4, _newy+8, obj_sink_floor) && !position_meeting(_newx+3, _newy+8, obj_sink_floor)) { //No collision with tile under character
				_falling = true;
				_newy += 2; //Increase newy so we fall
				jumpdirection = 0; //Set jump direction to 0
			}
		} else { //Facing left
			if (!tilemap_get_at_pixel(_tilemap, _newx-5, _newy+8) && !tilemap_get_at_pixel(_tilemap, _newx+3, _newy+8) && !position_meeting(_newx-5, _newy+8, obj_sink_floor) && !position_meeting(_newx+3, _newy+8, obj_sink_floor)) { //No collision with tile under character
				_falling = true;
				_newy += 2; //Increase newy so we fall
				jumpdirection = 0; //Set jump direction to 0
			}		
		}
		
		if(_falling) { //Falling
			if(image_xscale == 1) { //Facing right			
				if(tilemap_get_at_pixel(_tilemap, _newx+5, _newy+7) && !tilemap_get_at_pixel(_tilemap, _newx+5, _newy+6)) { //Collision below toe but not above toe
					_falling = false;
					_newy = _oldy;
					jumpdirection = 0;
				}
			} else { //Facing left	
				if(tilemap_get_at_pixel(_tilemap, _newx-6, _newy+7) && !tilemap_get_at_pixel(_tilemap, _newx-6, _newy+6)) { //Collision below toe but not above toe
					_falling = false;
					_newy = _oldy;
					jumpdirection = 0;
				}				
			}
		}
			
		if(!_falling) { //Not falling
			
			//Work out if we can jump
			if (_key_jump && jumpcount == 0) { //Can jump
				
				jumpcount = 180 + _jump_step; //Set the jump counter
				jumpdirection = 0; //Default is jump up
				jump_y_start = _oldy; //The start y position of the jump
				if(_key_left || _key_right) {
					jumpdirection = _key_left ? -1 : 1; //If left or right pressed then jump left or right
					image_xscale = jumpdirection;
				}
			
			} else { //Can't jump
				
				if(_key_right) { //Pressing right
					if(image_xscale == -1) { //Facing left
						image_xscale = 1; //Face right
						_newx -= 2;
					}		
					if(image_xscale == 1) { //Currently facing right
						_newx += 2;
						if(tilemap_get_at_pixel(_tilemap, _newx + 5, _newy + 7) == 1) { //Colliding right at toe
							_newx -= 2;
						}						
					}
				}					
				
				if(_key_left) { //Pressing left
					if(image_xscale == 1) { //Facing right
						image_xscale = -1; //Face left
						_newx += 2;
					}
					if(image_xscale == -1) { //Currently facing left
						_newx -= 2;
						if(tilemap_get_at_pixel(_tilemap, _newx - 5, _newy + 7) == 1) { //Colliding left at toe
							_newx += 2;
						}
					}
				}
			
			}
		} else { //Falling
			
			var _ay = 15 - (_newy mod 15);
			audio_play_sound(snd_blip,1,0,0.25,false,1 + (_ay / 15));
			
		}
				
	} else { //Jumping
		
		_newy = round_to_even(floor(jump_y_start + jmps[jumpcount-_jump_step])); //Work out the new ypos
		audio_play_sound(snd_blip,1,0,0.25,false,1+(abs(jmps[jumpcount-_jump_step])/ 20));
		
		if(jumpdirection == 1) { //Jumping right
			if(!_collide_right) { //Not colliding with a tile to the right
				_newx += 2;	
			}
		}
		
		if(jumpdirection == -1) { //Jumping left
			if(!_collide_left) {//Not colliding with a tile to the left
				_newx -= 2;
			}
		}
		
		if(_newy > _oldy) { //Jumping but on the descend

			var _chy = (floor(_newy / 8) * 8) + 8; //The y position we need to check for a collision underfoot. This is the newy pos rounded to the nearest 8 pixels
			for(_x=-4;_x<4;_x++){ //Loop the x axis of character
				if(_chy >= _newy && (tilemap_get_at_pixel(_tilemap, _newx+_x, _chy) || position_meeting(_newx+_x, _newy+8, obj_sink_floor)) ){ //There's a collision on the bottom
					jumpdirection = 0; //Set jump direction to 0
					_newy = _chy - 8; //Set to the y position we've found - 8
					jumpcount = _jump_step; //Set to jumpstep so it ends as 0 after this pass
					break; //Break loop
				}		
			}	

			if(jumpdirection == 1) { //Jumping right
				if(_collide_right) { //Not colliding with a tile to the right
					jumpdirection = 0; //Set jump direction to 0
					jumpcount = _jump_step; //Set to jumpstep so it ends as 0 after this pass
				}
			}
			
			if(jumpdirection == -1) { //Jumping left
				if(_collide_left){ //Not colliding with a tile to the left
					jumpdirection = 0; //Set jump direction to 0
					jumpcount = _jump_step; //Set to jumpstep so it ends as 0 after this pass
				}
			}			
			
		} else { //Jumping but on the ascend
			
			for(_x=-4;_x<4;_x++){
				if(tilemap_get_at_pixel(_tilemap, _newx+_x, _newy-8) == 1){ //There's a collision above
					jumpdirection = 0; //Set jump direction to 0
					_newy = _oldy; //Set to the old y position
					jumpcount = _jump_step; //Set to jumpstep so it ends as 0 after this pass
					break; //Exit loop
				}		
			}			
		
		}
		
		jumpcount -= _jump_step; //Decrease jump count
		
	}

	x = _newx; //Modify x position based on newx
	y = _newy; //Modify y position based on newy
	if(image_xscale == 1) { //Facing right
		image_index = ((_newx+2) mod (sprite_get_number(sprite_index) * 2)) / 2;
	} else { //Facing left
		image_index = ((_newx-1) mod (sprite_get_number(sprite_index) *2)) / 2;
	}
	
	if(place_meeting(x,y,[obj_static_obstacle,objEnemy])) { //Now colliding with a nasty thing that kills you
		restarting_room += 1; //Increase counter
		with (all) {
			image_speed = 0; //Stop animations
		} //Loop all objects
	}
	
	if(place_meeting(x,y,[obj_collectable])) { //Collide with a collectable
		var _collectable = instance_place(x, y, obj_collectable);
		if (_collectable != noone) { //Destroy the collectable
		    instance_destroy(_collectable); //Destroy collectable
			global.collected_items += 1; //Increase item counter
		}
	}
	
	if(instance_number(obj_collectable) == 0) { //There are no more collectables
		with(obj_exit){ //Loop the exits
			image_alpha -= 0.1;
			if(image_alpha <= 0.2) image_alpha = 1;
		}
		if(player_in_exit(objPlayer,obj_exit)) { //In the exit
			room_restart();
		}
	}

		
	with(obj_collectable){ //Loop the collectables
		image_alpha -= 0.1;
		if(image_alpha <= 0.2) image_alpha = 1;
	}

} else { //Restarting the room
	
	if(restarting_room > 1) {
		room_restart(); //Restart the room
	} else {
		restarting_room += 1; //Increase counter
	}
		
}

