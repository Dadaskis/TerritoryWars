-- Good luck

local TW = TerritoryWars

-- Changeable Могут ли суперадмины менять настройки?
--
-- true  - да
-- false - нет
-- --
-- Changeable Can superadmins change settings?
--
-- true  - yes
-- false - no
TW.Changeable 						= true



TW.OnKillPointsCaseSpawn            = true



TW.PointsCaseProcents               = 5




-- SlotPrice Цена слота.
-- --
-- SlotPrice Slot price
TW.SlotPrice 						= 300




-- SlotAddPrice Сколько добавит к стоимости улучшений у ролей добавление слота?
-- --
-- SlotAddPrice How much adding a slot will increase price of upgrades?
TW.SlotAddPrice 					= 1




-- SlotAddCount Сколько добавляет слотов за одно добавление?
-- --
-- SlotAddCount How many adds slots for one addition?
TW.SlotAddCount						= 1




-- RoleCreatePrice Сколько стоит создание роли.
-- --
-- RoleCreatePrice New role create price
TW.RoleCreatePrice					= 100




-- TerritoryChunkSize Какой размер у территории.
-- -- 
-- TerritoryChunkSize Size of one territory chunk.
TW.TerritoryChunkSize 				= 2000




-- MaxGroupCount Сколько может быть группировок максимум.
-- --
-- MaxGroupCount Maximal amount of groups.
TW.MaxGroupCount 					= 999




-- TerritoryCaptureTime Сколько занимает захват вообще. 
-- Расспростроняется и на территории, и на флаги.
-- --
-- TerritoryCaptureTime Time(seconds) to capture flag or territory.
TW.TerritoryCaptureTime 			= 30




-- GiveGroupTablet Давать ли Group tablet при спауне
--
-- true  - да
-- false - нет
-- --
-- GiveGroupTablet Give the group tablet on spawn or not
--
-- true  - yes
-- false - no
TW.GiveGroupTablet					= true




-- TabletPointsInteractions можно ли взаимодействовать с очками в Group tablet
--
-- true  - да
-- false - нет
-- --
-- TabletPointsInteractions Withdraw/Deposit/Give points in Group tablet
--
-- true  - yes
-- false - no
TW.TabletPointsInteractions 		= true


-- ComputerHealth Количество здоровья у компа
-- -- 
-- ComputerHealth Amount of health of main computer
TW.ComputerHealth                   = 60000


-- ComputerHealthRegenerationTime Время регенерации здоровья компа
-- -- 
-- ComputerHealthRegenerationTime Regeneration time of main computer health
TW.ComputerHealthRegenerationTime   = 60 * 2




-- RoleMenuFromTablet меню с ролями в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- RoleMenuFromTablet roles menu in Group tablet
--
-- true  - yes
-- false - no
TW.RoleMenuFromTablet				= true


-- RoleInteractionFromTablet можно ли менять роли в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- RoleInteractionFromTablet can we change the roles in Group tablet
--
-- true  - yes
-- false - no
TW.RoleInteractionFromTablet		= true


-- QuestMenuFromTablet квесты в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- QuestMenuFromTablet Show quests in Group tablet
--
-- true  - yes
-- false - no
TW.QuestMenuFromTablet				= true



-- QuestInteractionFromTablet Взаимодействие с квестами в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- QuestInteractionFromTablet Interact with quests in Group tablet
--
-- true  - yes
-- false - no
TW.QuestInteractionFromTablet 		= true



-- GroupQuestMenuFromTablet Групповые квесты в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- GroupQuestMenuFromTablet Show group quests in Group tablet
--
-- true  - yes
-- false - no
TW.GroupQuestMenuFromTablet 		= true



-- GroupQuestInteractionFromTablet Взаимодействие с групповыми квестами в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- GroupQuestInteractionFromTablet Interaction with group quests in Group tablet
--
-- true  - yes
-- false - no
TW.GroupQuestInteractionFromTablet  = true


-- GroupUpgradeMenuFromTablet Грейды группы в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- GroupUpgradeMenuFromTablet Show group upgrades in Group tablet
--
-- true  - yes
-- false - no
TW.GroupUpgradeMenuFromTablet       = true



-- GroupUpgradeMenuFromTablet Управление грейдами группы в Group tablet
--
-- true  - да
-- false - нет
-- -- 
-- GroupUpgradeMenuFromTablet Starting group upgrades in Group tablet
--
-- true  - yes
-- false - no
TW.GroupUpgradeInteractionFromTablet = true




-- UnitsKillDiplomacyMinus Сколько очков дипломатии 
-- снимается при убийстве члена другой группировки
-- --
-- UnitsKillDiplomacyMinus How many points of diplomacy
-- will decrease when member of group was killed.
TW.UnitsKillDiplomacyMinus 			= 200




-- GroupStartLifeTime Сколько секунд времени жизни
-- даётся группировке при создании.
-- -- 
-- GroupStartLifeTime Start lifetime of group.
TW.GroupStartLifeTime 				= 60 * 30




-- GroupCreationMoney (ТОЛЬКО ДЛЯ ДАРКРП) 
-- Сколько денег снимает при создании группы
-- --
-- GroupCreationMoney (ONLY FOR DARKRP)
-- How much money we need to create group
TW.GroupCreationMoney 				= 0




-- IntelRespawnTime Сколько секунд нужно для респауна кейса с инфой.
-- --  
-- IntelRespawnTime Seconds to respawn case with intel
TW.IntelRespawnTime 				= 60 * 3




-- GroupStartSalaryDelay Изначальный промежуток времени между зарплатами.
-- -- 
-- GroupStartSalaryDelay Group salary delay at start
TW.GroupStartSalaryDelay			= 60




-- BringCaseReward Какая награда, если принести кейс.
-- -- 
-- BringCaseReward Reward when case was passed
TW.BringCaseReward 					= 1200




-- BringIncomeCaseReward Какая награда, если принести кейс с доходом.
-- -- 
-- BringIncomeCaseReward Reward when case with income was passed
TW.BringIncomeCaseReward			= 200




-- RoleUpgrading Включить ли вообще прокачку ролей.
-- Включённая прокачка ролей может немного сожрать фпс на сервере.
-- true  - включить
-- false - выключить
-- --
-- RoleUpgrading Enable ability to upgrade roles or not.
-- When enabled it can "eat" some fps on server
-- true  - enable
-- false - disable
TW.RoleUpgrading 					= true




-- RoleUpgradeCoolDown Включить ли обратный отсчёт до улучшения в роли.
-- true  - включить
-- false - отключить
-- -- 
-- RoleUpgradeCoolDown Enable countdown before upgrade role
-- true  - enable
-- false - disable
TW.RoleUpgradeCoolDown 				= false




-- AutoSaveDelay Сколько секунд в промежутке между автосейвами.
-- -- 
-- AutoSaveDelay How much seconds between autosaves
TW.AutoSaveDelay  					= 60




-- TerritoryCapturing Включить ли вообще захват территорий.
-- true  - включить
-- false - выключить
-- -- 
-- TerritoryCapturing Enable territory capturing
-- true  - enable
-- false - disable 
TW.TerritoryCapturing				= false








-- CriticalDamage Множитель критического урона.
-- --
-- CriticalDamage Critical damage multiplier
TW.CriticalDamage 					= 12.0




-- BuyTimeSeconds как много секунд можно купить за раз
-- -- 
-- BuyTimeSeconds how much seconds group can buy at one time
TW.BuyTimeSeconds					= 60 * 60 * 3




-- BuyTimePoints Сколько очков надо заплатить за время
-- -- 
-- BuyTimePoints How much points group need to pay when buy a time
TW.BuyTimePoints					= 300




-- HandGetIncome Нужно ли брать доход с территорий/флагов вручную
-- true  - да
-- false - нет
-- -- 
-- HandGetIncome Do groups need to take income from territories/flags manually?
-- true  - yes
-- false - no
TW.HandGetIncome 					= false




-- ShopActivated Включён ли магазин
-- true  - да
-- false - нет
-- -- 
-- ShopActivated Is shop enabled?
-- true  - yes
-- false - no
TW.ShopActivated 					= true




-- ShopPocketLimit Лимит Shop Pocket'a
-- -- 
-- ShopPocketLimit Limit of Shop Pocket
TW.ShopPocketLimit 					= 20




-- QuestsAvailable Активированы ли задания
-- true  - да
-- false - нет
-- -- 
-- QuestsAvailable Are quests activated
-- true  - yes
-- false - no
TW.QuestsAvailable 					= true




-- GroupUpgrading Доступна ли прокачка группировки
-- true  - да 
-- false - нет
-- -- 
-- GroupUpgrading Is group upgrading available
-- true  - yes
-- false - no
TW.GroupUpgrading 					= true


-- SpecialDoorHealth Здоровье у специальной двери
-- --
-- SpecialDoorHealth Special door health
TW.SpecialDoorHealth                = 60000

-- SpecialDoorHealthRegenerationTime Время регенерации здоровья у специальной двери
-- --
-- SpecialDoorHealthRegenerationTime Special door regeneration time
TW.SpecialDoorHealthRegenerationTime    = 60


-- ShopHealth Здоровье у магазина
-- --
-- ShopHealth Shop health
TW.ShopHealth                = 10000

-- ShopHealthRegenerationTime Время регенерации здоровья у магазина
-- --
-- ShopHealthRegenerationTime Shop regeneration time
TW.ShopHealthRegenerationTime    = 60



-- GroupUpgradeCoolDown Включить ли обратный отсчёт перед прокачкой
-- true  - да
-- false - нет
-- -- 
-- GroupUpgradeCoolDown Is countdown before group upgrade activated
-- true  - yes
-- false - no
TW.GroupUpgradeCoolDown 			= false




-- TerritoryRetainerFlagRadius Радиус действия удерживателя территорий на флаги
-- --
-- TerritoryRetainerFlagRadius Radius of territory retainer in which he hold the flag
TW.TerritoryRetainerFlagRadius 		= 3500




-- NoviceSlotsCount Количество слотов у первой роли изначально
-- --
-- NoviceSlotsCount Count of slots in novice role from beginning
TW.NoviceSlotsCount = 10








-- AdrenalineEnabled Включена ли прокачка "Адреналин"
-- true  - включить
-- false - выключить
-- -- 
-- AdrenalineEnabled Is role upgrade "Adrenaline" enabled?
-- true  - yes
-- false - no
TW.AdrenalineEnabled 				= true




-- AdrenalineAddPrice Сколько добавляет к цене "Адреналин"
-- -- 
-- AdrenalineAddPrice How many "Adrenaline" adds to price
TW.AdrenalineAddPrice				= 1




-- AdrenalineUpgradePrice Сколько стоит "Адреналин"
-- --
-- AdrenalineUpgradePrice How much "Adrenaline" costs
TW.AdrenalineUpgradePrice			= 50000




-- AdrenalineSpeed Промежуток времени в секундах
-- между поднятием хп (т.е регеном) у "Адреналина".
-- --
-- AdrenalineSpeed Regeneration speed of "Adrenaline"
TW.AdrenalineSpeed					= 0.2




-- AdrenalineRegenerationPower Сколько хп добавляет
-- каждый реген от "Адреналина"
-- -- 
-- AdrenalineRegenerationPower How much HP "Adrenaline" regeneration restore at one time
TW.AdrenalineRegenerationPower 		= 10




-- AdrenalineHealthLimit Минимальное кол-во хп,
-- при котором "Адреналин" начинает работать.
-- --
-- AdrenalineHealthLimit Minimum amount of HP to make "Adrenaline" work
TW.AdrenalineHealthLimit				= 99





-- AdrenalineCoolDown Количество секунд до прокачки "Адреналина"
-- --
-- AdrenalineCoolDown Amount of seconds before "Adrenaline" will upgraded
TW.AdrenalineCoolDown				= 60 * 4








-- RunnerEnabled Включать ли "Бегуна".
-- true  - включить
-- false - выключить
-- -- 
-- RunnerEnabled Is role upgrade "Runner" enabled?
-- true  - yes
-- false - no
TW.RunnerEnabled					= true




-- RunnerAddPrice Сколько "Бегун" добавляет к цене
-- -- 
-- RunnerAddPrice How many "Runner" adds to price
TW.RunnerAddPrice					= 5




-- RunnerUpgradePrice Сколько "Бегун" стоит
-- --
-- RunnerUpgradePrice How much "Runner" costs
TW.RunnerUpgradePrice 				= 50000




-- RunnerHealthLimit Сколько хп нужно иметь, что бы "Бегун"
-- заработал.
-- -- 
-- RunnerHealthLimit Minimum amount of HP to make "Runner" work
TW.RunnerHealthLimit 				= 60




-- RunnerTime Сколько секунд длится бафф от попавшей в игрока пули
-- --
-- RunnerTime Amount of seconds that "Runner" work
TW.RunnerTime 						= 30




-- RunnerDodgeProcent Сколько процентов шанса уклониться даётся при баффе.
-- --
-- RunnerDodgeProcent How many procents adds to chance to dodge bullet when "Runner" is active
TW.RunnerDodgeProcent				= 90




-- RunnerPower Как сильно увеличивает скорость персонажа в процентах.
-- --
-- RunnerPower How much "Runner" increases speed of player when "Runner" is active
TW.RunnerPower						= 20




-- RunnerCoolDown Количество секунд до прокачки "Бегуна"
-- --
-- RunnerCoolDown Amount of seconds before "Runner" will upgraded
TW.RunnerCoolDown 					= 60 * 5








-- HealthEnabled Включено ли "Здоровье"
-- true  - включить
-- false - выключить
-- -- 
-- HealthEnabled Is role upgrade "Health" enabled?
-- true  - yes
-- false - no
TW.HealthEnabled					= true




-- HealthMaximum Сколько раз можно прокачать "Здоровье"
TW.HealthMaximum 					= 100000




-- HealthAddPrice На сколько увеличивает цену прокачка "Здоровья"
-- -- 
-- HealthAddPrice How many "Health" adds to price
TW.HealthAddPrice 					= 1




-- HealthPerTier Сколько даётся здоровья за каждый уровень.
TW.HealthPerTier					= 100




-- HealthUpgradePrice Сколько стоит "Здоровье"
-- --
-- HealthUpgradePrice How much "Health" costs
TW.HealthUpgradePrice				= 50000




