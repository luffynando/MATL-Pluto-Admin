tools = {}

function tools:ToXmlString(value)
	value = string.gsub (value, "&", "&amp;");		
	value = string.gsub (value, "<", "&lt;");		
	value = string.gsub (value, ">", "&gt;");		
	value = string.gsub (value, "\"", "&quot;");
   	value = string.gsub(value, "([^%w%&%;%p%\t% ])",
       	function (c) 
       		return string.format("&#x%X;", string.byte(c)) 
       	end);
	return value;
end

function tools:FromXmlString(value)
  	value = string.gsub(value, "&#x([%x]+)%;",
      	function(h) 
      		return string.char(tonumber(h,16)) 
      	end);
  	value = string.gsub(value, "&#([0-9]+)%;",
      	function(h) 
      		return string.char(tonumber(h,10)) 
      	end);
	value = string.gsub (value, "&quot;", "\"");
	value = string.gsub (value, "&apos;", "'");
	value = string.gsub (value, "&gt;", ">");
	value = string.gsub (value, "&lt;", "<");
	value = string.gsub (value, "&amp;", "&");
	return value;
end

function tools:ParseArgs(s)
  local arg = {}
  string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
    	arg[w] = self:FromXmlString(a);
  	end)
  return arg
end

function tools:ParseXmlText(xmlText)
  local stack = {}
  local top = {Name=nil,Value=nil,Attributes={},ChildNodes={}}
  table.insert(stack, top)
  local ni,c,label,xarg, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,xarg, empty = string.find(xmlText, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(xmlText, i, ni-1);
    if not string.find(text, "^%s*$") then
      top.Value=(top.Value or "")..self:FromXmlString(text);
    end
    if empty == "/" then  -- empty element tag
      table.insert(top.ChildNodes, {Name=label,Value=nil,Attributes=self:ParseArgs(xarg),ChildNodes={}})
    elseif c == "" then   -- start tag
      top = {Name=label, Value=nil, Attributes=self:ParseArgs(xarg), ChildNodes={}}
      table.insert(stack, top)   -- new level
    else  -- end tag
      local toclose = table.remove(stack)  -- remove top
      top = stack[#stack]
      if #stack < 1 then
        print("ToolParser: nothing to close with "..label)
      end
      if toclose.Name ~= label then
        print("ToolParser: trying to close "..toclose.Name.." with "..label)
      end
      table.insert(top.ChildNodes, toclose)
    end
    i = j+1
  end
  local text = string.sub(xmlText, i);
  if not string.find(text, "^%s*$") then
      stack[#stack].Value=(stack[#stack].Value or "")..self:FromXmlString(text);
  end
  if #stack > 1 then
    print("ToolParser: unclosed "..stack[stack.n].Name)
  end
  return stack[1].ChildNodes[1];
end

function tools:ParseXmlFile(xmlFileName)
	local hFile,err = io.open(xmlFileName,"r");
	if (not err) then
		local xmlText=hFile:read("*a"); -- read file content
		io.close(hFile);
        return self:ParseXmlText(xmlText),nil;
	else
		return nil,err;
	end
end

function string:split(sSeparator, nMax, bRegexp)
    if sSeparator == '' then
        sSeparator = ','
    end

    if nMax and nMax < 1 then
        nMax = nil
    end

    local aRecord = {}

    if self:len() > 0 then
        local bPlain = not bRegexp
        nMax = nMax or -1

        local nField, nStart = 1, 1
        local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
        while nFirst and nMax ~= 0 do
            aRecord[nField] = self:sub(nStart, nFirst-1)
            nField = nField+1
            nStart = nLast+1
            nFirst,nLast = self:find(sSeparator, nStart, bPlain)
            nMax = nMax-1
        end
        aRecord[nField] = self:sub(nStart)
    end

    return aRecord
end

function tools:readd(path, sep, tonum, null)
    tonum = tonum or true
    sep = sep or ','
    null = null or ''
    local csvFile = {}
    local file = assert(io.open(path, "r"))
    for line in file:lines() do
        fields = line:split(sep)
        table.insert(csvFile, fields)
    end
    file:close()
    return csvFile
end

function tools:writed(path, data, sep)
    sep = sep or ','
    local file = assert(io.open(path, "w"))
    for i=1,#data do
        for j=1,#data[i] do
            if j>1 then file:write(sep) end
            file:write(data[i][j])
        end
        file:write('\n')
    end
    file:close()
end

function tools:dump(_class, no_func, depth)
	if(not _class) then 
		print("nil");
		return;
	end
	
	if(depth==nil) then depth=0; end
	local str="";
	for n=0,depth,1 do
		str=str.."\t";
	end
    
	print(str.."["..type(_class).."]");
	print(str.."{");
    
	for i,field in pairs(_class) do
		if(type(field)=="table") then
			print(str.."\t"..tostring(i).." =");
			tools:dump(field, no_func, depth+1);
		else 
			if(type(field)=="number") then
				print(str.."\t"..tostring(i).."="..field);
			elseif(type(field) == "string") then
				print(str.."\t"..tostring(i).."=".."\""..field.."\"");
			elseif(type(field) == "boolean") then
				print(str.."\t"..tostring(i).."=".."\""..tostring(field).."\"");
			else
				if(not no_func)then
					if(type(field)=="function")then
						print(str.."\t"..tostring(i).."()");
					else
						print(str.."\t"..tostring(i).."<userdata=["..type(field).."]>");
					end
				end
			end
		end
	end
	print(str.."}");
end

function tools:file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function tools:lines_from(file)
    if not tools:file_exists(file) then 
      print("No hay archivo")
      return {} 
    end
    lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

function tools:dir_exists(file)
	local f= io.open(file, "w")
	if f then f:close() end
	return f ~= nil
end

return tools;