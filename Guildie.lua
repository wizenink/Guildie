
local guildie = {
	visible = false,
	emabled = false
}


function SlashCmdList.GUILDIE(msg,editbox)
	if guildie.enabled then
		for i=1,10 do
			for y=1,100 do
				if GetGuildBankItemLink(i,y) == nil then
				else 
					print(GetGuildBankItemLink(i,y))
				end
			end
		end
	else
		print("Abre el banco de hermandad para utlizar esta característica")
	end
end


Guildie = LibStub("AceAddon-3.0"):NewAddon("Guildie", "AceConsole-3.0","AceEvent-3.0")

local AceGUI = LibStub("AceGUI-3.0")
frame = nil

function CreateUIFrame()
	frame = AceGUI:Create("Frame")
	frame:SetTitle("Guildie - 1.0.0")
	frame:SetStatusText("Guildie- Blackmoon Guild Bank Management System")
	frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame:SetLayout("Flow")

	local editbox = AceGUI:Create("MultiLineEditBox")
	editbox:SetFullWidth(true)
	
	editbox:SetNumLines(10)
  	editbox:SetHeight(170)
	frame:AddChild(editbox)

	local button = AceGUI:Create("Button")
	button:SetText("Export")
	button:SetWidth(200)
	button:SetCallback("OnClick",function(widget)
		itemString = ""
		items = {}
		for i=1,10 do
			for y=1,100 do
				if GetGuildBankItemLink(i,y) == nil
				then
				else
					texture, itemCount, locked, isFiltered, quality = GetGuildBankItemInfo(i,y)
					itemName = GetGuildBankItemLink(i,y)
					if items[itemName] == nil then
						items[itemName] = itemCount
					else
						items[itemName] = items[itemName] + itemCount
					end
				end
			end
		end
		for k,v in pairs(items) do
			itemString = itemString .. "\"" .. k .. "\"" .. "," .. v .. ";"
		end
		editbox:SetText(itemString)
	end)
	frame:AddChild(button)
end

function Guildie:OnInitialize()
    -- Called when the addon is loaded
end

function Guildie:OnEnable()
	-- Called when the addon is enabled
	
	self:RegisterEvent("GUILDBANKFRAME_OPENED")
	self:RegisterEvent("GUILDBANKFRAME_CLOSED")
end

function Guildie:OnDisable()
	-- Called when the addon is disabled
end

function Guildie:GUILDBANKFRAME_OPENED()
	self:Print("Guild Bank opened!")
	CreateUIFrame()
end

function Guildie:GUILDBANKFRAME_CLOSED()
	self:Print("Guild Bank closed!")
	AceGUI:Release(frame)
	frame = nil
end
