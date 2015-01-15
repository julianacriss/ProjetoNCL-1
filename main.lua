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
      --print("--> ARQUIVO EXISTE!")
      io.input(arquivo)
      local content = io.read()
      if (content ~= nil) then
          print("--> CONTENT: ", content)
          local xmlhandler = simpleTreeHandler()
          local xmlparser = xmlParser(xmlhandler)
          xmlparser:parse(content)                
          if (xmlhandler.root['aui:HandGesture']._attr.gesture == 'hand_left') then
            evt1.action = 'start'; event.post(evt1)
            evt1.action = 'stop' ; event.post(evt1)
          elseif (xmlhandler.root['aui:HandGesture']._attr.gesture == 'hand_right') then
            evt2.action = 'start'; event.post(evt2)
            evt2.action = 'stop' ; event.post(evt2)
          end
          print("antes do close")
        io.close(arquivo)
      print("depois do close e antes do remove")
      os.remove(path)
      print("depois do remove")
      end -- if content
      
    end --if arquivo
    
  end -- while
end -- function

local function sinal2()
  local evt = {
    class = 'ncl',
    type  = 'attribution',
    name  = 'sinal2',
    value = 2,
  }
  evt.action = 'start'; event.post(evt)
  evt.action = 'stop' ; event.post(evt)
end

event.timer(2000, sinal1)
event.timer(5000, sinal2)