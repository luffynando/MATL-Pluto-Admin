commandparser={}

commandparser.functions={}

commandparser.adminpath= string.format(".//scripts//mp//matl//%s",config.admins)
commandparser.banpath= string.format(".//scripts//mp//matl//%s",config.bans)
commandparser.logconsolepath= string.format(".//scripts//mp//matl//logs//%s",config.logconsole)
commandparser.logcommandspath= string.format(".//scripts//mp//matl//logs//%s",config.logcommands)
commandparser.mtimespath= string.format(".//scripts//mp//matl//%s",config.tmes_file)
commandparser.rulespath= string.format(".//scripts//mp//matl//%s",config.rules)
commandparser.rulespath_en= string.format(".//scripts//mp//matl//%s",config.rules_en)
commandparser.commandspath= string.format(".//scripts//mp//matl//%s",config.commands)
commandparser.groupspath= string.format(".//scripts//mp//matl//%s",config.groups)
commandparser.maprotpath= string.format(".//scripts//mp//matl//%s", config.maprot_file)
commandparser.spotspath= string.format(".//scripts//mp//matl//%s", config.spots)
commandparser.clientspath= string.format(".//scripts//mp//matl//%s", config.clients)

function commandparser:getversion()
    print("Version 0.1")
end

function commandparser:has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function commandparser:emptyAlias(var)
	local count = var:len()+1
	local test= var:split(" ")
	if count == #test then 
		return true
	end
	return false
end

function commandparser.add(name,numargs,sintax)
	commandparser.functions[name]={}
	commandparser.functions[name].numArgs= numargs
	commandparser.functions[name].usage= sintax
end

function commandparser:savelogConsole()
    if config.logconsole_enabled then
		print(lang.save_console)
		if (#logconsole ~= 0)then
			local updatefil= assert(io.open(commandparser.logconsolepath,"a+"))
			for i in pairs(logconsole) do
				local strin= logconsole[i]
				updatefil:write(tostring(strin),"\n")
			end
			updatefil:close()
			logconsole=nil
			logconsole={}
		end
    end
    if config.logcommands_enabled then 
        print(lang.save_console)
		if (#logcommands ~= 0)then
			local updatefile= assert(io.open(commandparser.logcommandspath,"a+"))
			for i in pairs(logcommands) do
				local strin2= logcommands[i]
				updatefile:write(tostring(strin2),"\n")
			end
			updatefile:close()
			logcommands=nil
			logcommands={}
		end
    end
end

function commandparser:updatelogConsole(args)
	local log= string.format("%s %s: %s",os.date("%c"),args.sender.name,args.message)
    logconsole[#logconsole+1] = log
	print(string.format("%s :%s",args.sender.name,args.message))
end

function commandparser:updatelogCommand(args)
	local log= string.format("%s %s: %s",os.date("%c"),args.sender.name,args.message)
    logcommands[#logcommands+1] = log
    print(string.format("%s :%s",args.sender.name,args.message))
end

commandparser.colors={}

function commandparser:colores()
	table.insert(commandparser.colors,"^1")
	table.insert(commandparser.colors,"^2")
	table.insert(commandparser.colors,"^3")
	table.insert(commandparser.colors,"^4")
	table.insert(commandparser.colors,"^5")
	table.insert(commandparser.colors,"^6")
	table.insert(commandparser.colors,"^7")
	table.insert(commandparser.colors,"^0")
	table.insert(commandparser.colors,"^;")
	table.insert(commandparser.colors,"^:")
end

function commandparser:sayToPlayer(player, msg)
	player:tell(string.format("^0[^5PM^0]^7 %s",msg))
end

function commandparser:sayAll(message)
    local consoleName = config.sysprefix
	util.chatPrint(consoleName .. message)
end

function commandparser:custumMsg(msg)
	gsc.iprintln(string.format("%s %s",config.sysprefix,msg))
end

function commandparser:sayTellPlayer(player, mensaje)
	player:iPrintLnBold(mensaje)
end

function commandparser:checkrangocommand(comando)
	local myrango=-1
	for j in pairs (commands.ChildNodes) do
		if (commands.ChildNodes[j].Name ~="ignorecmd") then
			if (commands.ChildNodes[j].Value == comando) then
				myrango= tonumber(commands.ChildNodes[j].Attributes.minrango)
			end
		end
	end
	return myrango
end

function commandparser:darbanbarang(solicitante, rango, tipo ,segpar, terpar, time)
	local mensaje = ""
	if tipo == "kick" then
		mensaje = "kick"
	elseif tipo == "tban" then
		mensaje = "temp ban"
	elseif tipo == "pban" then
		mensaje = "perm ban"
	end
	if segpar ~= nil then
		local segundo= getPlayer(solicitante,segpar)
		if segundo ~= nil then
			local segundorango= tonumber(checkAdmin(segundo:getguid()))
			if segundorango == nil then
				segundorango =0;
			end
			if (rango > segundorango) or (rango == 100) then
				local prefix=""
				if terpar ~= nil then
					prefix= getPrefix(rango)
					local msg= lang.msg_ban_player_all:gsub("@player",segundo.name)
					msg= msg:gsub("@tipo",mensaje)
					msg= msg:gsub("@admin",prefix..solicitante.name)
					msg= msg:gsub("@reason",terpar)
					commandparser:sayAll(msg)
					if tipo == "tban"then
						local msgArray2 = tools:lines_from(commandparser.banpath)
						local times=0
						if time ~= nil then
							if tonumber(time) then
								local time2= tonumber(time)
								times= os.time()+(time2*3600)
								matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,terpar,os.time(),times)
							else
								solicitante:iPrintLnBold(lang.error_time_nonumber_msg)
								times= os.time()+config.ban_default_duration
								matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,terpar,os.time(),times)
							end
						else
							times= os.time()+config.ban_default_duration
							matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,terpar,os.time(),times)
						end
						local banmsg= lang.ban_with_reason_time:gsub("@admin",prefix..solicitante.name)
						banmsg= banmsg:gsub("@reason", terpar)
						banmsg= banmsg:gsub("@banid",tostring(#msgArray2 +1))
						banmsg= banmsg:gsub("@website",config.clansite)
						banmsg= banmsg:gsub("@duration", os.date("%c",times))
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),banmsg))
					elseif tipo == "pban" then
						local msgArray2 = tools:lines_from(commandparser.banpath)
						matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,terpar,os.time(),-2)
						local banmsg= lang.permban_with_reason:gsub("@admin",prefix..solicitante.name)
						banmsg= banmsg:gsub("@reason", terpar)
						banmsg= banmsg:gsub("@banid",tostring(#msgArray2 +1))
						banmsg= banmsg:gsub("@website",config.clansite)
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),banmsg))
					else
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),lang.kick_with_reason:gsub("@reason",terpar)))
					end
				else
					prefix= getPrefix(rango)
					local msg= lang.msg_ban_player_all_without_reason:gsub("@player",segundo.name)
					msg= msg:gsub("@tipo",mensaje)
					msg= msg:gsub("@admin",prefix..solicitante.name)
					commandparser:sayAll(msg)
					if tipo == "tban"then
						local msgArray2 = tools:lines_from(commandparser.banpath)
						local tims=0
						if time ~= nil then
							if tonumber(time) then
								local time2= tonumber(time)
								tims= os.time()+(time2*3600)
								matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,lang.register_ban_without_reason,os.time(),tims)
							else
								tims= os.time()+config.ban_default_duration
								solicitante:iPrintLnBold(lang.error_time_nonumber_msg)
								matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,lang.register_ban_without_reason,os.time(),tims)
							end
						else
							tims= os.time()+config.ban_default_duration
							matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,lang.register_ban_without_reason,os.time(),tims)
						end
						local banmsg= lang.ban_without_reason_time:gsub("@admin",prefix..solicitante.name)
						banmsg= banmsg:gsub("@banid",tostring(#msgArray2 +1))
						banmsg= banmsg:gsub("@website",config.website)
						banmsg= banmsg:gsub("@duration", os.date("%c",times))
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),banmsg))
					elseif tipo == "pban" then
						local msgArray2 = tools:lines_from(commandparser.banpath)
						matlAddBan(#msgArray2 +1,segundo.name,segundo:getguid(),segundo.ip,solicitante.name,lang.register_ban_without_reason,os.time(),-2)
						local banmsg= lang.permban_without_reason:gsub("@admin",prefix..solicitante.name)
						banmsg= banmsg:gsub("@banid",tostring(#msgArray2 +1))
						banmsg= banmsg:gsub("@website",config.website)
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),banmsg))
					else
						util.executeCommand(string.format("dropclient %s \"%s\"",tostring(segundo:getentitynumber()),lang.kick_without_reason))
					end
				end
			else
				local msg= lang.admin_intent_ban_msg:gsub("@player",solicitante.name)
				msg= msg:gsub("@tipo",tipo)
				commandparser:sayToPlayer(segundo,msg)
				solicitante:iPrintLnBold((lang.ban_no_admin_permission:gsub("@tipo",tipo)))
			end
		else
			solicitante:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",segpar)))
		end
	else
		solicitante:iPrintLnBold((lang.ban_tipo_error_format:gsub("@tipo",tipo)))
	end
