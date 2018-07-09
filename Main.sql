-- GameData1
-- Author: pedrito_elcabra
-- DateCreated: 7/8/2018 12:17:16 PM
--------------------------------------------------------------

update 'UnitCaptures' 
set BecomesUnitType = 'UNIT_BUILDER' 
where CapturedUnitType = 'UNIT_SETTLER';