
--	FeatherWeight Balance Mod

function Initialize()
end

-- ===========================================================================
function InitializeNewGame()
end

-- ===========================================================================
local function SetInitialVisibility()

	-- Apply updates to all majors
	local aPlayers = PlayerManager.GetAliveMajors();
	for loop, pPlayer in ipairs(aPlayers) do
	
		local iPlayer = pPlayer:GetID();

		local startingPlot = pPlayer:GetStartingPlot();

		g_iW, g_iH = Map.GetGridSize();

		local pCurPlayerVisibility = PlayersVisibility[pPlayer:GetID()];
		if(pCurPlayerVisibility ~= nil) then
	
			-- Reveal Space Around Spawn
			for iX = 0, g_iW - 1 do
				for iY = 0, g_iH - 1 do
					
					local iDistance = Map.GetPlotDistance(startingPlot:GetX(), startingPlot:GetY(), iX, iY);
					if (iDistance < 5) then
						local iPlotIndex = Map.GetPlot(iX, iY):GetIndex();
						pCurPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 0);
					end
				end
			end
		end
	end
end

-- ===========================================================================
local function BuildWallsInCityStates()

	-- Apply updates to all minors
	local aPlayers = PlayerManager.GetAliveMinors();
	for loop, pPlayer in ipairs(aPlayers) do

		local csCapital = pPlayer:GetCities():GetCapitalCity();
		
		csCapital:GetBuildQueue():CreateBuilding(GameInfo.Buildings["BUILDING_WALLS"].Index);

	end
end

-- ===========================================================================
local function OnPlayerTurnActivated( player )
	local currentTurn = Game.GetCurrentGameTurn();
	
	if (player == 0 and currentTurn == 1) then
		SetInitialVisibility();
	end
	
	if (player == 0 and currentTurn == 10) then
		BuildWallsInCityStates();
	end
end

-- ===========================================================================

Initialize();
GameEvents.PlayerTurnStarted.Add(OnPlayerTurnActivated);
LuaEvents.NewGameInitialized.Add(InitializeNewGame);