end

function commandparser:removeUserBan(admin,namee)
	if not tools:file_exists(commandparser.banpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.banpath)
			if #msgArray ~= 0 then
				--only test
				local banss= tools:readd(commandparser.banpath,';')
				local myi = -1
				local count=0
				for i in pairs (msgArray) do
					if banss[i][2] == namee then
						myi=i
						count= count+1
					end
				end
				if count == 1 then
					table.remove(banss,myi)
					tools:writed(commandparser.banpath,banss,';')
					commandparser:sayTellPlayer(admin,lang.unban_succesful_msg)
				elseif count > 1 then
					commandparser:sayTellPlayer(admin,lang.unban_error_player_name_msg)
				elseif count < 1 then 
					commandparser:sayTellPlayer(admin,lang.unban_error_noplayer)
				end
			else
				commandparser:sayTellPlayer(admin,lang.unban_error_nobans)
			end
	end
end

function commandparser:removeUserBanbyID(admin,id)
	if not tools:file_exists(commandparser.banpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.banpath)
			if #msgArray ~= 0 then
				--only test
				local banss= tools:readd(commandparser.banpath,';')
				local myi = -1
				local count=0
				for i in pairs (msgArray) do
					if banss[i][1] == id then
						myi=i
						count= count+1
					end
				end
				if count == 1 then
					table.remove(banss,myi)
					tools:writed(commandparser.banpath,banss,';')
					commandparser:sayTellPlayer(admin,lang.unban_succesful_msg)
				elseif count > 1 then
					commandparser:sayTellPlayer(admin,lang.unban_error_id_conflict)
				elseif count < 1 then 
					commandparser:sayTellPlayer(admin,lang.unban_error_noid)
				end
			else
				commandparser:sayTellPlayer(admin,lang.unban_error_nobans)
			end
	end
end

