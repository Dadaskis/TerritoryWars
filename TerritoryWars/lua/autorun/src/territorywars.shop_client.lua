local TW = TerritoryWars

TW.Shop = TW.Shop or {}
TW.Shop.ShopList = TW.Shop.ShopList or {}
TW.Shop.ShopQueue = TW.Shop.ShopQueue or {}
TW.Shop.Count = TW.Shop.Count or 0

TW.ShopReceived = TW.ShopReceived or 0
TW.ShopQueueReceived = TW.ShopQueueReceived or 0

net.Receive("TerritoryWars.GetShopItem", function() 
	local index = net.ReadInt(32)
	TW.Shop.ShopList[index] = net.ReadTable()
	TW.ShopReceived = RealTime()
end)

net.Receive("TerritoryWars.SendShopQueue", function() 
    TW.Shop.ShopQueue = net.ReadTable()
    TW.ShopQueueReceived = RealTime()
end)

function TW.Shop:Buy(index) 
	net.Start("TerritoryWars.Buy")
		net.WriteInt(index, 32)
	net.SendToServer()
end

function TW.Shop:Delete(index) 
	net.Start("TerritoryWars.ChangeShopData")
		net.WriteInt(index, 32)
		net.WriteBool(true)
	net.SendToServer()
end

function TW.Shop:Change(index, name, price, alwaysUnlocked, playerIsOwner, category) 
	net.Start("TerritoryWars.ChangeShopData")
		net.WriteInt(index, 32)
		net.WriteBool(false)
		net.WriteString(name)
		net.WriteInt(price, 32)
		net.WriteBool(alwaysUnlocked)
		net.WriteBool(playerIsOwner)
		net.WriteString(category)
	net.SendToServer()
end

function TW.Shop:Return(index)
    net.Start("TerritoryWars.ReturnShopEntity")
        net.WriteInt(index, 32)
    net.SendToServer()
end

TW.ShopLimitReceived = 0
net.Receive("TerritoryWars.ShopBuyedCount", function() 
	TW.Shop.Count = net.ReadInt(32)
	TW.ShopLimitReceived = RealTime()
end)

