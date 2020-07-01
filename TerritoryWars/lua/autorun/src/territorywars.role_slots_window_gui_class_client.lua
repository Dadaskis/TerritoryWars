local TW = TerritoryWars
local TWUtil = TW.Utilities

local SlotsWindow = {}

function SlotsWindow:Think() 
	if self.LastRolesReceived < TW.RolesReceived then
		self.LastRolesReceived = TW.RolesReceived
		local role = TW.Group.Roles[self.RoleName]
		self.SlotsLabel:SetText(TW.Labels.Slots .. " " .. role.CurrentSlots .. "/" .. role.MaxSlots)
		self.SlotsLabel:SizeToContents()
		self.PriceLabel:SetText(TW.Labels.Price .. " " .. TW.Labels.For .. " " 
			.. TW.SlotAddCount .. " " .. TW.Labels.Slots2 .. ": " .. role.SlotPrice)
		self.PriceLabel:SizeToContents()
	end
end

function SlotsWindow:SetRoleName(roleName) 
	self.RoleName = roleName
end

function SlotsWindow:Init() 
	self:SetSize(ScrW() * 0.3, ScrH() * 0.2)
	self:Center()
	self:MakePopup()

	self.LastRolesReceived = 0
	self.SlotsLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.SlotsLabel:SetFontInternal("TW.Font" .. ScrH())
	self.SlotsLabel:SetText(TW.Labels.Slots .. " 0/0")
	self.SlotsLabel:SizeToContents()
	self.SlotsLabel:Dock(TOP)
	self.SlotsLabel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
	self.SlotsLabel:SetContentAlignment(5)

	self.PriceLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.PriceLabel:SetFontInternal("TW.SFont" .. ScrH())
	self.PriceLabel:SetText(TW.Labels.Price .. " " .. TW.Labels.For .. " " 
		.. TW.SlotAddCount .. " " .. TW.Labels.Slots2 .. ": 0")
	self.PriceLabel:SizeToContents()
	self.PriceLabel:Dock(TOP)
	self.PriceLabel:SetContentAlignment(5)

	self.BuyButton = vgui.Create("TerritoryWars.ButtonBase", self)
	self.BuyButton:SetFontInternal("TW.SFont" .. ScrH())
	self.BuyButton:SetText(TW.Labels.Buy)
	self.BuyButton:SetImage("icon16/add.png")
	self.BuyButton:Dock(TOP)
	self.BuyButton:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
	function self.BuyButton.DoClick() 
		net.Start("TerritoryWars.RoleSlotUpgrade")
			net.WriteString(self.RoleName)
		net.SendToServer()
	end
end

vgui.Register("TerritoryWars.RoleSlotsWindow", SlotsWindow, "TerritoryWars.WindowBase")