local TW = TerritoryWars
TW.TerritoryBonusMap = TW.TerritoryBonusMap or {}

net.Receive("TerritoryWars.TerritoryBonus", function() 
	TW.TerritoryBonusMap = net.ReadTable()
end)

net.Receive("TerritoryWars.SetTerritories", function() 
	local X = net.ReadInt(32)
	local Z = net.ReadInt(32)
	TW.Territories[X][Z] = net.ReadTable()
end)

TW.TerritoryIncomeStatus = {}
net.Receive("TerritoryWars.TerritoryIncomeStatus", function() 
	TW.TerritoryIncomeStatus[net.ReadString()] = net.ReadBool()
end)

local TWUtil = TW.Utilities
TW.InMap = false

function TW:OpenMap() 
	local territory1Select = true
	local territory2Select = true

	local frame = vgui.Create("TerritoryWars.WindowBase")
	frame:SetTitle("")
	TWUtil:SetPanelSize(0.8, 0.8, frame)
	frame:Center()
	frame:MakePopup()

	local mapPanel = vgui.Create("DPanel", frame)
	mapPanel:Dock(FILL)

	if LocalPlayer():IsSuperAdmin() and TW.Changeable then
		local connectButton = vgui.Create("DImageButton", mapPanel)
		connectButton:SetImage("icon16/add.png")
		connectButton:SetStretchToFit(false)
		connectButton:SetTooltip(TW.Labels.ConnectTerritories)
		TWUtil:SetPanelSize(0.04, 0.04, connectButton)
		TWUtil:SetPanelPos(0.75, 0.05, connectButton)

		function connectButton.DoClick() 
			territory1Select = nil
			territory2Select = nil
			mapPanel.TWTerritorySelect = false
			mapPanel.OnConnect = true
			mapPanel.OnDisconnect = false
		end

		local disconnectButton = vgui.Create("DImageButton", mapPanel)
		disconnectButton:SetImage("icon16/cross.png")
		disconnectButton:SetStretchToFit(false)
		disconnectButton:SetTooltip(TW.Labels.DisconnectTerritories)
		TWUtil:SetPanelSize(0.04, 0.04, disconnectButton)
		TWUtil:SetPanelPos(0.75, 0.1, disconnectButton)

		function disconnectButton.DoClick() 
			territory1Select = nil
			territory2Select = nil
			mapPanel.TWTerritorySelect = false
			mapPanel.OnDisconnect = true
			mapPanel.OnConnect = false
		end
	end

	mapPanel.TWTerritorySize = 50
	mapPanel.TWX = 0
	mapPanel.TWZ = 0

	mapPanel.TWPrevX = 0
	mapPanel.TWPrevY = 0
	mapPanel.TWMove = false

	local plyPos = LocalPlayer():GetPos()
	local X = plyPos.x / TW.TerritoryChunkSize
	local Z = plyPos.y / TW.TerritoryChunkSize
	mapPanel.TWX = mapPanel.TWTerritorySize * X - ScrW() * 0.4
	mapPanel.TWZ = mapPanel.TWTerritorySize * Z - ScrH() * 0.4

	function frame:OnClose()
		TerritoryWars.InMap = false
	end

	function mapPanel:Think() 
		self.TWAngles = LocalPlayer():EyeAngles()
		if input.IsMouseDown(MOUSE_LEFT) and (self.TWMove or false) then			
			local X, Y = self:LocalCursorPos()
			local xOffset = self.TWPrevX - X 
			local yOffset = self.TWPrevY - Y 

			self.TWPrevX = X
			self.TWPrevY = Y

			self.TWX = self.TWX + xOffset
			self.TWZ = self.TWZ + yOffset
		elseif not input.IsMouseDown(MOUSE_LEFT) then
			self.TWPrevX, self.TWPrevY = self:LocalCursorPos()
		end
	end

	function mapPanel:OnMouseWheeled(scrollDelta) 
		self.TWTerritorySize = self.TWTerritorySize + scrollDelta * 3
		self.TWTerritorySize = math.Round(self.TWTerritorySize)
		if self.TWTerritorySize < 10 then
			self.TWTerritorySize = 10
		end
	end

	function mapPanel:OnMousePressed(keyCode) 
		self.TWMove = true
	end

	function mapPanel:OnMouseReleased(keyCode) 
		if keyCode == MOUSE_RIGHT then
			self.TWPress = true
		end
		if keyCode == MOUSE_LEFT then
			self.TWTerritorySelect = true
			self.TWMove = false
		end
	end
	
	function mapPanel:Paint(width, height) 
		self.TWX = math.Round(self.TWX or 0)
		self.TWZ = math.Round(self.TWZ or 0)
		local TWX = self.TWX
		local TWZ = self.TWZ
		local curX, curY = self:LocalCursorPos()
		local foundedX = -1.2
		local foundedZ = -1.2
		self.TWTerritorySize = self.TWTerritorySize or 0
		for X = (TWX / self.TWTerritorySize) - 1, ((TWX / self.TWTerritorySize) + (width / self.TWTerritorySize)) + 1 do 
			for Z = (TWZ / self.TWTerritorySize) - 1, ((TWZ / self.TWTerritorySize) + (height / self.TWTerritorySize)) + 1 do 
				X = math.Round(X)
				Z = math.Round(Z)
				local pixX = (X * self.TWTerritorySize) - TWX 
				local pixZ = (Z * self.TWTerritorySize) - TWZ
				local color = Color(0, 0, 0)
				if not TW.Territories[X] or not TW.Territories[X][Z] then
					color = Color(0, 0, 0)
				elseif TW.Territories[X][Z].Capture then
					color = Color(math.Round(math.abs(math.sin(RealTime()) * 100)), 0, 0)
				else
					color = TW.Territories[X][Z].Color or Color(0, 0, 0)
				end
				if TW.Territories[X] and TW.Territories[X][Z] and TW.Territories[X][Z].Parent then
					local coord = TW.Territories[X][Z].Parent
					if coord then
						if TW.Territories[coord[1]] and TW.Territories[coord[1]][coord[2]] then
							local parent = TW.Territories[coord[1]][coord[2]]
							color = parent.Color or Color(0, 0, 0)
							if parent.Capture then
								color = Color(math.Round(math.abs(math.sin(RealTime()) * 100)), 0, 0)
							end
						end
					end
				end

				if territory1Select ~= true and territory1Select ~= nil and X == territory1Select[1] and Z == territory1Select[2] then
					color = Color(0, 0, math.Round(math.abs(math.sin(RealTime()) * 100)))
				end

				if curX >= pixX and curX <= pixX + self.TWTerritorySize then
					if curY >= pixZ and curY <= pixZ + self.TWTerritorySize then
						foundedX = X
						foundedZ = Z
					end
				end
				draw.RoundedBox(0, pixX, pixZ, self.TWTerritorySize, self.TWTerritorySize, color)

				local XExist = TW.Territories[X]
				local thisTerritoryExist = XExist and TW.Territories[X][Z]
				if thisTerritoryExist and TW.Territories[X - 1] and TW.Territories[X - 1][Z] then
					if not TW.Territories[X - 1][Z].Parent 
							or not TW.Territories[X][Z].Parent
							or TW.Territories[X - 1][Z].Parent[1] ~= TW.Territories[X][Z].Parent[1]
							or TW.Territories[X - 1][Z].Parent[2] ~= TW.Territories[X][Z].Parent[2] then
						draw.RoundedBox(0, pixX, pixZ, math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(25, 25, 25))
						local parent1 = TW.Territories[X - 1][Z].Parent
						local parent2 = TW.Territories[X][Z].Parent
						local territory1 = TW.Territories[X - 1][Z]
						local territory2 = TW.Territories[X][Z]
						if parent1 then
							local territory1 = TW.Territories[parent1[1]][parent1[2]]
						end
						if parent2 then
							local territory2 = TW.Territories[parent2[1]][parent2[2]]
						end
						if territory1.GroupName and territory2.GroupName and territory1.GroupName ~= territory2.GroupName then
							draw.RoundedBox(0, pixX, pixZ, math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(100, 0, 0))
						end
					end
				else
					draw.RoundedBox(0, pixX, pixZ, math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(25, 25, 25))
				end

				if thisTerritoryExist and TW.Territories[X + 1] and TW.Territories[X + 1][Z] then
					if not TW.Territories[X + 1][Z].Parent 
							or not TW.Territories[X][Z].Parent
							or TW.Territories[X + 1][Z].Parent[1] ~= TW.Territories[X][Z].Parent[1]
							or TW.Territories[X + 1][Z].Parent[2] ~= TW.Territories[X][Z].Parent[2] then
						draw.RoundedBox(0, pixX + self.TWTerritorySize, pixZ + self.TWTerritorySize, 
							math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(25, 25, 25))
						local parent1 = TW.Territories[X + 1][Z].Parent
						local parent2 = TW.Territories[X][Z].Parent
						local territory1 = TW.Territories[X + 1][Z]
						local territory2 = TW.Territories[X][Z]
						if parent1 then
							local territory1 = TW.Territories[parent1[1]][parent1[2]]
						end
						if parent2 then
							local territory2 = TW.Territories[parent2[1]][parent2[2]]
						end
						if territory1.GroupName and territory2.GroupName and territory1.GroupName ~= territory2.GroupName then
							draw.RoundedBox(0, pixX + self.TWTerritorySize, pixZ + self.TWTerritorySize, 
								math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(100, 0, 0))
						end
					end
				else
					draw.RoundedBox(0, pixX + self.TWTerritorySize, pixZ + self.TWTerritorySize, 
							math.max(self.TWTerritorySize / 100, 1), self.TWTerritorySize, Color(25, 25, 25))
				end

				if thisTerritoryExist and TW.Territories[X][Z + 1] then
					if not TW.Territories[X][Z + 1].Parent 
							or not TW.Territories[X][Z].Parent
							or TW.Territories[X][Z + 1].Parent[1] ~= TW.Territories[X][Z].Parent[1]
							or TW.Territories[X][Z + 1].Parent[2] ~= TW.Territories[X][Z].Parent[2] then
						draw.RoundedBox(0, pixX, pixZ + self.TWTerritorySize, 
							self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(25, 25, 25))
						local parent1 = TW.Territories[X][Z + 1].Parent
						local parent2 = TW.Territories[X][Z].Parent
						local territory1 = TW.Territories[X][Z + 1]
						local territory2 = TW.Territories[X][Z]
						if parent1 then
							local territory1 = TW.Territories[parent1[1]][parent1[2]]
						end
						if parent2 then
							local territory2 = TW.Territories[parent2[1]][parent2[2]]
						end
						if territory1.GroupName and territory2.GroupName and territory1.GroupName ~= territory2.GroupName then
							draw.RoundedBox(0, pixX, pixZ + self.TWTerritorySize, 
								self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(100, 0, 0))
						end
					end
				else
					draw.RoundedBox(0, pixX, pixZ + self.TWTerritorySize, 
							self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(25, 25, 25))
				end

				if thisTerritoryExist and TW.Territories[X][Z - 1] then
					if not TW.Territories[X][Z - 1].Parent 
							or not TW.Territories[X][Z].Parent
							or TW.Territories[X][Z - 1].Parent[1] ~= TW.Territories[X][Z].Parent[1]
							or TW.Territories[X][Z - 1].Parent[2] ~= TW.Territories[X][Z].Parent[2] then
						draw.RoundedBox(0, pixX, pixZ, 
							self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(25, 25, 25))
						local parent1 = TW.Territories[X][Z - 1].Parent
						local parent2 = TW.Territories[X][Z].Parent
						local territory1 = TW.Territories[X][Z - 1]
						local territory2 = TW.Territories[X][Z]
						if parent1 then
							local territory1 = TW.Territories[parent1[1]][parent1[2]]
						end
						if parent2 then
							local territory2 = TW.Territories[parent2[1]][parent2[2]]
						end
						if territory1.GroupName and territory2.GroupName and territory1.GroupName ~= territory2.GroupName then
							draw.RoundedBox(0, pixX, pixZ, 
								self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(100, 0, 0))
						end
					end
				else
					draw.RoundedBox(0, pixX, pixZ, 
							self.TWTerritorySize, math.max(self.TWTerritorySize / 100, 1), Color(25, 25, 25))
				end
			end
		end

		local plyPos = LocalPlayer():GetPos()
		local X = plyPos.x / TW.TerritoryChunkSize
		local Z = plyPos.y / TW.TerritoryChunkSize
		local pixX = X * self.TWTerritorySize - TWX 
		local pixZ = Z * self.TWTerritorySize - TWZ 
		draw.RoundedBox(100, pixX, pixZ, 
			self.TWTerritorySize / 10, self.TWTerritorySize / 10, Color(100, 100, 255))
		local pitch = self.TWAngles.pitch
		local yaw = self.TWAngles.yaw
		local dirPointX, dirPointY = 
			pixX + math.cos(yaw * 0.0174533) * (self.TWTerritorySize / 15), 
			pixZ + math.sin(yaw * 0.0174533) * (self.TWTerritorySize / 15)
		draw.RoundedBox(100, dirPointX, dirPointY, 
			self.TWTerritorySize / 15, self.TWTerritorySize / 15, Color(50, 50, 125))
		
		if foundedX ~= -1.2 and foundedZ ~= -1.2 then
			local foundedX2, foundedZ2
			if TW.Territories[foundedX] and TW.Territories[foundedX][foundedZ] then
				if TW.Territories[foundedX][foundedZ].Parent then
					foundedX2 = TW.Territories[foundedX][foundedZ].Parent[1]
					foundedZ2 = TW.Territories[foundedX][foundedZ].Parent[2]
				end
			end
			local territory = TW.Territories[foundedX2 or foundedX]
			if territory then
				territory = TW.Territories[foundedX2 or foundedX][foundedZ2 or foundedZ]
			end
			local nobodyOwner
			if not territory or not territory.GroupName then
				nobodyOwner = true
				draw.SimpleText("", "TW.Font" .. ScrH(), 0.01 * width, 0.95 * height, Color(255, 255, 255))
			elseif territory.Capture then
				draw.SimpleText(TW.Labels.ThisTerritoryIsUnderAssault, "TW.Font" .. ScrH(), 
					0.01 * width, 0.90 * height, Color(255, 255, 255))
			else
				draw.SimpleText(territory.GroupName, "TW.Font" .. ScrH(), 
					0.01 * width, 0.90 * height, territory.Color)
			end
			draw.SimpleText(foundedX .. " " .. foundedZ, "TW.Font" .. ScrH(), 0.85 * width, 0.90 * height, Color(255, 255, 255))

			if territory and territory.Name then
				draw.SimpleText(territory.Name, 
					"TW.Font" .. ScrH(), width * 0.025, height * 0.025, Color(200, 190, 0))
			end

			if self.TWPress then
				self.TWPress = false
				local info = vgui.Create("TerritoryWars.TerritoryInfoWindow")
				local foundedX, foundedZ = foundedX, foundedZ
				local existBefore = true
				if not TW.Territories[foundedX] then
					TW.Territories[foundedX] = {}
					existBefore = false
				end
				if not TW.Territories[foundedX][foundedZ] then
					TW.Territories[foundedX][foundedZ] = {}
					existBefore = false
				end
				if TW.Territories[foundedX][foundedZ].Parent then
					local temp1, temp2 = foundedX, foundedZ
					foundedX = TW.Territories[temp1][temp2].Parent[1]
					foundedZ = TW.Territories[temp1][temp2].Parent[2]
				end
				local territory = TW.Territories[foundedX][foundedZ]
				info:SetBonuses(TW.TerritoryBonusMap[foundedX .. " " .. foundedZ] or {})
				if existBefore then
					info:SetName(territory.Name or "")
					info:SetOwner(territory.GroupName or "")
					info:SetAdditionalInfo(territory.AdditionalInfo or "")
				end
				info:UpdateDescription()

				function info:BonusSettingsOnApply(window) 
					net.Start("TerritoryWars.TerritoryBonus")
						net.WriteString(foundedX .. " " .. foundedZ)
						net.WriteTable(TWUtil:GetTableData(window:GetBonuses()))
					net.SendToServer()
					info:UpdateDescription()
				end

				function info.SettingsOnApply(_, name, additionalInfo) 
					info:SetName(name)
					info:SetAdditionalInfo(additionalInfo)
					territory.Name = name
					territory.AdditionalInfo = additionalInfo
					net.Start("TerritoryWars.SetTerritories")
						net.WriteInt(foundedX, 32)
						net.WriteInt(foundedZ, 32)
						net.WriteTable(TWUtil:GetTableData(territory))
					net.SendToServer()
					info:UpdateDescription()
				end
			end

			if not territory1Select and self.TWTerritorySelect then
				territory1Select = { foundedX, foundedZ }
				self.TWTerritorySelect = false
				if self.OnDisconnect then
					net.Start("TerritoryWars.DisconnectTerritories")
						net.WriteTable(territory1Select)
					net.SendToServer()
					territory1Select = true
					self.OnDisconnect = false
				end
			elseif not territory2Select and self.TWTerritorySelect and self.OnConnect then
				self.TWTerritorySelect = false
				local distance = math.Distance(territory1Select[1], territory1Select[2], foundedX, foundedZ)
				if distance <= 1 and distance > 0 then
					territory2Select = { foundedX, foundedZ }

					net.Start("TerritoryWars.ConnectTerritories")
						net.WriteTable(territory1Select)
						net.WriteTable(territory2Select)
					net.SendToServer()

					self.OnConnect = false

					territory1Select = true
					territory2Select = true
				end
			end
		end

		if not territory1Select and self.OnConnect or self.OnDisconnect then
			draw.DrawText(TW.Labels.MapSelectTerritory1, "TW.Font" .. ScrH(), width * 0.5, height * 0.1, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		elseif not territory2Select and self.OnConnect then
			draw.DrawText(TW.Labels.MapSelectTerritory2, "TW.Font" .. ScrH(), width * 0.5, height * 0.1, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
		draw.SimpleText(TW.Labels.PressSMB, "TW.MFont" .. ScrH(), ScrW() * 0.01, ScrH() * 0.01, Color(255, 255, 255))
	end
end

--[[
hook.Add("PostDrawTranslucentRenderables", "TerritoryWars.DrawChunksBorders", function() 
	for X = -10, 10 do 
		for Z = -10, 10 do 
			render.DrawLine(
				Vector(X * TW.TerritoryChunkSize + 1, Z * TW.TerritoryChunkSize + 1, -30000),
				Vector(X * TW.TerritoryChunkSize + 1, Z * TW.TerritoryChunkSize + 1, 30000),
				Color(255, 0, 0),
				true
			)

			render.DrawLine(
				Vector(X * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, Z * TW.TerritoryChunkSize + 1, -30000),
				Vector(X * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, Z * TW.TerritoryChunkSize + 1, 30000),
				Color(0, 255, 0),
				true
			)

			render.DrawLine(
				Vector(X * TW.TerritoryChunkSize + 1, Z * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, -30000),
				Vector(X * TW.TerritoryChunkSize - 1, Z * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, 30000),
				Color(0, 0, 255),
				true
			)

			render.DrawLine(
				Vector(X * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, Z * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, -30000),
				Vector(X * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, Z * TW.TerritoryChunkSize + TW.TerritoryChunkSize - 1, 30000),
				Color(255, 255, 255),
				true
			)
		end
	end
end)
-- This shit helped me a lot
]]