-- HealthCoolDown Количество секунд до прокачки "Health"
-- --
-- HealthCoolDown Amount of seconds before "Health" will upgraded
TW.HealthCoolDown					= 20




-- HealthFirstCoolDown Количество секунд до первой прокачки "Здоровья"
-- --
-- HealthFirstCoolDown Amount of seconds before "Health" will upgraded at first time 
TW.HealthFirstCoolDown 				= 60








-- ArmorEnabled Включена ли "Броня"
-- true  - включить
-- false - выключить
-- -- 
-- ArmorEnabled Is role upgrade "Armor" enabled?
-- true  - yes
-- false - no
TW.ArmorEnabled						= true




-- ArmorMaximum Сколько раз можно прокачать "Броню"
TW.ArmorMaximum						= 100000



-- ArmorUpgradePrice Сколько стоит "Броня"
-- --
-- ArmorUpgradePrice How much "Armor" costs
TW.ArmorUpgradePrice 				= 50000




-- ArmorAddPrice Сколько добавляет к цене прокачка "Брони"
-- -- 
-- ArmorAddPrice How many "Armor" adds to price
TW.ArmorAddPrice 					= 1




-- ArmorPerTier Сколько брони даётся за прокачку "Брони"
TW.ArmorPerTier 					= 100




-- ArmorFirstCoolDown Количество секунд до первой прокачки "Брони"
-- --
-- ArmorFirstCoolDown Amount of seconds before "Armor" will upgraded at first time
TW.ArmorFirstCoolDown				= 60 * 2




-- ArmorCoolDown Количество секунд до прокачки "Брони"
-- --
-- ArmorCoolDown Amount of seconds before "Armor" will upgraded
TW.ArmorCoolDown 					= 30








-- SpeedEnabled Включена ли "Скорость"
-- true  - включить
-- false - выключить
-- -- 
-- SpeedEnabled Is role upgrade "Speed" enabled?
-- true  - yes
-- false - no
TW.SpeedEnabled						= true




-- SpeedMaximum Сколько раз максимум можно прокачать "Скорость"
TW.SpeedMaximum						= 2




-- SpeedUpgradePrice Сколько стоит прокачка "Скорости"
-- --
-- SpeedUpgradePrice How much "Speed" costs
TW.SpeedUpgradePrice 				= 50000




-- SpeedPerTier Как сильно увеличивает скорость прокачка "Скорости"
TW.SpeedPerTier 					= 15




-- SpeedAddPrice Сколько добавляет к цене прокачка "Скорости"
-- -- 
-- SpeedAddPrice How many "Speed" adds to price
TW.SpeedAddPrice					= 0




-- SpeedCoolDown Количество секунд до прокачки "Скорости"
-- --
-- SpeedCoolDown Amount of seconds before "Speed" will upgraded
TW.SpeedCoolDown 					= 60 * 2




-- SpeedFirstCoolDown Количество секунд до первой прокачки "Скорости"
-- --
-- SpeedFirstCoolDown Amount of seconds before "Speed" will upgraded at first time
TW.SpeedFirstCoolDown 				= 60 * 5








-- JumpEnabled Включен ли "Прыжок"
-- true  - включить
-- false - выключить
-- -- 
-- JumpEnabled Is role upgrade "Jump" enabled?
-- true  - yes
-- false - no
TW.JumpEnabled						= true




-- JumpMaximum Сколько раз можно прокачать "Прыжок"
TW.JumpMaximum						= 2




-- JumpUpgradePrice Сколько стоит "Прыжок"
-- --
-- JumpUpgradePrice How much "Jump" costs
TW.JumpUpgradePrice 				= 50000




-- JumpAddPrice Сколько добавляет к цене "Прыжок"
-- -- 
-- JumpAddPrice How many "Jump" adds to price
TW.JumpAddPrice						= 0




-- JumpPerTier Сколько добавляет к высоте прыжка "Прыжок"
-- -- 
-- JumpPerTier How much "Jump" adds to players jump height
TW.JumpPerTier 						= 40




-- JumpFirstCoolDown Количество секунд до первой прокачки "Прыжка"
-- --
-- JumpFirstCoolDown Amount of seconds before "Health" will upgraded at first time
TW.JumpFirstCoolDown 				= 60 * 5




-- JumpCoolDown Количество секунд до прокачки "Прыжка"
-- --
-- JumpCoolDown Amount of seconds before "Jump" will upgraded
TW.JumpCoolDown 					= 60 * 2









-- RegenerationEnabled Включена ли "Регенерация"
-- true  - включить
-- false - выключить
-- -- 
-- RegenerationEnabled Is role upgrade "Regeneration" enabled?
-- true  - yes
-- false - no
TW.RegenerationEnabled				= true




-- RegenerationMaximum Сколько раз максимум можно прокачать "Регенерацию"
TW.RegenerationMaximum				= 4




-- RegenerationUpgradePrice Сколько стоит "Регенерация"
-- --
-- RegenerationUpgradePrice How much "Regeneration" costs
TW.RegenerationUpgradePrice 		= 50000




-- RegenerationAddPrice Сколько добавляет к цене "Регенерация"
-- -- 
-- RegenerationAddPrice How many "Regeneration" adds to price
TW.RegenerationAddPrice				= 1




-- RegenerationSpeedPerTier Как сильно ускоряет каждая прокачка "Регенерации" 
-- Каждые (RegenerationSpeedPerTier / уровень_регенерации) секунд оно будет восстанавливать
-- RegenerationPower здоровья.
-- -- 
-- RegenerationSpeedPerTier How fast "Regeneration" restores health.
-- Every (RegenerationSpeedPerTier / regeneration_tier) seconds "Regeneration" will restore
-- RegenerationPower of health.
TW.RegenerationSpeedPerTier 		= 3




-- RegenerationPower Сколько здоровья будет восстанавливать "Регенерация" за раз.
-- -- 
-- RegenerationPower How many health "Regeneration" will restore at one time.
TW.RegenerationPower 				= 5




-- RegenerationCoolDown Количество секунд до прокачки "Регенерации"
-- --
-- RegenerationCoolDown Amount of seconds before "Regeneration" will upgraded 
TW.RegenerationCoolDown 			= 60 * 2




-- RegenerationFirstCoolDown Количество секунд до первой прокачки "Регенерации"
-- --
-- RegenerationFirstCoolDown Amount of seconds before "Regeneration" will upgraded at first time
TW.RegenerationFirstCoolDown 		= 60 * 5








-- DodgeEnabled Включено ли "Уклонение"
-- true  - включить
-- false - выключить
-- -- 
-- DodgeEnabled Is role upgrade "Dodge" enabled?
-- true  - yes
-- false - no
TW.DodgeEnabled						= true




-- DodgeMaximum Сколько раз максимум можно прокачать "Уклонение"
TW.DodgeMaximum						= 10




-- DodgeUpgradePrice Сколько стоит "Уклонение"
-- --
-- DodgeUpgradePrice How much "Dodge" costs
TW.DodgeUpgradePrice 				= 50000




-- DodgeAddPrice Сколько добавляет к цене "Уклонение"
-- -- 
-- DodgeAddPrice How many "Dodge" adds to price
TW.DodgeAddPrice					= 20




-- DodgePerTier Сколько процентов шанса уклониться добавляет "Уклонение"
TW.DodgePerTier 					= 20




-- DodgeCoolDown Количество секунд до прокачки "Уклонения"
-- --
-- DodgeCoolDown Amount of seconds before "Dodge" will upgraded
TW.DodgeCoolDown					= 60




-- DodgeFirstCoolDown Количество секунд до первой прокачки "Уклонение"
-- --
-- DodgeFirstCoolDown Amount of seconds before "Dodge" will upgraded at first time
TW.DodgeFirstCoolDown				= 60 * 3








-- CritsEnabled Включены ли "Криты"
-- true  - включить
-- false - выключить
-- -- 
-- CritsEnabled Is role upgrade "Crits" enabled?
-- true  - yes
-- false - no
TW.CritsEnabled						= true




-- CritsMaximum Сколько раз максимум можно прокачать "Криты"
TW.CritsMaximum						= 2




-- CritsUpgradePrice Сколько стоят "Криты"
-- --
-- CritsUpgradePrice How much "Crits" costs
TW.CritsUpgradePrice 				= 50000




-- CritsAddPrice Сколько добавляют к цене "Криты"
-- -- 
-- CritsAddPrice How many "Crits" adds to price
TW.CritsAddPrice					= 3




-- CritsAddPrice Сколько процентов шанса нанести критический урон
-- даётся за каждый уровень "Криты"
TW.CritsPerTier 					= 10




-- CritsFirstCoolDown Количество секунд до первой прокачки "Криты"
-- --
-- CritsFirstCoolDown Amount of seconds before "Crits" will upgraded at first time
TW.CritsFirstCoolDown				= 60 * 4




-- CritsCoolDown Количество секунд до прокачки "Криты"
-- --
-- CritsCoolDown Amount of seconds before "Crits" will upgraded 
TW.CritsCoolDown 					= 60








-- DamageEnabled Включён ли "Урон"
-- true  - включить
-- false - выключить
-- --
-- DamageEnabled Is role upgrade "Damage" enabled?
-- true  - yes
-- false - no
TW.DamageEnabled					= true




-- DamageMaximum Сколько раз максимум можно прокачать "Урон"
-- -- 
-- DamageMaximum Maximum of "Damage" upgrading
TW.DamageMaximum 					= 100000




-- DamageUpgradePrice Сколько стоит "Урон"
-- --
-- DamageUpgradePrice How much "Damage" costs
TW.DamageUpgradePrice 				= 50000




-- DamageAddPrice Сколько добавляет к цене урон
-- -- 
-- DamageAddPrice How many "Damage" adds to price
TW.DamageAddPrice					= 1




-- DamagePerTier Сколько процентов добавляет к урону каждый уровень "Урон"
-- -- 
-- DamagePerTier How many procents to damage adds "Damage"
TW.DamagePerTier 					= 100




-- DamageFirstCoolDown Количество секунд до первой прокачки "Урон"
-- --
-- DamageFirstCoolDown Amount of seconds before "Damage" will upgraded at first time
TW.DamageFirstCoolDown				= 60 * 2




-- DamageCoolDown Количество секунд до прокачки "Урон"
-- --
-- DamageCoolDown Amount of seconds before "Damage" will upgraded
TW.DamageCoolDown					= 60








-- StealthEnabled Включён ли "Стелс"
-- true  - включить
-- false - выключить
-- --
-- StealthEnabled Is role upgrade "Stealth" enabled?
-- true  - yes
-- false - no
TW.StealthEnabled					= false




-- StealthAddPrice Сколько добавляет к цене "Стелс"
-- -- 
-- StealthAddPrice How many "Stealth" adds to price
TW.StealthAddPrice					= 5




-- StealthUpgradePrice Цена "Стелса"
-- --
-- StealthUpgradePrice How much "Stealth" costs
TW.StealthUpgradePrice				= 50000




-- StealthCoolDown Количество секунд до прокачки "Стелс"
-- --
-- StealthCoolDown Amount of seconds before "Stealth" will upgraded
TW.StealthCoolDown 					= 60 * 3




-- StealthFOVNeeded Как сильно нужно зайти за спину жертве для крита (градусы)
-- --
-- StealthFOVNeeded How much you need to go begind the victim for crit (degrees)
TW.StealthFOVNeeded 				= 90



-- StealthEnableInvisible Становятся ли в присяди игроки невидимыми со "Стелсом"
-- --
-- StealthEnableInvisible Can player with "Stealth" upgraded become invisible while crouching?
TW.StealthEnableInvisible           = true



-- StealthDisableTime Время которое нельзя стать невидимым если попали
-- --
-- StealthDisableTime Time that player cant become invisible if player takes damage from bullets
TW.StealthDisableTime               = 5








-- ArmorerEnabled Включён ли "Техник"
-- true  - включить
-- false - выключить
-- --
-- ArmorerEnabled Is role upgrade "Armorer" enabled?
-- true  - yes
-- false - no
TW.ArmorerEnabled					= true




-- ArmorerAddPrice Сколько добавляет к цене "Техник"
-- -- 
-- ArmorerAddPrice How many "Armorer" adds to price
TW.ArmorerAddPrice					= 1




-- ArmorerUpgradePrice Сколько стоит "Техник"
-- --
-- ArmorerUpgradePrice How much "Armorer" costs
TW.ArmorerUpgradePrice 				= 50000




-- ArmorerDelay Какой промежуток времени в секундах между регеном брони 
-- возле члена группировки с "Техником"
-- -- 
-- ArmorerDelay How many seconds before "Armorer" will restore armor
TW.ArmorerDelay 					= 1




-- ArmorerPower Как много восстанавливает брони за раз.
-- -- 
-- ArmorerPower How many "Armorer" will restore armor at one time
TW.ArmorerPower 					= 10





-- ArmorerDistance Как далеко радиус действия "Техника"
-- -- 
-- ArmorerDistance Radius of "Armorer"
TW.ArmorerDistance	 				= 500




-- ArmorerCoolDown Количество секунд до прокачки "Техника"
-- --
-- ArmorerCoolDown Amount of seconds before "Armorer" will upgraded
TW.ArmorerCoolDown					= 60 * 7








-- MedicEnabled Включён ли "Медик"
-- true  - включить
-- false - выключить
-- --
-- MedicEnabled Is role upgrade "Medic" enabled?
-- true  - yes
-- false - no
TW.MedicEnabled						= true




-- MedicAddPrice Сколько добавляет к цене "Медик"
-- -- 
-- MedicAddPrice How many "Medic" adds to price
TW.MedicAddPrice					= 1




-- MedicUpgradePrice Сколько стоит "Медик"
-- --
-- MedicUpgradePrice How much "Medic" costs
TW.MedicUpgradePrice 				= 50000




-- MedicDelay Промежуток времени в секундах между регеном здоровья
-- возле члена группировки с "Медиком"
-- -- 
-- MedicDelay How many seconds before "Medic" will restore health
TW.MedicDelay 						= 1




-- MedicPower Как много здоровья "Медик" восстанавливает за раз.
-- --
-- MedicPower How many "Medic" will restore health at one time
TW.MedicPower 						= 10




-- MedicDistance Радиус действия "Медика"
-- --  
-- MedicDistance "Medic" radius
TW.MedicDistance					= 500




