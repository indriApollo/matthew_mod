--matthew_mod

--block
minetest.register_node("matthew_mod:play", {
	description = "matthew_mod play button",
	tiles = {"default_wood.png^matthew_mod_play.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, player, pointed_thing)
		matthew_mod.play()
	end,
})

minetest.register_node("matthew_mod:pause", {
	description = "matthew_mod pause button",
	tiles = {"default_wood.png^matthew_mod_pause.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, player, pointed_thing)
		matthew_mod.pause()
	end,
})

--functions
local http = matthew_mod.http

matthew_mod.play = function()
	--
end

matthew_mod.pause = function()

	local req = {url="http://localhost:8888/pause",
				timeout=3,
				post_data = nil, --use GET
				user_agent="minetest http"}
	http.fetch(req, matthew_mod.pause_callback)
end

matthew_mod.pause_callback = function (resp)
	minetest.chat_send_all(resp.data)
end