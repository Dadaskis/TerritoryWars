local TW = TerritoryWars
local TWUtil = TW.Utilities

local QuestButton = {}

AccessorFunc(QuestButton, "ActivePanel", "ActivePanel")
AccessorFunc(QuestButton, "AvailablePanel", "AvailablePanel")
AccessorFunc(QuestButton, "ChoosedPanel", "ChoosedPanel")

function QuestButton:Init2() end

function QuestButton:Init() 
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText("Lalalalal")
	self:Dock(TOP)
	self:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
	self.AcceptButtonEnabled = true
	self.GroupUpgradesReceived = 0
end

function QuestButton:SetQuestByIndex(questIndex) 
	self.QuestIndex = questIndex
	self.Quest = TW.Quests[questIndex]
end

function QuestButton:GetDescriptionLabel()
	return self.DescriptionLabel
end

function QuestButton:QuestPanelChanged() end

function QuestButton:AddRewardText(orMore)
	local reward = self.Quest.PointsReward or "???"
	if isnumber(reward) and TW.GroupUpgrading and TW.GroupQuestPointsRewardUpgradeEnabled then
		reward = (reward * (1 + ((TW.GroupQuestPointsRewardUpgradeProcents / 100) * TW.GroupUpgrades["QuestPointsReward"])))
	end
	if orMore then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. 
			TW.Labels.Reward .. ": " .. TW.Labels.Minimum .. " " .. (reward or "???") .. " " .. TW.Labels.Points2 .. "."
		)
	else
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. 
			TW.Labels.Reward .. ": " .. (reward or "???") .. " " .. TW.Labels.Points2 .. "."
		)
	end
end

function QuestButton:SendSocketToActivate(index) 
	net.Start("TerritoryWars.ActivateQuest")
		net.WriteInt(index, 32)
	net.SendToServer()
end

local function TWFormatTime(time) 
	local time = string.FormattedTime(time)
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

function QuestButton:DoClick() 
	self.ChoosedPanel:Clear()

	self.TimerPanel = vgui.Create("TerritoryWars.PanelBase", self.ChoosedPanel)
	self.TimerPanel:Dock(TOP)

	self.TimerLabel = vgui.Create("TerritoryWars.LabelBase", self.TimerPanel)
	self.TimerLabel:SetFont("TW.Font" .. ScrH())
	self.TimerLabel:SetText("---")
	self.TimerLabel:Dock(FILL)
	self.TimerLabel:SetContentAlignment(5)

	self.DescriptionLabel = vgui.Create("DTextEntry", self.ChoosedPanel)
	self.DescriptionLabel:SetEditable(false)
	self.DescriptionLabel:SetMultiline(true)
	self.DescriptionLabel:SetTextColor(TW.TextColor)
	self.DescriptionLabel:SetDrawBackground(false)
	self.DescriptionLabel:SetFont("TW.SFont" .. ScrH())
	self.DescriptionLabel:SetText("You need to do nothing ^_^")
	self.DescriptionLabel:Dock(TOP)
	self.DescriptionLabel:InvalidateParent()
	local X, Y = self.DescriptionLabel:GetSize()
	self.DescriptionLabel:SetSize(X, ScrH() * 0.7)

	local index = self.QuestIndex
	local quest = self.Quest
	local sendSocket = self.SendSocketToActivate

	self.TimerPanel.Think = function() 
		if quest.Active and quest.HaveTime then
			local text = TWFormatTime(quest.OverTime - os.time())
			if IsValid(self.TimerLabel) then
				self.TimerLabel:SetText(text)
			end
		end
	end

	if not TW.MainWindowFromTablet or TW.QuestInteractionFromTablet then
		self.AcceptButton = vgui.Create("TerritoryWars.ButtonBase", self.ChoosedPanel)
		self.AcceptButton:SetFontInternal("TW.Font" .. ScrH())
		self.AcceptButton:SetText("Accept")
		self.AcceptButton:Dock(BOTTOM)
		self.AcceptButton:SetEnabled(self.AcceptButtonEnabled)
		self:Init2()
		if self.Quest.Active then
			self.AcceptButton:SetEnabled(false)
		else
			function self.AcceptButton.DoClick() 
				sendSocket(nil, index)
				if IsValid(self) then
					self:SetParent(self.ActivePanel)
					self.ActivePanel:InvalidateLayout(true)
					self.AvailablePanel:InvalidateLayout(true)
					self.AcceptButtonEnabled = false
					self.AcceptButton:SetEnabled(self.AcceptButtonEnabled)
				end
			end
		end
		self.AcceptButton:InvalidateParent()
		local X, Y = self.AcceptButton:GetSize()
		self.AcceptButton:SetSize(X, ScrH() * 0.055)
	end

	self:QuestPanelChanged()

	local groupUpgradesReceived = 0
	hook.Add("Think", "TerritoryWars.QuestUpdateOnGroupUpgrade", function() 
		if groupUpgradesReceived < TW.GroupUpgradesReceived then
			groupUpgradesReceived = TW.GroupUpgradesReceived
			if self.DescriptionLabel and IsValid(self.DescriptionLabel) then
				self:QuestPanelChanged()
			end
		end	
	end)
end

vgui.Register("TerritoryWars.QuestButtonBase", QuestButton, "TerritoryWars.ButtonBase")