-- MedicCoolDown Количество секунд до прокачки "Медика"
-- --
-- MedicCoolDown Amount of seconds before "Medic" will upgraded
TW.MedicCoolDown 					= 60 * 5








-- TankEnabled Включён ли "Танк"
-- true  - включить
-- false - выключить
-- --
-- TankEnabled Is role upgrade "Tank" enabled?
-- true  - yes
-- false - no
TW.TankEnabled 						= true




-- TankAddPrice Сколько добавляет к цене "Танк"
-- -- 
-- TankAddPrice How many "Tank" adds to price
TW.TankAddPrice						= 1




-- TankUpgradePrice Сколько стоит "Танк"
-- --
-- TankUpgradePrice How much "Tank" costs
TW.TankUpgradePrice 				= 50000




-- TankPower Как много процентов от нанесённого урона преобразуется в броню
-- --
-- TankPower How many procents from damage will converted to armor
TW.TankPower						= 100




-- TankHealthLimit При каком количестве здоровья "Танк" начинает работать
-- --
-- TankHealthLimit Minimal amount of HP to make "Tank" work
TW.TankHealthLimit					= 100




-- TankCoolDown Количество секунд до прокачки "Танк"
-- --
-- TankCoolDown Amount of seconds before "Tank" will upgraded
TW.TankCoolDown 					= 60 * 10









-- AllyGroupQuestPointsReward Сколько даёт групповой квест "Союзник" очков.
-- -- 
-- AllyGroupQuestPointsReward How many points gives "Ally" quest
TW.AllyGroupQuestPointsReward 		= 5000




-- AllyGroupQuestLifeTimeReward Сколько даёт групповой квест "Союзник" секунд жизни группировки.
-- -- 
-- AllyGroupQuestLifeTimeReward How many seconds gives "Ally" quest
TW.AllyGroupQuestLifeTimeReward		= 60 * 20








-- DestroyGroupQuestPointsReward Сколько даёт групповой квест "Уничтожить" очков.
-- -- 
-- DestroyGroupQuestPointsReward How many points gives "Destroy" quest
TW.DestroyGroupQuestPointsReward 	= 20000




-- DestroyGroupQuestLifeTimeReward Сколько даёт групповой квест "Уничтожить" секунд жизни группировки.
-- --
-- DestroyGroupQuestLifeTimeReward How many seconds gives "Destroy" quest
TW.DestroyGroupQuestLifeTimeReward	= 60 * 60 * 2








-- QuestDoneGroupQuestPointsReward Сколько даёт прибавки к награде в очках групповой квест "Рекорд" за 
-- количество выполненных квестов в условии.
-- Если в условии сказано выполнить 5 квестов,
-- то выдаст 5000, если QuestDoneGroupQuestPointsReward = 1000
-- -- 
-- QuestDoneGroupQuestPointsReward How many points adds to reward in "Goal" quest
-- for count of completed quests in list.
-- If in list says that you need to complete 5 quests,
-- then the reward is 5000 if QuestDoneGroupQuestPointsReward = 1000
TW.QuestDoneGroupQuestPointsReward  	= 500




-- QuestDoneGroupQuestLifeTimeReward Сколько секунд жизни группировки даёт "Рекорд" при выполнении
-- --
-- QuestDoneGroupQuestLifeTimeReward How many seconds gives "Goal" quest
TW.QuestDoneGroupQuestLifeTimeReward	= 60 * 60 * 24 * 7




-- QuestDoneGroupQuestTimeLength Сколько секунд длится групповой квест "Рекорд". 
-- Работает как QuestDoneGroupQuestPointsReward
-- -- 
-- QuestDoneGroupQuestTimeLength How many seconds lasts "Goal" quest
-- Works like QuestDoneGroupQuestPointsReward
TW.QuestDoneGroupQuestTimeLength		= 60 * 5









-- PassCasesGroupQuestPointsReward Как много очков даёт задание "Кейсы" за выполнение
-- -- 
-- PassCasesGroupQuestPointsReward How many points gives "Cases" quest
TW.PassCasesGroupQuestPointsReward 		= 6000
-- PassCasesGroupQuestLifeTimeReward Как много секунд жизни группировки даёт "Кейсы" за выполнение
-- -- 
-- PassCasesGroupQuestLifeTimeReward How many seconds gives "Cases" quest
TW.PassCasesGroupQuestLifeTimeReward 	= 60 * 60 * 24 * 7
-- PassCasesGroupQuestCount Как много кейсов нужно принести в задании "Кейсы"
-- -- 
-- PassCasesGroupQuestCount How many cases you need to bring in "Cases" quest
TW.PassCasesGroupQuestCount				= 20
-- PassCasesGroupQuestTimeLength Сколько секунд длится задание "Кейсы"
-- --
-- PassCasesGroupQuestTimeLength How many seconds lasts "Cases" quest
TW.PassCasesGroupQuestTimeLength 		= 60 * 20








-- AttackGroupQuestTimeLength Сколько секунд длится задание "Удержать" (для территорий)
-- -- 
-- AttackGroupQuestTimeLength How many seconds lasts "Hold" quest (for territories)
TW.AttackGroupQuestTimeLength				= 60 * 15




-- AttackGroupQuestTerritoriesLimit Максимум территорий в задании "Удержать"
-- -- 
-- AttackGroupQuestTerritoriesLimit Maximum of territories in "Hold" quest
TW.AttackGroupQuestTerritoriesLimit 		= 5




-- AttackGroupQuestPointsReward Сколько очков даёт задание "Удержать"
-- -- 
-- AttackGroupQuestPointsReward How many points gives "Hold" quest
TW.AttackGroupQuestPointsReward 			= 5000




-- AttackGroupQuestLifeTimeReward Сколько секунд жизни группировки даёт задание "Удержать"
-- -- 
-- AttackGroupQuestLifeTimeReward How many seconds gives "Hold" quest
TW.AttackGroupQuestLifeTimeReward 			= 60 * 60 * 24 * 7




-- AttackGroupQuestGroupsLimit Сколько группировок может получить задание "Удержать"
-- -- 
-- AttackGroupQuestGroupsLimit How many groups can get "Hold" quest
TW.AttackGroupQuestGroupsLimit				= 2




-- AttackGroupQuestParticalPointsReward Частичная награда в очках за провал задания "Удержать"
-- -- 
-- AttackGroupQuestParticalPointsReward Partical reward in points for "Hold" quest fail
TW.AttackGroupQuestParticalPointsReward 	= 600




-- AttackGroupQuestParticalLifeTimeReward Частичная награда в секундах жизни группировки за провал задания "Удержать"
-- -- 
-- AttackGroupQuestParticalLifeTimeReward Partical reward in seconds for "Hold" quest fail
TW.AttackGroupQuestParticalLifeTimeReward 	= 60 * 60 * 24








-- AttackFlagGroupQuestTimeLength Сколько секунд длится задание "Удержать" (для флагов)
-- -- 
-- AttackFlagGroupQuestTimeLength How many seconds lasts "Hold" quest (for flags)
TW.AttackFlagGroupQuestTimeLength				= 60 * 15




-- AttackFlagGroupQuestFlagLimit Максимум флагов в задании "Удержать" (для флагов)
-- -- 
-- AttackFlagGroupQuestFlagLimit Maximum of flags in "Hold" quest (for flags)
TW.AttackFlagGroupQuestFlagLimit 				= 2




-- AttackFlagGroupQuestPointsReward Сколько очков даёт задание "Удержать" (для флагов)
-- -- 
-- AttackFlagGroupQuestPointsReward How many points gives "Hold" quest (for flags)
TW.AttackFlagGroupQuestPointsReward 			= 5000




-- AttackGroupQuestLifeTimeReward Сколько секунд жизни группировки даёт задание "Удержать" (для флагов)
-- -- 
-- AttackGroupQuestLifeTimeReward How many seconds gives "Hold" quest (for flags)
TW.AttackFlagGroupQuestLifeTimeReward 			= 60 * 60 * 24 * 7




-- AttackGroupQuestGroupsLimit Сколько группировок может получить задание "Удержать" (для флагов)
-- -- 
-- AttackGroupQuestGroupsLimit How many groups can get "Hold" quest (for flags)
TW.AttackFlagGroupQuestGroupsLimit				= 2




-- AttackGroupQuestParticalPointsReward Частичная награда в очках за провал задания "Удержать" (для флагов)
-- -- 
-- AttackGroupQuestParticalPointsReward Partical reward in points for "Hold" quest fail
TW.AttackFlagGroupQuestParticalPointsReward 	= 600




-- AttackGroupQuestParticalLifeTimeReward Частичная награда в секундах жизни группировки за провал задания "Удержать"
-- -- 
-- AttackGroupQuestParticalLifeTimeReward Partical reward in seconds for "Hold" quest fail
TW.AttackFlagGroupQuestParticalLifeTimeReward 	= 60 * 60 * 24








-- AttackQuestPointsReward Сколько даёт очков квест "Захват" (для территорий)
-- -- 
-- AttackQuestPointsReward How many points gives "Capture" quest (for territories)
TW.AttackQuestPointsReward				= 10




-- AttackQuestTimeLength Сколько длится квест "Захват" (для территорий)
-- --
-- AttackQuestTimeLength How many seconds lasts "Capture" quest (for territories)
TW.AttackQuestTimeLength				= 60 * 5




-- AttackFlagQuestPointsReward Сколько даёт очков квест "Захват" (для флагов)
-- -- 
-- AttackFlagQuestPointsReward How many points gives "Capture" quest (for flags)
TW.AttackFlagQuestPointsReward			= 600




-- AttackFlagQuestTimeLength Сколько длится квест "Захват" (для флагов)
-- -- 
-- AttackFlagQuestTimeLength How many seconds lasts "Capture" quest (for flags)
TW.AttackFlagQuestTimeLength			= 60 * 5








-- MovingQuestPointsReward Сколько даёт очков задание "Разведка" (для территорий)
-- -- 
-- MovingQuestPointsReward How many points gives "Scout" quest (for territories)
TW.MovingQuestPointsReward				= 3




-- MovingQuestTimeLength Сколько длится задание "Разведка" (для территорий)
-- -- 
-- MovingQuestTimeLength How many seconds lasts "Scout" quest (for territories)
TW.MovingQuestTimeLength				= 60




-- MovingQuestPointsReward Сколько даёт очков задание "Разведка" (для флагов)
-- -- 
-- MovingQuestPointsReward How many points gives "Scout" quest (for flags)
TW.MovingOnFlagQuestPointsReward		= 500




-- MovingQuestTimeLength Сколько длится задание "Разведка" (для флагов)
-- -- 
-- MovingQuestTimeLength How many seconds lasts "Scout" quest (for flags)
TW.MovingOnFlagQuestTimeLength			= 60








-- DefendQuestPointsReward Сколько даёт очков квест "Защита" (для территорий)
-- -- 
-- DefendQuestPointsReward How many points gives "Defend" quest (for territories)
TW.DefendQuestPointsReward				= 1200




-- DefendQuestTimeLength Сколько времени длится квест "Защита" (для территорий)
-- -- 
-- DefendQuestTimeLength How many seconds lasts "Defend" quest (for territories)
TW.DefendQuestTimeLength 				= 60 * 10




-- DefendQuestPointsReward Сколько даёт очков квест "Защита" (для флагов)
-- -- 
-- DefendFlagQuestPointsReward How many points gives "Defend" quest (for flags)
TW.DefendFlagQuestPointsReward			= 1200



-- DefendQuestTimeLength Сколько времени длится квест "Защита" (для флагов)
-- -- 
-- DefendFlagQuestTimeLength How many seconds lasts "Defend" quest (for flags)
TW.DefendFlagQuestTimeLength 			= 60 * 10








-- KillerQuestPointsReward Сколько очков даёт квест "Киллер"
-- -- 
-- KillerQuestPointsReward How many points gives "Killer" quest
TW.KillerQuestPointsReward			= 1000




-- KillerQuestTimeLength Сколько секунд длится квест "Киллер"
-- --
-- KillerQuestTimeLength How many seconds lasts "Killer" quest
TW.KillerQuestTimeLength			= 60 * 10




-- KillerQuestInfoOnActivateChance Каков шанс, что квест "Киллер"
-- сделает объявление в чат о том, что он был начат.
-- --
-- KillerQuestInfoOnActivateChance Chance of that quest "Killer" will
-- make advert about his start.
TW.KillerQuestInfoOnActivateChance 	= 50








-- PassCaseQuestPointsReward Сколько даёт квест "Принести кейс" очков
-- --
-- PassCaseQuestPointsReward How many points gives "Pass case" quest
TW.PassCaseQuestPointsReward 		= 700




-- PassCaseQuestTimeLength Сколько длится квест "Принести кейс" секунд
-- -- 
-- PassCaseQuestTimeLength How many seconds lasts "Pass case" quest
TW.PassCaseQuestTimeLength			= 60 * 5




-- PassCaseQuestCreateChance Сколько процентов шанса того, что "Принести кейс"
-- появится в списке квестов.
-- --
-- PassCaseQuestCreateChance How many procents of change that "Pass case" will generated
TW.PassCaseQuestCreateChance		= 10








-- FlagCaptureDistance Размер радиуса, в котором игроки учитываются как участвующие в захвате.
-- --
-- FlagCaptureDistance Radius of flag capture
TW.FlagCaptureDistance 				= 500








-- GroupIncomeUpgradeEnabled "Увеличить доход" включен
-- true  - да
-- false - нет
-- --
-- GroupIncomeUpgradeEnabled "Increase income" enabled
-- true  - yes
-- false - no
TW.GroupIncomeUpgradeEnabled			= true




-- GroupIncomeUpgradePrice Цена "Увеличить доход"
-- -- 
-- GroupIncomeUpgradePrice Price of "Income increase"
TW.GroupIncomeUpgradePrice 				= 1000




-- GroupIncomeUpgradeFirstCoolDown Секунды до первого улучшения "Увеличить доход"
-- --
-- GroupIncomeUpgradeFirstCoolDown Seconds before "Increase income" first upgrade
TW.GroupIncomeUpgradeFirstCoolDown		= 60 * 8




-- GroupIncomeUpgradeCoolDown Секунды до улучшения "Увеличить доход"
-- --
-- GroupIncomeUpgradeCoolDown Seconds before "Increase income" upgrade
TW.GroupIncomeUpgradeCoolDown 			= 60 * 5




