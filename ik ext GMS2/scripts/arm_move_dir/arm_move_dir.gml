/// @desc move the arm towards dir and calculate the joints accordingly using the inverse kinematics formula
/// @func arm_move_dir(len, dir, pin, px, py);
/// @arg len	length to move
/// @arg dir	direction to move
/// @arg pin	whether to pin or not (constrain to a position)
/// @arg px		x location to pin/constrain to
/// @arg py		y location to pin/constrain to

//	only fill in the two first arguments if you want the arm to move freely.
//	the last two arguments are where you want to pin the arm to.

var _len = argument[0], 
	_dir = argument[1], 
	_pin = false,
	_pnx = x,
	_pny = y;			
			
if (argument_count > 2) {
	_pin = argument[2];
	if (_pin) {
		if (argument_count > 3) {
			var _pnx = argument[3],
				_pny = argument[4];
		}
	}
} else _pin = arm_pinned;

if (_len != 0) {
	seg_x[@ seg_amount] += dcos(_dir)*_len;   
	seg_y[@ seg_amount] += dsin(360-_dir)*_len; 

	for(var _i = seg_amount-1; _i >= _pin; _i--) 
		seg_calculate(	_i,	seg_x[@ _i+1], 
								seg_y[@ _i+1]);
}

if (_pin && (seg_x[@ 0] != _pnx || seg_y[@ 0] != _pny || _len != 0)) {
	seg_x[@ 0] = _pnx;
	seg_y[@ 0] = _pny;
	
	for(var _i = 1; _i <= seg_amount; _i++)
		seg_calculate(	_i,	seg_x[@ _i-1], 
								seg_y[@ _i-1]);
}