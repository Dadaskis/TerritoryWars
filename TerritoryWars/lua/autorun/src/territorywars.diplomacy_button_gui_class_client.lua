local TW = TerritoryWars
local TWUtil = TW.Utilities
local group 

local diplomacyButton = {}

AccessorFunc(diplomacyButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(diplomacyButton, "ChoosedPanel", "ChoosedPanel")

function diplomacyButton:Init()
	group = TW.Group
	self.ID = 10
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Diplomacy)
	self:SetIcon("icon16/report_link.png")
end

function diplomacyButton:DoClick() 
	net.Start("TerritoryWars.GetGroupNames")
	net.SendToServer()

	net.Start("TerritoryWars.GetGroup")
	net.SendToServer()

	timer.Simple(LocalPlayer():Ping() / 500, function()
		self.ChoosedPanel:Clear()
		local scrollPanel = vgui.Create("TerritoryWars.ScrollPanelBase", self.ChoosedPanel)
		scrollPanel:Dock(FILL)
	
		for index, groupName in pairs(TW.GroupNames) do 
			if groupName ~= group.Name then 
				local lastDiplomacyReceived = 0	
				local panel = vgui.Create("TerritoryWars.PanelBase", scrollPanel:GetCanvas())
				panel:Dock(TOP)
				panel:InvalidateParent()
				local X = select(panel:GetSize(), 1)
				panel:SetSize(X, ScrH() * 0.06)

				local horizontalScroller = vgui.Create("DHorizontalScroller", panel)
				horizontalScroller.Paint = TW.PanelPaint
				horizontalScroller:Dock(FILL)

				local nameLabel = vgui.Create("TerritoryWars.LabelBase", horizontalScroller)
				nameLabel:SetFontInternal("TW.Font" .. ScrH())
				nameLabel:SetText(groupName)
				nameLabel:SetColor(TW.GroupColors[groupName])
				nameLabel:SizeToContents()
				nameLabel:Dock(LEFT)
				nameLabel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
				horizontalScroller:AddPanel(nameLabel)

				local statusLabel = vgui.Create("TerritoryWars.LabelBase", horizontalScroller)
				statusLabel:SetFontInternal("TW.Font" .. ScrH())
				statusLabel:Dock(LEFT)
				statusLabel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
				function statusLabel:Think() 
					if lastDiplomacyReceived < TW.DiplomacyReceived then
						lastDiplomacyReceived = TW.DiplomacyReceived
						if group.Diplomacy[groupName] then
							if group.Diplomacy[groupName] > -5000 and group.Diplomacy[groupName] < 5000 then
								statusLabel:SetText("  " .. TW.Labels.Neutral)
								statusLabel:SetColor(Color(200, 200, 0))
							elseif group.Diplomacy[groupName] <= -5000 then
								statusLabel:SetText("  " .. TW.Labels.Enemy)
								statusLabel:SetColor(Color(200, 0, 0))
							elseif group.Diplomacy[groupName] >= 5000 then
								statusLabel:SetText("  " .. TW.Labels.Ally)
								statusLabel:SetColor(Color(0, 200, 0))
							end
						else
							statusLabel:SetText("  " .. TW.Labels.Neutral)
							statusLabel:SetColor(Color(200, 200, 0))
						end
						statusLabel:SizeToContents()
						--statusLabel:InvalidateParent()
					end
				end
				horizontalScroller:AddPanel(statusLabel)
				
				if LocalPlayer():SteamID() == group.LeaderSteamID or LocalPlayer():TWGetGroupRole().Permisions["Diplomacy"] then
					local settingsButton = vgui.Create("DImageButton", horizontalScroller)
					settingsButton:SetImage("icon16/cog.png")
					settingsButton:SetStretchToFit(false)
					settingsButton:Dock(LEFT)
					settingsButton:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
					settingsButton:InvalidateParent()
					TWUtil:SetPanelSize(0.08, 0.08, settingsButton)
					horizontalScroller:AddPanel(settingsButton)

					function settingsButton:DoClick() 
						local menu = DermaMenu()

						local enemyButton = menu:AddOption(TW.Labels.Enemy)
						local neutralButton = menu:AddOption(TW.Labels.Neutral)
						local allyButton = menu:AddOption(TW.Labels.Ally)

						function enemyButton:DoClick() 
							local window = vgui.Create("TerritoryWars.DiplomacyReasonWindow")
							function window:OnApply(reasonText) 
								net.Start("TerritoryWars.SetDiplomacyEnemy")
									net.WriteString(groupName)
									net.WriteString(reasonText)
								net.SendToServer()
							end
						end

						function neutralButton:DoClick() 
							local window = vgui.Create("TerritoryWars.DiplomacyReasonWindow")
							function window:OnApply(reasonText) 
								net.Start("TerritoryWars.SetDiplomacyNeutral")
									net.WriteString(groupName)
									net.WriteString(reasonText)
								net.SendToServer()
							end
						end

						function allyButton:DoClick() 
							local window = vgui.Create("TerritoryWars.DiplomacyReasonWindow")
							function window:OnApply(reasonText) 
								net.Start("TerritoryWars.SetDiplomacyAlly")
									net.WriteString(groupName)
									net.WriteString(reasonText)
								net.SendToServer()
							end
						end

						menu:Open()
					end
				end
			end
		end
	end)
end

vgui.Register("TerritoryWars.DiplomacyButton", diplomacyButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddDiplomacyButton", function(groupWindow) 
	local diplomacyMenu = vgui.Create("TerritoryWars.DiplomacyButton")
	diplomacyMenu:SetChoosePanel(groupWindow:GetChoosePanel())
	diplomacyMenu:SetChoosedPanel(groupWindow:GetChoosedPanel())
	groupWindow:AddToChoosePanel(diplomacyMenu)
end)