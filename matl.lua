dictionary = require "scripts\\mp\\matl.dictionary"
tools = require "scripts\\mp\\matl.toolsutil"
balance = require "scripts\\mp\\matl.teambalance"
config = require "scripts\\mp\\matl_config"
lang= config:getlang()
groups ={}
commands ={}
userWarns = {}
spots={}
logconsole={}
logcommands={}
rota={}
spots={}
vote={}
enc={}
commandparser= require "scripts.mp.matl.commandparser"
commandparser:init()
function succesfulfile(path)
	print(string.format("%s %s",lang.succesful_create_file,path))
end

function matlMensajes(path)
	local newfile= assert(io.open(path, "w" ))
	newfile:write("^2Bienvenido ^7has habilitado ^1matl script mensajes ^4Para cambiarlos accede en la carpeta del script", "\n")
	newfile:write("^1Soporte y mas en ^2~|^7M^1|~ ^7Clan ^2Maniacos", "\n")
	newfile:close()
	succesfulfile(config.tmes_file)
end

function matlAdmins(path)
	local newfil = assert(io.open(path, "w"))
	newfil:close()
	succesfulfile(config.admins)
end

function matlClients(path)
	local file= assert(io.open(path,"w"))
	file:close()
	succesfulfile(config.clients)
end

function matlConsoleLog(path)
	local newfilee = assert(io.open(path, "w"))
	newfilee:close()
	succesfulfile(config.logconsole)
end

function matlCommandsLog(path)
		local newfile2 = assert(io.open(path, "w"))
		newfile2:close()
		succesfulfile(config.logcommands)
end

function matlBans(path)
	local nwfile = assert(io.open(path, "w"))
	nwfile:close()
	succesfulfile(config.bans)
end

function configSpots(path)
	local nw= assert(io.open(path,"w"))
	nw:close()
	succesfulfile(config.spots)
end

function matlRules(path)
	local newfile1= assert(io.open(path, "w" ))
	newfile1:write("^1Restricciones: ^7Esto es una ^2regla", "\n")
	newfile1:write("^1Restricciones: ^7Esto es otra ^2regla", "\n")
	newfile1:close()
	succesfulfile(config.rules)
end

function matlRulesEn(path)
	local newfile1= assert(io.open(path, "w" ))
	newfile1:write("^1Restrictions: ^7Only specialist ^2Streak", "\n")
	newfile1:write("^1Restrictions: ^7No ^2Silencer", "\n")
	newfile1:write("^1Restrictions: ^7Rifles: ^2MK14", "\n")
	newfile1:write("^1Restrictions: ^7SMG: ^2MP7,P90,PP90*,All LMG", "\n")
	newfile1:write("^1Restrictions: ^7Machine Guns: ^2PKP PECHENEG, MK46, M60E4","\n")
	newfile1:write("^1Restrictions: ^7Snipers: ^2Barret CAL50, Dragunov,AS50,RSASS","\n")
	newfile1:write("^1Restrictions: ^7Shotguns: ^2USAS12, AA12,Striker,KSG 12,Model*,Riot Shield","\n")
	newfile1:write("^1Restrictions: ^7Secondary: ^2All Machine Pistols*","\n")
	newfile1:write("^1Restrictions: ^7Launchers: ^2SMAW, JAVELIN, XM25, M320GLM, RPG-7","\n")
	newfile1:write("^1Restrictions: ^7Lethal: ^2Bounging Betty, Claymore, C4","\n")
	newfile1:write("^1Restrictions: ^7Tactical: ^2Scrambler,EMP Granade,Trophy System,Tactical Insertion,Portable Radar","\n")
	newfile1:write("^1Restrictions: ^7Perks: ^2Recon,Hardline,Overkill,Marksman","\n")
	newfile1:write("^1Restrictions: ^7Strike Package: ^2All Assault, All Support","\n")
	newfile1:write("^1Restrictions: ^7Death Streak: ^2Revenge, Final Stand, Martyrdom, Dead Mans Hand, Hallow Points","\n")
	newfile1:write("^1Restrictions: ^7Proficiency: ^2Range,Melee,Damage","\n")
	newfile1:write("^1Restrictions: ^7Attachments: ^2ACOG Scope*, GRIP*,Akimbo,Thermal,Shotgun,Heartbeat Sensor,Rapid Fire*,Holographic Sight","\n")
	newfile1:write("^1Restrictions: ^7Attachments: ^2Variable Zoom Scope*,Grenade Launchers Silencer,Hamr Scope*,Hybrid Sight*,Tactical Knife*","\n")
	newfile1:close()
	succesfulfile(config.rules_en)
