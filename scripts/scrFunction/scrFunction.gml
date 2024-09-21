
function player_in_exit(_player, _exit) {
	var _ret = false;
	var _small_left = _player.bbox_left;
	var _small_top = _player.bbox_top;
	var _small_right = _player.bbox_right;
	var _small_bottom = _player.bbox_bottom;
	var _large_left = _exit.bbox_left;
	var _large_top = _exit.bbox_top;
	var _large_right = _exit.bbox_right;
	var _large_bottom = _exit.bbox_bottom;
	if (_small_left >= _large_left && _small_right <= _large_right && _small_top >= _large_top && _small_bottom <= _large_bottom) {
		_ret = true;
	}
	return _ret;
}

function round_to_even(_num) {
    var _rounded = round(_num);
    if (_rounded % 2 != 0) {
        return _rounded + (_rounded < _num ? 1 : -1);
    }
    return _rounded;
}