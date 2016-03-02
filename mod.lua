--matthew_mod
matthew_mod.list = {}
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

matthew_mod.loadList = function()

	minetest.log("action","loadlist")
	
	local req = {url="http://localhost:8888/list",
				timeout=10,
				post_data = nil, --use GET
				user_agent="minetest http"}
	http.fetch(req, matthew_mod.loadList_callback)
end

matthew_mod.loadList_callback = function(resp)

	if resp.code ~= 200 then
		minetest.log("error","Could not load music list !(http "..resp.code..")")
	else
		local data = minetest.parse_json(resp.data)
		local list = data.message
		for i,v in ipairs(list) do
			matthew_mod.list[i] = {}
			matthew_mod.list[i].name = v.name
			matthew_mod.list[i].m_id = matthew_mod.base64enc(v.name)
		end
		minetest.log("action",#list.." songs loaded in music list")
	end
end

matthew_mod.play = function()
	math.randomseed( os.time() )
	if matthew_mod.list[1] then
		local n = math.random(#matthew_mod.list)
		local m_id = matthew_mod.list[n].m_id
		local req = {url="http://localhost:8888/play/"..m_id,
				timeout=10,
				post_data = nil, --use GET
				user_agent="minetest http"}
	http.fetch(req, matthew_mod.play_callback)
	end
end

matthew_mod.play_callback = function (resp)
	minetest.chat_send_all(resp.data)
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

--onload
minetest.after(0, matthew_mod.loadList )