-- GroupIncomeUpgradeMaximum Максимум улучшения "Увеличить доход"
-- --
-- GroupIncomeUpgradeMaximum "Increase income" maximum
TW.GroupIncomeUpgradeMaximum 			= 100000




-- GroupIncomeUpgradeUpgradedCount Сколько добавляет к цене "Увеличить доход"
-- -- 
-- GroupIncomeUpgradeUpgradedCount How many adds to price "Increase income" upgrade
TW.GroupIncomeUpgradeUpgradedCount 		= 100




-- GroupIncomeUpgradeProcents Сколько процентов добавляется к доходу из-за улучшения "Увеличить доход"
-- -- 
-- GroupIncomeUpgradeProcents How many procents adds to income because of "Increase income" upgrade
TW.GroupIncomeUpgradeProcents 			= 1000








-- GroupQuestPointsRewardUpgradeEnabled "Увеличение очков за задания" включен
-- true  - да
-- false - нет
-- --
-- GroupQuestPointsRewardUpgradeEnabled "Quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupQuestPointsRewardUpgradeEnabled 		= true




-- GroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за задания"
-- -- 
-- GroupQuestPointsRewardUpgradePrice Price of "Quest points reward increase"
TW.GroupQuestPointsRewardUpgradePrice			= 1000




-- GroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за задания"
-- --
-- GroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Quest points reward increase" first upgrade
TW.GroupQuestPointsRewardUpgradeFirstCoolDown	= 60 * 8




-- GroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за задания"
-- --
-- GroupQuestPointsRewardUpgradeCoolDown Seconds before "Quest points reward increase" upgrade
TW.GroupQuestPointsRewardUpgradeCoolDown 		= 60 * 5




-- GroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за задания"
-- --
-- GroupQuestPointsRewardUpgradeMaximum "Quest points reward increase" maximum
TW.GroupQuestPointsRewardUpgradeMaximum			= 100000




-- GroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за задания"
-- -- 
-- GroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Quest points reward increase" upgrade
TW.GroupQuestPointsRewardUpgradeUpgradedCount	= 100




-- GroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за задания"
-- -- 
-- GroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Quest points reward increase" upgrade
TW.GroupQuestPointsRewardUpgradeProcents		= 1000








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupGroupQuestPointsRewardUpgradeEnabled 		= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupGroupQuestPointsRewardUpgradePrice			= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupGroupQuestPointsRewardUpgradeFirstCoolDown	= 60 * 10




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupGroupQuestPointsRewardUpgradeCoolDown 		= 60 * 8




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupGroupQuestPointsRewardUpgradeMaximum		= 100000




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupGroupQuestPointsRewardUpgradeUpgradedCount	= 100




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupGroupQuestPointsRewardUpgradeProcents		= 1000








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled 			= false




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupGroupQuestLifeTimeRewardUpgradePrice			= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupGroupQuestLifeTimeRewardUpgradeFirstCoolDown	= 60 * 8




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupGroupQuestLifeTimeRewardUpgradeCoolDown 		= 60 * 6




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupGroupQuestLifeTimeRewardUpgradeMaximum			= 100000




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupGroupQuestLifeTimeRewardUpgradeUpgradedCount	= 100




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupGroupQuestLifeTimeRewardUpgradeProcents			= 1000








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupQuestPositiveTimeLengthUpgradeEnabled 			= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupQuestPositiveTimeLengthUpgradePrice				= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupQuestPositiveTimeLengthUpgradeFirstCoolDown		= 60 * 3




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupQuestPositiveTimeLengthUpgradeCoolDown 			= 60




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupQuestPositiveTimeLengthUpgradeMaximum			= 3




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupQuestPositiveTimeLengthUpgradeUpgradedCount		= 10




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupQuestPositiveTimeLengthUpgradeProcents			= 20








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupQuestNegativeTimeLengthUpgradeEnabled 			= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupQuestNegativeTimeLengthUpgradePrice				= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupQuestNegativeTimeLengthUpgradeFirstCoolDown		= 60 * 3




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupQuestNegativeTimeLengthUpgradeCoolDown 			= 60




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupQuestNegativeTimeLengthUpgradeMaximum			= 3




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupQuestNegativeTimeLengthUpgradeUpgradedCount		= 10




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupQuestNegativeTimeLengthUpgradeProcents			= 20








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupGroupQuestPositiveTimeLengthUpgradeEnabled 				= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupGroupQuestPositiveTimeLengthUpgradePrice				= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupGroupQuestPositiveTimeLengthUpgradeFirstCoolDown		= 60 * 8




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupGroupQuestPositiveTimeLengthUpgradeCoolDown 			= 60 * 6




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupGroupQuestPositiveTimeLengthUpgradeMaximum				= 3




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupGroupQuestPositiveTimeLengthUpgradeUpgradedCount		= 10




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupGroupQuestPositiveTimeLengthUpgradeProcents				= 20








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupGroupQuestNegativeTimeLengthUpgradeEnabled 				= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupGroupQuestNegativeTimeLengthUpgradePrice				= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupGroupQuestNegativeTimeLengthUpgradeFirstCoolDown		= 60 * 8




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupGroupQuestNegativeTimeLengthUpgradeCoolDown 			= 60 * 6




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupGroupQuestNegativeTimeLengthUpgradeMaximum				= 3




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupGroupQuestNegativeTimeLengthUpgradeUpgradedCount		= 10




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupGroupQuestNegativeTimeLengthUpgradeProcents				= 20








-- GroupRoleUpgradeDiscountUpgradeEnabled "Скидка на прокачку ролей" включен
-- true  - да
-- false - нет
-- --
-- GroupRoleUpgradeDiscountUpgradeEnabled "Role upgrading discount" enabled
-- true  - yes
-- false - no
TW.GroupRoleUpgradeDiscountUpgradeEnabled 				= true




-- GroupRoleUpgradeDiscountUpgradePrice Цена "Скидка на прокачку ролей"
-- -- 
-- GroupRoleUpgradeDiscountUpgradePrice Price of "Role upgrading discount"
TW.GroupRoleUpgradeDiscountUpgradePrice					= 1000




-- GroupRoleUpgradeDiscountUpgradeFirstCoolDown Секунды до первого улучшения "Скидка на прокачку ролей"
-- --
-- GroupRoleUpgradeDiscountUpgradeFirstCoolDown Seconds before "Role upgrading discount" first upgrade
TW.GroupRoleUpgradeDiscountUpgradeFirstCoolDown			= 60 * 3




-- GroupRoleUpgradeDiscountUpgradeCoolDown Секунды до улучшения "Скидка на прокачку ролей"
-- --
-- GroupRoleUpgradeDiscountUpgradeCoolDown Seconds before "Role upgrading discount" upgrade
TW.GroupRoleUpgradeDiscountUpgradeCoolDown 				= 60 * 2




-- GroupRoleUpgradeDiscountUpgradeMaximum Максимум улучшения "Скидка на прокачку ролей"
-- --
-- GroupRoleUpgradeDiscountUpgradeMaximum "Role upgrading discount" maximum
TW.GroupRoleUpgradeDiscountUpgradeMaximum				= 25




-- GroupRoleUpgradeDiscountUpgradeUpgradedCount Сколько добавляет к цене "Скидка на прокачку ролей"
-- -- 
-- GroupRoleUpgradeDiscountUpgradeUpgradedCount How many adds to price "Role upgrading discount" upgrade
TW.GroupRoleUpgradeDiscountUpgradeUpgradedCount			= 1




-- GroupRoleUpgradeDiscountUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Скидка на прокачку ролей"
-- -- 
-- GroupRoleUpgradeDiscountUpgradeProcents How many procents adds to reward because of "Role upgrading discount" upgrade
TW.GroupRoleUpgradeDiscountUpgradeProcents				= 20








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupRoleUpgradeCooldownDiscountUpgradeEnabled 				= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupRoleUpgradeCooldownDiscountUpgradePrice					= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupRoleUpgradeCooldownDiscountUpgradeFirstCoolDown			= 60 * 4




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupRoleUpgradeCooldownDiscountUpgradeCoolDown 				= 60 * 2




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupRoleUpgradeCooldownDiscountUpgradeMaximum				= 10




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupRoleUpgradeCooldownDiscountUpgradeUpgradedCount			= 25




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents				= 10








-- GroupGroupQuestPointsRewardUpgradeEnabled "Увеличение очков за групповые задания" включен
-- true  - да
-- false - нет
-- --
-- GroupGroupQuestPointsRewardUpgradeEnabled "Group quest points reward increase" enabled
-- true  - yes
-- false - no
TW.GroupShopDiscountUpgradeEnabled 					= true




-- GroupGroupQuestPointsRewardUpgradePrice Цена "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradePrice Price of "Group quest points reward increase"
TW.GroupShopDiscountUpgradePrice					= 1000




-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Секунды до первого улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeFirstCoolDown Seconds before "Group quest points reward increase" first upgrade
TW.GroupShopDiscountUpgradeFirstCoolDown			= 60 * 10




-- GroupGroupQuestPointsRewardUpgradeCoolDown Секунды до улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeCoolDown Seconds before "Group quest points reward increase" upgrade
TW.GroupShopDiscountUpgradeCoolDown 				= 60 * 5




-- GroupGroupQuestPointsRewardUpgradeMaximum Максимум улучшения "Увеличение очков за групповые задания"
-- --
-- GroupGroupQuestPointsRewardUpgradeMaximum "Group quest points reward increase" maximum
TW.GroupShopDiscountUpgradeMaximum					= 4




-- GroupGroupQuestPointsRewardUpgradeUpgradedCount Сколько добавляет к цене "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeUpgradedCount How many adds to price "Group quest points reward increase" upgrade
TW.GroupShopDiscountUpgradeUpgradedCount			= 25




-- GroupGroupQuestPointsRewardUpgradeProcents Сколько процентов добавляется к награде из-за улучшения "Увеличение очков за групповые задания"
-- -- 
-- GroupGroupQuestPointsRewardUpgradeProcents How many procents adds to reward because of "Group quest points reward increase" upgrade
TW.GroupShopDiscountUpgradeProcents					= 20










-- Дальше кривая локализация.

TW.Labels = {}

TW.Languages = {}
TW.DefaultLanguage = "Русский"

