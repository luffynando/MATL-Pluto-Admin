teambalance = {}
dictionary = require "scripts\\mp\\matl.dictionary"

function teambalance:setbalance(gametype)
	local flag = (not dictionary.gameisTeamBased(gametype)) or (gametype == "infect")
	if flag== true then
		util.chatPrint("El gametype es : ".. gametype)
	end
	if (not flag) then
		local list1 ={}
		local list2 = {}
		for p in util.iterPlayers() do
			local flag2 = p.sessionteam == "allies"
			if (flag2) then
				list2[#list2+1]= p
			else
				local flag3 = p.sessionteam == "axis"
				if (flag3) then
					list1[#list1+1]= p
				end
			end
		end
		local num = math.abs(#list1 - #list2) / 2 ;
		local flag4 = (#list2 - #list1 >= 2) or (#list2 - #list1 <= 2);
		if (flag4) then
            util.chatPrint("^2Equipo ^3Balanceado!")
		end
		local flag5 = #list2 > #list1;
        if (flag5) then
			table.sort(list2, function(a, b) return tonumber(a.pers["kills"]) > tonumber(b.pers["kills"]) end)
            for i=1,num do
                teambalance:ChangePlayerTeam(list2[i], "axis")
            end
		else
			table.sort(list1, function(a, b) return tonumber(a.pers["kills"]) > tonumber(b.pers["kills"]) end)
            for i=1,num do
                teambalance:ChangePlayerTeam(list1[i], "allies")
            end
		end
	end
end

function orderByLiveorDead(list)
	local listbinari = {}
	for i in pairs(list) do
		if gsc.isalive(list[i]) then
			listbinari[#listbinari+1] = {list[i],1}
		else
			listbinari[#listbinari+1] = {list[i],0}
		end
	end
	table.sort(listbinari, function(a, b) return a[2] > b[2] end)
	return listbinari
end

function teambalance:ChangePlayerTeam(player, NewTeam)
	player.sessionteam = NewTeam
	util.notifyObject(player,"menuresponse","team_marinesopfor",NewTeam)
end

return teambalance