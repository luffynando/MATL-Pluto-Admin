config={}

function config:getlang()
    local lang={}
        lang.comming_soon_msg="Proximamente xD"
        lang.error_more_than_one_player="^1Hay mas de un jugador con ese nombre"
        lang.unsuccesful_create_file="No se ha creado el archivo :s"
        lang.norules="En este servidor no hay reglas :v"
        lang.error_nolines_rules="No hay lineas en reglas"
        lang.specialmsg_endspree="A ^1@name ^7se le acabo la racha (^3@num_kills ^7kills). Fue asesinado por ^2@attacker!"
        lang.specialmsg_knifekill="^2@attacker ^7navajeo a ^1@victim"
        lang.specialmsg_explosivekill="^1@victim ^7ha explotado!"
        lang.specialmsg_suicide="^1@victim ^7no sabe jugar! :v."
        lang.specialmsg_headshot="^2@attacker ^7le volo la cabeza a ^1@victim"
        lang.error_nolines_tmes="No hay lineas para time mensajes"
        lang.save_console="Se ha guardado el log de forma automatica"
        lang.error_msg_direct= "Crea una carpeta llamada matl en la carpeta actual del script"
        lang.succesful_create_file= "Se ha creado satisfactoriamente el archivo"
        lang.register_ban_without_reason="Razon no especificada"
        lang.ban_tipo_error_format="^1Error el formato es: ^2!@tipo name,razonopcional,timeenhoras"
        lang.msg_ban_player_all="^1El usuario: ^;@player ^2se le ha dado @tipo del server por: ^;@admin ^3 Razon: ^4@reason"
        lang.msg_ban_player_all_without_reason="^1El usuario: ^;@player ^2se le ha dado @tipo del server por: ^;@admin"
        lang.bankick_temp_with_reason="Has sido baneado temporalmente de este servidor por @admin .^7 Tiempo restante: ^3@time_left .^7 Razon: ^1@reason .^1Hora: ^2 @time_issued . ^7BanID: ^3@banid. ^7Apelacion al ban en ^3@website"
        lang.bankick_temp_without_reason="Has sido baneado temporalmente de este servidor por @admin .^7 Tiempo restante: ^3@time_left . ^1Hora: ^2 @time_issued . ^7BanID: ^3@banid. ^7Apelacion al ban en ^3@website"
        lang.welcome_msg_admin_default="Bienvenido pro player ^;@name a nuestro servidor"
        lang.welcome_msg_new="Bienvenido ^3a nuestro servidor, ^2@name"
        lang.public_welcome_msg_new="Bienvenido al servidor ^2@name ^7."
        lang.insufficient_privileges="^1No papu!"
        lang.no_such_command="^1No existe ese comando"
        lang.no_rango_command="^1El comando existe pero no tiene rango asignado"
        lang.no_function_command="^1El comando existe, tiene rango, pero no tiene funcion asignada"
        lang.ban_no_admin_permission="^1Error no puedes dar @tipo a un rango mayor o igual al tuyo"
        lang.admin_intent_ban_msg="^2El usuario ^1@player ^2ha intentado darte ^3@tipo"
        lang.kick_without_reason="Tu has sido kickeado de este servidor."
        lang.kick_with_reason="Tu has sido kickeado de este servidor. Razon: ^3@reason"
        lang.ban_without_reason_time="Tu has sido temporalmente baneado de este servidor por ^3@duration ^7by admin ^2@admin. ^7BanID: ^3@banid. ^7Apelacion al ban en ^3@website"
        lang.ban_with_reason_time="Tu has sido temporalmente baneado de este servidor por ^3@duration ^7by admin ^2@admin. ^7Razon: ^1@reason . ^7BanID: ^3@banid. ^7Apelacion al ban en ^3@website"
        lang.permban_without_reason="Tu has sido permanentemente baneado de este servidor ^7by admin ^2@admin. ^7BanID: ^3@banid. ^7Apelacion al ban en: ^3@website"
        lang.permban_with_reason="Tu has sido permanentemente baneado de este servidor ^7by admin ^2@admin. ^7Razon: ^1@reason. ^7BanID: ^3@banid ^7Apelacion al ban en ^3@website"
        lang.warn_ban_kick="Tu has sido temporalmente baneado de este servidor por ^3@duration. ^7Razon: ^3por muchos warnings. ^7Ultimo warning: ^1@last_warning . ^7BanID: ^3@banid. ^7Apelacion al ban en ^3@website"
        lang.warn_kick="Tu has sido kickeado de este servidor. ^7Razon: ^3por muchos warnings. ^7Ultima advertencia: ^1@last_warning"
        lang.votekick_ban_msg="Los otros jugadores seleccionaron el ^3kickearte ^7de este servidor. @reason Adicionalmente, tu has sido ^1temporalmente baneado ^7por ^3@duration. ^7BanID: ^3@banid ^7Apelacion al ban en ^3@website"
        lang.votekick_kick_msg="@player ^2ha sido kickeado del server por ^;votacion ^3 Razon ^4@reason"
        lang.iamgod_blocked_msg="Este comando esta bloqueado"
        lang.iamgod_succesful_msg="^2Se ha registrado correctamente como ^3Primer Owner"
        lang.gravity_succesful_msg="Gravedad fijada a: ^3@number"
        lang.gravity_succesful_default="^1Si quieres regresar a la por defecto es 800"
        lang.error_nonumber_msg="^1Error ingresaste un valor que no es un numero"
        lang.error_time_nonumber_msg="^1Error el tiempo que ingreso no se puede pasar a numero, estableciendo tiempo por defecto"
        lang.gravity_error_msg="^1Error el formato es: ^2!gravity numero"
        lang.speed_succesful_msg="Velocidad fijada a: ^3@number"
        lang.speed_succesful_default="^1Si quieres regresar a la por defecto es 190"
        lang.speed_error_msg="^1Error el formato es: ^2!speed numero"
        lang.rage_default_msg="@name ha abandonado la partida"
        lang.rage_only_msg="has abandonado la partida"
        lang.unban_error_msg="^1Error el formato es: ^2!unban name|@id"
        lang.unban_error_id_msg="^1Error el id debe ser un numero"
        lang.unban_succesful_msg="^1Se ha retirado con exito al usuario del ban"
        lang.unban_error_player_name_msg="^1Hay mas de un usuario con el mismo nombre"
        lang.unban_error_noplayer="^1No hay coincidencias de usuario en los baneados"
        lang.unban_error_nobans="^1No hay ningun ban registrado"
        lang.unban_error_noid="^1No hay coincidencias de id"
        lang.unban_error_id_conflict="^1Esto es penoso al parecer hay mas de un usuario con la misma id :S"
        lang.groups_error_nogroups="Por alguna razon no hay grupos :V"
        lang.saycon_error_msg="^1Error el formato es: ^2!saycon mensaje"
        lang.setnextdsr_error_msg="^1Error el formato es: ^2!setnextdsr namedsr,opcionalmap"
        lang.setnextdsr_error_dsr_msg="^1Error el archivo @dsr no existe en el servidor"
        lang.setnextdsr_error_map_msg="^1No se encontro ningun mapa con el nombre ^2@map"
        lang.setnextdsr_succesful_dsr_msg="^2Se ha fijado el siguiente modo a: ^5@dsr"
        lang.setnextdsr_succesful_msg="^2Se ha fijado el siguiente modo a ^5@dsr ^2 y mapa a @map"
        lang.setnextdsr_error_write_msg="algo salio mal no se pudo actualizar el dsr"
        lang.setnextmap_error_msg="^1Error el formato es: ^2!setnextmap mapname"
        lang.setnextmap_error_map_msg="^1No se encontro ningun mapa con el nombre ^2@map"
        lang.setnextmap_succesful_msg="^2Se ha fijado el siguiente mapa a ^5@map"
        lang.dsr_succesful_msg="^2Cambiando en 3 segundos"
        lang.dsr_error_msg="^1Error el formato es: ^2!dsr namedsr,opcionalmap"
        lang.sayas_error_msg="^1Error el formato es: ^2!sayas name,mensaje"
        lang.sayas_error_player_msg="^1No se encontro jugador con el nombre: ^2@player"
        lang.sayas_error_nullmsg_msg="^1Error mensaje vacio"
        lang.putgroup_error_msg="^1Error el formato es: ^2!putgroup name,group"
        lang.error_noplayer_msg="^1No se encontro jugador con el nombre: ^2@player"
        lang.putgroup_error_group_msg="^1Error el usuario que intentas agregar ya esta en un grupo"
        lang.putgroup_error_nullgroup_msg="^1Error el nombre del grupo: ^2@group ^1no existe"
        lang.putgroup_succesful_admin_msg="^2Se ha registrado correctamente otro admin"
        lang.putgroup_succesful_all_msg="^:El usuario : ^;@player ^7 ha sido agregado al grupo: ^1@group"
        lang.ungroup_error_msg="^1Error el formato es: ^2!ungroup name"
        lang.ungroup_succesful_admin_msg="^1Se ha retirado con exito al usuario del grupo"
        lang.ungroup_error_no_player="^1No hay coincidencias de usuario en el grupo"
        lang.ungroup_error_no_admins="^1No hay ningun admin registrado"
        lang.jump_error_msg="^1Error el formato es: ^2!jump valor"
        lang.jump_error_nonumber_msg="^1Error el valor ingresado no se puede pasar a numero"
        lang.jump_succesful_default_msg="^1Si quieres regresar a la por defecto es 39"
        lang.jump_succesful_msg="Salto fijado a: ^3@valor"
        lang.givegun_error_msg="^1Error el formato es: ^2!givegun gunname"
        lang.givegun_error_noweapon_msg="^1No se encontro ningun arma con el nombre: ^2@gun"
        lang.warn_error_msg="^1Error el formato es: ^2!warn name,mensaje"
        lang.website_nosite_error_msg="^1No hay sitio web configurado"
        lang.unwarn_error_msg="^1Error el formato es: ^2!unwarn name"
        lang.unwarn_error_nowarns_msg="^1Actualmente no hay ningun warn en progreso"
        lang.unwarn_error_nowarnsforplayer_msg="^1El player que ingreso no tiene ninguna advertencia"
        lang.unwarn_succesful_msg="^1Al player que ingreso se le retiro con exito las advertencias"
        lang.map_error_msg="^1Error el formato es: ^2!map nombredelmapa"
        lang.map_error_nomap_msg="^1No se encontro ningun mapa con el nombre ^2@map"
        lang.map_succesful_msg="^7Cambiando mapa a ^3@map"
        lang.map_admin_msg="Mapa cambiado por @player"
        lang.rotate_succesful_msg="Mapa rotado por @player"
        lang.fastrestart_succesful_msg="Mapa reiniciado por @player"
        lang.tell_error_msg="^1Error el formato es: ^2!tell name,mensaje"
        lang.tell_error_nomsg="^1Error no puedes enviar un mensaje vacio"
        lang.tell_succesful_msg="^2Tu mensaje ha sido enviado correctamente"
        lang.disabled_update_msg="^1Desabilitado hasta proximo update"
        lang.tellall_error_msg="^1Error el formato es: ^2!tellall mensaje"
        lang.pm_error_msg="^1Error el formato es: ^2!pm name,mensaje"
        lang.pm_succesful_msg="^2Tu mensaje ha sido enviado correctamente"
        lang.pm_sintax_msg="^1De: @player ^7@msg"
        lang.scream_error_msg="^1Error el formato es: ^2!scream mensaje"
        lang.load_error_msg="^1Error el formato es: ^2!load nombredescript.lua"
        lang.load_error_nofile_msg="^1Error el archivo ^2@file ^1no existe"
        lang.load_succesful_msg="^2Exito comando ejecutado"
        lang.unload_error_msg="^1Error el formato es ^2!unload nombredescript.lua"
        lang.unload_succesful_msg="^2Exito el archivo se ha deshabilitado"
        lang.suicide_succesful_msg="^1Compa que paso por que quiere terminar asi u.u"
        lang.lastbans_sintax_msg="^2ID ^7@id^2, ^7@name ^2Ban por: ^7@admin ^2 Razon: ^7@reason ^2Termina ban el^7: @time"
        lang.dsrs_error_nodsr_msg="^1Al parecer no hay dsrs :V" -- comando dsrs solo funciona en servidores corriendo en windows
        lang.dsrs_noenabled_msg="^1No habilitada la vista de dsrs"
        lang.afkgod_succesful_msg="^3Los poderes son tuyos ahora :3"
        lang.setteam_error_msg="^1Error el formato es ^2!setteam nameplayer,allies|spectator|axis"
        lang.setteam_error_noteam_msg="^1Error el team no debe estar vacio"
        lang.setteam_error_team="^1El team debe ser allies|spectator|axis"
        lang.setteam_error_spec_player="^1El jugador que tratas de mover se encuentra en modo espectador"
        lang.setteam_player_team_error="^1El jugador ya esta en el team al que lo quieres mover"
        lang.setteam_succesful_msg="^3Se movio exitosamente al usuario"
        lang.kill_error_msg="^1Error el formato es: ^2!kill nameplayer"
        lang.kill_succesful_msg="^2Exito :V"
        lang.kill_error_insufficient_privileges="^1No puedes dar kill a un rango mayor al tuyo :s"
        lang.kill_intent_msg="^3El jugador :^1@name ^3ha intentado darte kill"
        lang.ac130_succesful_admin_msg="^2Se le concedio ac130 al usuario ^3@player"
        lang.ac130_succesful_sintax_msg="Se te ha concendido @gun por @admin"
        lang.addr_error_msg="^1Error el formato es: ^2!addr nuevaregla"
        lang.addr_succesful_msg="Se ha añadido correctamente la regla"
        lang.addr_error_file_msg="No se ha podido añadir la regla, algo salio mal"
        lang.showspot_error_nospots_msg="^1No hay ningun spot registrado"
        lang.showspot_sintax_msg="@name ^2Mapa ^7@map"
        lang.addspot_error_msg="^1Error el formato es: ^2!addspot name"
        lang.addspot_name_error_msg="^1Error ya existe un spot con el mismo nombre"
        lang.addspot_succesful_msg="^2Exito el spot se agrego correctamente"
        lang.addspot_error_file_msg="No se ha podido añadir el spot,algo salio mal" 
        lang.delspot_error_msg="^1Error el formato es: ^2!delspot name"
        lang.delspot_error_nospots="^1No hay ningun spot registrado"
        lang.delspot_error_name_spots="^1No hay coincidencias de spot"
        lang.delspot_succesful_spots="^1Se ha retirado con exito al spot"
        lang.spottp_error_msg="^1Error el formato es: ^2!spottp name"
        lang.spottp_error_nospots="^1No hay ningun spot registrado"
        lang.spottp_error_nomap_spot="Este spot no puede ser utilizado en este mapa"
        lang.spottp_error_name_spot="^1Error no existe ningun spot con ese nombre"
        lang.listmap_error_msg="^1Error el formato es: ^2!listmap all|normal|dlc1|dlc2|dlc3|dlc4|faceoff|terminal"
        lang.listmap_error_noformat="^1Error no existe ese tipo"
        lang.myip_sintax_msg="Tu direccion IP  es ^1@ip"
        lang.help_no_sintax_error="No hay sintax para mostrar"
        lang.teleport_error_msg="^1Error el formato es: ^2!teleport playerorigen,playerdestino"
        lang.teleport_succesful_sintax="^;@origen ^3 se ha teletransportado ha ^4@destino"  --Player origen , player destino
        lang.nextgame_error_msg="^1La rotacion esta deshabilitada en este server"
        lang.nextgame_succesful_msg="^2El proximo mapa es: ^7@map ^2el tipo de juego es: ^7@game"
        lang.vote_error_no_allowed="^1Error la votacion esta deshabilitada en este server"
        lang.vote_error_vote_in_progress="^1Error hay una votacion en ^2progreso"
        lang.vote_format_msg="Di ^4!y ^7para votar que si, di ^4!n ^7para votar no."
        lang.vote_cancel_msg="^3La votacion ha sido cancelada por: ^;@admin"
        lang.vote_insufficient_votes_msg="^1La votacion ha fallado por ^3Insufiencia de votos"
        lang.encuesta_error_msg="^1Error el formato es ^2!encuesta name,question"
        lang.encuesta_no_question="^1Error falta la pregunta para proceder"
        lang.encuesta_error_name="^1Error ya hay una encuesta con ese nombre"
        lang.encuesta_format_msg="^;@player ^3quiere saber: ^2@question"
        lang.encuesta_end_msg="^3La encuesta a terminado con los siguientes resultados ^2votos a favor ^;@y ^2votos en contra ^;@n"
        lang.encuesta_end_credits="^3Gracias por participar en encuestas by Mapa"
        lang.votekick_error_msg="^1Error el formato es: ^2!votekick name,razonopcional"
        lang.votekick_rank_admin_error="^1Error no puedes dar votekick a un administrador"
        lang.votekick_admin_msg="^3El usuario :^1@player ha intentado darte ^3votekick"
        lang.votekick_sintax_msg="^;@player ^3busca kickear a ^2@victim ^7por ^3@reason"
        lang.votemap_error_msg="^1Error el formato es: ^2!votemap nombredelmapa" 
        lang.votemap_error_actual_map="^1Error el mapa que desea cambiar ^2@map ^3es el actual!"
        lang.votemap_sintax_msg="^;@player ^3busca cambiar el mapa a ^2@map"
        lang.votemap_no_allowed_map="^1Error el mapa que quieres poner no esta permitido"
        lang.vote_error_vote_already_msg="^1Error tu ya has votado :s"
        lang.y_changed_msg="^;@player ^3a cambiado su voto a ^2yes"
        lang.y_succesful_msg="^;@player ^3a votado ^2yes"
        lang.n_changed_msg="^;@player ^3a cambiado su voto a ^2no"
        lang.n_succesful_msg="^;@player ^3a votado ^2no"
        lang.myguid_sintax_msg="Tu GUID es ^1@guid"
        lang.rotation_error_msg="No se tiene ninguna entry en el @file, dejando por default."
        lang.rotation_error_nodsr="El campo dsr esta vacio no se puede asignar :S, dejando por default."
        lang.rotation_error_no_match="El dsr especificado no esta en la carpeta admin :S, dejando por default."
        lang.rotation_error_no_maps="El campo maps esta vacio no se puede asignar :s, dejando por default"
        lang.rotation_error_no_match_map="No se encontro ningun mapa con el nombre especificado Dejando por default"
        lang.freeze_error_msg="^1Error el formato es: ^2!freeze name"
        lang.setalias_error_msg="^1Error el formato es: ^2!setalias name,newalias"
        lang.setalias_error_empty_alias="^1Error no puedes definir un alias vacio"
        lang.setalias_succesful_msg="^2Exito se ha agregado al usuario el alias"
        lang.setalias_error_no_file="^1Error no se pudo definir el alias porque el archivo no existe"
        lang.setalias_notification_msg="^2Se te ha concedido el alias ^7@alias"
        lang.setalias_error_len_msg="^1El alias tiene que ser menor a @len caracteres"
        lang.delalias_error_msg="^1Error el formato es: ^2!delalias name"
        lang.delalias_error_no_file="^1Error no se puede borrar un alias porque no hay archivo"
        lang.delalias_error_no_found="^1Error no se encontro @name dentro de los que tienen alias"
        lang.delalias_error_no_players="^1Error no hay ningun cliente registrado"
        lang.delalias_succesful_msg="^2Exito se ha retirado con exito el alias del cliente"
    return lang