TW.Languages["Русский"] = function()
	TW.PermisionsList = {}

	local List = TW.PermisionsList
	List["Kick"] 					= "Выгонять."
	List["Invite"] 					= "Приглашать."
	List["Role changing"] 			= "Менять роли."
	List["Role creating"] 			= "Создавать и настраивать роли."
	List["Group point managing"] 	= "Снимать очки из группового счёта."
	List["Diplomacy"] 				= "Управлять дипломатией."
	List["MOTD"] 					= "Менять сообщение."
	if TW.GroupUpgrading then
		List["Group upgrading"] 	= "Улучшать группировку."
	end
	if TW.QuestsAvailable then
		List["Group quest accept"]  = "Принимать групповые задания"
	end

	TW.Labels.Guide =
	"   ВНИМАНИЕ: Этот гайд обновляется в зависимости от настроек аддона.\n\n" ..
	"   Инструкция для начала:\n" ..
	" Группировки из этого аддона не являются бессмертными, они могут быть уничтожены благодаря " ..
	"взрыву главного компьютера группировки или же по истечению времени жизни группировки. " ..
	"Так что главный компьютер ставьте в то место, где безопаснее всего.\n" ..
	"Если вы лидер, то сперва вам нужно поставить главный компьютер. " ..
	"Что бы его поставить вам нужно использовать SWEP на шестом слоте, который называется Computer Parts. " ..
	"Просто наводитесь на поверхность и жмёте ЛКМ. Будьте осторожны, компьютер очень большой по размерам.\n"
	if TW.ShopActivated then
		TW.Labels.Guide = TW.Labels.Guide .. "Так же не забудьте поставить магазин используя так же SWEP Shop Computer Parts.\n"
	end
	TW.Labels.Guide = TW.Labels.Guide .. "Вам как лидеру нужно нанимать людей в свою группировку что бы те помогали вам в ваших целях. " ..
	"Это делается в меню, которое можно открыть если использовать компьютер. Слева кнопка \"Пригласить\" и далее в окне выбираете " ..
	"кого нужно пригласить. Стоит помнить что вы можете доверить одному из членов группировки приглашение людей. Это делается в меню " .. 
	"\"Роли\", где вы можете для него создать новую роль, или назначить нужной разрешения нажав на шестерёнку справа от названия роли.\n"
	if TW.RoleUpgrading then
		TW.Labels.Guide = TW.Labels.Guide .. "Роли существуют не только для того что бы указать кто кем является, но и для того " ..
		"что бы улучшить характеристики людей имеющих ту или иную роль. Если вы прокачиваете роль, то люди имеющие эту роль " ..
		"получат тот бонус который вы решили прокачать. Что бы открыть меню прокачки роли нужно зайти в меню ролей и нажать на " ..
		"зелёную стрелку вверх справа от имени роли. Вам откроется окно с улучшениями, для того что бы узнать что даёт та или иная прокачка " ..
		"вам нужно навестись мышкой на её название. Больше подробностей о прокачке ролей можно найти ниже.\n"
	end
	TW.Labels.Guide = TW.Labels.Guide .. "Вам как лидеру люди нужны для захвата флагов или территорий. Что бы захватить флаг, нужно " ..
	"подойти к флагу и использовать его, в меню будет специальная кнопка для захвата этого флага.\n"
	if TW.TerritoryCapturing then 
		TW.Labels.Guide = TW.Labels.Guide .. "Что бы захватить территорию или по крайней мере понять в какой вы находитесь, нужно использовать " ..
		"нужные SWEP в шестом слоте. А именно:\n" ..
		"    Capturer: Для захвата территории. Нажимаете Левую Кнопку Мыши и начинаете захват." ..
		"    Map tablet: Для просмотра территорий. Нажимаете Левую Кнопку Мыши и появляется окно, где видны квадраты, " ..
		"обозначающие территории. Передвигаться по карте можно зажимая Левую Кнопку Мыши. Можно приближать или отдалять при помощи колёсика мыши. " ..
		"И не забудьте проверять бонусы, которые даёт территория нажав по ней Правой Кнопкой Мыши. В левом верхнем углу название территории, а " ..
		"справа снизу более точная координата квадрата.\n"
		if TW.HandGetIncome then
			TW.Labels.Guide = TW.Labels.Guide .. "    Income getter: Для получения прибыли с территории. " .. 
			"Нажимаете Левую Кнопку Мыши, получаете кейс и тащите его на базу.\n"
		end
	end
	if TW.HandGetIncome then 
		TW.Labels.Guide = TW.Labels.Guide .. "Группировка не может просто так получить прибыль, её нужно ещё дотащить. " ..
		"Получив кейс, нужно зайти в меню группировки используя компьютер, и слева нажать на соответствующую кнопку.\n" ..
		"Если вы умрёте по дороге на базу с кейсом, то он выпадает."
	end
	TW.Labels.Guide = TW.Labels.Guide .. "Что бы получить дополнительное время жизни группировки можно сделать следующее:\n"

	TW.Labels.Guide = TW.Labels.Guide .. "    Купить время за ваши очки.\n"

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. "    Выполнять групповые задания.\n"
	end

	TW.Labels.Guide = TW.Labels.Guide .. "Очки - это валюта добавляемая этим аддоном. Её можно добыть следующими способами:\n"

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. "    Выполнить задание.\n"		
	end

	if TW.TerritoryCapturing then
		TW.Labels.Guide = TW.Labels.Guide .. "    Захватить территорию с доходом.\n"
	end

	TW.Labels.Guide = TW.Labels.Guide .. "    Захватить флаг с доходом.\n"

	TW.Labels.Guide = TW.Labels.Guide ..
	"Территории или флаги при захвате дают те или иные бонусы, или же наоборот, при " ..
	"захвате их другой группировки вы лишаетесь этих бонусов.\n" ..
	"Бонусы могут быть следующими:\n" ..
	"    1) Доход в виде очков. Какое-то количество очков каждое какое-то количество секунд.\n" ..
	"    2) Предмет в магазине.\n" ..
	"Захват территорий или флагов длится " .. TW.TerritoryCaptureTime .. " секунд.\n"

	if TW.ShopActivated then 
		TW.Labels.Guide = TW.Labels.Guide .. 
		"Магазин имеет в себе предметы, однако некоторые из них могут быть закрыты, или же все. " ..
		"Что бы открыть тот или иной предмет, нужно захватить флаг или территорию с соответствующим " ..
		"бонусом.\n"
	end

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. 
		"Задания генерируются группировке автоматически, и за них даются награды. " ..
		"Имеется два типа заданий: индивидуальные и групповые.\n " ..
		"Индивидуальные выдаются каждому члену группировки индивидуально, и имеют индивидуальные условия." ..
		"Индивидуальные задания выдают награды в очках.\n" .. 
		"Групповые выдаются группе, и условия могут выполнить все члены группировки. Групповые задания " ..
		"выдают награды в очках и в дополнительном времени жизни группировки.\n"
	end
		

	if TW.RoleUpgrading or TW.GroupUpgrading then
		TW.Labels.Guide = TW.Labels.Guide .. 
			"Есть так же прокачка ролей или группировки.\n" ..
			"Прокачка ролей влияет на способности тех лиц, кто состоит в той роли которую прокачивают. " ..
			"Т.е. вы можете прокачать регенерацию здоровья, и она будет у тех, у кого та роль, которой вы её прокачали. " ..
			"Но будьте осторожны, при каждой прокачке какого-либо улучшения для роли будет становиться дороже " ..
			"остальные улучшения для этой же роли. Чем больше значение \"Добавляет к стоимости улучшений\", тем дороже " ..
			"они будут.\n" ..
			"Допустим, что у нас есть улучшения здоровье и броня. Они имеют разную цену.\n\n" ..
			"    Здоровье. Цена: 500. Уровень: 0.\n" ..
			"    Броня. Цена: 120. Уровень: 0.\n\n" ..
			"Если мы прокачаем здоровье, у которая добавляет к стоимости улучшений 1, " ..
			"то в итоге цены будут такими:\n\n" ..
			"    Здоровье. Цена: 1000. Уровень: 1.\n" ..
			"    Броня. Цена: 240. Уровень: 0.\n\n" ..
			"Но, если мы прокачаем броню, у которая добавляет к стоимости улучшений 5, вместо здоровья," ..
			"то в итоге цены будут такими:\n\n" ..
			"    Здоровье. Цена: 2500. Уровень: 0.\n" ..
			"    Броня. Цена: 600. Уровень: 1.\n\n" ..
			"Т.е. цена = изначальная цена * стоимость улучшений.\n" ..
			"Под изначальной ценой имеется в виду цена, которая стоит при стоимости улучшений равной 1, " ..
			"т.е когда роль вовсе не прокачали." ..
			"Критический урон - это умножение урона который вы наносите на " .. TW.CriticalDamage .. "х.\n\n" ..
			"Группировку можно прокачать, и имеет она свои бонусы, работает так же как и прокачка ролей.\n\n"
			if TW.GroupUpgradeCoolDown or TW.RoleUpgradeCoolDown then
				TW.Labels.Guide = TW.Labels.Guide ..
				"Однако, прокачка группировки или ролей может занять время, т.е. вам придётся подождать " ..
				"некоторое время перед тем, как вы получите бонус. Сколько ждать показывает таймер сверху.\n"
			end
	end

	TW.Labels.Guide = TW.Labels.Guide .. 
	"\n\nВопрос: Что же мне делать со всем этим?\n" ..
	"Ответ: Создайте группировку и покажите полиции, что не только они короли. Вы можете " ..
	"использовать очки что бы обменять на предметы, которые можете продать или использовать." ..
	"Т.е. вы можете создать банду, которая будет источником оружия в городе, или же ещё чего-то.\n\n" ..
	"Вопрос: Зачем нужна дипломатия?\n" ..
	"Ответ: Если все группировки союзные, то зачем генерировать задания?\n" ..
	"Как минимум по таблице и уведомлениям можно понять, что же делает с вами группировка." ..
	"Вдруг она захватывает территории или флаги, которые вы приказали в условиях не захватывать?" ..
	"Или допустим убивает членов вашей группировки...\n"..
	"Забыл сказать, что дипломатию можно использовать для того, что бы получить прибыль благодаря условиям.\n\n" ..
	"Вопрос: Почему группировки имеют таймер?\n" ..
	"Ответ: Иначе они ничего делать толком не будут, за примерами далеко ходить не надо.\n" ..
	"Под страхом смерти человек достигает чего-то, двигается, так развивайтесь и покажите кто тут босс!\n\n" ..
	"Примеры группировок:\n" ..
	"\"Банда\", допустим что вы хотите сидеть где-то в улицах города, грабить и так далее. " ..
	"Вы просто зарабатываете очки что бы наверняка разменять на оружие и наркоту... " ..
	"Ну или просто хотите остаться в этом городе подольше, да. " ..
	"В такой группировке наверняка не нужен устав, правила и так далее, может быть " ..
	"базовые, да, но этика под вопросом. Вы просто можете создавать полиции или кому " ..
	"угодно проблемы, наживаясь на этом.\n" ..
	"\"Частная Военная Компания (ЧВК)\", что-то вроде армии, вы являетесь наёмниками, " ..
	"можете принимать задания от игроков взамен на что-нибудь. Скорее всего " ..
	"строгая армия, в которой нарушение правил может вести к пагубным последствиям. " ..
	"Тоже может быть источником оружия в городе."

	TW.Labels.Upgrades = {}
	TW.Labels.UpgradesDescription = {}
	TW.Labels.Bonuses = {}
	TW.Labels.GroupUpgrades = {}
	TW.Labels.GroupUpgradesDescription = {}

	TW.Labels.Bonuses["ShopUnlock"] 			= "Открыть в магазине"
	TW.Labels.Bonuses["Income"] 				= "Доход"

	TW.Labels.Upgrades["Health"] 			= "Здоровье"
	TW.Labels.Upgrades["Armor"] 			= "Броня"
	TW.Labels.Upgrades["Speed"] 			= "Скорость"
	TW.Labels.Upgrades["Jump"]				= "Прыжок"
	TW.Labels.Upgrades["Regeneration"] 		= "Регенерация"
	TW.Labels.Upgrades["Dodge"] 			= "Уклонение"
	TW.Labels.Upgrades["Crits"] 			= "Криты"
	TW.Labels.Upgrades["Damage"] 			= "Урон"
	TW.Labels.Upgrades["Stealth"] 			= "Стелс"
	TW.Labels.Upgrades["Armorer"] 			= "Техник"
	TW.Labels.Upgrades["Medic"] 			= "Медик"
	TW.Labels.Upgrades["Tank"] 				= "Танк"
	TW.Labels.Upgrades["Adrenaline"] 		= "Адреналин"
	TW.Labels.Upgrades["Runner"] 			= "Бегун"

	TW.Labels.GroupUpgrades["Income"] 			 		
		= "Увеличение дохода"
	TW.Labels.GroupUpgrades["QuestPointsReward"] 		
		= "Увеличение очков за задания"
	TW.Labels.GroupUpgrades["GroupQuestPointsReward"]   
		= "Увеличение очков за групповые задания"
	TW.Labels.GroupUpgrades["GroupQuestLifeTimeReward"] 
		= "Увеличение времени жизни группы за групповые задания"
	TW.Labels.GroupUpgrades["QuestPositiveTimeLength"]  
		= "Увеличение времени на выполнение заданий"
	TW.Labels.GroupUpgrades["QuestNegativeTimeLength"]  
		= "Уменьшение времени на завершение заданий"
	TW.Labels.GroupUpgrades["GroupQuestPositiveTimeLength"]  
		= "Увеличение времени на выполнение групповых заданий"
	TW.Labels.GroupUpgrades["GroupQuestNegativeTimeLength"]  
		= "Уменьшение времени на завершение групповых заданий"
	TW.Labels.GroupUpgrades["RoleUpgradeDiscount"]			 
		= "Скидка на прокачку ролей"
	TW.Labels.GroupUpgrades["RoleUpgradeCooldownDiscount"]   
		= "Скидка на скорость прокачки ролей"
	TW.Labels.GroupUpgrades["ShopDiscount"] 				 
		= "Скидка в магазине"

	TW.Labels.OriginalPrice = "Изначальная цена: "

	TW.Labels.UpgradesDescription["Health"] 
		= "Добавляет " .. TW.HealthPerTier .. "% здоровья каждый уровень.\n Добавляет к стоимости улучшений " .. TW.HealthAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Armor"] 
		= "Добавляет " .. TW.ArmorPerTier .. "% брони каждый уровень.\n Добавляет к стоимости улучшений " .. TW.ArmorAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Speed"] 
		= "Добавляет " .. TW.SpeedPerTier .. "% скорости передвижения каждый уровень.\n " .. 
		"Добавляет к стоимости улучшений " .. TW.SpeedAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Regeneration"] 
		= "Ускоряет скорости регенерации здоровья каждый уровень.\n " .. 
		"Регенерация даёт каждые (" .. TW.RegenerationSpeedPerTier .. " / уровень улучшения) секунд " .. TW.RegenerationPower .. "% здоровья. " ..
		"Добавляет к стоимости улучшений " .. TW.RegenerationAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Dodge"] 
		= "Добавляет " .. TW.DodgePerTier .. "% шанса уклониться от пули каждый уровень.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.DodgeAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Crits"] 
		= "Добавляет " .. TW.CritsPerTier .. "% шанса нанести критический урон каждый уровень.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.CritsAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Damage"] 
		= "Добавляет " .. TW.DamagePerTier .. "% урона от пуль каждый уровень.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.DamageAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Stealth"] 
		= "Если к тебе цель стоит спиной, значит по ней ты можешь нанести критический урон.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.StealthAddPrice .. ".\n"
    if TW.StealthEnableInvisible then
        TW.Labels.UpgradesDescription["Stealth"] = TW.Labels.UpgradesDescription["Stealth"]
        .. "Так же даёт возможность стать невидимым если присел."
    end
	TW.Labels.UpgradesDescription["Armorer"] 
		= "Если есть союзники по группировке стоят рядом," ..
		" тогда у них будет восстанавливаться броня. На того у кого это прокачено это тоже расспростроняется.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.ArmorerAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Medic"] 
		= "Если есть союзники по группировке стоят рядом," .. 
		" тогда у них будет восстанавливаться здоровье. На того у кого это прокачено это тоже расспростроняется.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.MedicAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Tank"] 
		= "Если ваше здоровье меньше " .. TW.TankHealthLimit .. "%, то нанося урон пулями вы будете получать броню," .. 
		" а именно " .. TW.TankPower .. "% от урона пули.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.TankAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Adrenaline"] 
		= "Если ваше здоровье меньше " .. TW.AdrenalineHealthLimit .. "%, то у вас начинается регенерация здоровья," .. 
		" а именно " .. TW.AdrenalineSpeed .. " секунд вы будете получать " .. TW.AdrenalineRegenerationPower .. "% здоровья.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.AdrenalineAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Runner"] 
		= "Если ваше здоровье меньше " .. TW.RunnerHealthLimit .. "%, то у вас повышается скорость передвижение и шанс уклона," .. 
		" а именно скорость передвижения увеличивается на " .. TW.RunnerPower .. "% и шанс увернуться от пули так же увеличивается на " 
		.. TW.RunnerDodgeProcent .. "%.\n" .. 
		" Добавляет к стоимости улучшений " .. TW.AdrenalineAddPrice .. ".\n"

	TW.Labels.GroupUpgradesDescription["Income"] 					
		= "Увеличивает доход от территорий/флагов на " .. TW.GroupIncomeUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupIncomeUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestPointsReward"] 		
		= "Увеличивает награду в виде очков за задания на " .. TW.GroupQuestPointsRewardUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupQuestPointsRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestPointsReward"] 	
		= "Увеличивает награду в виде очков за групповые задания на " 
			.. TW.GroupGroupQuestPointsRewardUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupGroupQuestPointsRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestLifeTimeReward"]  
		= "Увеличивает награду в виде времени жизни группировки за групповые задания на " 
			.. TW.GroupGroupQuestLifeTimeRewardUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupGroupQuestLifeTimeRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestPositiveTimeLength"] 
		= "Увеличение времени для выполнения заданий, таких как \"Захват\", \"Принести кейс\" и \"Киллер\" на " 
			.. TW.GroupQuestPositiveTimeLengthUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupQuestPositiveTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestNegativeTimeLength"]  
		= "Уменьшения времени для завершения заданий, таких как \"Защита\", \"Разведка\"" 
			.. TW.GroupQuestNegativeTimeLengthUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupQuestNegativeTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestPositiveTimeLength"] 
		= "Увеличение времени для выполнения групповых заданий, таких как \"Рекорд\", \"Кейсы\"" 
			.. TW.GroupGroupQuestPositiveTimeLengthUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupGroupQuestPositiveTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestNegativeTimeLength"]  
		= "Уменьшения времени для завершения групповых заданий, таких как \"Удержание\"." 
			.. TW.GroupGroupQuestNegativeTimeLengthUpgradeProcents .. "% каждый уровень.\n"
			.. " Добавляет к стоимости улучшений " .. TW.GroupGroupQuestNegativeTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["RoleUpgradeDiscount"]
		= "Даёт " .. TW.GroupRoleUpgradeDiscountUpgradeProcents .. "% скидку на прокачку ролей каждый уровень.\n"
		.. " Добавляет к стоимости улучшений " .. TW.GroupRoleUpgradeDiscountUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["RoleUpgradeCooldownDiscount"]
		= "Даёт " .. TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents .. "% скидку на скорость прокачки ролей каждый уровень.\n"
		.. " Добавляет к стоимости улучшений " .. TW.GroupRoleUpgradeCooldownDiscountUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["ShopDiscount"]
		= "Даёт " .. TW.GroupShopDiscountUpgradeProcents .. "% скидку в магазине каждый уровень.\n"
		.. " Добавляет к стоимости улучшений " .. TW.GroupShopDiscountUpgradeUpgradedCount .. ".\n"


	TW.Labels.Warning = "При создании группировки помните, что она не бессмертна. \nДля большей информации читайте гайд."
	if gmod.GetGamemode().Name == "DarkRP" then
		TW.Labels.Warning = TW.Labels.Warning .. "\n Цена группировки: " .. TW.GroupCreationMoney .. "$"
	end
 	
    TW.Labels.Return                                = "Вернуть"
    TW.Labels.Everything                            = "Всё"
    TW.Labels.Category                              = "Категория"
 	TW.Labels.RoleUpgrades 							= "Прокачка"
 	TW.Labels.IncomeGetterDescription				= "Income getter - создан для сбора дохода с территорий"
 	TW.Labels.MapTabletDescription					= "Map tablet - создан для просмотра карты территорий и для ориентации в них"
 	TW.Labels.CapturerDescription					= "Capturer - создан для захвата территорий"
 	TW.Labels.Step3									= "Для захвата территорий используйте SWEPы на 6-ом слоте."
 	TW.Labels.Step2									= "Поставьте магазин (см. 6-ой слот, \"Shop computer parts\")"
 	TW.Labels.Step1 								= "Поставьте компьютер в безопасном месте. (см. 6-ой слот, \"Computer parts\")"
 	TW.Labels.EditMOTD 								= "Поменять сообщение"
 	TW.Labels.TerritoryRetainerText					= "Вы не можете это захватить, поскольку рядом удерживатель территорий."
 	TW.Labels.BuyLength 							= "Покупка длится "
 	TW.Labels.AnotherBuy 							= "Последующие длятся "
	TW.Labels.FirstBuy								= "Первая покупка длится "
	TW.Labels.UpgradesText 							= "Улучшения"
	TW.Labels.Tier 									= "Уровень"
	TW.Labels.GetIncome 							= "Взять доход"
	TW.Labels.YouGetSpecialCase						= "Вы взяли кейс с информацией, доставьте его к компьютеру на базу."
	TW.Labels.YouGetIncome							= "Вы собрали доход в защищённый кейс. Доставьте его на базу к компьютеру."
	TW.Labels.YouNeedToHoldFlag2					= " секунд из этого списка:\n"
	TW.Labels.YouNeedToHoldFlag1					= "Вам нужно удержать флаги в течении " 
	TW.Labels.BuyTime								= "Купить время"
	TW.Labels.YouNeedToHold2						= " секунд из этого списка:\n"
	TW.Labels.YouNeedToHold1						= "Вам нужно удержать территории в течении " 
	TW.Labels.AttackGroupQuest 						= "Удержание"
	TW.Labels.AndStayThere 							= "и оставаться там"
	TW.Labels.YouNeedToGoOnFlag 					= "Вам нужно пойти на флаг"
	TW.Labels.YouNeedToGoOn 						= "Вам нужно пойти на территорию"
	TW.Labels.Scout 								= "Разведка"
    TW.Labels.Cases 								= "Кейсы"
    TW.Labels.YouNeedBringCases2 					= " кейсов" 
    TW.Labels.YouNeedBringCases1 					= "Вам нужно принести " 
	TW.Labels.YouNeedToDefendFlag					= "Вам нужно защищать флаг"
	TW.Labels.YouNeedToCaptureFlag					= "Вам нужно захватить флаг"
	TW.Labels.OrMore 								= "или больше"
	TW.Labels.PlayerIsOwner							= "Владелец это игрок"
	TW.Labels.DiplomacyWorsen						= "Ухудшились отношения с"
	TW.Labels.DiplomacyImprove						= "Улучшились отношения с"
	TW.Labels.DiplomacyReason						= "Причина / Условие"
	TW.Labels.SecondToTimer							= "секунд жизни группировки"
	TW.Labels.KillerComplete 						= "Киллер выполнил заказ."
	TW.Labels.KillerText2							= " был заказан у киллера."
	TW.Labels.KillerText1 							= "Ходит слух, что "
	TW.Labels.PressSMB								= "ПКМ для большей информации."
	TW.Labels.SalarySettingsText2					= " секунд."
	TW.Labels.SalarySettingsText1					= "Зарплата выдаётся каждые "
	TW.Labels.SalarySettings						= "Настройка зарплат"
	TW.Labels.Salaries								= "Зарплаты"
	TW.Labels.Incomes 								= "Доходы"
	TW.Labels.CaseText								= "Вы сдали кейс, за что получили"
	TW.Labels.RemainsToDeletingGroup				= "Осталось до удаления группы:"
	TW.Labels.ToDeletingGroup						= " минут до удаления группы."
	TW.Labels.Remains 								= "Остаётся "
	TW.Labels.SecondsOfLifeTime						= "секунд жизни группировки"
	TW.Labels.YourGroupEarn							= "Ваша группировка получила"
	TW.Labels.YouFailGroupQuest2					= "\". "
	TW.Labels.YouFailGroupQuest1					= "Ваша группировка провалила групповое задание \""
	TW.Labels.YouCompleteGroupQuest2				= "\". "
	TW.Labels.YouCompleteGroupQuest1				= "Ваша группировка завершила групповое задание \""
	TW.Labels.YouEarn								= "Вы получили"
	TW.Labels.YouFailQuest2							= "\". "
	TW.Labels.YouFailQuest1							= "Вы провалили задание \""
	TW.Labels.YouCompleteQuest2						= "\". "
	TW.Labels.YouCompleteQuest1						= "Вы завершили задание \""
	TW.Labels.Minimum 								= "минимум"
	TW.Labels.Points2								= "очков"
	TW.Labels.Reward 								= "Награда"
	TW.Labels.Remove 								= "Удалить"
	TW.Labels.FlagAt2 								= "флага в"
	TW.Labels.FlagAt 								= "флаг в"
	TW.Labels.IsOver 								= "окончен"
	TW.Labels.TerritoryAt2 							= "территории в"
	TW.Labels.Capture2								= "Захват"
	TW.Labels.AlwaysUnlocked						= "Открыто изначально"
	TW.Labels.MapSelectTerritory2 					= "Выберите ближайшую территорию."
	TW.Labels.MapSelectTerritory1 					= "Выберите территорию."
	TW.Labels.AdditionalInfo						= "Дополнительная инфа"
	TW.Labels.Owner 								= "Владелец"
	TW.Labels.CaptureBonuses						= "Бонусы от захвата"
	TW.Labels.DisconnectTerritories 				= "Отсоединить территорию"
	TW.Labels.ConnectTerritories 					= "Соединить территории"
	TW.Labels.Connect 								= "Присоединить"
	TW.Labels.BonusSettings 						= "Настройки бонусов"
	TW.Labels.YouCantInvite2						= "\" переполнена. Купите больше слотов."
	TW.Labels.YouCantInvite1						= "Вы не можете пригласить человека, поскольку роль \""
	TW.Labels.ThisRoleIsFull						= "Эта роль переполнена, купите больше слотов."
	TW.Labels.For 									= "для"
	TW.Labels.Slots2								= "слотов"
	TW.Labels.Slots 								= "Слоты"
	TW.Labels.Delay 								= "Промежуток"
	TW.Labels.Income 								= "Доход"
	TW.Labels.Per 									= "каждые"
	TW.Labels.Settings 								= "Настройки"
	TW.Labels.Add 									= "Добавить"
	TW.Labels.AddToShop								= "Предмет в магазине"
	TW.Labels.YouNeedToPassCase						= "Вам нужно принести на базу кейс"
	TW.Labels.PassCase								= "Отдать кейс"
	TW.Labels.Killer 								= "Киллер"
	TW.Labels.YouNeedToKill							= "Вам нужно убить"
	TW.Labels.YouNeedToCapture						= "Вам нужно захватить территорию"
	TW.Labels.Capture 								= "Захват"
	TW.Labels.QuestGoal								= "Рекорд"
	TW.Labels.LanguageSwitch						= "Язык"
	TW.Labels.GuideButton 							= "Гайд"
	TW.Labels.AddRole 								= "Добавить"
	TW.Labels.Roles 								= "Роли"
	TW.Labels.ThisRoleCan							= "Эта роль может:"
	TW.Labels.AnySpecial							= "У этой роли нету специфичных разрешений."
	TW.Labels.Color 								= "Цвет"
	TW.Labels.Salary 								= "Зарплата"
	TW.Labels.Name 									= "Имя"
	TW.Labels.AvailableQuests 						= "Доступные задания"
	TW.Labels.ActiveQuests							= "Текущие задания"
	TW.Labels.Withdraw 								= "Снять"
	TW.Labels.WithdrawPoints 						= "Снять очки"
	TW.Labels.Disable 								= "Выключить"
	TW.Labels.Enable 								= "Включить"
	TW.Labels.TerritoryRetainer						= "УДЕРЖИВАТЕЛЬ ТЕРРИТОРИЙ"
	TW.Labels.GroupColor 							= "Цвет группы"
	TW.Labels.CreateGroup 							= "Создать группу"
	TW.Labels.Buy 									= "Купить"
	TW.Labels.Accept 								= "Принять"
	TW.Labels.Price 								= "Цена"
	TW.Labels.Name 									= "Имя"
	TW.Labels.Buyed									= "куплено"
	TW.Labels.Points 								= "Очки"
	TW.Labels.YouNeedToDefend						= "Вам нужно защитить территорию"
	TW.Labels.Defend 								= "Защита"
	TW.Labels.Quests 								= "Задания"
	TW.Labels.Kick 									= "Выгнать"
	TW.Labels.ThisIsLeader	 						= "Это лидер."
	TW.Labels.TerritoriesCaptured 					= "Территорий захвачено"
	TW.Labels.ThisTerritoryIsUnderAssault 			= "Эта территория захватывается."
	TW.Labels.AcceptOrNotLeave						= "Вы точно хотите уйти?"
	TW.Labels.Leave 								= "Уйти"
	TW.Labels.Vote 									= "Голосовать"
	TW.Labels.InvitesYou 							= "приглашает вас!"
	TW.Labels.Invite 								= "Пригласить"
	TW.Labels.QuestsGoal 							= "Рекорд"
	TW.Labels.QuestsIn 								= "заданий за"
	TW.Labels.Destroy 								= "Уничтожить"
	TW.Labels.GroupQuests 							= "Задания группы"
	TW.Labels.Seconds 								= "секунд"
	TW.Labels.QuestIn 								= "за"
	TW.Labels.YouMustDestroy 						= "Вы должны уничтожить группу"
	TW.Labels.YouMustMakeAnAlly 					= "Вы должны заключить союз с группой" 
	TW.Labels.YouNeedToComplete 					= "Вам нужно закончить "
	TW.Labels.GroupPoints 							= "Групповые очки"
	TW.Labels.GroupInfo 							= "Информация"
	TW.Labels.ChooseAColor 							= "Выберите цвет"
	TW.Labels.Apply 								= "Принять"
	TW.Labels.DepositPoints 						= "Положить очки"
	TW.Labels.GivePoints 							= "Передать очки"
	TW.Labels.Deposit 								= "Положить"
	TW.Labels.Give 									= "Передать"
	TW.Labels.ChoosePlayer 							= "Выберите человека"
	TW.Labels.AllianceText 							= "хочет изменить отношения с вами!"
	TW.Labels.Yes 									= "Да"
	TW.Labels.No 									= "Нет"
	TW.Labels.F3Notice 								= "Нажмите F3 для активации курсора."
	TW.Labels.Enemy 								= "Враг"
	TW.Labels.Neutral 								= "Нейтрал"
	TW.Labels.Ally 									= "Союзник"
	TW.Labels.Diplomacy 							= "Дипломатия"
	TW.Labels.TerritoryAt 							= "территорию в"
	TW.Labels.Capturing 				    		= "Захватываем"
	TW.Labels.AlreadyCaptured			    		= "уже захвачена"
	TW.Labels.GroupRegisterWindowTitle      		= "Регистрация группы"
	TW.Labels.GroupName 				    		= "Имя:" 
	TW.Labels.CantCreateGroupBecauseOfCount 		= "Невозможно создать группу ибо достигнут максимум"
	TW.Labels.CantCreateGroupBecauseOfName  		= "Группа с таким же именем уже существует"
	TW.Labels.ThisIsTerritory     	 	    		= "Эта территория"
	TW.Labels.OwnedBy								= "пренадлежащую"
	TW.Labels.Nothing 								= "никем"
	TW.Labels.Novice 								= "Новичок"
	TW.Labels.YouAreNotInGroup 						= "Вы не в группе."
	TW.Labels.YouAreInvitedInToGroup 	    		= "Вы приглашены в группу"
	TW.Labels.ToAcceptInvite						= "что бы принять"
	TW.Labels.ToDeclineInvite 						= "что бы отказаться"
	TW.Labels.CantCreateGroupBecauseYouAreInGroup 	= "Вы не можете создать группу поскольку вы уже в группе."

	TW.Labels.BonusText = {}

	TW.Labels.BonusText["Income"] = function(bonus) 
		return TW.Labels.Income .. ": " .. bonus.Properties.Points .. " " .. TW.Labels.Points2 .. " "
			.. TW.Labels.Per .. " " .. bonus.Properties.Delay .. " " .. TW.Labels.Seconds .. "."
	end

	TW.Labels.BonusText["ShopUnlock"] = function(bonus)
		local shopEntity = TW.Shop.ShopList[bonus.Properties.Item] 
		local itemName = "Nothing"
		if shopEntity then
			itemName = shopEntity.Name
		end
		return TW.Labels.AddToShop .. ": " .. itemName .. "."
	end
