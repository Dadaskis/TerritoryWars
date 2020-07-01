local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local infoButton = {}

AccessorFunc(infoButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(infoButton, "ChoosedPanel", "ChoosedPanel")

function infoButton:Init() 
	group = TW.Group
	self.ID = 0
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.GroupInfo)
	self:SetIcon("icon16/table.png")
end

local function TWFormatTime(time) 
	local result = ""
	if time.h < 10 then
		result = result .. "0"
	end
	result = result .. time.h .. ":"
	if time.m < 10 then
		result = result .. "0"
	end
	result = result .. time.m .. ":"
	if time.s < 10 then
		result = result .. "0"
	end
	result = result .. time.s
	return result
end

function infoButton:DoClick() 
	self.ChoosedPanel:Clear()

	local scrollPanelBase = vgui.Create("TerritoryWars.ScrollPanelBase", self.ChoosedPanel)
	scrollPanelBase:Dock(FILL)

	local nameLabel = vgui.Create("TerritoryWars.LabelBase", scrollPanelBase)
	nameLabel:SetText(group.Name)
	nameLabel:SetFont("TW.Font" .. ScrH())
	nameLabel:SizeToContents()
	nameLabel:SetColor(group.Color)
	nameLabel:Dock(TOP)
	nameLabel:SetContentAlignment(5)

	local remainsLabel = vgui.Create("TerritoryWars.LabelBase", scrollPanelBase)
	remainsLabel:SetFont("TW.Font" .. ScrH())
	remainsLabel:SetText(TW.Labels.RemainsToDeletingGroup)
	remainsLabel:SizeToContents()
	remainsLabel:SetContentAlignment(5)
	remainsLabel:Dock(TOP)

	local lifeTime = vgui.Create("TerritoryWars.LabelBase", scrollPanelBase)
	local time = string.FormattedTime(TW.Group.LifeTime - os.time())
	lifeTime:SetText(TWFormatTime(time))
	lifeTime:SetFont("TW.Font" .. ScrH())
	lifeTime:SizeToContents()
	lifeTime:SetContentAlignment(5)
	lifeTime:Dock(TOP)

	local panel = vgui.Create("TerritoryWars.PanelBase", scrollPanelBase)
	panel:Dock(TOP)
	panel:InvalidateParent()
	panel:SetPos(X, Y)
	panel:SetSize(select(panel:GetSize(), 1), (ScrH() * 0.06) * (table.Count(TW.Group.Members) + 1))

	local editMOTD
	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID or LocalPlayer():TWGetGroupRole().Permisions["MOTD"] then
		editMOTD = vgui.Create("TerritoryWars.ButtonBase", scrollPanelBase)
		editMOTD:SetText(TW.Labels.EditMOTD)
		editMOTD:SetFont("TW.SFont" .. ScrH())
		editMOTD:Dock(TOP)
		editMOTD:DockMargin(ScrW() * 0.01, ScrH() * 0.05, ScrW() * 0.01, ScrH() * 0.05)
	end
	local changing = false

	local MOTD = vgui.Create("DTextEntry", scrollPanelBase)
	MOTD:SetText(TW.Group.MOTD)
	MOTD:SetFont("TW.SFont" .. ScrH())
	MOTD:SetDrawBackground(false)
	MOTD:SetTextColor(TW.TextColor)
	MOTD:SetMultiline(true)
	MOTD:SetKeyboardInputEnabled(false)
	MOTD:SetVerticalScrollbarEnabled(true)
	MOTD:Dock(TOP)
	MOTD:DockMargin(ScrW() * 0.025, ScrH() * 0.005, ScrW() * 0.025, ScrH() * 0.005)
	MOTD:InvalidateParent()
	local X = MOTD:GetSize()
	MOTD:SetSize(X, ScrH() * 0.5)

	if editMOTD then
		function editMOTD:DoClick() 
			if not changing then
				MOTD:SetKeyboardInputEnabled(true)
				MOTD:SetDrawBackground(true)
				editMOTD:SetText(TW.Labels.Accept)
			else
				MOTD:SetKeyboardInputEnabled(false)
				MOTD:SetDrawBackground(false)
				editMOTD:SetText(TW.Labels.EditMOTD)
				net.Start("TerritoryWars.ChangeMOTD")
					net.WriteString(MOTD:GetText())
				net.SendToServer()
			end

			changing = not changing
		end
	end

	local MOTDReceived = 0
	local lastMembersReceived = 0
	function self.Think() 
		if IsValid(lifeTime) and TW.Group then
			local time = string.FormattedTime(TW.Group.LifeTime - os.time())
			lifeTime:SetText(TWFormatTime(time))
			lifeTime:SizeToContents()
		end
		if not changing and (MOTDReceived < TW.MOTDReceived) then
			MOTDReceived = TW.MOTDReceived
			MOTD:SetText(TW.Group.MOTD)
		end
		if not changing and (lastMembersReceived < TW.MembersReceived) then
			lastMembersReceived = TW.MembersReceived
			if panel and IsValid(panel) then
				panel:Clear()
				for SteamID, member in pairs(group.Members) do
					local panel = vgui.Create("TerritoryWars.MemberPanel", panel)
					panel:SetMember(member, SteamID)
				end
			end
		end
	end
end

vgui.Register("TerritoryWars.GroupInfoButton", infoButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGroupInfoButton", function(groupWindow) 
	local groupInfo = vgui.Create("TerritoryWars.GroupInfoButton")
	groupInfo:SetChoosePanel(groupWindow:GetChoosePanel())
	groupInfo:SetChoosedPanel(groupWindow:GetChoosedPanel())
	groupWindow:AddToChoosePanel(groupInfo)
	groupInfo:DoClick()
end)