end

--Seccion especial msg
--Si quieres o no que aparescan
config.endspree_enabled=true
config.knifekill=true
config.explosivekill=true
config.suicide=true
config.headshot=true
-->

--Seccion map
config.mapadminname= true

--Seccion General de ajustes
--Votar
config.voting_enabled=true
config.vote_time= 30
config.votekick_bantime= 10800
--Por default estan todos los mapas, si tu quieres solo permitir algunos o bloquear algunos, ponlos en los siguientes
config.vote_allowed_maps={}
config.vote_blocked_maps={}
    
--Warnings
config.warn_default_reason= "Advertencia"
config.warn_max_warnings= 3
config.warn_bantime= 7200

--Bans
config.ban_default_reason="Hacks"
config.ban_default_duration=10800

--Alias
config.alias_len_max=13

--Sensor de ping --aun en progreso
--config.pingcensor_enabled=true
--config.pingcensor_maxping=350
--config.pingcensor_maxwarns=3

--Mensajes por tiempo
config.tmes_enabled= true
config.tmes_interval= 40000
config.tmes_file= "mensajes_time.txt"

--Rotacion de mapas
config.maprot_enabled= true
config.maprot_file= "rotation.xml"

--Permitir balance matl
config.balbetter= true
config.baltime=30000    -- 1 segundo = 1000

--Permitir usar comando dsrs
config.dsrs_enabled= true

--Spree mensajes
config.spree_enabled= true
    
--Seccion por default, no dejar en blanco ni repetir nombres
config.rules= "rules.txt"

--Seccion rules EN uso exclusivo de clanes latinos para rules en
config.rules_en_enabled= true
config.rules_en= "rules-en.txt"

config.groups= "groups.xml"
config.commands= "commands.xml"
config.admins= "admins.dat"
config.clients= "clients.dat"

--Si quieres habilitar el guardado automatico en archivo de logconsole
config.logconsole_enabled= true
config.logconsole= "console.txt"

--Lo mismo con comandos 
config.logcommands_enabled= true
config.logcommands= "commands.txt"

config.bans= "bans.dat"
config.spots= "spots.txt"
-->

--Ajustes
config.sysprefix="^2[M^7AT^1L]:^7 "
config.clansite="www.facebook.com/ClanManiacos"
config.teamspeak="ip"
config.raidcall=""
config.discord=""
config.rulelistdelay=2000
config.kickthisguyhax=true

return config