end

TW.Languages["English"] = function()
	TW.Labels.Upgrades = {}
	TW.Labels.UpgradesDescription = {}
	TW.Labels.Bonuses = {}
	TW.Labels.GroupUpgrades = {}
	TW.Labels.GroupUpgradesDescription = {}

	TW.Labels.Bonuses["ShopUnlock"] 			= "Unlock in shop"
	TW.Labels.Bonuses["Income"] 				= "Income"

	TW.Labels.Upgrades["Health"] 			= "Health"
	TW.Labels.Upgrades["Armor"] 			= "Armor"
	TW.Labels.Upgrades["Speed"] 			= "Speed"
	TW.Labels.Upgrades["Jump"] 				= "Jump"
	TW.Labels.Upgrades["Regeneration"]		= "Regeneration"
	TW.Labels.Upgrades["Dodge"] 			= "Dodge"
	TW.Labels.Upgrades["Crits"] 			= "Crits"
	TW.Labels.Upgrades["Damage"] 			= "Damage"
	TW.Labels.Upgrades["Stealth"] 			= "Stealth"
	TW.Labels.Upgrades["Armorer"] 			= "Armorer"
	TW.Labels.Upgrades["Medic"] 			= "Medic"
	TW.Labels.Upgrades["Tank"]= "Tank"
	TW.Labels.Upgrades["Adrenaline"] 		= "Adrenaline"
	TW.Labels.Upgrades["Runner"] 			= "Runner"                 

	TW.PermisionsList = {}

	local List = TW.PermisionsList
	List["Kick"] 					= "Kick people from group."
	List["Invite"] 					= "Invite people to group."
	List["Role changing"] 			= "Changing member roles."
	List["Role creating"] 			= "Creating and setting roles."
	List["Group point managing"] 	= "Withdraw group points."
	List["Diplomacy"] 				= "Manage diplomacy."
	List["MOTD"] 					= "Change message."
	if TW.GroupUpgrading then
		List["Group upgrading"] 	= "Upgrade the group."
	end
	if TW.QuestsAvailable then
		List["Group quest accept"]  = "Accept group quests"
	end

	TW.Labels.Guide =
	"   Warning: this guide is updated depending on addon settings.\n\n" ..
	" Groups from this addon are not immortal, they can be destroyed by the explosion of the main computer of the group " ..
	"or after the expiration of the group. " ..
	"So put main computer to the safest place.\n" .. 
	"To get an extra time to group lifetime, you can do the following:\n"

	TW.Labels.Guide = TW.Labels.Guide .. "    Buy time for your points.\n"

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. "    Complete group quests.\n"
	end

	TW.Labels.Guide = TW.Labels.Guide .. "Points are the currency added by this addon. It can be obtained in the following ways:\n"

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. "    Complete quests.\n"		
	end

	if TW.TerritoryCapturing then
		TW.Labels.Guide = TW.Labels.Guide .. "    Capture territories with income.\n"
	end

	TW.Labels.Guide = TW.Labels.Guide .. "    Capture flag with income.\n"

	TW.Labels.Guide = TW.Labels.Guide ..
	"Territories or flags give bonuses for capturing, or vice versa, if another group captures them, you lose these bonuses.\n" ..
	"Bonuses can be as follows:\n" ..
	"	Income in the form of points. A certain number of points each some number of seconds.\n" ..
	"	Item in shop.\n" ..
	"Territory or flag capture lasts " .. TW.TerritoryCaptureTime .. " seconds.\n"

	if TW.ShopActivated then 
		TW.Labels.Guide = TW.Labels.Guide .. 
		"The store has items in it, but some of them can be closed, or all of them. " ..
		"To open an item, you need to capture a flag or territory with an appropriate bonus.\n"
	end

	if TW.QuestsAvailable then
		TW.Labels.Guide = TW.Labels.Guide .. 
		"Assignments are generated for the group automatically, and awards are given for them. " ..
		"There are two types of quests: individual and group.\n " ..
		"Individual are issued to each member of the group individually, and have individual conditions." ..
		"Individual tasks give rewards in points.\n" .. 
		"Group tasks are issued to the group, and all members of the group can fulfill the conditions. " ..
		"Group tasks give rewards in points and in an extra time group life.\n"
	end
		

	if TW.RoleUpgrading or TW.GroupUpgrading then
		TW.Labels.Guide = TW.Labels.Guide .. 
			"There are also roles or group upgrades.\n" ..
			"Upgrading roles improves the abilities of those who are in the role you improve. " ..
			"I.e. you can improve the regeneration of health, and it will be for those who have the role with which you have improved it. " ..
			"But be careful, with each improvement of any improvement for the role will become more expensive other improvements " ..
			"for the same role. The higher the value of \"adds to price of upgrade\", the more expensive they will be \n" ..
			"Suppose that we have upgraded health and armor. They have a different price.\n\n" ..
			"   Health. Price: 500. Tier: 0.\n" ..
			"   Armor. Price: 120. Tier: 0.\n\n" ..
			"If we upgrade health, which increases the price of upgrades 1, then in the end prices will be as follows:\n\n" ..
			"   Health. Price: 1000. Tier: 1.\n" ..
			"   Armor. Price: 240. Tier: 0.\n\n" ..
			"But, if we improve the armor, which adds to the price of upgrades 5, instead of health, " .. 
			"then in the end prices will be as follows:\n\n" ..
			"   Health. Price: 2500. Tier: 0.\n" ..
			"   Armor. Price: 600. Tier: 1.\n\n" ..
			"I.e. price = original price * price of upgrades.\n" ..
			"The original price is the price that stands when the price of upgrades equal to 1, that is when the role was not improved at all." ..
			"Critical damage is the multiplication of damage that you do by " .. TW.CriticalDamage .. "х.\n\n" ..
			"Grouping can be improved, and it has its own bonuses, it works the same way as upgrading roles.\n\n"
			if TW.GroupUpgradeCoolDown or TW.RoleUpgradeCoolDown then
				TW.Labels.Guide = TW.Labels.Guide ..
				"However, improving group or roles may take time, i.e." .. 
				"You will have to wait some time before you receive the bonus. How long to wait shows the timer on top.\n"
			end
	end

	TW.Labels.Guide = TW.Labels.Guide .. 
	"\nQuestion: What should I do with all this?\n" ..
	"Answer: Create a group and show the police that they are not only kings. " .. 
	"You can use points to exchange for items that you can sell or use. " .. 
	"I.e You can create a gang that will be a source of weapons in the city, or something else.\n\n" ..
	"Question: Why is diplomacy needed?\n" ..
	"Answer: If all the groups are allies, then why generate tasks? " .. 
	"At least in the table and notifications you can understand what the group is doing with you. " .. 
	"Suddenly it captures territories or flags that you ordered in conditions not to capture? Or let's say it kills members of your group... " .. 
	"I forgot to say that diplomacy can be used to make a profit thanks to the conditions.\n\n" ..
	"Question: Why do groups have a timer?\n" ..
	"Answer: Otherwise, they will not really do anything, for examples there is no need to go far." .. 
	" Under the fear of death, a human achieves something, moves, so develop and show who the boss is!\n\n" ..
	"Groups example:\n" ..
	"\"Gang\", let's say that you want to sit somewhere in the streets of the city, rob and so on. " .. 
	"You just earn points that you would probably exchange for weapons and drugs... " .. 
	"Well, or just want to stay in this city a little longer, yes. " .. 
	"In such a group, we certainly don’t need a charter, rules, and so on, maybe basic ones, yes, but ethics is questionable. " .. 
	"You can simply create problems for the police or anyone else by profiting from it.\n" ..
	"\"Private Military Company (PMC)\" something like an army, you are a mercenary, " .. 
	"you can accept tasks from players in exchange for something. Most likely a strict army, " .. 
	"in which breaking the rules can lead to disastrous consequences. It can also be a source of weapons in the city."

	TW.Labels.OriginalPrice = "Original price: "

	TW.Labels.UpgradesDescription["Health"] 
		= "Adds " .. TW.HealthPerTier .. "% health per tier.\n Adds to the price of upgrades " .. TW.HealthAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Armor"] 
		= "Adds " .. TW.ArmorPerTier .. "% armor per tier.\n Adds to the price of upgrades " .. TW.ArmorAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Speed"] 
		= "Adds " .. TW.SpeedPerTier * 100 .. "% moving speed per tier.\n " .. 
		"Adds to the price of upgrades " .. TW.SpeedAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Regeneration"] 
		= "Accelerates speed of regeneration health per tier.\n " .. 
		"Every (" .. TW.RegenerationSpeedPerTier .. " / tier) seconds regeneration gives " .. TW.RegenerationPower .. "% health.\n " ..
		"Adds to the price of upgrades " .. TW.RegenerationAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Dodge"] 
		= "Adds " .. TW.DodgePerTier .. "% chance to dodge bullet per tier.\n" .. 
		" Adds to the price of upgrades " .. TW.DodgeAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Crits"] 
		= "Adds " .. TW.CritsPerTier .. "% chance of critical damage per tier.\n" .. 
		" Adds to the price of upgrades " .. TW.CritsAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Damage"] 
		= "Adds " .. TW.DamagePerTier * 100 .. "% bullet damage per tier.\n" .. 
		" Adds to the price of upgrades " .. TW.DamageAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Stealth"] 
		= "If the target is back to you, then you can inflict the critical damage.\n" .. 
		" Adds to the price of upgrades " .. TW.StealthAddPrice .. ".\n"
    if TW.StealthEnableInvisible then
        TW.Labels.UpgradesDescription["Stealth"] = TW.Labels.UpgradesDescription["Stealth"]
        .. "Also gives you ability to become invisible if you crouching."
    end
	TW.Labels.UpgradesDescription["Armorer"] 
		= "If allies from group are standing near," ..
		" then theirs armor will restore. On the one who has this improvement is also distributed.\n" .. 
		" Adds to the price of upgrades " .. TW.ArmorerAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Medic"] 
		= "If allies from group are standing near," .. 
		" then theirs health will restore. On the one who has this improvement is also distributed.\n" .. 
		" Adds to the price of upgrades " .. TW.MedicAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Tank"] 
		= "If your health less than " .. TW.TankHealthLimit .. "%, then damaging by bullets you will restore armor," .. 
		" namely " .. TW.TankPower * 100 .. "% from bullet damage.\n" .. 
		" Adds to the price of upgrades " .. TW.TankAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Adrenaline"] 
		= "If your health less than " .. TW.AdrenalineHealthLimit .. "%, then regeneration of health is begins," .. 
		" namely every " .. TW.AdrenalineSpeed .. " seconds you get " .. TW.AdrenalineRegenerationPower .. "% health.\n" .. 
		" Adds to the price of upgrades " .. TW.AdrenalineAddPrice .. ".\n"
	TW.Labels.UpgradesDescription["Runner"] 
		= "If your health less than " .. TW.RunnerHealthLimit .. "%, then your moving speed and chance of dodge are increased." ..
		" Namely moving speed are increase by " .. TW.RunnerPower * 100 .. "% and dodge chance is also increases by " 
		.. TW.RunnerDodgeProcent * 100 .. "%.\n" .. " Adds to the price of upgrades " .. TW.RunnerAddPrice .. ".\n"

	TW.Labels.GroupUpgrades["Income"] 			 		
		= "Income increase"
	TW.Labels.GroupUpgrades["QuestPointsReward"] 		
		= "Quest points reward increase"
	TW.Labels.GroupUpgrades["GroupQuestPointsReward"]   
		= "Group quest points reward increase"
	TW.Labels.GroupUpgrades["GroupQuestLifeTimeReward"] 
		= "Group quest lifetime reward increase"
	TW.Labels.GroupUpgrades["QuestPositiveTimeLength"]  
		= "Increase amount of time for completing quests"
	TW.Labels.GroupUpgrades["QuestNegativeTimeLength"]  
		= "Decrease amount of time for completing quests"
	TW.Labels.GroupUpgrades["GroupQuestPositiveTimeLength"]  
		= "Increase amount of time for completing group quests"
	TW.Labels.GroupUpgrades["GroupQuestNegativeTimeLength"]  
		= "Decrease amount of time for completing group quests"
	TW.Labels.GroupUpgrades["RoleUpgradeDiscount"]			 
		= "Discount in role upgrading"
	TW.Labels.GroupUpgrades["RoleUpgradeCooldownDiscount"]   
		= "Discount in role upgrading countdown"
	TW.Labels.GroupUpgrades["ShopDiscount"] 				 
		= "Discount in shop"

	TW.Labels.GroupUpgradesDescription["Income"] 					
		= "Increases income from territories/flags by " .. TW.GroupIncomeUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupIncomeUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestPointsReward"] 		
		= "Increases quest points reward by " .. TW.GroupQuestPointsRewardUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupQuestPointsRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestPointsReward"] 	
		= "Increases group quest points reward by " 
			.. TW.GroupGroupQuestPointsRewardUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupGroupQuestPointsRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestLifeTimeReward"]  
		= "Increases group quest lifetime reward by " 
			.. TW.GroupGroupQuestLifeTimeRewardUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupGroupQuestLifeTimeRewardUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestPositiveTimeLength"] 
		= "Increases time for quests like \"Capture\", \"Bring case\" and \"Killer\" by " 
			.. TW.GroupQuestPositiveTimeLengthUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupQuestPositiveTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["QuestNegativeTimeLength"]  
		= "Decreases time for quests like \"Defend\" and \"Scout\" by " 
			.. TW.GroupQuestNegativeTimeLengthUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupQuestNegativeTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestPositiveTimeLength"] 
		= "Increases time for completing group quests like \"Goal\" and \"Cases\" by " 
			.. TW.GroupGroupQuestPositiveTimeLengthUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupGroupQuestPositiveTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["GroupQuestNegativeTimeLength"]  
		= "Decreases time for completing group quests like \"Hold\" by " 
			.. TW.GroupGroupQuestNegativeTimeLengthUpgradeProcents .. "% each tier.\n"
			.. " Adds to price of upgrades " .. TW.GroupGroupQuestNegativeTimeLengthUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["RoleUpgradeDiscount"]
		= "Each tier gives " .. TW.GroupRoleUpgradeDiscountUpgradeProcents .. "% discount in role upgrading.\n"
		.. " Adds to price of upgrades " .. TW.GroupRoleUpgradeDiscountUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["RoleUpgradeCooldownDiscount"]
		= "Each tier gives " .. TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents .. "% discount in role upgrading countdown.\n"
		.. " Adds to price of upgrades " .. TW.GroupRoleUpgradeCooldownDiscountUpgradeUpgradedCount .. ".\n"
	TW.Labels.GroupUpgradesDescription["ShopDiscount"]
		= "Each tier gives " .. TW.GroupShopDiscountUpgradeProcents .. "% discount in shop.\n"
		.. " Adds to price of upgrades " .. TW.GroupShopDiscountUpgradeUpgradedCount .. ".\n"


	TW.Labels.Warning = "When creating group, remember that is it not immortal. \nFor more info read the guide."
	if gmod.GetGamemode().Name == "DarkRP" then
		TW.Labels.Warning = TW.Labels.Warning .. "\n Group price: " .. TW.GroupCreationMoney .. "$"
	end
	
    TW.Labels.Return                                = "Return"
    TW.Labels.Everything                            = "Everything"
    TW.Labels.Category                              = "Category"
	TW.Labels.RoleUpgrades 							= "Upgrades"
	TW.Labels.IncomeGetterDescription				= "Income getter is created to collect income from territories"
 	TW.Labels.MapTabletDescription					= "Map tablet is created to view the territories map and for orientation between them"
 	TW.Labels.CapturerDescription					= "Capturer is created to capture the territories"
 	TW.Labels.Step3									= "To capture the territories use SWEPs from 6th slot."
 	TW.Labels.Step2									= "Place the shop (see 6-th slot, \"Shop computer parts\")"
 	TW.Labels.Step1 								= "Place the computer in save place. (see 6-th slot, \"Computer parts\")"
	TW.Labels.EditMOTD 								= "Change message"
	TW.Labels.YouNeedToCapture						= "You need to capture territory"
	TW.Labels.TerritoryRetainerText					= "You can't capture that because of territory retainer."
	TW.Labels.Capture 								= "Capture"
	TW.Labels.BuyLength 							= "Purchase lasts "
 	TW.Labels.AnotherBuy 							= "Other lasts "
	TW.Labels.FirstBuy								= "First purchase lasts "
	TW.Labels.UpgradesText 							= "Upgrades"
	TW.Labels.Tier 									= "Tier"
	TW.Labels.GetIncome 							= "Get income"
	TW.Labels.YouGetSpecialCase						= "You got the case with info, take it to the base to the computer."
	TW.Labels.YouGetIncome							= "You got the income to the reinforced case. Take it to the base to the computer."
	TW.Labels.YouNeedToHoldFlag2					= " seconds:\n"
	TW.Labels.YouNeedToHoldFlag1					= "You need to hold flags from this list in " 
	TW.Labels.BuyTime								= "Buy a time"
	TW.Labels.YouNeedToHold2						= " seconds:\n"
	TW.Labels.YouNeedToHold1						= "You need to hold territories from this list in " 
	TW.Labels.AttackGroupQuest 						= "Hold"
	TW.Labels.AndStayThere 							= "and stay there"
	TW.Labels.YouNeedToGoOnFlag 					= "You need to go to the flag"
	TW.Labels.YouNeedToGoOn 						= "You need to go to the territory"
	TW.Labels.Scout 								= "Scout"
    TW.Labels.Cases 								= "Cases"
    TW.Labels.YouNeedBringCases2 					= " cases" 
    TW.Labels.YouNeedBringCases1 					= "You need to bring " 
	TW.Labels.YouNeedToDefendFlag					= "You need to defend flag"
	TW.Labels.YouNeedToCaptureFlag					= "You need to capture"
	TW.Labels.OrMore 								= "or more"
	TW.Labels.PlayerIsOwner							= "Player is owner"
	TW.Labels.DiplomacyWorsen						= "Worsened relations with"
	TW.Labels.DiplomacyImprove						= "Improved relations with"
	TW.Labels.DiplomacyReason						= "Reason / Condition"
	TW.Labels.SecondToTimer							= "seconds of group lifetime"
	TW.Labels.KillerComplete 						= "Killer completed task."
	TW.Labels.KillerText2							= " was ordered to be killed."
	TW.Labels.KillerText1 							= "It was rumored that "
	TW.Labels.PressSMB								= "SMB for more info."
	TW.Labels.SalarySettingsText2					= " seconds."
	TW.Labels.SalarySettingsText1					= "Salary is issued every "
	TW.Labels.SalarySettings						= "Salary settings"
	TW.Labels.Salaries								= "Salaries"
	TW.Labels.Incomes 								= "Incomes"
	TW.Labels.CaseText								= "You brought the case and get"
	TW.Labels.RemainsToDeletingGroup				= "Remained before removing the group:"
	TW.Labels.ToDeletingGroup						= " minutes before removing group."
	TW.Labels.Remains 								= "Remains "
	TW.Labels.SecondsOfLifeTime						= "seconds of group lifetime"
	TW.Labels.YourGroupEarn							= "Your group earn"
	TW.Labels.YouFailGroupQuest2					= "\". "
	TW.Labels.YouFailGroupQuest1					= "Your group failed group quest \""
	TW.Labels.YouCompleteGroupQuest2				= "\". "
	TW.Labels.YouCompleteGroupQuest1				= "Your group completed group quest \""
	TW.Labels.YouEarn								= "You earn"
	TW.Labels.YouCompleteQuest2						= "\"."
	TW.Labels.YouCompleteQuest1						= "You completed quest \""
	TW.Labels.YouFailQuest2							= "\". "
	TW.Labels.YouFailQuest1							= "You failed quest \""
	TW.Labels.Minimum 								= "minimum"
	TW.Labels.Points2								= "points"
	TW.Labels.Reward 								= "Reward"
	TW.Labels.Remove 								= "Remove"
	TW.Labels.FlagAt2 								= "flag at"
	TW.Labels.FlagAt 								= "flag at"
	TW.Labels.IsOver 								= "is over"
	TW.Labels.TerritoryAt2 							= "territory at"
	TW.Labels.Capture2 								= "Capture of"
	TW.Labels.AlwaysUnlocked						= "Always unlocked"
	TW.Labels.MapSelectTerritory2 					= "Choose nearest territory."
	TW.Labels.MapSelectTerritory1 					= "Choose territory."
	TW.Labels.AdditionalInfo						= "Additional info"
	TW.Labels.Owner 								= "Owner"
	TW.Labels.Points2 								= "points"
	TW.Labels.CaptureBonuses						= "Capture bonuses"
	TW.Labels.DisconnectTerritories 				= "Disconnect territory"
	TW.Labels.ConnectTerritories 					= "Connect territories"
	TW.Labels.Connect 								= "Connect"
	TW.Labels.BonusSettings 						= "Bonus settings"
	TW.Labels.YouCantInvite2						= "\" is full. Buy more slots."
	TW.Labels.YouCantInvite1						= "You can't invite because role \""
	TW.Labels.ThisRoleIsFull						= "This role is full, buy more slots."
	TW.Labels.For 									= "for"
	TW.Labels.Slots2								= "slots"
	TW.Labels.Slots 								= "Slots"
	TW.Labels.Delay 								= "Delay"
	TW.Labels.Income 								= "Income"
	TW.Labels.Per 									= "per"
	TW.Labels.Settings 								= "Settings"
	TW.Labels.Add 									= "Add"
	TW.Labels.AddToShop								= "Item in shop"
	TW.Labels.YouNeedToPassCase						= "You need to bring the case to the base"
	TW.Labels.PassCase								= "Pass case"
	TW.Labels.Killer 								= "Killer"
	TW.Labels.YouNeedToKill							= "You need to kill"
	TW.Labels.QuestGoal 							= "Goal"
	TW.Labels.LanguageSwitch						= "Language"
	TW.Labels.GuideButton 							= "Guide"
	TW.Labels.AddRole 								= "Add role"
	TW.Labels.Roles 								= "Roles"
	TW.Labels.ThisRoleCan							= "This role can:"
	TW.Labels.AnySpecial							= "This role haven't any special permisions."
	TW.Labels.Color 								= "Color"
	TW.Labels.Salary 								= "Salary"
	TW.Labels.Name 									= "Name"
	TW.Labels.AvailableQuests 						= "Available quests"
	TW.Labels.ActiveQuests							= "Active quests"
	TW.Labels.Withdraw 								= "Withdraw"
	TW.Labels.WithdrawPoints 						= "Withdraw points"
	TW.Labels.Disable 								= "Disable"
	TW.Labels.Enable 								= "Enable"
	TW.Labels.TerritoryRetainer						= "TERRITORY RETAINER"
	TW.Labels.GroupColor 							= "Group color"
	TW.Labels.CreateGroup 							= "Create group"
	TW.Labels.Buy 									= "Buy"
	TW.Labels.Accept 								= "Accept"
	TW.Labels.Price 								= "Price"
	TW.Labels.Name 									= "Name"
	TW.Labels.Buyed									= "buyed"
	TW.Labels.Points 								= "Points"
	TW.Labels.YouNeedToDefend						= "You need to defend territory"
	TW.Labels.Defend 								= "Defend"
	TW.Labels.Quests 								= "Quests"
	TW.Labels.Kick 									= "Kick"
	TW.Labels.ThisIsLeader	 						= "This is leader."
	TW.Labels.TerritoriesCaptured 					= "Territories captured"
	TW.Labels.ThisTerritoryIsUnderAssault 			= "This territory is under assault."
	TW.Labels.AcceptOrNotLeave						= "Do you really want to leave?"
	TW.Labels.Leave 								= "Leave"
	TW.Labels.Vote 									= "Vote"
	TW.Labels.InvitesYou 							= "invites you!"
	TW.Labels.Invite 								= "Invite"
	TW.Labels.QuestsGoal 							= "Quest goal"
	TW.Labels.QuestsIn 								= "quests in"
	TW.Labels.Destroy 								= "Destroy"
	TW.Labels.GroupQuests 							= "Group quests"
	TW.Labels.Seconds 								= "seconds"
	TW.Labels.QuestIn 								= "in"
	TW.Labels.YouMustDestroy 						= "You must destroy the group"
	TW.Labels.YouMustMakeAnAlly 					= "You must make an ally of the group" 
	TW.Labels.YouNeedToComplete 					= "You need to complete "
	TW.Labels.GroupPoints 							= "Group points"
	TW.Labels.GroupInfo 							= "Group info"
	TW.Labels.ChooseAColor 							= "Choose a color"
	TW.Labels.Apply 								= "Apply"
	TW.Labels.DepositPoints 						= "Deposit points"
	TW.Labels.GivePoints 							= "Give points"
	TW.Labels.Deposit 								= "Deposit"
	TW.Labels.Give 									= "Give"
	TW.Labels.ChoosePlayer 							= "Choose player"
	TW.Labels.AllianceText 							= "wants to make an alliance with you!"
	TW.Labels.Yes 									= "Yes"
	TW.Labels.No 									= "No"
	TW.Labels.F3Notice 								= "Press F3 to activate cursor."
	TW.Labels.Enemy 								= "Enemy"
	TW.Labels.Neutral 								= "Neutral"
	TW.Labels.Ally 									= "Ally"
	TW.Labels.Diplomacy 							= "Diplomacy"
	TW.Labels.HelpCommand				    		= "/territorywars.help"
	TW.Labels.HelpHeader 				    		= "All commands will work only if you are in group."
	TW.Labels.CaptureCommandHelpDescription 		= "Will capture territory"
	TW.Labels.TerritoryAt 							= "territory at"
	TW.Labels.Capturing 				    		= "capturing"
	TW.Labels.AlreadyCaptured			    		= "already captured"
	TW.Labels.GroupRegisterWindowTitle      		= "group register"
	TW.Labels.GroupName 				    		= "Name:" 
	TW.Labels.CantCreateGroupBecauseOfCount 		= "Can't create group because number of them is reached maximum"
	TW.Labels.CantCreateGroupBecauseOfName  		= "Can't create group because group with this name is already exists"
	TW.Labels.ThisIsTerritory     	 	    		= "This is territory"
	TW.Labels.OwnedBy								= "owned by"
	TW.Labels.Nothing 								= "nothing"
	TW.Labels.Novice 								= "Novice"
	TW.Labels.YouAreNotInGroup 						= "You are not in group."
	TW.Labels.YouAreInvitedInToGroup 	    		= "You are invited in to group"
	TW.Labels.ToAcceptInvite						= "to accept invite"
	TW.Labels.ToDeclineInvite 						= "to decline it"
	TW.Labels.CantCreateGroupBecauseYouAreInGroup 	= "Can't create group because you are already in group"

	TW.Labels.BonusText = {}

	TW.Labels.BonusText["Income"] = function(bonus) 
		return TW.Labels.Income .. ": " .. bonus.Properties.Points .. " " .. TW.Labels.Points2 .. " "
			.. TW.Labels.Per .. " " .. bonus.Properties.Delay .. " " .. TW.Labels.Seconds .. "."
	end

	TW.Labels.BonusText["ShopUnlock"] = function(bonus)
		local shopEntity = TW.Shop.ShopList[bonus.Properties.Item] 
		local itemName = "Nothing"
		if shopEntity then
			itemName = shopEntity.Name
		end
		return TW.Labels.AddToShop .. ": " .. itemName .. "."
	end
end

hook.Add("InitPostEntity", "TerritoryWars.LangInit", TW.Languages[TW.DefaultLanguage])
TW.Languages[TW.DefaultLanguage]()