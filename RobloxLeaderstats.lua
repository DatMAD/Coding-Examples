--Settings Module
local SettingsModule = {}

SettingsModule.Leaderstats = {
	{Name = "Cash", Type = "IntValue"};
}

SettingsModule.FirstTime = {
	Cash = 0;
}




--Leaderstats Module
local StatsModule = {}

local statsData = game:GetService("DataStoreService"):GetDataStore("StatsData")

game.Players.PlayerAdded:Connect(function(player)
	
	local data pcall(function()
		data = statsData:GetAsync(player.userId)
	end)
	
	if not data then
		StatsModule[player.Name] = {}
		for i,v in pairs(SettingsModule.Leaderstats) do
			StatsModule[player.Name][v.Name] = SettingsModule.FirstTime[v.Name]
		end
	else
		StatsModule[player.Name] = data
	end
	
	local leaderstats = Instance.new("Folder")
	leaderstast.Name = "leaderstats"
	leaderstats.Parent = player
	
	for i,v in pairs(SettingsModule.Leaderstats) do
		local value = Instance.New(v.Type)
		value.Name = v.Name
		value.Value = StatsModule[player.Name][v.Name]
		value.Parent = leaderstats
	end
end)




--Server Script
game.Players.PlayerAdded:Connect(function(player)
	
	local connection
	
	local metatable = {
		__index = function(self,key)
			if string.lower(key) == "changed" then
				local connectionTable = {}
				function connectionTable:Connect(embeddedEvent)
					connection = embeddedEvent
				end
				return connectionTable
			end
		else
			if StatsModule[player.Name][key] == nil then
				warn(key.."is nil")
			end
			return StatsModule[player.Name][key]
		end;
		
		__newindex = function(self,key,value)
			StatsModule[player.Name][key] = value
			connection(key,value)
		end
	}
	
	local playerStats = setmetatable({},metatable)
	
	playerStats.Changed:Connect(function(key,value)
		if string.lower(key) == "Cash" then
			player.leaderstats.Cash = value
		end
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	statsData:SetAsync(player.userId,StatsModule[player.Name])
end)
