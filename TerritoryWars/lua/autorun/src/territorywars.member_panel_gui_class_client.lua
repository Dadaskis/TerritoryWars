local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local Panel = {}

AccessorFunc(Panel, "Member", "Member")

function Panel:SetMember(member, SteamID) 
	group = TW.Group
	self.Member = member
	self:SetTooltip(TW.Labels.TerritoriesCaptured .. ": " .. member.TerritoriesCaptured .. ".")

	self.NameLabel:SetText(member.Nick)
	self.NameLabel:DockPadding(ScrW() * 0.01, 0, ScrW() * 0.01, 0)
	self.NameLabel:DockMargin(ScrW() * 0.01, 0, ScrW() * 0.01, 0)
	self.NameLabel:SizeToContents()
	local X, Y = self.NameLabel:GetSize()
	self.NameLabel:InvalidateParent()
	self.NameLabel:SetSize(X * 1.3, Y)
	if member.SteamID == group.LeaderSteamID then
		self.NameLabel:SetColor(Color(255, 0, 0))
		self.NameLabel:SetMouseInputEnabled(true)
		self.NameLabel:SetTooltip(TW.Labels.ThisIsLeader)
	end

	self.PlayerAvatar:SetSteamID(util.SteamIDTo64(SteamID), 128)

	if group.Roles[member.Role] then
		self.RoleLabel:SetText(member.Role)
		self.RoleLabel:SizeToContents()
		self.RoleLabel:SetColor(group.Roles[member.Role].Color)
	else
		self.RoleLabel:SetText(group.Roles[group.NoviceRole].Name)
		self.RoleLabel:SizeToContents()
		self.RoleLabel:SetColor(group.Roles[group.NoviceRole].Color)
	end

	if LocalPlayer():SteamID() == group.LeaderSteamID or
			LocalPlayer():TWGetGroupRole().Permisions["Role changing"] then 
		local settingsButton = vgui.Create("DImageButton", self)
		settingsButton:SetImage("icon16/cog.png")
		settingsButton:SetStretchToFit(false)
		settingsButton:Dock(RIGHT)
		settingsButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, settingsButton)
		settingsButton:SetMouseInputEnabled(true)
		function settingsButton.DoClick() 
			local menu = DermaMenu() 
			for _, role in pairs(group.Roles) do 
				menu:AddOption(role.Name, function() 
					net.Start("TerritoryWars.ChangeMemberRole")	
						net.WriteString(SteamID)
						net.WriteString(role.Name)
					net.SendToServer()
					--self.RoleLabel:SetText(role.Name)
					--self.RoleLabel:SetColor(role.Color)
					self.RoleLabel:SizeToContents()
				end)
			end
			menu:Open()
		end
	end

	if self.Member.SteamID ~= LocalPlayer():SteamID() and
			self.Member.SteamID ~= group.LeaderSteamID then
		if LocalPlayer():SteamID() == group.LeaderSteamID or
				LocalPlayer():TWGetGroupRole().Permisions["Kick"] then
			local kickButton = vgui.Create("DImageButton", self)
			kickButton:SetImage("icon16/group_delete.png")
			kickButton:SetStretchToFit(false)
			kickButton:Dock(RIGHT)
			kickButton:InvalidateParent()
			TWUtil:SetPanelSize(0.02, 0.02, kickButton)
			kickButton:SetMouseInputEnabled(true)
			function kickButton.DoClick() 
				local frame = vgui.Create("TerritoryWars.WindowBase")
				frame:SetSize(ScrW() * 0.4, ScrH() * 0.2)
				frame:Center()
				frame:MakePopup()

				local label = vgui.Create("TerritoryWars.LabelBase", frame)
				label:Dock(TOP)
				label:SetContentAlignment(5)
				label:SetFontInternal("TW.SFont" .. ScrH())
				label:SetText(TW.Labels.Kick .. " " .. self.Member.Nick .. "?")
				label:SizeToContents()

				local answerPanel = vgui.Create("TerritoryWars.PanelBase", frame)
				answerPanel:Dock(BOTTOM)

				local yesButton = vgui.Create("TerritoryWars.ButtonBase", answerPanel)
				yesButton:SetFontInternal("TW.SFont" .. ScrH())
				yesButton:SetText(TW.Labels.Yes)
				yesButton:Dock(LEFT)
				function yesButton.DoClick() 
					net.Start("TerritoryWars.Kick")
						net.WriteString(self.Member.SteamID)
					net.SendToServer()
					frame:Close()
				end

				local noButton = vgui.Create("TerritoryWars.ButtonBase", answerPanel)
				noButton:SetFontInternal("TW.SFont" .. ScrH())
				noButton:SetText(TW.Labels.No)
				noButton:Dock(RIGHT)
				function noButton.DoClick() 
					frame:Close()
				end
			end
		end
	end
end

function Panel:Paint(width, height) 
	draw.RoundedBox(0, 0, 0, width, height, Color(29, 29, 29))
end

function Panel:Init() 
	group = TW.Group
	self:SetMouseInputEnabled(true)
	self:Dock(TOP)
	self:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
	self:InvalidateLayout()
	local X, Y = self:GetSize()
	self:SetSize(X, ScrH() * 0.06)

	self.PlayerAvatar = vgui.Create("AvatarImage", self)
	self.PlayerAvatar:Dock(LEFT)
	self.PlayerAvatar:InvalidateParent()
	local X, Y = self:GetSize()
	self.PlayerAvatar:SetSize(Y, Y)

	self.HorizontalScroll = vgui.Create("DHorizontalScroller", self)
	--self.HorizontalScroll.Paint = TW.PanelPaint
	self.HorizontalScroll:Dock(LEFT)

	self.NameLabel = vgui.Create("TerritoryWars.LabelBase", self.HorizontalScroll)
	self.NameLabel:SetText("IDK... why are you reading this?...")
	self.NameLabel:SetFontInternal("TW.Font" .. ScrH())
	self.NameLabel:SizeToContents()
	self.NameLabel:Dock(LEFT)
	self.HorizontalScroll:AddPanel(self.NameLabel)
	self.HorizontalScroll:InvalidateParent()
	TWUtil:SetPanelSize(0.37, 0.06, self.HorizontalScroll)

	self.RoleLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.RoleLabel:SetFontInternal("TW.Font" .. ScrH())
	self.RoleLabel:Dock(RIGHT)
end

vgui.Register("TerritoryWars.MemberPanel", Panel, "TerritoryWars.PanelBase")

