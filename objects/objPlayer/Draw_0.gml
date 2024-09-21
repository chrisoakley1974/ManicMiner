//This draws an overlay over the screen which will gradually darken everything when the room restarts.
//This is to mimic the quick fade out you see when you die.
draw_self();
draw_set_alpha(restarting_room / 2);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
draw_set_alpha(1);
