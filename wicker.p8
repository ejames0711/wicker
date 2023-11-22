pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()

	--player
	player = {}
	player.x = 50
	player.y = 100
	player.flip = false
	player.spr = 5
	player.state = "idle"
	
	--animation
	stimer = 0
	sub_frame = false
	
	--apples
	apples = {}
	
	--enemy
	
	score = 0
end


function _update()
	
 update_game()

end

function _draw()
 draw_game()
end
-->8
--player

function player_mv(dir)

	if stimer%5 == 0 then
		if player.spr < 7 then
 		player.spr += 1
 	else
 		player.spr = 6
 	end
 end

--right
	if dir == "right" then
	
		player.x += 2
		player.flip = false
		
	end
	
--left
	if dir == "left" then
	
		player.x -= 2
		player.flip = true
		
	end
	
	if player.x+8 > 128 then
		player.x = 120
	end
	
	if player.x < 0 then
		player.x = 0
	end

end


-->8
-- helper

function update_stime()

	if stimer < 999 then
		stimer += 1
	else
		stimer = 0
	end
	
end

function collision(a,b)

	local a_left = a.x
	local a_top = a.y
	local a_right = a.x+7
	local a_bottom = a.y+7
	
	local b_left = b.x
	local b_top = b.y
	local b_right = b.x+7
	local b_bottom = b.y+7
	
	if a_top > b_bottom then return false end
	if b_top > a_bottom then return false end
	if a_left > b_right then return false end
	if b_left > a_right then return false end
	
	return true
	
end

function spawn_apple()
	local apple = {}
	rnd_num = flr(rnd(126))
	apple.x = rnd_num
	apple.y = flr(rnd(40))+10
	apple.spr = 3
	add(apples,apple)
end
-->8
-- update

function update_game()
	update_stime()
	
	if stimer%50 == 0 then
		spawn_apple()
	end
	
	if not btn(➡️) and not btn(⬅️) then
		player.spr = 5
	end

 if btn(➡️) then
		player_mv("right")
	end
	
	if btn(⬅️) then
		player_mv("left")
	end
	
	for apple in all(apples) do
		apple.y += 2
		if collision(apple,player) then
			score += 1
			del(apples,apple)
		end
	end
	
end
-->8
--draw

function draw_game()
 cls(12)
	spr(player.spr,player.x,player.y,1,1,player.flip)
	for en in all(apples) do
		spr(en.spr,en.x,en.y)
	end
	print(score)
