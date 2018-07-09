
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
		if(pPlayer:IsHuman() == true) then
			local iPlayer = pPlayer:GetID();
	
			local pCurPlayerVisibility = PlayersVisibility[pPlayer:GetID()];
			if(pCurPlayerVisibility ~= nil) then
		
				-- Reveal Balkans and Turkey
				for iX = 0, 5, 1 do
					for iY = 10, 15, 1 do
						local iPlotIndex = Map.GetPlot(iX, iY):GetIndex();
						pCurPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 1);
					end
				end
			end
		end
	end
end

-- ===========================================================================
local function OnPlayerTurnActivated( player )
	local currentTurn = Game.GetCurrentGameTurn();
	
	if (player == 0 and currentTurn == 1) then
		SetInitialVisibility();
	end
end

-- ===========================================================================

Initialize();
GameEvents.PlayerTurnStarted.Add(OnPlayerTurnActivated);
LuaEvents.NewGameInitialized.Add(InitializeNewGame);
