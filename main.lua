dofile("lib/LuaXML/xml.lua")
dofile("lib/LuaXML/handler.lua")

local function sinal1()
  local evt1 = {
    class = 'ncl',
    type  = 'attribution',
    name  = 'sinal1',
    value = 1,
  }
  
  local evt2 = {
    class = 'ncl',
    type  = 'attribution',
    name  = 'sinal2',
    value = 2,
  }

  while true do
    local path = "/misc/ncl30/mpeg-u.xml"
    local arquivo = io.open(path, "r")
    if arquivo then
      io.input(arquivo)
      local content = io.read()
      if (content ~= nil) then
          print("--> CONTENT: ", content)
          local xmlhandler = simpleTreeHandler()
          local xmlparser = xmlParser(xmlhandler)
          xmlparser:parse(content)                
          if (xmlhandler.root['aui:HandGesture']._attr.gesture == 'slap_left') then
            evt1.action = 'start'; event.post(evt1)
            evt1.action = 'stop' ; event.post(evt1)
          elseif (xmlhandler.root['aui:HandGesture']._attr.gesture == 'slap_right') then
            evt2.action = 'start'; event.post(evt2)
            evt2.action = 'stop' ; event.post(evt2)
          end
        io.close(arquivo)
      os.remove(path)
      end -- if content    
    end --if arquivo
  end -- while
end -- function


event.timer(0, sinal1)