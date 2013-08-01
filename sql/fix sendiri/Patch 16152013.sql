-- Add spell (Goblin All-In-1-Der Belt Shocker) to quest (Good Help is Hard to Find) for count sleeping troll slaves
UPDATE`quest_template`SET`RequiredSpellCast1`=66306 WHERE`Id`=14069;

-- Following items are not converted when changing faction.1. Blade of the Fearless
-- Ally version: http://www.wowhead.com/item=62473
-- Horde version: http://www.wowhead.com/item=62454
REPLACE INTO `player_factionchange_items` (`race_A`, `alliance_id`, `commentA`, `race_H`, `horde_id`, `commentH`) VALUES (0, 62473, 'Blade of the Fearless', 0, 62454, 'Blade of the Fearless');

-- remove auto complete flag from A Gap in Their Armor quest
UPDATE `quest_template` SET `Flags`=4096 WHERE `Id`=25758;
-- add loot Twilight Armor Plate to game object
DELETE FROM `gameobject_loot_template` WHERE `entry`=29580;
INSERT INTO `gameobject_loot_template` (`entry`, `item`) VALUES (29580, 55809);

-- make Tome of Flame lootable
UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=203046;

-- make Burning Litanies lootable
UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=203047;

-- make Ascendant's Codex lootable
UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=203048;