end

function matlRotation(path)
	local new= assert(io.open(path, "w"))
	new:write("mp_dome,TDM_default,1","\n")
	new:close()
	succesfulfile("default.matl.dspl")
end

function configRotation(path)
	local new1= assert(io.open(path,"w"))
	new1:write("<?xml version=\"1.0\" encoding=\"utf-8\"?>", "\n")
	new1:write("<!-- Ajustes para el modulo de rotacion. ","\n")
	new1:write("\t","\n")
	new1:write("\tAjustes estan divididos en \"entries\". Cada entry tiene dos atributos: dsrs y mapas. Su valor es descartado. ","\n")
	new1:write("\tEl atributo dsrs especifica el archivo DSR a usar. Multiples archivos DSR deberan ser separados por comas.","\n")
	new1:write("\t","\n")
	new1:write("\tEl atributo maps especifica los mapas a usar en el DSR. Multiples mapas deberan ser separados por comas. ","\n")
	new1:write("\tLos mapas no necesitan estar en formato ingame (ex. mp_radar). Tu puedes usar la mismas sintaxis que usas en el comando !map.","\n")
	new1:write("\t","\n")
	new1:write("\tInstanciado de un nombre de mapa, tu puedes usar el \"normal|dlc1|dlc2|dlc3|dlc4|faceoff|terminal\". O si tu lo quieres, los mapas puedes ser seleccionados de manera aleatoria all map respectivamente.","\n")
	new1:write("\t","\n")
	new1:write("\tY al inicio de cada ronda, MATL debera aleatorizar el mapa y DSR que tu hayas seleccionado.","\n")
	new1:write("\t","\n")
	new1:write("-->","\n")
	new1:write("","\n")
	new1:write("<Rotation>","\n")
	new1:write("\t<entry dsrs=\"TDM_default\" maps=\"dome,lockdown,hardhat\"></entry>","\n")
	new1:write("</Rotation>","\n")
	new1:close()
	succesfulfile(config.maprot_file)
end

function matlGroups(path)
	local newfile3= assert(io.open(path, "w"))
	newfile3:write("<?xml version=\"1.0\" encoding=\"utf-8\"?>", "\n")
	newfile3:write("","\n")
	newfile3:write("<!-- Cambia esto si tu buscas custumizar los grupos. Explicacion de parametros:", "\n")
	newfile3:write(" - prefix es el prefix que tendra el miembro del grupo al hablar","\n")
	newfile3:write(" - code son lo que usaras posterior a !putgroup","\n")
	newfile3:write(" - rango es el numero de \"rango\" para el grupo","\n")
	newfile3:write(" - mensaje define el mensaje de bienvenido para cuando el miembro se conecta.","\n")
	newfile3:write(" - pass - Si lo asignas, todos los miembros de ese grupo tendran que hacer !login antes de hacer algo","\n")
	newfile3:write(" Nota adicional: no asignes mas de un grupo al mismo rango, esto puede provocar el mal funcionamiento del script","\n")
	newfile3:write("-->","\n")
	newfile3:write("","\n")
	newfile3:write("<groups>","\n")
	newfile3:write("\t<group code=\"owner\" rango=\"100\" prefix=\"^2[|^7Owner^1|] ^5\" mensaje=\"^1Owner ^3@name^7 ha entrado al servidor.\" pass=\"\">Owner</group>","\n")
	newfile3:write("\t<group code=\"sadm\" rango=\"80\" prefix=\"^6\" mensaje=\"^2SeniorAdmin ^3@name^7 ha entrado al servidor.\" pass=\"\">Senior admin</group>","\n")
	newfile3:write("\t<group code=\"admin\" rango=\"60\" prefix=\"^2\" mensaje=\"^2Admin ^3@name^7 ha entrado al servidor.\" pass=\"\">Admin</group>","\n")
	newfile3:write("\t<group code=\"mod\" rango=\"40\" prefix=\"^5\" mensaje=\"^2Moderador ^3@name^7 ha entrado al server.\" pass=\"\">Moderador</group>","\n")
	newfile3:write("\t<group code=\"mem\" rango=\"20\" prefix=\"\" mensaje=\"^2Clan Member ^3@name^7 ha entrado al server.\" pass=\"\">Clan Member</group>","\n")
	newfile3:write("","\n")
	newfile3:write("</groups>","\n")
	newfile3:close()
	succesfulfile(config.groups)
end