function commandparser:removeAdmin(admin,guild)
	if not tools:file_exists(commandparser.adminpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(lang.unsuccesful_create_file)
			if #msgArray ~= 0 then
				--only test
				local adminss= tools:readd(commandparser.adminpath,';')
				local my = -1
				local i=1
				local ban=0
				local myguild = tostring(guild)
				while  (i <= #msgArray) and (ban ~= 1)    do
					local adminguild= tostring(adminss[i][4])
					if string.find(adminguild,myguild) then
						my=i
						ban=1
					end
					i=i+1
				end
				if ban ~= 0 then
					table.remove(adminss,my)
					tools:writed(commandparser.adminpath,adminss,';')
					commandparser:sayTellPlayer(admin,lang.ungroup_succesful_admin_msg)
				else
					commandparser:sayTellPlayer(admin,lang.ungroup_error_no_player)
				end
			else
				commandparser:sayTellPlayer(admin,lang.ungroup_error_no_admins)
			end
	end
end

function commandparser:removeAdminbyName(admin,namee)
	if not tools:file_exists(commandparser.adminpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.adminpath)
			if #msgArray ~= 0 then
				--only test
				local adminss= tools:readd(commandparser.adminpath,';')
				local my = -1
				local count=0
				for i in pairs (msgArray) do
					if adminss[i][2] == namee then
						my=i
						count= count+1
					end
				end
				if count == 1 then
					table.remove(adminss,my)
					tools:writed(commandparser.adminpath,adminss,';')
					commandparser:sayTellPlayer(admin,admin,lang.ungroup_succesful_admin_msg)
				elseif count > 1 then
					commandparser:sayTellPlayer(admin,lang.error_more_than_one_player)
				elseif count < 1 then 
					commandparser:sayTellPlayer(admin,admin,lang.ungroup_error_no_player)
				end
			else
				commandparser:sayTellPlayer(admin,lang.ungroup_error_no_admins)
			end
	end
end

function commandparser:setTeam(player,team)
    player.sessionteam = team
    util.notifyObject(player, "menuresponse", "team_marinesopfor", team)
end

-->Commandos
function commandparser.iamgod(player)
	if not tools:file_exists(commandparser.adminpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.adminpath)
		if #msgArray ~= 0 then
			player:iPrintLnBold(lang.iamgod_blocked_msg)
		else
			matlAddAdmin(#msgArray+1, player.name , 102012301203, player:getguid() , player.ip, 100, 1)
			player:iPrintLnBold(lang.iamgod_succesful_msg)
		end
	end
end

function commandparser.gravity(player, args)
	if args ~= nil and args ~="" then
		if tonumber(args) then
			commandparser:sayAll((lang.gravity_succesful_msg:gsub("@number",args)))
			util.executeCommand(string.format("g_gravity %s",args))
			commandparser:sayToPlayer(player, lang.gravity_succesful_default)
		else
			player:iPrintLnBold(lang.error_nonumber_msg)
		end
	else
		player:iPrintLnBold(lang.gravity_error_msg)
	end
end

function commandparser.speed(player,args)
	if args ~= nil and args ~="" then
		if tonumber(args) then
			commandparser:sayAll((lang.speed_succesful_msg:gsub("@number",args)))
			util.executeCommand(string.format("g_speed %s",args))
			commandparser:sayToPlayer(player,lang.speed_succesful_default)
		else
			player:iPrintLnBold(lang.error_nonumber_msg)
		end
	else
		player:iPrintLnBold(lang.speed_error_msg)
	end
end

function commandparser.rage(player,args)
	if args ~= nil and args ~= "" then
		commandparser:custumMsg(string.format("%s %s",player.name,args))
		util.executeCommand(string.format("dropClient %s \"%s\"",tostring(player:getentitynumber()),args))
	else
		commandparser:custumMsg((lang.rage_default_msg:gsub("@name",player.name)))
		util.executeCommand(string.format("dropClient %s \"%s\"",tostring(player:getentitynumber()),lang.rage_only_msg))
	end
end

function commandparser.website(player)
	if config.clansite ~= "" then
		commandparser:sayToPlayer(player,config.clansite)
	else
		player:iPrintLnBold(lang.website_nosite_error_msg)
	end
end

function commandparser.time(player)
	commandparser:sayToPlayer(player,"^3"..tostring(os.date("%c")))
end

function commandparser.weball(player)
	if config.clansite ~= "" then
		commandparser:sayAll(config.clansite)
	else
		player:iPrintLnBold(lang.website_nosite_error_msg)
	end
end

function commandparser.timeall(player)
	commandparser:sayAll("^3"..tostring(os.date("%c")))
end

function commandparser.rall(player)
	if not tools:file_exists(commandparser.rulespath) then
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.rulespath)
		if #msgArray ~= 0 then
			for j in pairs (msgArray) do
				callbacks.afterDelay.add(j*config.rulelistdelay,function() util.chatPrint(tostring(j)..". "..msgArray[j]) end)
			end
		else
			player:iPrintLnBold(lang.error_nolines_rules)
		end
	end
end

function commandparser.kick(player,args,rango)
	local partes= args:split(",")
	commandparser:darbanbarang(player, rango,"kick",partes[1],partes[2],partes[3])
end

function commandparser.tban(player,args,rango)
	local partes= args:split(",")
	commandparser:darbanbarang(player, rango,"tban",partes[1],partes[2],partes[3])
end

function commandparser.pban(player,args,rango)
	local partes= args:split(",")
	commandparser:darbanbarang(player, rango,"pban",partes[1],partes[2],partes[3])
end

function commandparser.unban(player,args)
		if args ~= nil and args~= "" then
			if string.sub(args,1,1) == "@" then
				local test= string.sub(args, 2)
				if tonumber(test) then
					commandparser:removeUserBanbyID(player,test)
				else
					player:iPrintLnBold(lang.unban_error_id_msg)
				end
			else
				removeUserBan(player,args)
			end
		else
			player:iPrintLnBold(lang.unban_error_msg)
		end
end

function commandparser.groups(player)
	if #groups.ChildNodes ~= 0 then
		for i in pairs (groups.ChildNodes) do
			callbacks.afterDelay.add(1000*i,function() commandparser:sayToPlayer(player,groups.ChildNodes[i].Attributes.code .. " ^1rango: " .. groups.ChildNodes[i].Attributes.rango ) end)
		end
	else
		print(lang.groups_error_nogroups)
		player:iPrintLnBold(lang.groups_error_nogroups)
	end
end

function commandparser.credits(player)
	player:tell("^2[M^7AT^1L] ^3v0.6 ^5by ^2~|^7M^1|~ ^7Clan ^2Maniacos")
	player:tell("^2[M^7AT^1L] ^3Send^5me ^2Pack ^7in my ^2teamspeak")
end

function commandparser.contact(player)
	if config.clansite ~= "" then
		commandparser:sayToPlayer(player,string.format("Web: %s",config.clansite))
	end
	if config.teamspeak ~= "" then 
		commandparser:sayToPlayer(player,string.format("TeamSpeak: %s",config.teamspeak))
	end
	if config.raidcall ~= "" then
		commandparser:sayToPlayer(player,string.format("Raidcall: %s",config.raidcall))
	end
	if config.discord ~= "" then
		commandparser:sayToPlayer(player,string.format("Discord: %s",config.discord))
	end
end

function commandparser.saycon(player,args)
	if args ~= nil and args ~= "" then 
		commandparser:sayAll(args)
	else
		player:iPrintLnBold(lang.saycon_error_msg)
	end
end

function commandparser.setnextdsr(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		print(string.format(".//admin//%s.dsr",partes[1]))
		if tools:file_exists(string.format(".//admin//%s.dsr",partes[1])) then 
			if partes[2] ~= nil and partes[2] ~= "" then
				local mapsA= dictionary.searchmap(partes[2])
				if mapsA.map ~= nil then 
					updateDsr(mapsA.map,partes[1],nil)
					local msg= lang.setnextdsr_succesful_msg:gsub("@dsr",partes[1])
					msg= msg:gsub("@map",mapsA.mapname)
					commandparser:sayAll(msg)
				else
					player:iPrintLnBold((lang.setnextdsr_error_map_msg:gsub("@map",partes[2])))
				end
			else
				updateDsr(nil,partes[1],nil)
				commandparser:sayAll((lang.setnextdsr_succesful_dsr_msg:gsub("@dsr",partes[1])))
			end
		else
			player:iPrintLnBold((lang.setnextdsr_error_dsr_msg:gsub("@dsr",partes[1])))
		end
	else
		player:iPrintLnBold(lang.setnextdsr_error_msg)
	end
end

function commandparser.dsr(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~="" then
		if tools:file_exists(string.format(".//admin//%s.dsr",partes[1])) then 
			if partes[2] ~= nil and partes[2] ~= "" then
				local mapsA= dictionary.searchmap(partes[2])
				if mapsA.map ~= nil then 
					updateDsr(mapsA.map,partes[1],nil)
					local msg= lang.setnextdsr_succesful_msg:gsub("@dsr",partes[1])
					msg= msg:gsub("@map", mapsA.mapname)
					commandparser:sayAll(msg)
					commandparser:sayAll(lang.dsr_succesful_msg)
					callbacks.afterDelay.add(3000,function() util.executeCommand("map_rotate") end)
				else
					player:iPrintLnBold((lang.setnextdsr_error_map_msg:gsub("@map",partes[2])))
				end
			else
				updateDsr(nil,partes[1],nil)
				commandparser:sayAll((lang.setnextdsr_succesful_dsr_msg:gsub("@dsr",partes[1])))
				commandparser:sayAll(lang.dsr_succesful_msg)
				callbacks.afterDelay.add(3000,function() util.executeCommand("map_rotate") end)
			end
		else
			player:iPrintLnBold((lang.setnextdsr_error_dsr_msg:gsub("@dsr",partes[1])))
		end
	else
		player:iPrintLnBold(lang.dsr_error_msg)
	end
end

function commandparser.setnextmap(player, args)
	if args ~= nil and args ~= "" then
		local mapss = dictionary.searchmap(args)
		if mapss.map ~= nil then 
			updateDsr(mapss.map)
			commandparser:sayAll((lang.setnextmap_succesful_msg:gsub("@map",mapss.mapname)))
		else
			player:iPrintLnBold((lang.setnextmap_error_map_msg:gsub("@map",args)))
		end
	else
		player:iPrintLnBold(lang.setnextmap_error_msg)
	end
end

function commandparser.sayas(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		local twogamer= getPlayer(player, partes[1])
		if twogamer ~= nil then
			if partes[2] ~= nil and partes[2] ~= "" then
				local rango3 = checkAdmin(twogamer:getguid())
				if rango3 == nil then
					rango3 = 0
				end
				prefix= getPrefix(rango3)	
				util.chatPrint(string.format("%s%s: %s",prefix,twogamer.name,partes[2]))
			else
				player:iPrintLnBold(lang.sayas_error_nullmsg_msg)
			end
		else
			player:iPrintLnBold((lang.sayas_error_player_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.sayas_error_msg)
	end
end

function commandparser.putgroup(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		local twoplayer= getPlayer(player, partes[1])
		if twoplayer ~= nil then
			local rango2 = checkAdmin(twoplayer:getguid())
			if rango2 == nil then
				if partes[2] ~= nil and partes[2] ~= "" then
					local grouprang= getGroup(partes[2])
					if grouprang ~= "" then 
						if not tools:file_exists(commandparser.adminpath) then 
							print(lang.unsuccesful_create_file)
							matlInicio()
						else
							local testarray = tools:lines_from(commandparser.adminpath)
							matlAddAdmin(#testarray+1, twoplayer.name , 102012301203, twoplayer:getguid() , twoplayer.ip, grouprang, 1)
							player:iPrintLnBold(lang.putgroup_succesful_admin_msg)
							local msg= lang.putgroup_succesful_all_msg:gsub("@player",twoplayer.name)
							msg= msg:gsub("@group",partes[2])
							commandparser:sayAll(msg)
						end
					else
						player:iPrintLnBold((lang.putgroup_error_nullgroup_msg:gsub("@group",partes[2])))
					end
				else 
					player:iPrintLnBold(lang.putgroup_error_msg)
				end
			else
				player:iPrintLnBold(lang.putgroup_error_group_msg)
			end
		else 
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else 
		player:iPrintLnBold(lang.putgroup_error_msg)
	end
end

function commandparser.ungroup(player,args)
	if args ~= nil and args ~="" then
		local twoplayer= getPlayer(player, args)
		if twoplayer ~= nil then
			commandparser:removeAdmin(player, twoplayer:getguid())
		else 
			commandparser:removeAdminbyName(player, args)
		end
	else 
		player:iPrintLnBold(lang.ungroup_error_msg)
	end
end

function commandparser.jump(player,args)
	if args ~= nil and args ~="" then 
		if tonumber(args) then
			commandparser:sayAll((lang.jump_succesful_msg:gsub("@valor",args)))
			gsc.setdvar("jump_height", tonumber(args))
			commandparser:sayToPlayer(player, lang.jump_succesful_default_msg)
		else
			player:iPrintLnBold(lang.jump_error_nonumber_msg)
		end
	else
		player:iPrintLnBold(lang.jump_error_msg)
	end
end

function commandparser.givegun(player,args)
	if args ~= nil and args ~= "" then 
		local guns= dictionary.searchgun(args)
		if guns.gun ~= nil then 
			player:giveWeapon(guns.gun)
			player:switchToWeaponImmediate(guns.gun)
		else
			player:iPrintLnBold((lang.givegun_error_noweapon_msg:gsub("@gun",args)))
		end
	else
		player:iPrintLnBold(lang.givegun_error_msg)
	end
end

function commandparser.warn(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		local segundoplayer = getPlayer(player, partes[1])
		if segundoplayer ~=nil then
			if partes[2] ~= nil then 
				addUserWarn(segundoplayer,partes[2])
			else
				addUserWarn(segundoplayer,config.warn_default_reason)
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.warn_error_msg)
	end	
end

function commandparser.unwarn(player,args)
	if args ~= nil and args ~= "" then
		local segundoplayerg = getPlayer(player, args)
		if segundoplayerg ~=nil then
			removeUserWarn(player, segundoplayerg:getguid())
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.unwarn_error_msg)
	end
end

function commandparser.map(player,args,rango)
	if args ~= nil and args ~= "" then
		local maps= dictionary.searchmap(args)
		if maps.map ~= nil then
			commandparser:sayAll((lang.map_succesful_msg:gsub("@map",maps.mapname)))
			callbacks.afterDelay.add(3000,function() util.executeCommand(string.format("map %s",maps.map)) end)
			if config.mapadminname then
				local prefix= getPrefix(rango)
				callbacks.afterDelay.add(3000,function() commandparser:sayAll((lang.map_admin_msg:gsub("@player",prefix..player.name)))end)
			end
		else
			player:iPrintLnBold(lang.map_error_nomap_msg:gsub("@map",args))
		end
	else
		player:iPrintLnBold(lang.map_error_msg)
	end
end

function commandparser.rotate(player,args,rango)
	local prefix= getPrefix(rango) 
	commandparser:sayAll((lang.rotate_succesful_msg:gsub("@player",prefix .. player.name)))
	util.executeCommand("map_rotate")
end

function commandparser.fastrestart(player,args,rango)
	local prefix= getPrefix(rango)
	commandparser:sayAll((lang.fastrestart_succesful_msg:gsub("@player",prefix .. player.name)))
	gsc.map_restart()
end

function commandparser.tell(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		local segundoplayer3 = getPlayer(player, partes[1])
		if segundoplayer3 ~=nil then
			if partes[2] ~= nil and partes[2] ~= "" then 
				commandparser:sayTellPlayer(segundoplayer3, partes[2])
				commandparser:sayTellPlayer(player,lang.tell_succesful_msg)
			else
				commandparser:sayTellPlayer(player,lang.tell_error_nomsg)
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.tell_error_msg)
	end
end

function commandparser.balance(player)
	player:iPrintLnBold(lang.disabled_update_msg)
	--balance:setbalance(gsc.getdvar("g_gametype"))
end

function commandparser.tellall(player)
	if args ~= nil and args ~= "" then
		gsc.iprintlnbold(args)
	else
		player:iPrintLnBold(lang.tellall_error_msg)
	end
end

function commandparser.pm(player,args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		local segundoplayer2 = getPlayer(player, partes[1])
		if segundoplayer2 ~=nil then
			if partes[2] ~= nil and partes[2] ~= "" then
				local msg= lang.pm_sintax_msg:gsub("@player",player.name)
				msg= msg:gsub("@msg",partes[2])
				commandparser:sayToPlayer(segundoplayer2,msg)
				commandparser:sayTellPlayer(player,lang.pm_succesful_msg)
			else
				player:iPrintLnBold(lang.tell_error_nomsg)
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.pm_error_msg)
	end
end

function commandparser.restart(player,args,rango)
	local prefix= getPrefix(rango)
	commandparser:sayAll((lang.fastrestart_succesful_msg:gsub("@player",prefix .. player.name)))
	util.executeCommand("map_restart")
end

function commandparser.scream(player,args)
	if args ~= nil and args ~= "" then 
		for i in pairs(commandparser.colors) do
			callbacks.afterDelay.add(i*1000,function() util.chatPrint(string.format("%s%s",commandparser.colors[i],args))end)
		end
	else
		player:iPrintLnBold(lang.scream_error_msg)
	end
end

function commandparser.load(player,args)
	if args ~= nil and args ~= "" then 
		if tools:file_exists(string.format(".//scripts//mp//%s",args)) then
			util.executeCommand(string.format("loadscript %s",args))
			player:iPrintLnBold(lang.load_succesful_msg)
		else
			player:iPrintLnBold((lang.load_error_nofile_msg:gsub("@file",args)))
		end
	else
		player:iPrintLnBold(lang.load_error_msg)
	end
end

function commandparser.unload(player,args)
	if args ~= nil and args ~= "" then 
		if tools:file_exists(string.format(".//scripts//mp//%s",args)) then
			util.executeCommand(string.format("unloadscript %s",args))
			player:iPrintLnBold(lang.unload_succesful_msg)
		else
			player:iPrintLnBold((lang.load_error_nofile_msg:gsub("@file",args)))
		end
	else
		player:iPrintLnBold(lang.unload_error_msg)
	end
end

function commandparser.suicide(player)
	--Thanks RektInator for solution suicide
	player:iPrintLnBold(lang.suicide_succesful_msg)
	player.data.suicide = true
end

function commandparser.lastbans(player)
	if not tools:file_exists(commandparser.banpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.banpath)
			if #msgArray ~= 0 then
				--only test
				local count=5
				local size = #msgArray
				local banss= tools:readd(commandparser.banpath,';')
				local i=1
				while (size ~= 0 and count ~= 0) do
					local msg= lang.lastbans_sintax_msg:gsub("@id",banss[size][1])
					msg= msg:gsub("@name",banss[size][2])
					msg= msg:gsub("@admin",banss[size][5])
					msg= msg:gsub("@reason",banss[size][6])
					msg= msg:gsub("@time",os.date("%c",tonumber(banss[size][8])))
					commandparser:sayToPlayer(player,msg)
					count= count-1;
					i=i+1;
					size= size-1;
				end
			else
				commandparser:sayTellPlayer(player,lang.unban_error_nobans)
			end
	end
end

function commandparser.dsrs(player)
	if config.dsrs_enabled then
		--Solo funciona en sistemas basados en windows
		local packs= package.path:split(";")
		local sizes= packs[1]:len() - 9;
		local direct = packs[1]:sub(1,sizes)
		direct= direct.."admin/"
		local mydsrs={}
		for dir in io.popen('dir "'..direct..'" /b'):lines() do 
			if (string.find(dir,".dsr")) then 
				table.insert(mydsrs,dir)
			end 
		end
		if #mydsrs ~= 0 then 
			for i in pairs(mydsrs) do
				callbacks.afterDelay.add(i*1000,function() commandparser:sayToPlayer(player,string.format("%s %s",tostring(i),mydsrs[i]))end)
			end
		else
			player:iPrintLnBold(lang.dsrs_error_nodsr_msg)
		end
	else
		player:iPrintLnBold(lang.dsrs_noenabled_msg)
	end
end

function commandparser.afkgod(player)
	player.sessionteam= "spectator"
	player.sessionstate= "playing"
	player:iPrintLnBold(lang.afkgod_succesful_msg)
end

function commandparser.spec(player)
	player:iPrintLnBold(lang.disabled_update_msg)
	--commandparser:setTeam(player,"spectator")
end

function commandparser.setteam(player,args)
	player:iPrintLnBold(lang.disabled_update_msg)
	--[[local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then
		if partes[2] ~= nil and partes[2] ~= "" then  
			local searchplayer= getPlayer(player,partes[1])
			if searchplayer ~= nil then
				if partes[2]== "allies" or "spectator" or "axis" then
					if searchplayer.sessionteam == "spectator" then 
						player:iPrintLnBold(lang.setteam_error_spec_player)
					else
						if searchplayer.sessionteam == partes[2] then
							player:iPrintLnBold(lang.setteam_player_team_error)
						else
							commandparser:setTeam(searchplayer,partes[2])
							player:iPrintLnBold(lang.setteam_succesful_msg)
						end
					end
				else
					player:iPrintLnBold(lang.setteam_error_team)
				end
			else
				player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
			end
		else
			player:iPrintLnBold(lang.setteam_error_noteam_msg)
		end
	else
		player:iPrintLnBold(lang.setteam_error_msg )
	end]]--
end

function commandparser.kill(player,args,rango)
	if args ~= nil and args ~= "" then 
		local jugad= getPlayer(player, args)
		if jugad ~= nil then
			local rango2 = tonumber(checkAdmin(jugad:getguid()))
			if rango2 == nil then
				rango2=0;
			end
			if rango >= rango2 then 
				jugad.data.suicide = true
				player:iPrintLnBold(lang.kill_succesful_msg)
			else
				player:iPrintLnBold(lang.kill_error_insufficient_privileges)
				jugad:iPrintLnBold((lang.kill_intent_msg:gsub("@name",player.name)))
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.kill_error_msg)
	end
end

function commandparser.ac130(player,args)
	if args ~= nil or args ~= "" then
		local playe2= getPlayer(player, args)
		if playe2 ~= nil then
			commandparser:sayTellPlayer(player,(lang.ac130_succesful_admin_msg:gsub("@player",playe2.name)))
			playe2:takeAllWeapons()
			playe2:giveWeapon("ac130_105mm_mp")
			playe2:giveWeapon("ac130_40mm_mp")
			playe2:giveWeapon("ac130_25mm_mp")
			playe2:switchToWeaponImmediate("ac130_25mm_mp")
			local msg= lang.ac130_succesful_sintax_msg:gsub("@gun","ac130_25mm_mp")
			msg= msg:gsub("@admin",player.name)
			playe2:iPrintLnBold(msg)
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:takeAllWeapons()
		player:giveWeapon("ac130_105mm_mp")
		player:giveWeapon("ac130_40mm_mp")
		player:giveWeapon("ac130_25mm_mp")
		player:switchToWeaponImmediate("ac130_25mm_mp") 
		local msg= lang.ac130_succesful_sintax_msg:gsub("@gun","ac130_25mm_mp")
		msg= msg:gsub("@admin",player.name)   
		player:iPrintLnBold(msg)
	end
end

function commandparser.rules(player)
	if config.rules_en_enabled then
		if not tools:file_exists(commandparser.rulespath_en) then
			matlInicio()
		else
			local msgArray = tools:lines_from(commandparser.rulespath_en)
			if #msgArray ~= 0 then
				for j in pairs (msgArray) do
					callbacks.afterDelay.add(j*config.rulelistdelay,function() commandparser:sayToPlayer(player, tostring(j)..". "..msgArray[j]) end)
				end
			else
				commandparser:sayToPlayer(player,lang.norules)
				print(lang.error_nolines_rules)
			end
		end
	else
		commandparser:sayToPlayer(player,lang.norules)
	end
end

function commandparser.reglas(player)
	if not tools:file_exists(commandparser.rulespath) then
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.rulespath)
		if #msgArray ~= 0 then
			for j in pairs (msgArray) do
				callbacks.afterDelay.add(j*config.rulelistdelay,function() commandparser:sayToPlayer(player, tostring(j)..". "..msgArray[j]) end)
			end
		else
			commandparser:sayToPlayer(player,lang.norules)
			print(lang.error_nolines_rules)
		end
	end
end

function commandparser.addr(player,args)
	if args ~= nil and args ~= "" then
		local newfile2= assert(io.open(commandparser.rulespath, "a+" ),lang.addr_error_file_msg)
		newfile2:write(args, "\n")
		newfile2:close()
		player:iPrintLnBold(lang.addr_succesful_msg)
	else 
		player:iPrintLnBold(lang.addr_error_msg )
	end
end

function commandparser.showspots(player)
	if #spots ~= 0 then 
		for i in pairs (spots) do
			local msg= lang.showspot_sintax_msg:gsub("@name",spots[i][1])
			msg= msg:gsub("@map",spots[i][2])
			callbacks.afterDelay.add(i*1000,function() commandparser:sayToPlayer(player,msg) end)
		end
	else
		commandparser:sayTellPlayer(player,lang.showspot_error_nospots_msg)
	end
end

function commandparser.addspot(player,args)
	if args ~= nil and args~= "" then 
		local mapaa= gsc.getdvar("mapname") 
		if #spots ~= 0 then 
			local flag=0
			for i in pairs(spots) do
				if string.find(spots[i][1],args) then
					flag=1;
				end
			end
			if flag ~= 1 then 
				matladdspot(args,mapaa,player:getorigin())
				player:iPrintLnBold(lang.addspot_succesful_msg)
			else
				player:iPrintLnBold(lang.addspot_name_error_msg)
			end
		else
			matladdspot(args,mapaa,player:getorigin())
			player:iPrintLnBold(lang.addspot_succesful_msg)
		end
	else
		player:iPrintLnBold(lang.addspot_error_msg)
	end
end

function commandparser.delspot(player,args)
	if args ~= nil and args ~= "" then 
		if not tools:file_exists(commandparser.spotspath) then 
			print(lang.unsuccesful_create_file)
			matlInicio()
		else
			local msgArray = tools:lines_from(commandparser.spotspath)
			if #msgArray ~= 0 then
				--only test
				local spotss= tools:readd(commandparser.spotspath,',')
				local my = -1
				local i=1
				local ban=0
				while  (i <= #msgArray) and (ban ~= 1)    do
					if string.find(spotss[i][1],args) then
						my=i
						ban=1
					end
					i=i+1
				end
				if ban ~= 0 then
					table.remove(spotss,my)
					tools:writed(commandparser.spotspath,spotss,',')
					commandparser:sayTellPlayer(player,lang.delspot_succesful_spots)
					updateSpots(commandparser.spotspath)
				else
					commandparser:sayTellPlayer(player,lang.delspot_error_name_spots)
				end
			else
				commandparser:sayTellPlayer(player,lang.delspot_error_nospots)
			end
		end
	else
		player:iPrintLnBold(lang.delspot_error_msg)
	end
end

function commandparser.spottp(player,args)
	if args ~= nil and args ~= "" then 
		local mapaa= gsc.getdvar("mapname") 
		if #spots ~= 0 then 
			local flag=0;
			local my=-1;
			for i in pairs(spots) do
				if string.find(spots[i][1],args) then
					flag=1;
					my=i;
				end
			end
			if flag ~= 1 then 
				player:iPrintLnBold(lang.spottp_error_name_spot)
			else
				--print(spots[my][2])
				if mapaa == spots[my][2] then
					local vector = Vector3.new(tonumber(spots[my][3]), tonumber(spots[my][4]), tonumber(spots[my][5]))
					player:setorigin(vector)
				else
					player:iPrintLnBold(lang.spottp_error_nomap_spot)
				end
			end
		else
			player:iPrintLnBold(lang.spottp_error_nospots)
		end
	else
		player:iPrintLnBold(lang.spottp_error_msg)
	end
end

function commandparser.listmap(player,args)
	if args ~= nil and args ~= "" then
		if args == "all" or "normal" or "dlc1" or "dlc2" or "dlc3" or "dlc4" or "faceoff" or "terminal" then
			local mapslist = dictionary.searchmap("algo",args)
			for i in pairs(mapslist)do
				callbacks.afterDelay.add(i*1000,function() commandparser:sayToPlayer(player,mapslist[i].mapname) end)
			end
		else
			player:iPrintLnBold(lang.listmap_error_noformat)
		end
	else
		player:iPrintLnBold("^1Error el formato es: ^2!listmap all|normal|dlc1|dlc2|dlc3|dlc4|faceoff|terminal" )
	end
end

function commandparser.myip(player)
	player:iPrintLnBold((lang.myip_sintax_msg:gsub("@ip",tostring(player.ip))))
end

function commandparser.help(player,args,rango)
	if args ~= nil and args ~="" then
		local rangocommand= checkrangocommand(args)
		if rangocommand ~= -1 then
			if rango >= rangocommand then  
				if commandparser.functions[args] ~= nil then 
					commandparser:sayToPlayer(player,string.format(" !%s usage < %s >",args,commandparser.functions[args].usage))
				else
					player:iPrintLnBold(lang.help_no_sintax_error)
				end
			else
				player:iPrintLnBold(lang.insufficient_privileges)
			end
		else
			player:iPrintLnBold(lang.no_such_command)
		end
	else
		local count5=1
		if #commands.ChildNodes ~= 0 then
			for j in pairs (commands.ChildNodes) do
				if (commands.ChildNodes[j].Name ~="ignorecmd") then
					if (tonumber(commands.ChildNodes[j].Attributes.minrango) <= rango) then
						local var=""
						if commandparser.functions[commands.ChildNodes[j].Value] == nil then 
							var =lang.help_no_sintax_error
						else
							var= commandparser.functions[commands.ChildNodes[j].Value].usage
						end
						callbacks.afterDelay.add(count5*1000,function() commandparser:sayToPlayer(player, string.format(" !%s usage < %s >",commands.ChildNodes[j].Value,var))end)
						count5= count5+1
					end
				end
			end
		end
	end
end

function commandparser.teleport(player,args)
	local partes= args:split(",")
	if (partes[1] ~= nil) and (partes[2] ~= nil) then 
		local player1 = getPlayer(player, partes[1])
		if player1 ~= nil then
			local player2 = getPlayer(player, partes[2])
			if player2 ~= nil then 
				player1:setorigin(player2.origin)
				local msg= lang.teleport_succesful_sintax:gsub("@origen",player1.name)
				msg= msg:gsub("@destino",player2.name)
				commandparser:sayAll(msg)
			else
				player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[2])))
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.teleport_error_msg)
	end
end

function commandparser.status(player)
	local myp=1
	for p in util.iterPlayers() do
		callbacks.afterDelay.add(myp*1000,function() commandparser:sayToPlayer(player,string.format("^3 %s. ^4%s",tostring(p:getentitynumber()),p.name))end)
		myp=myp+1;
	end
end

function commandparser.nextgame(player)
	local filetesst = ".//admin//default.matl.dspl"
	if not tools:file_exists(filetesst) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(filetesst)
		if #msgArray ~= 0 then
			local buffer = msgArray[1]:split(",")
			local mapa= dictionary.searchmap("algo",nil,buffer[1])
			local msg= lang.nextgame_succesful_msg:gsub("@map",mapa[1].mapname)
			msg= msg:gsub("@game",buffer[2])
			commandparser:sayAll(msg)
		else
			commandparser:sayToPlayer(player,lang.nextgame_error_msg)
		end
	end
end

function commandparser.encuesta(player,args)
	local partes = args:split(",")
	if config.voting_enabled then
		if vote.voteinprogress ~=true then
			if partes[1] ~= nil and partes[1] ~= "" then
				if partes[2] ~= nil and partes[2] ~= "" then 
					local verificador= getEnc(partes[1])
					if verificador.name == nil then 
						vote.voteyes=1
						vote.votedplayers[player:getentitynumber()] ="yes"
						vote.votetype="enc"
						vote.votename= partes[1]
						vote.votemsg=	partes[2]
						vote.voteinprogress=true
						local msg=lang.encuesta_format_msg:gsub("@player",player.name)
						msg= msg:gsub("@question",partes[2])
						commandparser:sayAll(msg)
						commandparser:sayAll(lang.vote_format_msg)
					else
						player:iPrintLnBold(lang.encuesta_error_name)
					end
				else
					player:iPrintLnBold(lang.encuesta_no_question)
				end
			else
				player:iPrintLnBold(lang.encuesta_error_msg)
			end
		else
			player:iPrintLnBold(lang.vote_error_vote_in_progress)
		end
	else
		player:iPrintLnBold(lang.vote_error_no_allowed)
	end
end

function commandparser.fly(player)
	util.executeCommand("ufo "..tostring(player:getentitynumber()))
end

function commandparser.votekick(player,args)
	local partes= args:split(",")
	if config.voting_enabled then
		if vote.voteinprogress ~= true then
			if partes[1] ~= nil and partes[1] ~= "" then
				local segundo= getPlayer(player,partes[1])
				if segundo ~= nil then
					local segundorango= tonumber(checkAdmin(segundo:getguid()))
					if segundorango == nil then
						segundorango =0;
					end
					if segundorango == 0 then
						vote.voteyes=1
						vote.votedplayers[player:getentitynumber()] ="yes"
						vote.votetype="kick"
						vote.votename=segundo.name
						vote.voteguild= tostring(segundo:getguid())
						vote.voteip= tostring(segundo.ip)
						local msg= lang.votekick_sintax_msg:gsub("@player",player.name)
						msg= msg:gsub("@victim",segundo.name)
						if partes[2] ~= nil and partes[2] ~= "" then
							vote.votemsg=partes[2]
							vote.voteinprogress=true
							msg= msg:gsub("@reason",partes[2])
						else
							vote.votemsg=config.ban_default_reason
							vote.voteinprogress=true
							msg= msg:gsub("@reason",config.ban_default_reason)
						end
						commandparser:sayAll(msg)
						commandparser:sayAll(lang.vote_format_msg)
					else
						commandparser:sayToPlayer(segundo,(lang.votekick_admin_msg:gsub("@player",player.name)))
						player:iPrintLnBold(lang.votekick_rank_admin_error)
					end
				else
					player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
				end
			else
				player:iPrintLnBold(lang.votekick_error_msg)
			end
		else
			player:iPrintLnBold(lang.vote_error_vote_in_progress)
		end
	else
		player:iPrintLnBold(lang.vote_error_no_allowed)
	end
end

function commandparser.votemap(player,args)
	if config.voting_enabled then
		if vote.voteinprogress ~= true then
			if args ~= nil and args ~= "" then
				local maps= dictionary.searchmap(args)
				if maps.map ~= nil then
					if maps.map == gsc.getdvar("mapname") then
						player:iPrintLnBold((lang.votemap_error_actual_map:gsub("@map",args)))
					else
						local flag = false
						if #config.vote_allowed_maps ~= 0 then 
							if commandparser:has_value(config.vote_allowed_maps,maps.map) then
								flag= true
							else
								player:iPrintLnBold(lang.votemap_no_allowed_map)
							end
						else
							if #config.vote_blocked_maps ~= 0 then 
								if commandparser:has_value(config.vote_blocked_maps,maps.map) then
									player:iPrintLnBold(lang.votemap_no_allowed_map)
								else
									flag=true
								end
							else
								flag=true
							end
						end
						if flag then
							vote.voteyes=1
							vote.votedplayers[player:getentitynumber()] ="yes"
							vote.votetype="map"
							vote.votemap= maps.mapname
							vote.mapfull= maps.map
							local msg= lang.votemap_sintax_msg:gsub("@player",player.name)
							msg= msg:gsub("@map",maps.mapname)
							commandparser:sayAll(msg)
							commandparser:sayAll(lang.vote_format_msg)
							vote.voteinprogress=true
						end
					end	
				else
					player:iPrintLnBold((lang.map_error_nomap_msg:gsub("@map",args)))
				end
			else
				player:iPrintLnBold(lang.votemap_error_msg)
			end
		else
			player:iPrintLnBold(lang.vote_error_vote_in_progress)
		end
	else
		player:iPrintLnBold(lang.vote_error_no_allowed)
	end
end

function commandparser.y(player)
	if vote.voteinprogress then 
		if vote.votedplayers[player:getentitynumber()+1] ~= "" then
			if vote.votedplayers[player:getentitynumber()+1] ~= "yes" then 
				vote.voteyes = vote.voteyes +1
				vote.voteno = vote.voteno -1
				vote.votedplayers[player:getentitynumber()+1] ="yes"
				commandparser:sayAll((lang.y_changed_msg:gsub("@player",player.name)))
			else
				player:iPrintLnBold(lang.vote_error_vote_already_msg)
			end
		else
			vote.voteyes = vote.voteyes +1
			vote.votedplayers[player:getentitynumber()+1] ="yes"
			commandparser:sayAll((lang.y_succesful_msg:gsub("@player",player.name)))
		end
	else
		player:iPrintLnBold(lang.vote_error_vote_in_progress)
	end
end

function commandparser.n(player)
	if vote.voteinprogress then 
		if vote.votedplayers[player:getentitynumber()+1] ~= "" then
			if vote.votedplayers[player:getentitynumber()+1] ~= "no" then 
				vote.voteno = vote.voteno +1
				vote.voteyes = vote.voteyes -1
				vote.votedplayers[player:getentitynumber()+1] ="no"
				commandparser:sayAll((lang.n_changed_msg:gsub("@player",player.name)))
			else
				player:iPrintLnBold(lang.vote_error_vote_already_msg)
			end
		else
			vote.voteno = vote.voteno +1
			vote.votedplayers[player:getentitynumber()+1] ="no"
			commandparser:sayAll((lang.n_succesful_msg:gsub("@player",player.name)))
		end
	else
		player:iPrintLnBold(lang.vote_error_vote_in_progress)
	end
end

function commandparser.myguid(player)
	player:iPrintLnBold((lang.myguid_sintax_msg:gsub("@guid",tostring(player:getguid()))))
end

function commandparser.votecancel(player)
	if vote.voteinprogress then 
		vote.admin= player.name
		vote.cancel= true
	else
		player:iPrintLnBold(lang.vote_error_vote_in_progress)
	end
end

function commandparser.setalias(player, args)
	local partes= args:split(",")
	if partes[1] ~= nil and partes[1] ~= "" then 
		local segundo= getPlayer(player,partes[1])
		if segundo ~= nil then 
			if partes[2] ~= nil and partes[2] ~= "" and commandparser:emptyAlias(partes[2]) ~= true then 
				if config.alias_len_max >= partes[2]:len() then
					if not tools:file_exists(commandparser.clientspath) then 
						print(lang.unsuccesful_create_file)
						matlInicio()
						player:iPrintLnBold(lang.setalias_error_no_file)
					else
						local msgArray = tools:lines_from(commandparser.clientspath)
						if #msgArray ~= 0 then
							--only test
							local clients= tools:readd(commandparser.clientspath,';',false)
							local i=1
							local ban=0
							local myguild = tostring(segundo:getguid())
							while  (i <= #msgArray) and (ban ~= 1)    do
								local adminguild= tostring(clients[i][3])
								if  adminguild == myguild then
									clients[i][5] = partes[2]
									ban=1
								end
								i=i+1
							end
							if ban ==1 then
								tools:writed(commandparser.clientspath,clients,';')
							else
								matlAddClient(#msgArray+1,segundo.name,segundo:getguid(),segundo.ip,partes[2],1)
							end
						else
							matlAddClient(#msgArray+1,segundo.name,segundo:getguid(),segundo.ip,partes[2],1)
						end
						player:iPrintLnBold(lang.setalias_succesful_msg)
						segundo:iPrintLnBold((lang.setalias_notification_msg:gsub("@alias",partes[2])))
					end
				else
					player:iPrintLnBold((lang.setalias_error_len_msg:gsub("@len",tostring(config.alias_len_max))))
				end
			else
				player:iPrintLnBold(lang.setalias_error_empty_alias)
			end
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",partes[1])))
		end
	else
		player:iPrintLnBold(lang.setalias_error_msg)
	end
end

function commandparser.delalias(player,args)
	if args ~= nil and args ~= "" then 
		if not tools:file_exists(commandparser.clientspath) then 
			print(lang.unsuccesful_create_file)
			matlInicio()
			player:iPrintLnBold(lang.delalias_error_no_file)
		else
			local msgArray = tools:lines_from(commandparser.clientspath)
			if #msgArray ~= 0 then
				--only test
				local clients= tools:readd(commandparser.clientspath,';',false)
				local i=1
				local ban=0
				while  (i <= #msgArray) and (ban ~= 1)    do
					if  clients[i][2] == args then
						clients[i][5] = ""
						ban=1
					end
					i=i+1
				end
				if ban == 1 then
					tools:writed(commandparser.clientspath,clients,';')
					player:iPrintLnBold(lang.delalias_succesful_msg)
				else
					player:iPrintLnBold((lang.delalias_error_no_found:gsub("@name",args)))
				end
			else
				player:iPrintLnBold(lang.delalias_error_no_players)
			end
		end
	else
		player:iPrintLnBold(lang.delalias_error_msg)
	end
end

function commandparser.freeze(player,args)
	if args ~= nil and args ~= "" then 
		local segundo= getPlayer(player,args)
		if segundo ~= nil then 
			segundo:freezeControls(true)
			segundo:iPrintLnBold(lang.freeze_succesful_player_msg)
			player:iPrintLnBold((lang.freeze_succesful_admin_msg:gsub("@player",segundo.name)))
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.freeze_error_msg)
	end
end

function commandparser.unfreeze(player,args)
	if args ~= nil and args ~= "" then 
		local segundo= getPlayer(player,args)
		if segundo ~= nil then 
			segundo:freezeControls(false)
			segundo:iPrintLnBold(lang.unfreeze_succesful_player_msg)
			player:iPrintLnBold((lang.unfreeze_succesful_admin_msg:gsub("@player",segundo.name)))
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.unfreeze_error_msg)
	end
end

function commandparser.blockchat(player,args)
	if args ~= nil and args ~= "" then
		local segundo= getPlayer(player,args)
		if segundo ~= nil then  
			segundo.data.blockchat = true
			segundo:iPrintLnBold(lang.blockchat_succesful_player_msg)
			player:iPrintLnBold((lang.blockchat_succesful_admin_msg:gsub("@player",segundo.name)))
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.blockchat_error_msg)
	end
end

function commandparser.unblockchat(player,args)
	if args ~= nil and args ~= "" then
		local segundo= getPlayer(player,args)
		if segundo ~= nil then  
			segundo.data.blockchat = false
			segundo:iPrintLnBold(lang.unblockchat_succesful_player_msg)
			player:iPrintLnBold((lang.unblockchat_succesful_admin_msg:gsub("@player",segundo.name)))
		else
			player:iPrintLnBold((lang.error_noplayer_msg:gsub("@player",args)))
		end
	else
		player:iPrintLnBold(lang.unblockchat_error_msg)
	end
end

function commandparser.run(sender,rango,args,command)
	local commandname= string.sub(command,2)
	local commandrango = commandparser:checkrangocommand(commandname)
	if commandparser.functions[commandname] ~= nil then
		if commandrango ~= -1 then
			if rango >= commandrango then
				if commandparser[commandname] ~= nil then
					if commandparser.functions[commandname].numArgs > 0 then 
						local argumentos= string.sub(args,command:len()+2)
						if commandparser.functions[commandname].numArgs == 2 then
							commandparser[commandname](sender,argumentos,rango)
						else
							commandparser[commandname](sender,argumentos)
						end
					else
						commandparser[commandname](sender)
					end
				else
					sender:iPrintLnBold(lang.no_function_command)
				end
			else
				sender:iPrintLnBold(lang.insufficient_privileges)
			end
		else
			sender:iPrintLnBold(lang.no_rango_command)
		end
	else
		sender:iPrintLnBold(lang.no_such_command)
	end
	return true
end

function commandparser:init()
	commandparser:colores()
	commandparser.add("iamgod",0,"!iamgod")
	commandparser.add("gravity",1,"!gravity number")
	commandparser.add("speed",1,"!speed number")
	commandparser.add("rage",1,"!rage opcionalarg")
	commandparser.add("website",0,"!website")
	commandparser.add("time",0,"!time")
	commandparser.add("weball",0,"!weball")
	commandparser.add("timeall",0,"!timeall")
	commandparser.add("rall",0,"!rall")
	commandparser.add("kick",2,"!kick name,opcionalreason")
	commandparser.add("tban",2,"!tban name,opcionalreason,timeinhours")
	commandparser.add("pban",2,"!pban name,opcionalreason")
	commandparser.add("unban",1,"!unban name|@id")
	commandparser.add("groups",0,"!groups")
	commandparser.add("credits",0,"!credits")
	commandparser.add("contact",0,"!contact")
	commandparser.add("saycon",1,"!saycon msg")
	commandparser.add("setnextdsr",1,"!setnextdsr namedsr,opcionalmap")
	commandparser.add("dsr",1,"!dsr namedsr,opcionalmap")
	commandparser.add("setnextmap",1,"!setnextmap mapname")
	commandparser.add("sayas",1,"!sayas name,msg")
	commandparser.add("putgroup",1,"!putgroup name,group")
	commandparser.add("ungroup",1,"!ungroup name")
	commandparser.add("jump",1,"!jump number")
	commandparser.add("givegun",1,"!givegun namegun")
	commandparser.add("warn",1,"!warn name,opcionalmsg")
	commandparser.add("unwarn",1,"!unwarn name")
	commandparser.add("map",2,"!map mapname")
	commandparser.add("rotate",2,"!rotate")
	commandparser.add("fastrestart",2,"!fastrestart")
	commandparser.add("tell",1,"!tell name,msg")
	commandparser.add("balance",0,"!balance")
	commandparser.add("tellall",0,"!tellall msg")
	commandparser.add("pm",1,"!pm name,msg")
	commandparser.add("restart",2,"!restart")
	commandparser.add("scream",1,"!scream msg")
	commandparser.add("load",1,"!load namescript.lua")
	commandparser.add("unload",1,"!unload namescript.lua")
	commandparser.add("suicide",0,"!suicide")
	commandparser.add("lastbans",0,"!lastbans")
	commandparser.add("dsrs",0,"!dsrs")
	commandparser.add("afkgod",0,"!afkgod")
	commandparser.add("spec",0,"!spec")
	commandparser.add("setteam",1,"!setteam name,allies|spectator|axis")
	commandparser.add("kill",2,"!kill name")
	commandparser.add("ac130",1,"!ac130 opcionalname")
	commandparser.add("rules",0,"!rules")
	commandparser.add("reglas",0,"!reglas")
	commandparser.add("addr",1,"!addr newrule")
	commandparser.add("showspots",0,"!showspots")
	commandparser.add("addspot",1,"!addspot name")
	commandparser.add("delspot",1,"!delspot name")
	commandparser.add("spottp",1,"!spottp name")
	commandparser.add("listmap",1,"!listmap all|normal|dlc1|dlc2|dlc3|dlc4|faceoff|terminal ")
	commandparser.add("myip",0,"!myip")
	commandparser.add("help",2,"!help opcionalcommand")
	commandparser.add("teleport",1,"!teleport playerorigen,playerdestino")
	commandparser.add("status",0,"!status")
	commandparser.add("nextgame",0,"!nextgame")
	commandparser.add("encuesta",1,"!encuesta name,question")
	commandparser.add("fly",0,"!fly")
	commandparser.add("votekick",1,"!votekick name,opcionalreason")
	commandparser.add("votemap",1,"!votemap mapname")
	commandparser.add("y",0,"!y")
	commandparser.add("n",0,"!n")
	commandparser.add("myguid",0,"!myguid")
	commandparser.add("votecancel",0,"!votecancel")
	commandparser.add("freeze",1,"!freeze name")
	commandparser.add("setalias",1,"!setalias name,newalias")
	commandparser.add("delalias",1,"!delalias name")
	commandparser.add("unfreeze",1,"!unfreeze name")
	commandparser.add("blockchat",1,"!blockchat name")
	commandparser.add("unblockchat",1,"!unblockchat name")
end

return commandparser