-- add Flame Blossom (http://www.wowhead.com/item=52537) loot to Flame Blossom (http://www.wowhead.com/object=202619)
REPLACE INTO `gameobject_loot_template` (`entry`, `item`) VALUES (28423, 52537);

-- make Gar'gol's Personal Treasure Chest clickable (Gar'gol's Gotta Go quest)

UPDATE `gameobject_template` SET `flags`=0 WHERE `entry`=204580;

-- it was total of 102% loot, so changed chance to 24 down from 26
UPDATE `skinning_loot_template` SET `ChanceOrQuestChance`=24 WHERE `entry`=6131 AND `item`=4304;

-- took loot from wowhead
SET @SKIN_LOOT_ENTRY=42181;
DELETE FROM `skinning_loot_template` WHERE `entry`=@SKIN_LOOT_ENTRY;
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(@SKIN_LOOT_ENTRY, 52976, 42, 1, 0, 1, 1),
(@SKIN_LOOT_ENTRY, 52977, 50, 1, 0, 2, 4),
(@SKIN_LOOT_ENTRY, 67495, 5, 1, 0, 1, 1);

-- Agitated Green Sand Crab is not skinnable (info from wowhead)
UPDATE `creature_template` SET `skinloot`=0 WHERE `entry`=40238;

-- make Garrosh Hellscream visible to all phases
UPDATE `creature` SET `phaseMask`=65535 WHERE `id`=39605;
-- make King Varian Wrynn visible to all phases
UPDATE `creature` SET `phaseMask`=65535 WHERE `id`=29611;

-- Set NPC Flag to Spellclick for Scourge Gryphons
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=29488;
UPDATE `creature_template` SET `npcflag`=16777216 WHERE `entry`=29501;

DELETE FROM `smart_scripts` WHERE `entryorguid`=25242;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25242, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(25242, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(25242, 0, 2, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(25242, 0, 3, 0, 9, 1, 100, 0, 5, 30, 3500, 4100, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(25242, 0, 4, 0, 9, 1, 100, 0, 30, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25242, 0, 5, 0, 9, 1, 100, 0, 9, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 15 Yards'),
(25242, 0, 6, 0, 9, 1, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25242, 0, 7, 0, 9, 1, 100, 0, 5, 30, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving when in Shoot Range'),
(25242, 0, 8, 0, 2, 1, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Enrage at 30% HP'),
(25242, 0, 9, 0, 2, 1, 100, 1, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say Text at 30% HP');

DELETE FROM `smart_scripts` WHERE `entryorguid`=39637;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39637, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(39637, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(39637, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack on Aggro'),
(39637, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(39637, 0, 4, 5, 9, 1, 100, 0, 5, 30, 2300, 3900, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(39637, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model'),
(39637, 0, 6, 7, 9, 1, 100, 0, 30, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(39637, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(39637, 0, 8, 9, 9, 1, 100, 0, 0, 10, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(39637, 0, 9, 10, 61, 1, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model when not in Shoot Range'),
(39637, 0, 10, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(39637, 0, 11, 12, 9, 1, 100, 0, 11, 25, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 25 Yards'),
(39637, 0, 12, 13, 61, 1, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack at 25 Yards'),
(39637, 0, 13, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model at 25 Yards'),
(39637, 0, 14, 15, 7, 1, 100, 1, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(39637, 0, 15, 0, 61, 1, 100, 1, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(39637, 0, 16, 0, 2, 1, 100, 1, 0, 15, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'At 15% HP - Set Phase 2'),
(39637, 0, 17, 0, 2, 2, 100, 1, 0, 15, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flee at 15% HP'),
(39637, 0, 18, 19, 7, 2, 100, 1, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(39637, 0, 19, 0, 61, 2, 100, 1, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(39637, 0, 20, 0, 2, 2, 100, 1, 0, 15, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say Text at 15% HP'),
(39637, 0, 21, 0, 0, 1, 100, 0, 7000, 8600, 10300, 11200, 11, 12024, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Net');

DELETE FROM `smart_scripts` WHERE `entryorguid`=43427;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(43427, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(43427, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(43427, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack on Aggro'),
(43427, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(43427, 0, 4, 5, 9, 1, 100, 0, 5, 30, 2300, 3900, 11, 23337, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(43427, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model'),
(43427, 0, 6, 7, 9, 1, 100, 0, 30, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(43427, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(43427, 0, 8, 9, 9, 1, 100, 0, 0, 10, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(43427, 0, 9, 10, 61, 1, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model when not in Shoot Range'),
(43427, 0, 10, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(43427, 0, 11, 12, 9, 1, 100, 0, 11, 25, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 25 Yards'),
(43427, 0, 12, 13, 61, 1, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack at 25 Yards'),
(43427, 0, 13, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model at 25 Yards'),
(43427, 0, 14, 15, 7, 1, 100, 1, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(43427, 0, 15, 0, 61, 1, 100, 1, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(43427, 0, 16, 0, 0, 1, 100, 0, 5000, 6000, 16000, 19000, 11, 18328, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Incapacitating Shout'),
(43427, 0, 17, 0, 0, 1, 100, 0, 3000, 3000, 11000, 12000, 11, 19643, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Mortal Strike'),
(43427, 0, 18, 0, 13, 1, 100, 0, 12000, 16000, 0, 0, 11, 15618, 0, 0, 0, 0, 0, 6, 1, 0, 0, 0, 0, 0, 0, 'Cast Snap Kick on Target Spellcast');

DELETE FROM `smart_scripts` WHERE `entryorguid`=39437;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(39437, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(39437, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(39437, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack on Aggro'),
(39437, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(39437, 0, 4, 5, 9, 1, 100, 0, 5, 30, 2300, 3900, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(39437, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model'),
(39437, 0, 6, 7, 9, 1, 100, 0, 30, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(39437, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(39437, 0, 8, 9, 9, 1, 100, 0, 0, 10, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(39437, 0, 9, 10, 61, 1, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model when not in Shoot Range'),
(39437, 0, 10, 0, 61, 1, 100, 0, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(39437, 0, 11, 12, 9, 1, 100, 0, 11, 25, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 25 Yards'),
(39437, 0, 12, 13, 61, 1, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack at 25 Yards'),
(39437, 0, 13, 0, 61, 1, 100, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model at 25 Yards'),
(39437, 0, 14, 15, 7, 1, 100, 1, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(39437, 0, 15, 0, 61, 1, 100, 1, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(39437, 0, 16, 0, 2, 1, 100, 1, 0, 15, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'At 15% HP - Set Phase 2'),
(39437, 0, 17, 0, 2, 2, 100, 1, 0, 15, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flee at 15% HP'),
(39437, 0, 18, 19, 7, 2, 100, 1, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(39437, 0, 19, 0, 61, 2, 100, 1, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(39437, 0, 20, 0, 2, 2, 100, 1, 0, 15, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say Text at 15% HP'),
(39437, 0, 21, 0, 0, 1, 100, 0, 8000, 8000, 12000, 19000, 11, 80012, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Chimera Shot'),
(39437, 0, 22, 0, 0, 1, 100, 0, 5000, 5000, 22000, 24000, 11, 80009, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Serpent Sting'),
(39437, 0, 23, 0, 9, 0, 100, 0, 0, 8, 15800, 18300, 11, 22910, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Immolation Trap on Close');

DELETE FROM `smart_scripts` WHERE `entryorguid`=25764;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25764, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(25764, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(25764, 0, 2, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 38556, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(25764, 0, 3, 0, 9, 1, 100, 0, 5, 30, 3500, 4100, 11, 38556, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(25764, 0, 4, 0, 9, 1, 100, 0, 30, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25764, 0, 5, 0, 9, 1, 100, 0, 9, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 15 Yards'),
(25764, 0, 6, 0, 9, 1, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25764, 0, 7, 0, 9, 1, 100, 0, 5, 30, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving when in Shoot Range');

DELETE FROM `smart_scripts` WHERE `entryorguid`=25311;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25311, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(25311, 0, 1, 0, 4, 1, 100, 1, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(25311, 0, 2, 0, 4, 1, 100, 1, 0, 0, 0, 0, 11, 95826, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(25311, 0, 3, 0, 9, 1, 100, 0, 5, 30, 3500, 4100, 11, 95826, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(25311, 0, 4, 0, 9, 1, 100, 0, 30, 100, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25311, 0, 5, 0, 9, 1, 100, 0, 9, 15, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 15 Yards'),
(25311, 0, 6, 0, 9, 1, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(25311, 0, 7, 0, 9, 1, 100, 0, 5, 30, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving when in Shoot Range');

DELETE FROM `smart_scripts` WHERE `entryorguid`=7332;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7332, 0, 0, 0, 4, 0, 100, 3, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(7332, 0, 1, 0, 4, 1, 100, 3, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(7332, 0, 2, 0, 4, 1, 100, 3, 0, 0, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(7332, 0, 3, 0, 61, 0, 100, 3, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack on Aggro'),
(7332, 0, 4, 5, 9, 1, 100, 2, 5, 30, 2300, 3900, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(7332, 0, 5, 0, 61, 1, 100, 2, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model'),
(7332, 0, 6, 0, 9, 1, 100, 2, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(7332, 0, 7, 0, 61, 1, 100, 2, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(7332, 0, 8, 0, 0, 1, 100, 2, 5000, 5000, 22000, 25000, 11, 11397, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Diseased Shot'),
(7332, 0, 9, 10, 61, 1, 100, 2, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model when not in Shoot Range'),
(7332, 0, 10, 0, 61, 1, 100, 2, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(7332, 0, 11, 12, 9, 1, 100, 2, 11, 25, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 25 Yards'),
(7332, 0, 12, 13, 61, 1, 100, 2, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack at 25 Yards'),
(7332, 0, 13, 0, 61, 1, 100, 2, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model at 25 Yards'),
(7332, 0, 14, 15, 7, 1, 100, 3, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(7332, 0, 15, 0, 61, 1, 100, 3, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(7332, 0, 16, 0, 0, 1, 100, 2, 5000, 5000, 22000, 25000, 11, 11397, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Diseased Shot'),
(7332, 0, 17, 0, 2, 1, 100, 3, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Enrage at 30% HP'),
(7332, 0, 18, 0, 2, 1, 100, 3, 0, 30, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say Text at 30% HP');

DELETE FROM `smart_scripts` WHERE `entryorguid`=4531;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4531, 0, 0, 0, 4, 0, 100, 3, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Phase 1 on Aggro'),
(4531, 0, 1, 0, 4, 1, 100, 3, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving on Aggro'),
(4531, 0, 2, 3, 61, 0, 100, 3, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack on Aggro'),
(4531, 0, 3, 0, 4, 1, 100, 3, 0, 0, 0, 0, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot on Aggro'),
(4531, 0, 4, 5, 9, 1, 100, 2, 5, 30, 2300, 3900, 11, 6660, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Shoot'),
(4531, 0, 5, 0, 61, 1, 100, 2, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model'),
(4531, 0, 6, 7, 9, 1, 100, 2, 30, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Moving when not in Shoot Range'),
(4531, 0, 7, 0, 61, 1, 100, 2, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(4531, 0, 8, 0, 2, 1, 100, 3, 0, 15, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'At 15% HP - Set Phase 2'),
(4531, 0, 9, 10, 61, 1, 100, 2, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model when not in Shoot Range'),
(4531, 0, 10, 0, 61, 1, 100, 2, 0, 0, 0, 0, 20, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Start Melee Attack when not in Shoot Range'),
(4531, 0, 11, 12, 9, 1, 100, 2, 11, 25, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Moving at 25 Yards'),
(4531, 0, 12, 13, 61, 1, 100, 2, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Stop Melee Attack at 25 Yards'),
(4531, 0, 13, 0, 61, 1, 100, 2, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Ranged Weapon Model at 25 Yards'),
(4531, 0, 14, 15, 7, 1, 100, 3, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(4531, 0, 15, 0, 61, 1, 100, 3, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(4531, 0, 16, 0, 2, 1, 100, 3, 0, 15, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'At 15% HP - Set Phase 2'),
(4531, 0, 17, 0, 2, 2, 100, 3, 0, 15, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flee at 15% HP'),
(4531, 0, 18, 19, 7, 2, 100, 3, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Set Melee Weapon Model on Evade'),
(4531, 0, 19, 0, 61, 2, 100, 3, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Reset on Evade'),
(4531, 0, 20, 0, 2, 2, 100, 3, 0, 15, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Say Text at 15% HP'),
(4531, 0, 21, 0, 11, 0, 100, 3, 0, 0, 0, 0, 11, 8274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cast Summon Tamed Battleboar on Spawn'),
(4531, 0, 22, 0, 0, 1, 100, 2, 6000, 9000, 9000, 14000, 11, 6984, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Cast Frost Shot');

UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='6004') AND (`source_type`='0') AND (`id`='8') AND (`link`='9');
UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='23619') AND (`source_type`='0') AND (`id`='1') AND (`link`='2');
UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='23623') AND (`source_type`='0') AND (`id`='1') AND (`link`='2');
UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='23624') AND (`source_type`='0') AND (`id`='1') AND (`link`='2');
UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='23625') AND (`source_type`='0') AND (`id`='1') AND (`link`='2');
UPDATE `smart_scripts` SET `link`='0' WHERE (`entryorguid`='23626') AND (`source_type`='0') AND (`id`='1') AND (`link`='2');