function matlCommands(path)
	local newfile4= assert(io.open(path, "w"))
	newfile4:write("<?xml version=\"1.0\" encoding=\"utf-8\"?>", "\n")
	newfile4:write("","\n")
	newfile4:write("<!-- Define la abreviatura y el privilegio minimo (player rango) para cada comando. -->","\n")
	newfile4:write("","\n")
	newfile4:write("<commands>","\n")
	newfile4:write("","\n")
	newfile4:write("\t<command abrev=\"k\" minrango=\"40\">kick</command>","\n")
	newfile4:write("\t<command abrev=\"tb\" minrango=\"60\">tban</command>","\n")
	newfile4:write("\t<command abrev=\"pb\" minrango=\"60\">pban</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">unban</command>","\n")
	newfile4:write("\t<command abrev=\"w\" minrango=\"40\">warn</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">unwarn</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">map</command>","\n")
	newfile4:write("\t<command abrev=\"res\" minrango=\"40\">fastrestart</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">restart</command>","\n")
	newfile4:write("\t<command abrev=\"rot\" minrango=\"40\">rotate</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">pm</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">tell</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">kill</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">jump</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">speed</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">gravity</command>","\n")
	newfile4:write("\t<command abrev=\"admin\" minrango=\"0\">admins</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">credits</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">putgroup</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">ungroup</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">status</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">help</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">setteam</command>","\n")
	newfile4:write("\t<command abrev=\"l\" minrango=\"20\">lookup</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">blowup</command>","\n")
	newfile4:write("\t<command abrev=\"afk\" minrango=\"0\">spec</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">rules</command>","\n")
	newfile4:write("\t<command abrev=\"r\" minrango=\"0\">reglas</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">register</command>","\n")
	newfile4:write("\t<command abrev=\"xlr\" minrango=\"0\">xlrstats</command>","\n")
	newfile4:write("\t<command abrev=\"xlrtop\" minrango=\"0\">xlrtopstats</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">balance</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">groups</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">scream</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">load</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">unload</command>","\n")
	newfile4:write("\t<command abrev=\"bc\" minrango=\"40\">blockchat</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">unblockchat</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"40\">baninfo</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">playerinfo</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">freeze</command>","\n")
	newfile4:write("\t<command abrev=\"s\" minrango=\"0\">suicide</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">sayas</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">saycon</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">givegun</command>","\n")
	newfile4:write("\t<command abrev=\"vk\" minrango=\"0\">votekick</command>","\n")
	newfile4:write("\t<command abrev=\"vm\" minrango=\"0\">votemap</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">y</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">n</command>","\n")
	newfile4:write("\t<command abrev=\"vc\" minrango=\"60\">votecancel</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">whoami</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">techinfo</command>","\n")
	newfile4:write("\t<command abrev=\"alias\" minrango=\"80\">setalias</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"100\">cmd</command>","\n")
	newfile4:write("\t<command abrev=\"ia\" minrango=\"80\">infammo</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">fly</command>","\n")
	newfile4:write("\t<command abrev=\"is\" minrango=\"80\">indspeed</command>","\n")
	newfile4:write("\t<command abrev=\"rld\" minrango=\"100\">reloadcfg</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">iamgod</command>","\n")
	newfile4:write("\t<command abrev=\"site\" minrango=\"0\">website</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">time</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">gametype</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">dsr</command>","\n")
	newfile4:write("\t<command abrev=\"nextmap\" minrango=\"0\">nextgame</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">setnextmap</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">setnextdsr</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">knife</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">lastbans</command>","\n")
	newfile4:write("\t<command abrev=\"tp\" minrango=\"80\">teleport</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">addspot</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">delspot</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"100\">addr</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">spottp</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"60\">showspots</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">myguid</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">myip</command>","\n")
	newfile4:write("\t<command abrev=\"nw\" minrango=\"80\">noweapons</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">tellall</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">weball</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">timeall</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">rall</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">adminsall</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">ac130</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">listmap</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"80\">rage</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"0\">contact</command>","\n")
	newfile4:write("\t<command abrev=\"enc\" minrango=\"0\">encuesta</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">afkgod</command>","\n")
	newfile4:write("\t<command abrev=\"\" minrango=\"90\">dsrs</command>","\n")
	newfile4:write("","\n")
	newfile4:write("<!-- Esta seccion es opcional. Si tu tienes otros scripts, y deseas que MATL los ignore entonces, agregalos aqui. Ejemplo - !ga - es given below. -->","\n")
	newfile4:write("\t<!-- EJEMPLO: <ignorecmd>!ga</ignorecmd> -->","\n")
	newfile4:write("\t","\n")
	newfile4:write("</commands>","\n")
	newfile4:write("\t","\n")
	newfile4:close()
	succesfulfile(config.commands)
end

function matlInicio()
	local file = ".//scripts//mp//matl//direct.txt"
	if not tools:dir_exists(file) then
		print(lang.error_msg_direct)
	else 
		os.remove(file)
		if not tools:file_exists(commandparser.mtimespath) then
			matlMensajes(commandparser.mtimespath)
		end
		if not tools:file_exists(commandparser.rulespath) then
			matlRules(commandparser.rulespath)
		end
		if config.rules_en_enabled then
			if not tools:file_exists(commandparser.rulespath_en) then
				matlRulesEn(commandparser.rulespath_en)
			end
		end
		if not tools:file_exists(commandparser.commandspath) then
			matlCommands(commandparser.commandspath)
			updateCommands(commandparser.commandspath)
		else 
			updateCommands(commandparser.commandspath)
		end
		if not tools:file_exists(commandparser.groupspath) then
			matlGroups(commandparser.groupspath)
			updateGroups(commandparser.groupspath)
		else
			updateGroups(commandparser.groupspath)
		end
		if not tools:file_exists(commandparser.adminpath) then 
			matlAdmins(commandparser.adminpath)
		end
		if not tools:file_exists(commandparser.banpath) then 
			matlBans(commandparser.banpath)
		end
		if config.logconsole_enabled then
			if not tools:file_exists(commandparser.logconsolepath) then
				matlConsoleLog(commandparser.logconsolepath)
			end
		end
		if config.logcommands_enabled then 
			if not tools:file_exists(commandparser.logcommandspath) then
				matlCommandsLog(commandparser.logcommandspath)
			end
		end
		if config.maprot_enabled then
			local file9= ".//admin//default.matl.dspl"
			if not tools:file_exists(file9) then
				matlRotation(file9)
			end
			if not tools:file_exists(commandparser.maprotpath) then
				configRotation(commandparser.maprotpath)
				updateRotacion(commandparser.maprotpath)
			else
				updateRotacion(commandparser.maprotpath)
			end
		end
		if not tools:file_exists(commandparser.spotspath) then
			configSpots(commandparser.spotspath)
			updateSpots(commandparser.spotspath)
		else
			updateSpots(commandparser.spotspath)
		end
		if not tools:file_exists(commandparser.clientspath) then
			matlClients(commandparser.clientspath)
		end
	end
end

function addresultenc(name, msg, numno, numyes)
	table.insert(enc,{nombre=name,mssg= msg,yes= numyes, no= numno})
end

function getEnc(name)
	local res={}
	for i in pairs(enc) do
		if (enc[i].nombre == name) then 
			res = enc[i]
		end
	end
	return res
end

function getBan(player)
	local flag = true
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
					if banss[i][3] == tostring(player:getguid()) then
						 local actualtime = os.time()
						 if tonumber(banss[i][8]) > actualtime then
							 local msg= lang.bankick_temp_with_reason:gsub("@admin",banss[i][5])
							 msg= msg:gsub("@time_left",os.date("%H",tonumber(banss[i][8])))
						 	msg= msg:gsub("@reason",banss[i][6])
						 	msg= msg:gsub("@time_issued ",os.date("%H",tonumber(banss[i][7])))
							 msg= msg:gsub("@banid",tostring(i))
						 	if config.clansite ~= nil and config.clansite ~= "" then 
								msg= msg:gsub("@website",config.clansite)
							 else
								msg= msg:gsub("@website",lang.website_nosite_error_msg)
							 end
							 gsc.iprintln(string.format("%s %s",player.name,msg))
							 callbacks.afterDelay.add(1000,function()util.executeCommand(string.format("dropclient %s \"%s\"",tostring(player:getentitynumber()),msg))end)
							 flag = false
						else
							table.remove(banss,i)
							tools:writed(commandparser.banpath,banss,';')
							--decir algo :V
						end
					end
				end
			end
	end
	return flag
end

function initvota()
	if config.voting_enabled then
		vote=nil
		local votedplayers={}
		for i=1,18,1 do
			votedplayers[i]=""
		end
		vote={
			timeout=config.vote_time,
			passedtime=0,
			voteinprogress=false,
			voteyes=0,
			voteno=0,
			votedplayers= votedplayers,
			votetype="",
			votemsg="",
			voteguild="",
			voteip="",
			votename="",
			votemap="",
			votetime_ban=config.votekick_bantime,
			needTonotify=false,
			needTochange=false,
			mapfull="",
			cancel=false,
			admin=""
		}
	end
end

initvota()

function updateRotacion(path)
	rota= nil
	rota= tools:ParseXmlFile(path)
end

function updateSpots(path)
	local msgArray = tools:lines_from(path)
	spots=nil
	if #msgArray ~= 0 then
		--only test
		spots= tools:readd(path,',',false)
	else
		spots={}
	end
end

function updateGroups(path)
	groups = nil
	groups = tools:ParseXmlFile(path)
end

function updateWarns()
	userWarns=nil
	userWarns={}
end

function updateCommands(path)
	commands = nil
	commands = tools:ParseXmlFile(path)
end

function timedMessages()
	if config.tmes_enabled then
		if not tools:file_exists(commandparser.mtimespath) then
			matlInicio()
		else
			local msgArray = tools:lines_from(commandparser.mtimespath)
			if #msgArray ~= 0 then
				math.randomseed(os.time())
				local printIndex = math.random(1, #msgArray)
				commandparser:sayAll(msgArray[printIndex])
			else
				print(lang.error_nolines_tmes)
			end
		end
	end
end

function onNotify(args)
	if args == "prematch_done" then
		iambot()
	end
end

function iambot()
	gsc.iprintln("^2[M^7AT^1L] ^3v0.6 ^5by ^1luffy^7nan^2do")
end

function onPlayerConnecting(args)
	print("[enPlayerConectando]: " .. args.player.name .. " esta conectandose.")
end

function onPlayerConnected(player)
	if getBan(player) then
		local rango = tonumber(checkAdmin(player:getguid()))
		if rango == nil then
		rango = 0
		end
		if rango ~= 0 then 
			local welcome = getMensajeGroup(rango)
			if welcome ~= "" then
				commandparser:sayAll(welcome:gsub("@name",player.name,1))
			else
				commandparser:sayAll(lang.welcome_msg_admin_default:gsub("@name",player.name,1))
			end
		else
			commandparser:sayAll(lang.welcome_msg_new:gsub("@name",player.name,1))
		end
		print("[enPlayerConectado]: " .. player.name .. " :".. tostring(player.ip))
	end
end

function onPlayerRequestingConnection(args)
	print("[enPeticiondePlayerConexion]: Haciendo peticion de conexion desde IP: " .. tostring(args.ip))
end

function onPlayerDamage(tblArgs)
	--print("Player damage")
	--print(tblArgs.ent,tblArgs.inflictor,tblArgs.attacker,tblArgs.damage,tblArgs.mod,tblArgs.weapon,tblArgs.point,tblArgs.dir,tblArgs.hitloc)
	--tblArgs.ent
	--tblArgs.inflictor
	--tblArgs.attacker
	--tblArgs.damage
	--tblArgs.mod
	--tblArgs.weapon
	--tblArgs.point
	--tblArgs.dir
	--tblArgs.hitloc
end

function onPlayerKilled(tblArgs)
	if config.headshot then 
		if (tblArgs.mod == MeansOfDeath.HeadShot) then
			local msg = lang.specialmsg_headshot:gsub("@attacker",tblArgs.attacker.name,1)
			msg= msg:gsub("@victim",tblArgs.ent.name,1)
			commandparser:sayAll(msg)
		end
	end
	
	if config.knifekill then
		if (tblArgs.mod == MeansOfDeath.Melee) then
			local msg2= lang.specialmsg_knifekill:gsub("@attacker",tblArgs.attacker.name,1)
			msg2= msg2:gsub("@victim",tblArgs.ent.name,1)
			commandparser:sayAll(msg2)
		end
	end
	
	if config.suicide then
		if (tblArgs.mod == MeansOfDeath.Suicide) then
			commandparser:sayAll(lang.specialmsg_suicide:gsub("@victim",tblArgs.ent.name,1))
		end
	end

	if config.explosivekill then 
		if (tblArgs.mod == MeansOfDeath.Explosive) then 
			commandparser:sayAll(lang.specialmsg_explosivekill:gsub("@victim",tblArgs.ent.name,1))
		end
	end
end

function matlAddAdmin(id,name,hw,guild,ip,rango,status)
	local updateFile= assert(io.open(commandparser.adminpath, "a+"))
	updateFile:write(tostring(id)..";"..name..";"..tostring(hw)..";"..tostring(guild)..";"..tostring(ip)..";"..tostring(rango)..";"..tostring(status),"\n")
	updateFile:close()
end

function matlAddClient(id,name,guild,ip,alias,status)
	local file= assert(io.open(commandparser.clientspath,"a+"))
	file:write(string.format("%s;%s;%s;%s;%s;%s",tostring(id),name,tostring(guild),tostring(ip),alias,tostring(status),"\n"))
	file:close()
end

function matladdspot(nombre,mapa,playerOrigin)
	local updateFile= assert(io.open(commandparser.spotspath,"a+"),lang.addspot_error_file_msg)
	updateFile:write(nombre..","..mapa..","..tostring(playerOrigin.x)..","..tostring(playerOrigin.y)..","..tostring(playerOrigin.z),"\n")
	updateFile:close()
	updateSpots(commandparser.spotspath);
end

function matlAddBan(id,name,guild,ip,baneador,razon,fechai,fechad)
	local updateFile= assert(io.open(string.format(".//scripts//mp//matl//%s",config.bans), "a+"))
	updateFile:write(tostring(id)..";"..name..";"..tostring(guild)..";"..tostring(ip)..";"..baneador..";"..razon..";"..tostring(fechai)..";"..tostring(fechad),"\n")
	updateFile:close()
end

function checkAdmin(guild)
	if not tools:file_exists(commandparser.adminpath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.adminpath)
			if #msgArray ~= 0 then
				--only test
				local adminss= tools:readd(commandparser.adminpath,';',false)
				local rango = nil
				local i=1
				local ban=0
				local myguild = tostring(guild)
				while  (i <= #msgArray) and (ban ~= 1)    do
					local adminguild= tostring(adminss[i][4])
					if  adminguild == myguild then
						rango= adminss[i][6]
						ban=1
					end
					i=i+1
				end
				return rango
			else
				return nil
			end
	end
	return nil
end

function getPrefix(rang)
	local pre=""
	local i=1;
	local ban=0;
	local myrango= tostring(rang)
	if #groups.ChildNodes ~=0 then
		while (i<= #groups.ChildNodes) and (ban ~=1) do
			if groups.ChildNodes[i].Attributes.rango == myrango then
				pre= groups.ChildNodes[i].Attributes.prefix
				ban=1
			end
			i=i+1
		end
	else
		print(lang.groups_error_nogroups)
	end
	return pre
end

function getAlias(guild)
	if not tools:file_exists(commandparser.clientspath) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(commandparser.clientspath)
			if #msgArray ~= 0 then
				--only test
				local adminss= tools:readd(commandparser.clientspath,';',false)
				local alias = nil
				local i=1
				local ban=0
				local myguild = tostring(guild)
				while  (i <= #msgArray) and (ban ~= 1)    do
					local adminguild= tostring(adminss[i][4])
					if  adminguild == myguild then
						alias= adminss[i][5]
						ban=1
					end
					i=i+1
				end
				if alias == "" then
					alias=nil
				end
				return alias
			else
				return nil
			end
	end
	return nil
end

function getMensajeGroup(rangoa)
	local pre=""
	local i=1;
	local ban=0;
	local myrango= tostring(rangoa)
	if #groups.ChildNodes ~=0 then
		while (i<= #groups.ChildNodes) and (ban ~=1) do
			if groups.ChildNodes[i].Attributes.rango == myrango then
				pre= groups.ChildNodes[i].Attributes.mensaje
				ban=1
			end
			i=i+1
		end
	else
		print(lang.groups_error_nogroups)
	end
	return pre
end

function getGroup(name)
	local name2=""
	local i=1;
	local ban=0;
	if #groups.ChildNodes ~=0 then
		while (i<= #groups.ChildNodes) and (ban ~=1) do
			if groups.ChildNodes[i].Attributes.code == name then
				name2= groups.ChildNodes[i].Attributes.rango
				ban=1
			end
			i=i+1
		end
	else
		print(lang.groups_error_nogroups)
	end
	return name2
end

function removeUserWarn(admin, userguid)
	local myi
	if #userWarns ~= 0 then
		local ban=1
		local i=1
		while (i<= #userWarns) and (ban ~= 1) do
			if (userWarns[i].guid == userguid) then
				myi=i
				ban=1
			end
			i=i+1
		end
		if ban ~= 0 then
			table.remove(userWarns,myi)
			commandparser:sayTellPlayer(admin, lang.unwarn_succesful_msg)
		else
			commandparser:sayTellPlayer(admin,lang.unwarn_error_nowarnsforplayer_msg)
		end
	else
		commandparser:sayTellPlayer(admin, lang.unwarn_error_nowarns_msg)
	end
end

function addUserWarn(user, msg)
	local myi
	if #userWarns ~= 0 then
		local ban=0
		local i=1
		while (i<= #userWarns) and (ban ~= 1) do
			if (userWarns[i].guid == user:getguid()) then
				userWarns[i].numwarn = userWarns[i].numwarn+1 
				userWarns[i].msg = msg
				myi=i
				ban=1
			end
			i=i+1
		end
		if ban==0 then
			myi = #userWarns+1
			userWarns[#userWarns+1] = {
							name= user.name,
							guid= user:getguid(),
							numwarn= 1,
							mesg= msg 
							}
		end
	else
		myi = #userWarns+1
		userWarns[#userWarns+1] = {
							name= user.name,
							guid= user:getguid(),
							numwarn= 1,
							mesg= msg 
							}
	end
	commandparser:sayAll("^1ADVERTENCIA: ^7".. user.name ..", ^3" ..msg .. " ^2" .. tostring(userWarns[myi].numwarn).. "/"..tostring(config.warn_max_warnings))
	if (userWarns[myi].numwarn== config.warn_max_warnings) then
		--kickeo al usuario
		util.executeCommand("dropclient "..tostring(user:getentitynumber()))
		--posiblemente registro?
		table.remove(userWarns,myi)
	end
end

function checkrangocommand(comando)
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

function aleatorizaRotacion()
	if #rota.ChildNodes ~= 0 then
		math.randomseed(os.time())
		local Index = math.random(1, #rota.ChildNodes)
		local dsrb = rota.ChildNodes[Index].Attributes.dsrs
		local dsrcoma= dsrb:split(",")
		local mapsb = rota.ChildNodes[Index].Attributes.maps:split(",")
		local mapsbtest = rota.ChildNodes[Index].Attributes.maps
		if dsrb ~= "" then
			local newdsr=""
			if dsrcoma[1] == nil then
				newdsr= dsrb
			else
				local newindex= math.random(#dsrcoma)
				newdsr= dsrcoma[newindex]
			end
			if tools:file_exists(string.format(".//admin//%s.dsr",newdsr)) then
				if mapsbtest ~= "" then
					local newmap="" 
					if mapsb[1] ~= nil then
						local printIndex2 = math.random(#mapsb)
						newmap= dictionary.searchmap(mapsb[printIndex2])
					else
						newmap= dictionary.searchmap(mapsbtest)
					end
					if newmap.map ~= nil then
						updateDsr(newmap.map,newdsr,nil);
					else
						print(lang.rotation_error_no_match_map)
						updateDsr(nil,newdsr,nil);
					end
				else
					print(lang.rotation_error_no_maps)
					updateDsr(nil,newdsr,nil)
				end
			else
				print(lang.rotation_error_no_match)
			end
		else
			print(lang.rotation_error_nodsr)
		end
	else
		print((lang.rotation_error_msg:gsub("@file",config.maprot_file)))
	end
end

function updateDsr(par1,par2,par3)
	local file6= ".//admin//default.matl.dspl"
	if not tools:file_exists(file6) then 
		print(lang.unsuccesful_create_file)
		matlInicio()
	else
		local msgArray = tools:lines_from(file6)
			if #msgArray ~= 0 then
				--only test
				local adminss= tools:readd(file6,',',false)
				if par1 ~= nil then
					adminss[1][1] = par1
				end
				if par2 ~=nil then
					adminss[1][2] = par2
				end
				if par3 ~=nil then 
					adminss[1][3] = par3
				end
				tools:writed(file6,adminss,',')
			else
				print(lang.setnextdsr_error_write_msg)
			end
	end
end

function getPlayer(peticion, nam)
	local player= nil
	local i=1
	local count =0;
	for p in util.iterPlayers() do
		if p.name == nam then 
			return p
		end
		if string.match(p.name, nam) then
			player= p
			count= count+1
		end
	end
	if (count > 1)then
		peticion:iPrintLnBold(lang.error_more_than_one_player)
		player= nil
	end
	return player
end



function resetvote()
	local votedplayers={}
	for i=1,18,1 do
		votedplayers[i]=""
	end
	vote.passedtime=0
	vote.voteyes=0
	vote.voteno=0
	vote.votedplayers = votedplayers
	vote.votetype=""
	vote.votemsg=""
	vote.voteguild=""
	vote.voteip=""
	vote.votename=""
	vote.votemap=""
	vote.needTonotify=false
	vote.needTochange=false
	vote.mapfull=""
	vote.cancel=false
	vote.admin=""
	vote.voteinprogress=false
end

function checkVote()
	if vote.voteinprogress then
		vote.passedtime = vote.passedtime + 1
		if vote.needTonotify then
			vote.needTonotify = false
			vote.needTochange = true
		end
		if vote.needTochange then
			if vote.votetype == "kick" then
				local msg= lang.votekick_kick_msg:gsub("@player",vote.votename)
				msg= msg:gsub("@reason",vote.votemsg)
				commandparser:sayAll(msg)
				local msgArray2 = tools:lines_from(commandparser.banpath)
				local time= os.time()+config.votekick_bantime
				matlAddBan(#msgArray2 +1,vote.votename,vote.voteguild,vote.voteip,"Automatico",vote.votemsg,os.time(),time)
				local kickmsg= lang.votekick_ban_msg:gsub("@reason",vote.votemsg)
				kickmsg= kickmsg:gsub("@duration",os.date("%c",time))
				kickmsg= kickmsg:gsub("@banid",tostring(#msgArray2))
				kickmsg= kickmsg:gsub("@website",config.clansite)
				util.executeCommand(string.format("drop %s \"%s\"",vote.votename,kickmsg))
				resetvote()
			elseif vote.votetype == "enc" then 
				local res= lang.encuesta_end_msg:gsub("@y",tostring(vote.voteyes))
				res= res:gsub("@n",tostring(vote.voteno))
				commandparser:sayAll(res)
				commandparser:sayAll(lang.encuesta_end_credits)
				addresultenc(vote.votename, vote.votemsg, vote.voteno, vote.voteyes)
				resetvote()
			elseif vote.votetype == "map" then 
				commandparser:sayAll((lang.map_succesful_msg:gsub("@map",vote.votemap)))
				util.executeCommand(string.format("map %s",vote.mapfull))
				resetvote()
			end
		end
		if vote.passedtime == vote.timeout then -- timeout
			if vote.votetype ~= "enc" then
				if vote.voteyes > vote.voteno then
					vote.needTonotify = true
				else
					resetvote()
					commandparser:sayAll(lang.vote_insufficient_votes_msg)
				end
			else
				vote.needTonotify = true
			end
		end
		if vote.cancel then 
			commandparser:sayAll((lang.vote_cancel_msg:gsub("@admin",vote.admin)))
			resetvote()
		end
	end
end

function onPlayerSay(args)
	local sender= args.sender
	local lowerMsg = args.message:lower()
	local chunks = lowerMsg:split(" ")
	local prefix=""
	local rango = tonumber(checkAdmin(args.sender:getguid()))
	if rango == nil then
		rango = 0
	end
	if string.sub(chunks[1], 1, 1) == "!" then
		if config.logcommands_enabled then 
			commandparser:updatelogCommand(args)
		end
		return commandparser.run(sender,rango,args.message,chunks[1])
	end
	if config.logconsole_enabled then
		commandparser:updatelogConsole(args)
	end
	if (rango ~= 0) then
		prefix= getPrefix(rango)
		local death= ""
		if args.sender.Health ~= nil and args.sender.Health ~= 0 then
				death=""
			else
				death="^7[Dead]"
		end
		if args.chatMode == 0 then 
			util.chatPrint(death..prefix .. args.sender.name .. ": ^7".. args.message)
		elseif args.chatMode == 1 then
			for p in util.iterPlayers() do
				if string.find(p.sessionteam, args.sender.sessionteam) then
						commandparser:sayToPlayer(p,death.."[T]"..prefix .. args.sender.name .. ": ^7".. args.message)
				end
			end
		end
		return true
	end
	return false
end

function updateAll()
	updateCommands(commandparser.commandspath)
	updateGroups(commandparser.groupspath)
	updateWarns()
	commandparser:savelogConsole()
	if config.maprot_enabled then
		updateRotacion(commandparser.maprotpath)
		aleatorizaRotacion()
	end
	updateSpots(commandparser.spotspath)
end

function onPlayerLeaving(args)
	print(args)
end

function onFrame()
		for player in util.iterPlayers() do
			if player.data.suicide ~= nil and player.data.suicide == true then
				-- reset suicide flag
				player.data.suicide = false
				-- kill player
				player:suicide()
			end
		end
end

--callbacks.localCommand.add(onLocalolCommand)
callbacks.playerConnecting.add(onPlayerConnecting)
callbacks.levelNotify.add(onNotify)
callbacks.playerSay.add(onPlayerSay)
callbacks.playerConnected.add(onPlayerConnected)
callbacks.playerRequestingConnection.add(onPlayerRequestingConnection)
callbacks.afterDelay.add(1000, matlInicio)
callbacks.playerDamage.add(onPlayerDamage)
callbacks.playerKilled.add(onPlayerKilled)
callbacks.onInterval.add(config.tmes_interval, timedMessages)
callbacks.preGameInit.add(updateAll)
callbacks.playerLeaving.add(onPlayerLeaving)
callbacks.frame.add(onFrame)
callbacks.onInterval.add(1000,checkVote)

print("Llamadas MATL instaladas")