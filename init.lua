matthew_mod = {}

matthew_mod.http = minetest.request_http_api()

if not matthew_mod.http then
	minetest.log("error","Http accesss not granted")
else
	dofile( minetest.get_modpath("matthew_mod").."/mod.lua" )
	minetest.log("info","matthew_mod is up and running")
end
