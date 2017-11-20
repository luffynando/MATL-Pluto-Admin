dictionary= {}

function dictionary:getMaps()
	local maps={}
	table.insert(maps,{map="mp_alpha",mapname="Lockdown",tipo="normal"})
	table.insert(maps,{map="mp_bootleg",mapname="Bootleg",tipo="normal"})
	table.insert(maps,{map="mp_bravo",mapname="Mission",tipo="normal"})
	table.insert(maps,{map="mp_carbon",mapname="Carbon",tipo="normal"})
	table.insert(maps,{map="mp_dome",mapname="Dome",tipo="normal"})
	table.insert(maps,{map="mp_exchange",mapname="Downturn",tipo="normal"})
	table.insert(maps,{map="mp_hardhat",mapname="Hardhat",tipo="normal"})
	table.insert(maps,{map="mp_interchange",mapname="Interchange",tipo="normal"})
	table.insert(maps,{map="mp_lambeth",mapname="Fallen",tipo="normal"})
	table.insert(maps,{map="mp_mogadishu",mapname="Baakara",tipo="normal"})
	table.insert(maps,{map="mp_paris",mapname="Resistance",tipo="normal"})
	table.insert(maps,{map="mp_plaza2",mapname="Arkaden",tipo="normal"})
	table.insert(maps,{map="mp_radar",mapname="Outpost",tipo="normal"})
	table.insert(maps,{map="mp_seatown",mapname="Seatown",tipo="normal"})
	table.insert(maps,{map="mp_underground",mapname="Underground",tipo="normal"})
	table.insert(maps,{map="mp_village",mapname="Village",tipo="normal"})
	table.insert(maps,{map="mp_italy",mapname="Piazza",tipo="dlc1"})
	table.insert(maps,{map="mp_morningwood",mapname="BlackBox",tipo="dlc1"})
	table.insert(maps,{map="mp_overwatch",mapname="Overwatch",tipo="dlc1"})
	table.insert(maps,{map="mp_park",mapname="Liberation",tipo="dlc1"})
	table.insert(maps,{map="mp_cement",mapname="Foundation",tipo="dlc2"})
	table.insert(maps,{map="mp_hillside_ss",mapname="Getaway",tipo="dlc2"})
	table.insert(maps,{map="mp_meteora",mapname="Sanctuary",tipo="dlc2"})
	table.insert(maps,{map="mp_qadeem",mapname="Oasis",tipo="dlc2"})
	table.insert(maps,{map="mp_restrepo_ss",mapname="Lookout",tipo="dlc2"})
	table.insert(maps,{map="mp_burn_ss",mapname="U-Turn",tipo="dlc3"})
	table.insert(maps,{map="mp_crosswalk_ss",mapname="Intersection",tipo="dlc3"})
	table.insert(maps,{map="mp_six_ss",mapname="Vortex",tipo="dlc3"})
	table.insert(maps,{map="mp_boardwalk",mapname="Boardwalk",tipo="dlc4"})
	table.insert(maps,{map="mp_moab",mapname="Gulch",tipo="dlc4"})
	table.insert(maps,{map="mp_nola",mapname="Parish",tipo="dlc4"})
	table.insert(maps,{map="mp_roughneck",mapname="Roughnek",tipo="dlc4"})
	table.insert(maps,{map="mp_shipbreaker",mapname="Decommision",tipo="dlc4"})
	table.insert(maps,{map="mp_aground_ss",mapname="Aground",tipo="faceoff"})
	table.insert(maps,{map="mp_courtyard_ss",mapname="Erosion",tipo="faceoff"})
	table.insert(maps,{map="mp_terminal_cls",mapname="Terminal",tipo="terminal"})
	return maps
end

function dictionary.searchmap(name, tipo,full)
	local lowmap = name:lower()
	local mapss= dictionary:getMaps()
	local resultado ={}
	if full ~= nil then
		for i in pairs(mapss) do
			if (mapss[i].map == full) then
				table.insert(resultado,mapss[i])
			end
		end
		return resultado	
	end
	if tipo == nil then 
			if lowmap:sub(1,3) == "mp_" then
				for i in pairs(mapss) do 
					if(mapss[i].map == lowmap) then
						resultado= mapss[i]
					end
				end
			elseif lowmap == "mission" then 
				resultado= mapss[3]
			elseif lowmap == "downturn" then
				resultado= mapss[6]
			elseif lowmap == "interchange" then
				resultado= mapss[8]
			else	
				for i in pairs(mapss) do
					if (string.find(mapss[i].mapname:lower(),lowmap)) then
						resultado= mapss[i]
					end
				end
			end
	else
		if tipo == "all" then
			resultado= mapss
		else
			for i in pairs(mapss) do
				if (mapss[i].tipo == tipo) then
				table.insert(resultado,mapss[i])
				end
			end
		end
	end
	return resultado
end