net.Receive("TerritoryWars.OpenShopWindow", function() 
	timer.Simple(LocalPlayer():Ping() / 500, function()
		local TWUtil = TW.Utilities
		local frame = vgui.Create("TerritoryWars.WindowBase")
		TWUtil:SetPanelSize(0.9, 0.9, frame)
		frame:Center()
		frame:MakePopup()

		function frame:OnClose() 
			net.Start("TerritoryWars.OutFromShopWindow")
			net.SendToServer()
		end

		local panel = vgui.Create("TerritoryWars.PanelBase", frame)
		panel:Dock(BOTTOM)
		panel:InvalidateParent()
		local X, _ = panel:GetSize()
		panel:SetSize(X, ScrH() * 0.055)

		local pointsLabel = vgui.Create("TerritoryWars.LabelBase", panel)
		pointsLabel:SetFontInternal("TW.Font" .. ScrH())
		pointsLabel:SizeToContents()
		pointsLabel:SetText(TW.Labels.Points .. ": " .. 0)
		pointsLabel:SizeToContents()
		local lastPointsReceived = 0
		function pointsLabel:Think() 
			if lastPointsReceived < TW.PointsReceived then
				pointsLabel:SetText(TW.Labels.Points .. ": " .. TW.Points)
				pointsLabel:SizeToContents()
			end
		end
		pointsLabel:Dock(LEFT)

        local buyedButton = vgui.Create("TerritoryWars.ButtonBase", panel)
        buyedButton:SetFont("TW.SFont" .. ScrH())
        buyedButton:SetText(TW.Labels.Buyed)
        buyedButton:Dock(RIGHT)
        buyedButton:InvalidateLayout()
        buyedButton:SizeToContents()

        function buyedButton:DoClick() 
            local window = vgui.Create("TerritoryWars.WindowBase")
            window:SetSize(ScrW() * 0.9, ScrH() * 0.9)
            window:Center()
            window:MakePopup()

            local scrollPanel = vgui.Create("TerritoryWars.ScrollPanelBase", window)
            scrollPanel:Dock(FILL)

            local shopQueueReceived = 0
            function scrollPanel:Think() 
                if shopQueueReceived < TW.ShopQueueReceived then
                    shopQueueReceived = TW.ShopQueueReceived
                    self:Clear()
                    for key, objectIndex in pairs(TW.Shop.ShopQueue) do
                        local shopEntity = TW.Shop.ShopList[objectIndex]

                        local entityData
                        if shopEntity.EntityClass == nil then
                            entityData = shopEntity.Entity.Entities[table.GetKeys(shopEntity.Entity.Entities)[1]]
                        else 
                            entityData = shopEntity
                        end

                        local panel = vgui.Create("TerritoryWars.PanelBase", scrollPanel)
                        local modelPanel = vgui.Create("DModelPanel", panel)
                        modelPanel:SetModel(entityData.Model or "models/hunter/blocks/cube025x025x025.mdl")
                        modelPanel:SetFOV(25)
                        modelPanel:SetLookAt(modelPanel:GetLookAt() - Vector(0, 0, 30))
                        function modelPanel:LayoutEntity() return end
                        modelPanel:Dock(LEFT)

                        local nameLabel = vgui.Create("TerritoryWars.LabelBase", panel)
                        nameLabel:SetText((shopEntity.Name or "...") .. " |") 
                        nameLabel:SetFontInternal("TW.SFont" .. ScrH())
                        nameLabel:SizeToContents()
                        nameLabel:Dock(LEFT)

                        local priceLabel

                        local returnButton = vgui.Create("TerritoryWars.ButtonBase", panel)
                        returnButton:SetFontInternal("TW.SFont" .. ScrH())
                        returnButton:SetText(TW.Labels.Return)
                        returnButton:Dock(RIGHT)
                        returnButton:InvalidateParent()
                        returnButton:SizeToContents()

                        function returnButton:DoClick() 
                            TW.Shop:Return(key)
                        end   

                        priceLabel = vgui.Create("TerritoryWars.LabelBase", panel)
                        local price
                        if TW.GroupUpgrading and TW.GroupShopDiscountUpgradeEnabled then
                            price = shopEntity.Price or 0
                            price = 
                                math.max(
                                    math.Round(price * (1 - ((TW.GroupShopDiscountUpgradeProcents / 100) * TW.GroupUpgrades["ShopDiscount"]))), 0)
                            priceLabel:SetText(price)
                        else
                            price = shopEntity.Price or 0
                            priceLabel:SetText(shopEntity.Price)
                        end
                        priceLabel:SetFontInternal("TW.SFont" .. ScrH())
                        priceLabel:SizeToContents()
                        priceLabel:DockMargin(ScrW() * 0.01, 0, ScrW() * 0.01, 0)
                        priceLabel:Dock(LEFT)
                        table.Add(priceLabels, { priceLabel })

                        panel:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
                        panel:Dock(TOP)
                        local X, Y = panel:GetSize()
                        panel:InvalidateParent()
                        panel:SetSize(X, Y * 2)

                        modelPanel:InvalidateParent()
                        local X, Y = panel:GetSize()
                        modelPanel:SetSize(Y, Y)
                    end
                end
            end
        end

		local limitLabel = vgui.Create("TerritoryWars.LabelBase", panel)
		limitLabel:SetFontInternal("TW.Font" .. ScrH())
		limitLabel:SetText("0/10 ")
		limitLabel:SizeToContents()
		local limitReceived = 0
		function limitLabel:Think() 
			if limitReceived < TW.ShopLimitReceived then
				limitReceived = TW.ShopLimitReceived
				limitLabel:SetText(TW.Shop.Count .. "/" .. TW.ShopPocketLimit .. " ")
				limitLabel:SizeToContents()
			end
		end
		limitLabel:Dock(RIGHT)

        if LocalPlayer():IsSuperAdmin() then 
            local addButton = vgui.Create("TerritoryWars.ButtonBase", panel)
            addButton:SetFont("TW.SFont" .. ScrH())
            addButton:SetText(TW.Labels.Add)
            addButton:Dock(RIGHT)
            addButton:InvalidateLayout()
            addButton:SizeToContents()

            function addButton:DoClick() 
                local window = vgui.Create("TerritoryWars.WindowBase")
                window:SetSize(ScrW() * 0.5, ScrH() * 0.3)
                window:Center()
                window:MakePopup()

                local label = vgui.Create("TerritoryWars.LabelBase", window)
                label:SetText("Entity class")
                label:SetFontInternal("TW.Font" .. ScrH())
                label:SizeToContents()
                label:SetContentAlignment(5)
                label:Dock(TOP)

                local input = vgui.Create("DTextEntry", window)
                TWUtil:SetPanelSize(0.1, 0.05, input)
                input:Dock(TOP)
                input:InvalidateParent()
                local Y = select(2, input:GetSize())
                input:SetSize(ScrW() * 0.3, Y)

                local button = vgui.Create("TerritoryWars.ButtonBase", window)
                button:SetFont("TW.SFont" .. ScrH())
                button:SetText(TW.Labels.Apply)
                button:Dock(BOTTOM)
                button:InvalidateLayout()
                button:SetSize(select(1, button:GetSize()), ScrH() * 0.05)
                function button:DoClick() 
                    net.Start("TerritoryWars.AddToShopEntityClass")
                        net.WriteString(input:GetText())
                    net.SendToServer()
                end
            end
        end

		local currentCategory = TW.Labels.Everything
		local comboBox = vgui.Create("DComboBox", frame) 
		comboBox:Dock(TOP)
		comboBox:AddChoice(TW.Labels.Everything)
		local mask = {}
		for index, shopEntity in pairs(TW.Shop.ShopList) do 
			mask[shopEntity.Category or TW.Labels.Everything] = true
		end
		for category, _ in pairs(mask) do 
			comboBox:AddChoice(category)
		end
		function comboBox.OnSelect(comboBox, index, value) 
			currentCategory = value
			TW.ShopReceived = RealTime()
		end

		local scrollPanel = vgui.Create("TerritoryWars.ScrollPanelBase", frame)
		scrollPanel.TWNextTime = 0
		scrollPanel.TWCount = 0
		scrollPanel:Clear()

		local lastShopReceived = 0
		local priceLabels = {}
		function scrollPanel:Think() 
			for index, priceLabel in ipairs(priceLabels) do
				local price = tonumber(priceLabel:GetText())
				if price > TW.Points then
					priceLabel:SetTextColor(Color(255, 0, 0))
				else
					priceLabel:SetTextColor(Color(0, 255, 0))
				end
			end
			if lastShopReceived < TW.ShopReceived then
				comboBox:Clear()
				comboBox:AddChoice(TW.Labels.Everything)
				local mask = {}
				for index, shopEntity in pairs(TW.Shop.ShopList) do 
					mask[shopEntity.Category or TW.Labels.Everything] = true
				end
				for category, _ in pairs(mask) do 
					if category ~= TW.Labels.Everything then
						comboBox:AddChoice(category)
					end
				end
				function comboBox.OnSelect(comboBox, index, value) 
					currentCategory = value
					TW.ShopReceived = RealTime()
				end
                comboBox:SetValue(currentCategory)
				priceLabels = {}
				lastShopReceived = TW.ShopReceived
				scrollPanel:Clear()
				for index, shopEntity in pairs(TW.Shop.ShopList) do 
					if currentCategory ~= TW.Labels.Everything and shopEntity.Category ~= currentCategory then
						continue
					end
					if not isnumber(index) then
						continue
					end
					if (TW.GroupShopList[index] or 0) > 0 or shopEntity.AlwaysUnlocked 
							or (LocalPlayer():IsSuperAdmin() and TW.Changeable) then
                        local entityData
                        if shopEntity.EntityClass == nil then
                            if shopEntity.Entity == nil then
                                return
                            end
    						entityData = shopEntity.Entity.Entities[table.GetKeys(shopEntity.Entity.Entities)[1]]
                        else
                            entityData = shopEntity
                        end

						local panel = vgui.Create("TerritoryWars.PanelBase", scrollPanel)

                        if index % 2 == 0 then
                            panel.Paint = function(_, width, height) 
                                function TW.PanelPaint(_, width, height) 
                                    draw.RoundedBox(0, 0, 0, width, height, Color(30, 30, 30, 130))
                                end
                            end
                        end

						local modelPanel = vgui.Create("DModelPanel", panel)
						modelPanel:SetModel(entityData.Model or "models/hunter/blocks/cube025x025x025.mdl")
						modelPanel:SetFOV(25)
						modelPanel:SetLookAt(modelPanel:GetLookAt() - Vector(0, 0, 30))
						function modelPanel:LayoutEntity() return end
						modelPanel:Dock(LEFT)

						local nameLabel = vgui.Create("TerritoryWars.LabelBase", panel)
						nameLabel:SetText((shopEntity.Name or "...") .. " |") 
						nameLabel:SetFontInternal("TW.SFont" .. ScrH())
						nameLabel:SizeToContents()
						nameLabel:Dock(LEFT)

						local priceLabel

						if LocalPlayer():IsSuperAdmin() and TW.Changeable then
							local settingsButton = vgui.Create("DImageButton", panel)
							settingsButton:SetImage("icon16/cog.png")
							settingsButton:SetStretchToFit(false)
							settingsButton:Dock(RIGHT)
							settingsButton:InvalidateParent()
							TWUtil:SetPanelSize(0.02, 0.02, settingsButton)
							function settingsButton:DoClick()
								local outNameLabel = nameLabel
								local outPriceLabel = priceLabel

								local frame = vgui.Create("TerritoryWars.WindowBase")
								TWUtil:SetPanelSize(0.4, 0.4, frame)
								frame:Center()
								frame:MakePopup()

								local namePanel = vgui.Create("TerritoryWars.PanelBase", frame)
								local nameLabel = vgui.Create("TerritoryWars.LabelBase", namePanel)
								local nameInput = vgui.Create("DTextEntry", namePanel)
								nameLabel:SetFontInternal("TW.SFont" .. ScrH())
								nameLabel:SetText(TW.Labels.Name .. ":")
								nameLabel:SizeToContents()
								nameLabel:Dock(LEFT)
								TWUtil:SetPanelSize(0.1, 0.03, nameInput)
								nameInput:SetText(shopEntity.Name or "")
								nameInput:Dock(LEFT)
								nameInput:InvalidateParent()
								local Y = select(2, nameInput:GetSize())
								nameInput:SetSize(ScrW() * 0.3, Y)
								namePanel:SizeToContents()
								namePanel:Dock(TOP)

								local pricePanel = vgui.Create("TerritoryWars.PanelBase", frame)
								local priceLabel = vgui.Create("TerritoryWars.LabelBase", pricePanel)
								local priceInput = vgui.Create("DTextEntry", pricePanel)
								priceLabel:SetFontInternal("TW.SFont" .. ScrH())
								priceLabel:SetText(TW.Labels.Price .. ":")
								priceLabel:SizeToContents()
								priceLabel:Dock(LEFT)

								TWUtil:SetPanelSize(0.1, 0.03, priceInput)
								priceInput:SetText(shopEntity.Price or "0")
								priceInput:Dock(LEFT)
								local Y = select(2, priceInput:GetSize())
								priceInput:SetSize(ScrW() * 0.3, Y)
								pricePanel:SizeToContents()
								pricePanel:Dock(TOP)

								local categoryPanel = vgui.Create("TerritoryWars.PanelBase", frame)
								local categoryLabel = vgui.Create("TerritoryWars.LabelBase", categoryPanel)
								local categoryInput = vgui.Create("DTextEntry", categoryPanel)
								categoryLabel:SetFontInternal("TW.SFont" .. ScrH())
								categoryLabel:SetText(TW.Labels.Category .. ":")
								categoryLabel:SizeToContents()
								categoryLabel:Dock(LEFT)

								TWUtil:SetPanelSize(0.1, 0.03, categoryInput)
								categoryInput:SetText(shopEntity.Category or "...")
								categoryInput:Dock(LEFT)
								local Y = select(2, categoryInput:GetSize())
								categoryInput:SetSize(ScrW() * 0.3, Y)
								categoryPanel:SizeToContents()
								categoryPanel:Dock(TOP)

								local alwaysUnlocked = vgui.Create("DCheckBoxLabel", frame)
								alwaysUnlocked:SetTextColor(TW.TextColor)
								alwaysUnlocked:SetFontInternal("TW.SFont" .. ScrH())
								alwaysUnlocked:SetText(TW.Labels.AlwaysUnlocked)
								alwaysUnlocked:SizeToContents()
								alwaysUnlocked:Dock(TOP)
								alwaysUnlocked:SetChecked(shopEntity.AlwaysUnlocked)

								local playerIsOwner = vgui.Create("DCheckBoxLabel", frame)
								playerIsOwner:SetTextColor(TW.TextColor)
								playerIsOwner:SetFontInternal("TW.SFont" .. ScrH())
								playerIsOwner:SetText(TW.Labels.PlayerIsOwner)
								playerIsOwner:SizeToContents()
								playerIsOwner:Dock(TOP)
								playerIsOwner:SetChecked(shopEntity.PlayerIsOwner)

								local panel = vgui.Create("TerritoryWars.PanelBase", frame)
								panel:Dock(BOTTOM)

								local acceptButton = vgui.Create("TerritoryWars.ButtonBase", panel)
								acceptButton:SetText(TW.Labels.Accept)
								acceptButton:SetFontInternal("TW.SFont" .. ScrH())
								acceptButton:Dock(RIGHT)
								function acceptButton:DoClick() 
									if not tonumber(priceInput:GetText()) then
										return
									end
									TW.Shop:Change(index, nameInput:GetText(), tonumber(priceInput:GetText()), alwaysUnlocked:GetChecked(),
										playerIsOwner:GetChecked(), categoryInput:GetText())
									
									if IsValid(outPriceLabel) then
										outPriceLabel:SetText(priceInput:GetText())
										outPriceLabel:SizeToContents()
									end
									if IsValid(outNameLabel) then
										outNameLabel:SetText(nameInput:GetText())
										outNameLabel:SizeToContents()
									end
									frame:Close()
								end

								local deleteButton = vgui.Create("DImageButton", panel)
								deleteButton:SetImage("icon16/cross.png")
								deleteButton:SetStretchToFit(false)
								deleteButton:Dock(LEFT)
								deleteButton:InvalidateParent()
								TWUtil:SetPanelSize(0.02, 0.02, deleteButton)
								deleteButton:SetMouseInputEnabled(true)
								function deleteButton.DoClick() 
									TW.Shop:Delete(index)
									frame:Close()
								end
							end

							local upButton = vgui.Create("DImageButton", panel)
							upButton:SetImage("icon16/arrow_up.png")
							upButton:SetStretchToFit(false)
							upButton:Dock(RIGHT)
							upButton:InvalidateParent()
							TWUtil:SetPanelSize(0.02, 0.02, upButton)
							function upButton:DoClick() 
								if TW.Shop.ShopList[index - 1] then
									TW.ShopReceived = RealTime()
									TW.Shop.ShopList[index], TW.Shop.ShopList[index - 1] = TW.Shop.ShopList[index - 1], TW.Shop.ShopList[index]
									net.Start("TerritoryWars.ShopSwap")
										net.WriteBool(false)
										net.WriteInt(index, 32)
									net.SendToServer()
								end
							end

							local downButton = vgui.Create("DImageButton", panel)
							downButton:SetImage("icon16/arrow_down.png")
							downButton:SetStretchToFit(false)
							downButton:Dock(RIGHT)
							downButton:InvalidateParent()
							TWUtil:SetPanelSize(0.02, 0.02, downButton)
							function downButton:DoClick() 
								if TW.Shop.ShopList[index + 1] then
									TW.ShopReceived = RealTime()
									TW.Shop.ShopList[index], TW.Shop.ShopList[index + 1] = TW.Shop.ShopList[index + 1], TW.Shop.ShopList[index]
									net.Start("TerritoryWars.ShopSwap")
										net.WriteBool(true)
										net.WriteInt(index, 32)
									net.SendToServer()
								end
							end
						end

						if (TW.GroupShopList[index] or 0) > 0 or shopEntity.AlwaysUnlocked then
							local buyButton = vgui.Create("TerritoryWars.ButtonBase", panel)
							buyButton:SetFontInternal("TW.SFont" .. ScrH())
							buyButton:SetText(TW.Labels.Buy)
							buyButton:Dock(RIGHT)
							buyButton:InvalidateParent()
							buyButton:SizeToContents()

							function buyButton:DoClick() 
								TW.Shop:Buy(index)
							end						
						end

						priceLabel = vgui.Create("TerritoryWars.LabelBase", panel)
						local price
						if TW.GroupUpgrading and TW.GroupShopDiscountUpgradeEnabled then
							price = shopEntity.Price or 0
							price = 
								math.max(
									math.Round(price * (1 - ((TW.GroupShopDiscountUpgradeProcents / 100) * TW.GroupUpgrades["ShopDiscount"]))), 0)
							priceLabel:SetText(price)
						else
							price = shopEntity.Price
							priceLabel:SetText(shopEntity.Price)
						end
						priceLabel:SetFontInternal("TW.SFont" .. ScrH())
						priceLabel:SizeToContents()
						priceLabel:DockMargin(ScrW() * 0.01, 0, ScrW() * 0.01, 0)
						priceLabel:Dock(LEFT)
						table.Add(priceLabels, { priceLabel })

						panel:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
						panel:Dock(TOP)
						local X, Y = panel:GetSize()
						panel:InvalidateParent()
						panel:SetSize(X, Y * 2)

						modelPanel:InvalidateParent()
						local X, Y = panel:GetSize()
						modelPanel:SetSize(Y, Y)
					end
				end
			end
		end

		scrollPanel:Dock(FILL)
	end)
end)