end 
__gfx__
00bbbbbbbbbbbbbbbbbbb0000440000000aaaa004666666400000000000000000000000000000000000000000000000000000000000000000000000000000000
0bbb33bbbb3333bb333bbbb0004422000a9999a04444444400000000466666640000000000000000000000000000000000000000000000000000000000000000
bbb3333bb333333b33333bb002848820a7d99d7a4754457446666664477447740000000000000000000000000000000000000000000000000000000000000000
bb333333333bb333333bb3bb28888e82a779977a4774477447544754475447540000000000000000000000000000000000000000000000000000000000000000
bb3333333333bb3333bb333b28888e82a999999a5444444547744774444444440000000000000000000000000000000000000000000000000000000000000000
bb3333bb33333bb33bbb333b2888e882a900009a0544445055444455554444550000000000000000000000000000000000000000000000000000000000000000
bb333bb333333bb33333333b288888820a0880a00055550005444450005555000000000000000000000000000000000000000000000000000000000000000000
bb333bb3333333333333333b0288882000aaaa001110011101555511111001100000000000000000000000000000000000000000000000000000000000000000
bb333333333333333333333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb33333333333bb33b33333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b333333333333bb33bbb333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b333bb3333bb33b3333b333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb333bb333bb3333333333bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb3333333bb333b3333333bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb33333333333bb333b333bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b333333333333b333bb3333b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000003bbb33330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000033333b330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000033333bb30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000003b3333b30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88888888888888888888888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8888eee8888888888888888888888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1eee1ee11111111111111111111111111111111111111111111111111111111111111111
111111e11e1111111b1b11b11b1b1711166116661117111111e11e1e1e111e1e1111111111111111111111111111111111111111111111111111111111111111
111111e11ee111111bb111b11b1b1711166111661117111111e11eee1ee11e1e1111111111111111111111111111111111111111111111111111111111111111
111111e11e1111111b1b11b11b1b1711166116661117111111e11e1e1e111e1e1111111111111111111111111111111111111111111111111111111111111111
11111eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1eee11111666161116661616166616661111161611111ccc1111111711111cc11ccc1ccc11111eee1e1e1eee1ee1111111111111111111111111
1111111111e11e1111111616161116161616161116161111161611711c1c11111171111111c1111c1c1c111111e11e1e1e111e1e111111111111111111111111
1111111111e11ee111111666161116661666166116611111116117771ccc11111711111111c11ccc1ccc111111e11eee1ee11e1e111111111111111111111111
1111111111e11e1111111611161116161116161116161111161611711c1c11111171111111c11c111c1c111111e11e1e1e111e1e111111111111111111111111
111111111eee1e1111111611166616161666166616161171161611111ccc1111111711111ccc1ccc1ccc111111e11e1e1eee1e1e111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111666161116661616166616661111161611111111111111111ccc1111111111111111111111111111111111111111111111111111111111111111
111111111111161616111616161616111616111116161111117117771111111c1111111111111111111111111111111111111111111111111111111111111111
1111111111111666161116661666166116611111116111111777111111111ccc1111111111111111111111111111111111111111111111111111111111111111
1111111111111611161116161116161116161111161611111171177711111c111111111111111111111111111111111111111111111111111111111111111111
1111111111111611166616161666166616161171161611111111111111111ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111eee1eee11111166166616661666166616661111111711111cc11ccc11111eee1e1e1eee1ee1111111111111111111111111111111111111
111111111111111111e11e11111116111161116116661611161611111171111111c11c1c111111e11e1e1e111e1e111111111111111111111111111111111111
111111111111111111e11ee1111116661161116116161661166111111711111111c11c1c111111e11eee1ee11e1e111111111111111111111111111111111111
111111111111111111e11e11111111161161116116161611161611111171111111c11c1c111111e11e1e1e111e1e111111111111111111111111111111111111
11111111111111111eee1e1111111661116116661616166616161111111711111ccc1ccc111111e11e1e1eee1e1e111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111111111661666166616661666166611111111111111111cc11111111111111111111111111111111111111111111111111111111111111111
11111111111111111111161111611161166616111616111111711777111111c11111111111111111111111111111111111111111111111111111111111111111
11111111111111111111166611611161161616611661111117771111111111c11111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111611611161161616111616111111711777111111c11111111111111111111111111111111111111111111111111111111111111111
1111111111111111111116611161166616161666161611111111111111111ccc1111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111eee1e1111ee1eee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111e111e111e111e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111ee11e111eee1ee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111e111e11111e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111eee1eee1ee11eee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111eee1eee111116661611166616161666166611111166166616661111111711111ccc11111eee1e1e1eee1ee111111111111111111111
1111111111111111111111e11e1111111616161116161616161116161111161116161616111111711111111c111111e11e1e1e111e1e11111111111111111111
1111111111111111111111e11ee111111666161116661666166116611111166616661661111117111111111c111111e11eee1ee11e1e11111111111111111111
1111111111111111111111e11e1111111611161116161116161116161111111616111616111111711111111c111111e11e1e1e111e1e11111111111111111111
111111111111111111111eee1e1111111611166616161666166616161171166116111616111111171111111c111111e11e1e1eee1e1e11111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111166616111666161616661666111111661666166611111111111111111cc111111111111111111111111111111111111111111111
1111111111111111111111111616161116161616161116161111161116161616111111711777111111c111111111111111111111111111111111111111111111
1111111111111111111111111666161116661666166116611111166616661661111117771111111111c111111111111111111111111111111111111111111111
1111111111111111111111111611161116161116161116161111111616111616111111711777111111c111111111111111111111111111111111111111111111
111111111111111111111111161116661616166616661616117116611611161611111111111111111ccc11111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111eee1e1111ee1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111e111e111e111e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111ee11e111eee1ee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111e111e11111e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111eee1eee1ee11eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111116661611166616161666166611111166166616661111111111111c11111111111111111111111111111111111111111111111111
11111111111111111111111116161611161616161611161611111611161616161111177711111c11111111111111111111111111111111111111111111111111
11111111111111111111111116661611166616661661166111111666166616611111111111111ccc111111111111111111111111111111111111111111111111
11111111111111111111111116111611161611161611161611111116161116161111177711111c1c111111111111111111111111111111111111111111111111
11111111111111111111111116111666161616661666161611711661161116161111111111111ccc111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111eee1ee11ee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111ee11e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111eee1e1e1eee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111166166616661666166616661111111111111ccc111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111611116111611666161116161111177711111c1c111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111666116111611616166116611111111111111c1c111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111116116111611616161116161111177711111c1c111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111661116116661616166616161111111111111ccc111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111eee1ee11ee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111ee11e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111e111e1e1e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111eee1e1e1eee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1e1111ee1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e111e111e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111ee11e111eee1ee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e11111e1e1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1eee1ee11eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111118888811111111111111111111111111111111111111111111111111111111111
111111111111166616111666161616661666111116161111111111111cc11ccc8888811111111111111111111111111111111111111111111111111111111111
1111111111111616161116161616161116161111161611111777111111c1111c8888811111111111111111111111111111111111111111111111111111111111
1111111111111666161116661666166116611111116111111111111111c11ccc8888811111111111111111111111111111111111111111111111111111111111
1111111111111611161116161116161116161111161611111777111111c11c118888811111111111111111111111111111111111111111111111111111111111
111111111111161116661616166616661616117116161111111111111ccc1ccc8888811111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111eee1ee11ee1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111171111111111111111111111111111111111111111111111111111
111111111ee11e1e1e1e111111111111111111111111111111111111111111111111111111177111111111111111111111111111111111111111111111111111
111111111e111e1e1e1e111111111111111111111111111111111111111111111111111111177711111111111111111111111111111111111111111111111111
111111111eee1e1e1eee111111111111111111111111111111111111111111111111111111177771111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111177111111111111111111111111111111111111111111111111111
11111eee1e1111ee1eee1eee1eee11111bbb1bbb1bb1117111666661117111111eee1e1e1ee11711111111111111111111111111111111111111111111111111
11111e111e111e111e1111e11e1111111b1b11b11b1b1711166611661117111111e11e1e1e111e1e111111111111111111111111111111111111111111111111
11111ee11e111eee1ee111e11ee111111bb111b11b1b1711166111661117111111e11eee1ee11e1e111111111111111111111111111111111111111111111111
11111e111e11111e1e1111e11e1111111b1b11b11b1b1711166611661117111111e11e1e1e111e1e111111111111111111111111111111111111111111111111
11111eee1eee1ee11eee1eee1e1111111bbb11b11b1b1171116666611171111111e11e1e1eee1e1e111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111666161116661616166616661111161611111111111111111ccc11111111111111111111111111111111111111111111111111111111111111111111
11111111161616111616161616111616111116161111111117771111111c11111111111111111111111111111111111111111111111111111111111111111111
111111111666161116661666166116611111116111111777111111111ccc11111111111111111111111111111111111111111111111111111111111111111111
111111111611161116161116161116161111161611111111177711111c1111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822282288882828282228888888888888888888888888888888888888888888888888888822282228882822282288222822288866688
82888828828282888888888288288828828288828888888888888888888888888888888888888888888888888888828282888828828288288282888288888888
82888828828282288888882288288828822282228888888888888888888888888888888888888888888888888888822282228828822288288222822288822288
82888828828282888888888288288828888282888888888888888888888888888888888888888888888888888888888288828828828288288882828888888888
82228222828282228888822282228288888282228888888888888888888888888888888888888888888888888888888282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

