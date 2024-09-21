draw_set_colour(make_color_rgb(205,205,205));
draw_set_font(fonArcade);
draw_text(8, 128, "WILLY'S LAST WOBBLY");
draw_text(8, 142, "SCORE: " + string_replace_all(string_format((global.collected_items * 100),6,0)," ","0") );