function dictionary:getguns()
	local guns={}
	table.insert(guns,{gun="iw5_acr_mp",gunname="acr",tipo="primaries"})
	table.insert(guns,{gun="iw5_type95_mp",gunname="type95",tipo="primaries"})
	table.insert(guns,{gun="iw5_m4_mp",gunname="m4",tipo="primaries"})
	table.insert(guns,{gun="iw5_ak47_mp",gunname="ak47",tipo="primaries"})
	table.insert(guns,{gun="iw5_m16_mp",gunname="m16",tipo="primaries"})
	table.insert(guns,{gun="iw5_mk14_mp",gunname="mk14",tipo="primaries"})
	table.insert(guns,{gun="iw5_g36c_mp",gunname="g36c",tipo="primaries"})
	table.insert(guns,{gun="iw5_scar_mp",gunname="scar",tipo="primaries"})
	table.insert(guns,{gun="iw5_fad_mp",gunname="fad",tipo="primaries"})
	table.insert(guns,{gun="iw5_cm901_mp",gunname="cm901",tipo="primaries"})
	table.insert(guns,{gun="iw5_mp5_mp",gunname="mp5",tipo="primaries"})
	table.insert(guns,{gun="iw5_p90_mp",gunname="p90",tipo="primaries"})
	table.insert(guns,{gun="iw5_m9_mp",gunname="m9",tipo="primaries"})
	table.insert(guns,{gun="iw5_pp90m1_mp",gunname="pp90m1",tipo="primaries"})
	table.insert(guns,{gun="iw5_ump45_mp",gunname="ump45",tipo="primaries"})
	table.insert(guns,{gun="iw5_mp7_mp",gunname="mp7",tipo="primaries"})
	table.insert(guns,{gun="iw5_spas12_mp",gunname="spas12",tipo="primaries"})
	table.insert(guns,{gun="iw5_aa12_mp",gunname="aa12",tipo="primaries"})
	table.insert(guns,{gun="iw5_striker_mp",gunname="striker",tipo="primaries"})
	table.insert(guns,{gun="iw5_1887_mp",gunname="1887",tipo="primaries"})
	table.insert(guns,{gun="iw5_usas12_mp",gunname="usas12",tipo="primaries"})
	table.insert(guns,{gun="iw5_ksg_mp",gunname="ksg",tipo="primaries"})
	table.insert(guns,{gun="iw5_m60_mp",gunname="m60",tipo="primaries"})
	table.insert(guns,{gun="iw5_mk46_mp",gunname="mk46",tipo="primaries"})
	table.insert(guns,{gun="iw5_pecheneg_mp",gunname="pecheneg",tipo="primaries"})
	table.insert(guns,{gun="iw5_sa80_mp",gunname="sa80",tipo="primaries"})
	table.insert(guns,{gun="iw5_mg36_mp",gunname="mg36",tipo="primaries"})
	table.insert(guns,{gun="iw5_barrett_mp",gunname="barrett",tipo="primaries"})
	table.insert(guns,{gun="iw5_msr_mp",gunname="msr",tipo="primaries"})
	table.insert(guns,{gun="iw5_rsass_mp",gunname="rsass",tipo="primaries"})
	table.insert(guns,{gun="iw5_dragunov_mp",gunname="dragunov",tipo="primaries"})
	table.insert(guns,{gun="iw5_as50_mp",gunname="as50",tipo="primaries"})
	table.insert(guns,{gun="iw5_l96a1_mp",gunname="l96a1",tipo="primaries"})
	table.insert(guns,{gun="iw5_usp45_mp",gunname="usp45",tipo="secondaries"})
	table.insert(guns,{gun="iw5_mp412_mp",gunname="mp412",tipo="secondaries"})
	table.insert(guns,{gun="iiw5_44magnum_mp",gunname="44magnum",tipo="secondaries"})
	table.insert(guns,{gun="iw5_deserteagle_mp",gunname="deserteagle",tipo="secondaries"})
	table.insert(guns,{gun="iw5_p99_mp",gunname="p99",tipo="secondaries"})
	table.insert(guns,{gun="iw5_fnfiveseven_mp",gunname="fnfiveseven",tipo="secondaries"})
	table.insert(guns,{gun="iw5_fmg9_mp",gunname="fmg9",tipo="secondaries"})
	table.insert(guns,{gun="iw5_g18_mp",gunname="g18",tipo="secondaries"});
	table.insert(guns,{gun="iw5_mp9_mp",gunname="mp9",tipo="secondaries"});
	table.insert(guns,{gun="iw5_skorpion_mp",gunname="skorpion",tipo="secondaries"});
	table.insert(guns,{gun="rpg_mp",gunname="rpg",tipo="secondaries"});
	table.insert(guns,{gun="javelin_mp",gunname="javelin",tipo="secondaries"});
	table.insert(guns,{gun="iw5_smaw_mp",gunname="smaw",tipo="secondaries"});
	table.insert(guns,{gun="m320_mp",gunname="m320",tipo="secondaries"});
	return guns
end

function dictionary.searchgun(name)
	local lowgun= name:lower()
	local res= {}
	local guns= dictionary:getguns()
	if name ~= nil then 
		if lowgun:sub(1,4) == "iw5_" then
			for i in pairs(guns) do 
				if(guns[i].gun == lowgun) then
					res= guns[i]
				end
			end
		else
			for i in pairs(guns) do
				if(guns[i].gunname == lowgun)then 
					res= guns[i]
				end
			end
		end
	end
	return res
end

function dictionary.gameisTeamBased(gametype)
	local ban = false;
	if gametype == "tdef" then
	    ban = true;
    	elseif gametype == "sd" then
            ban = true;
    	elseif gametype == "tjugg" then
            ban = true;
    	elseif gametype == "gun" then
            ban = false;
    	elseif gametype == "ctf" then
            ban = true;
    	elseif gametype == "war" then
            ban = true;
   	elseif gametype == "dd" then
            ban = true;
    	elseif gametype == "infect" then
            ban = false;
    	elseif gametype == "ffa" then
            ban = false;
    	elseif gametype == "jugg" then
            ban = true;
    	elseif gametype == "dm" then
            ban = true;
    	elseif gametype == "grnd" then
            ban = true;
    	elseif gametype == "koth" then
            ban = true;
   	 elseif gametype == "conf" then
            ban = true;
    	elseif gametype == "oic" then
	    ban = false;
    	elseif gametype == "dom" then
            ban = true;
    	elseif gametype == "sab" then
            ban = true;
    	end
	return ban;
end


return dictionary