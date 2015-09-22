local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.28

SPELL_TYPE = { LINEAR = 1, CIRCULAR = 2, CONE = 3, TARGETTED = 4, SELF = 5}

ORBWALK_MODE = { COMBO = 1, HARASS = 2, CLEAR = 3, LASTHIT = 4, NONE = -1}

CIRCLE_MANAGER = { CIRCLE_2D = 1, CIRCLE_3D = 2, CIRCLE_MINIMAP = 3}

LASTHIT_MODE = { NEVER = 1, SMART = 2, ALWAYS = 3}


class "_CircleManager"
class "_SpellManager"
class "_Spell"
class "_Prediction"
class "_Circle"
class "_OrbwalkManager"
class "_KeyManager"
class "_Required"
class "_Downloader"
class "_ScriptUpdate"
class "_Interrupter"
class "_Initiator"
class "_Evader"
class "_AutoSmite"
class "_SimpleTargetSelector"

local CHANELLING_SPELLS = {
    ["Caitlyn"]                     = { "R" },
    ["Katarina"]                    = { "R" },
    ["MasterYi"]                    = { "W" },
    ["Fiddlesticks"]                = { "R" },
    ["Galio"]                       = { "R" },
    ["Lucian"]                      = { "R" },
    ["MissFortune"]                 = { "R" },
    ["VelKoz"]                      = { "R" },
    ["Nunu"]                        = { "R" },
    ["Shen"]                        = { "R" },
    ["Karthus"]                     = { "R" },
    ["Malzahar"]                    = { "R" },
    ["Pantheon"]                    = { "R" },
    ["Warwick"]                     = { "R" },
    ["Xerath"]                      = { "R" },
}

local GAPCLOSER_SPELLS = {
    ["Aatrox"]                      = { "Q" },
    ["Akali"]                       = { "R" },
    ["Alistar"]                     = { "W" },
    ["Amumu"]                       = { "Q" },
    ["Caitlyn"]                     = { "E" },
    ["Corki"]                       = { "W" },
    ["Diana"]                       = { "R" },
    ["Ezreal"]                       = { "E" },
    ["Elise"]                       = { "Q", "E" },
    ["Fiddlesticks"]                = { "R" },
    ["Fiora"]                       = { "Q" },
    ["Fizz"]                        = { "Q" },
    ["Gnar"]                        = { "E" },
    ["Gragas"]                      = { "E" },
    ["Graves"]                      = { "E" },
    ["Hecarim"]                     = { "R" },
    ["Irelia"]                      = { "Q" },
    ["JarvanIV"]                    = { "Q", "R" },
    ["Jax"]                         = { "Q" },
    ["Jayce"]                       = { "Q" },
    ["Katarina"]                    = { "E" },
    ["Kassadin"]                    = { "R" },
    ["Kennen"]                      = { "E" },
    ["KhaZix"]                      = { "E" },
    ["Lissandra"]                   = { "E" },
    ["LeBlanc"]                     = { "W" , "R"},
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" },
    ["Lucian"]                      = { "E" },
    ["Malphite"]                    = { "R" },
    ["MasterYi"]                    = { "Q" },
    ["MonkeyKing"]                  = { "E" },
    ["Nautilus"]                    = { "Q" },
    ["Nocturne"]                    = { "R" },
    ["Olaf"]                        = { "R" },
    ["Pantheon"]                    = { "W" , "R"},
    ["Poppy"]                       = { "E" },
    ["RekSai"]                      = { "E" },
    ["Renekton"]                    = { "E" },
    ["Riven"]                       = { "Q", "E"},
    ["Rengar"]                      = { "R" },
    ["Sejuani"]                     = { "Q" },
    ["Sion"]                        = { "R" },
    ["Shen"]                        = { "E" },
    ["Shyvana"]                     = { "R" },
    ["Talon"]                       = { "E" },
    ["Thresh"]                      = { "Q" },
    ["Tristana"]                    = { "W" },
    ["Tryndamere"]                  = { "E" },
    ["Udyr"]                        = { "E" },
    ["Volibear"]                    = { "Q" },
    ["Vi"]                          = { "Q" },
    ["XinZhao"]                     = { "E" },
    ["Yasuo"]                       = { "E" },
    ["Zac"]                         = { "E" },
    ["Ziggs"]                       = { "W" },
}

local CC_SPELLS = {
    ["Ahri"]                        = { "E" },
    ["Amumu"]                       = { "Q", "R" },
    ["Anivia"]                      = { "Q" },
    ["Annie"]                       = { "R" },
    ["Ashe"]                        = { "R" },
    ["Bard"]                        = { "Q" },
    ["Blitzcrank"]                  = { "Q" },
    ["Brand"]                       = { "Q" },
    ["Braum"]                       = { "Q" },
    ["Cassiopeia"]                  = { "R" },
    ["Darius"]                      = { "E" },
    ["Draven"]                      = { "E" },
    ["DrMundo"]                     = { "Q" },
    ["Ekko"]                        = { "W" },
    ["Elise"]                       = { "E" },
    ["Evelynn"]                     = { "R" },
    ["Ezreal"]                      = { "R" },
    ["Fizz"]                        = { "R" },
    ["Galio"]                       = { "R" },
    ["Gnar"]                        = { "R" },
    ["Gragas"]                      = { "R" },
    ["Graves"]                      = { "R" },
    ["Jinx"]                        = { "W" , "R" },
    ["KhaZix"]                      = { "W" },
    ["Leblanc"]                     = { "E" },
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" , "R" },
    ["Lux"]                         = { "Q" , "R" },
    ["Malphite"]                    = { "R" },
    ["Morgana"]                     = { "Q" },
    ["Nami"]                        = { "Q" },
    ["Nautilus"]                    = { "Q" },
    ["Nidalee"]                     = { "Q" },
    ["Orianna"]                     = { "R" },
    ["Rengar"]                      = { "E" },
    ["Riven"]                       = { "R" },
    ["Sejuani"]                     = { "R" },
    ["Sion"]                        = { "E" },
    ["Shen"]                        = { "E" },
    --["Shyvana"]                   = { "R" },
    ["Sona"]                        = { "R" },
    ["Swain"]                       = { "W" },
    ["Thresh"]                      = { "Q" },
    ["Varus"]                       = { "R" },
    ["Veigar"]                      = { "E" },
    ["Vi"]                          = { "Q" },
    ["Xerath"]                      = { "E" , "R" },
    ["Yasuo"]                       = { "Q" },
    ["Zyra"]                        = { "E" },
    ["Quinn"]                       = { "E" },
    ["Rumble"]                      = { "E" },
    ["Zed"]                         = { "R" },
}

local YASUO_WALL_SPELLS = {
    ["Ahri"]                        = { "Q" , "E" },
    ["Amumu"]                       = { "Q" },
    ["Anivia"]                      = { "Q" },
    ["Annie"]                       = { "R" },
    ["Ashe"]                        = { "W" , "R" },
    ["Bard"]                        = { "Q" },
    ["Blitzcrank"]                  = { "Q" },
    ["Brand"]                       = { "Q" },
    ["Braum"]                       = { "Q" , "R" },
    ["Caitlyn"]                     = { "Q" , "E", "R" },
    ["Corki"]                       = { "Q" , "R" },
    ["Cassiopeia"]                  = { "R" },
    ["Diana"]                       = { "Q" },
    ["Darius"]                      = { "E" },
    ["Draven"]                      = { "E" , "R" },
    ["DrMundo"]                     = { "Q" },
    ["Ekko"]                        = { "Q" },
    ["Elise"]                       = { "E" },
    ["Ezreal"]                      = { "Q" , "W" , "R" },
    ["Fiora"]                       = { "W" },
    ["Fizz"]                        = { "R" },
    ["Galio"]                       = { "E" },
    ["Gnar"]                        = { "Q" },
    ["Gragas"]                      = { "Q" , "R" },
    ["Graves"]                      = { "R" },
    ["Heimerdinger"]                = { "W" , "E" },
    ["Irelia"]                      = { "R" },
    ["Janna"]                       = { "Q" },
    ["Jayce"]                       = { "Q" },
    ["Jinx"]                        = { "W" , "R" },
    ["Kalista"]                     = { "Q" },
    ["Karma"]                       = { "Q" },
    ["Kennen"]                      = { "Q" },
    ["KhaZix"]                      = { "W" },
    ["KogMaw"]                      = { "Q" , "E" },
    ["Leblanc"]                     = { "E" },
    ["LeeSin"]                      = { "Q" },
    ["Leona"]                       = { "E" },
    ["Lissandra"]                   = { "Q" , "E" },
    ["Lulu"]                        = { "Q" },
    ["Lux"]                         = { "Q" , "E" ,  "R" },
    ["Morgana"]                     = { "Q" },
    ["Nami"]                        = { "R" },
    ["Nautilus"]                    = { "Q" },
    ["Nocturne"]                    = { "Q" },
    ["Nidalee"]                     = { "Q" },
    ["Olaf"]                        = { "Q" },
    ["Orianna"]                     = { "Q" , "E" },
    ["Quinn"]                       = { "Q" },
    ["Rengar"]                      = { "E" },
    ["RekSai"]                      = { "Q" },
    ["Riven"]                       = { "R" },
    ["Rumble"]                      = { "E" },
    ["Ryze"]                        = { "Q" },
    ["Sejuani"]                     = { "Q" , "R"},
    ["Sion"]                        = { "E" },
    ["Soraka"]                      = { "Q" },
    ["Shen"]                        = { "E" },
    ["Shyvana"]                     = { "E" },
    ["Sivir"]                       = { "Q" },
    ["Skarner"]                     = { "E" },
    ["Sona"]                        = { "R" },
    ["TahmKench"]                   = { "Q" },
    ["Thresh"]                      = { "Q" },
    ["TwistedFate"]                 = { "Q" },
    ["Twitch"]                      = { "W" },
    ["Varus"]                       = { "Q" , "R" },
    ["Veigar"]                      = { "Q" },
    ["VelKoz"]                      = { "Q" },
    ["Viktor"]                      = { "E" },
    ["Xerath"]                      = { "E" },
    ["Yasuo"]                       = { "Q" },
    ["Zed"]                         = { "Q" },
    ["Ziggs"]                       = { "W" },
    ["Zilean"]                      = { "Q" },
    ["Zyra"]                        = { "E" },
}

local EnemiesInGame = {}

function ExtraTime()
    return -0.07--Latency() - 0.1
end

function Latency()
    return GetLatency()/2000 
end

function CheckUpdate()
    if AUTOUPDATES then
        local ToUpdate = {}
        ToUpdate.LocalVersion = _G.SimpleLibVersion
        ToUpdate.VersionPath = "raw.githubusercontent.com/jachicao/BoL/master/version/SimpleLib.version"
        ToUpdate.ScriptPath = "raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua"
        ToUpdate.SavePath = LIB_PATH.."SimpleLib.lua"
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) PrintMessage("Updated to "..NewVersion..". Please reload with 2x F9.") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) PrintMessage("No Updates Found.") end
        ToUpdate.CallbackNewVersion = function(NewVersion) PrintMessage("New Version found ("..NewVersion.."). Please wait...") end
        ToUpdate.CallbackError = function(NewVersion) PrintMessage("Error while trying to check update.") end
        _ScriptUpdate(ToUpdate)
    end
end

function Immune(target)
    if EnemiesInGame["Kayle"] and TargetHaveBuff("judicatorintervention", target) then return true
    elseif target.charName == "Tryndamere" and TargetHaveBuff("undyingrage", target) then return true
    elseif target.charName == "Sion" and TargetHaveBuff("sionpassivezombie", target) then return true
    elseif target.charName == "Aatrox" and TargetHaveBuff("aatroxpassivedeath", target) then return true
    elseif EnemiesInGame["Zilean"] and TargetHaveBuff("chronoshift", target) then return true end
    return false
end

function IsEvading()
    return _G.evade or _G.Evade
end

function IsValidTarget(object, distance, enemyTeam)
    local enemyTeam = (enemyTeam ~= false)
    return object ~= nil and object.valid and (object.team ~= player.team) == enemyTeam and object.visible and not object.dead and object.bTargetable and (enemyTeam == false or object.bInvulnerable == 0) 
    and (distance == nil or GetDistanceSqr(object) <= distance * distance)
    and (object.type == myHero.type and not Immune(object) or (object.type ~= myHero.type and true))
end

function SlotToString(Slot)
    local string = "Q"
    if Slot == _Q then
        string = "Q"
    elseif Slot == _W then
        string = "W"
    elseif Slot == _E then
        string = "E"
    elseif Slot == _R then
        string = "R"
    elseif Slot == SUMMONER_1 then
        string = "D"
    elseif Slot == SUMMONER_2 then
        string = "F"
    elseif Slot == ITEM_1 then
        string = "ITEM_1"
    elseif Slot == ITEM_2 then
        string = "ITEM_2"
    elseif Slot == ITEM_3 then
        string = "ITEM_3"
    elseif Slot == ITEM_4 then
        string = "ITEM_4"
    elseif Slot == ITEM_5 then
        string = "ITEM_5"
    elseif Slot == ITEM_6 then
        string = "ITEM_6"
    elseif Slot == ITEM_7 then
        string = "ITEM_7"
    end
    return string
end

function PrintMessage(arg1, arg2)
    local a, b = "", ""
    if arg2 ~= nil then
        a = arg1
        b = arg2
    else
        a = ScriptName
        b = arg1
    end
    print("<font color=\"#6699ff\"><b>" .. a .. ":</b></font> <font color=\"#FFFFFF\">" .. b .. "</font>") 
end

function FindItemSlot(name)
    for slot = ITEM_1, ITEM_7 do
        if myHero:CanUseSpell(slot) == READY and myHero:GetSpellData(slot) ~= nil and myHero:GetSpellData(slot).name ~= nil and ( myHero:GetSpellData(slot).name:lower():find(name:lower()) or name:lower():find(myHero:GetSpellData(slot).name:lower()) ) then
            return slot
        end
    end
    return nil
end

function FindSummonerSlot(name)
    for slot = SUMMONER_1, SUMMONER_2 do
        if myHero:GetSpellData(slot)  ~= nil and myHero:GetSpellData(slot).name  ~= nil and ( myHero:GetSpellData(slot).name:lower():find(name:lower()) or name:lower():find(myHero:GetSpellData(slot).name:lower()) ) then
            return slot
        end
    end
    return nil
end

function GetPriority(enemy)
    return 1 + math.max(0, math.min(1.5, TS_GetPriority(enemy) * 0.25))
end


function _GetDistanceSqr(p1, p2)
    p2 = p2 or player
    if p1 and p1.networkID and (p1.networkID ~= 0) and p1.visionPos then p1 = p1.visionPos end
    if p2 and p2.networkID and (p2.networkID ~= 0) and p2.visionPos then p2 = p2.visionPos end
    return GetDistanceSqr(p1, p2)
    
end

function CountObjectsNearPos(pos, range, radius, objects)
    local n = 0
    for i, object in ipairs(objects) do
        local r = radius --+ object.boundingRadius
        if _GetDistanceSqr(pos, object) <= math.pow(r, 2) then
            n = n + 1
        end
    end

    return n
end

function GetBestCircularFarmPosition(range, radius, objects)
    local BestPos 
    local BestHit = 0
    for i, object in ipairs(objects) do
        local hit = CountObjectsNearPos(object.visionPos or object, range, radius, objects)
        if hit > BestHit then
            BestHit = hit
            BestPos = object--Vector(object)
            if BestHit == #objects then
               break
            end
         end
    end
    return BestPos, BestHit
end

function CountObjectsOnLineSegment(StartPos, EndPos, width, objects)
    local n = 0
    for i, object in ipairs(objects) do
        local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(StartPos, EndPos, object)
        local w = width --+ object.boundingRadius
        if isOnSegment and GetDistanceSqr(pointSegment, object) < math.pow(w, 2) and GetDistanceSqr(StartPos, EndPos) > GetDistanceSqr(StartPos, object) then
            n = n + 1
        end
    end
    return n
end
    

function GetBestLineFarmPosition(range, width, objects)
    local BestPos 
    local BestHit = 0
    for i, object in ipairs(objects) do
        local EndPos = Vector(myHero) + range * (Vector(object) - Vector(myHero)):normalized()
        local hit = CountObjectsOnLineSegment(myHero, EndPos, width, objects)
        if hit > BestHit then
            BestHit = hit
            BestPos = object--Vector(object)
            if BestHit == #objects then
               break
            end
         end
    end
    return BestPos, BestHit
end



function GetHPBarPos(enemy)
    enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
    local barPos = GetUnitHPBarPos(enemy)
    local barPosOffset = GetUnitHPBarOffset(enemy)
    local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
    local BarPosOffsetX = -50
    local BarPosOffsetY = 46
    local CorrectionY = 39
    local StartHpPos = 31 
    barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
    barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
    local StartPos = Vector(barPos.x , barPos.y, 0)
    local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
    return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

function DrawLineHPBar(damage, text, unit, enemyteam)
    if unit.dead or not unit.visible then return end
    local p = WorldToScreen(D3DXVECTOR3(unit.x, unit.y, unit.z))
    if not OnScreen(p.x, p.y) then return end
    local thedmg = 0
    local line = 2
    local linePosA  = {x = 0, y = 0 }
    local linePosB  = {x = 0, y = 0 }
    local TextPos   = {x = 0, y = 0 }
    
    
    if damage >= unit.maxHealth then
        thedmg = unit.maxHealth - 1
    else
        thedmg = damage
    end
    
    thedmg = math.round(thedmg)
    
    local StartPos, EndPos = GetHPBarPos(unit)
    local Real_X = StartPos.x + 24
    local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
    if Offs_X < Real_X then Offs_X = Real_X end 
    local mytrans = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
    if mytrans >= 255 then mytrans=254 end
    local my_bluepart = math.round(400*((unit.health-thedmg)/unit.maxHealth))
    if my_bluepart >= 255 then my_bluepart=254 end

    
    if enemyteam then
        linePosA.x = Offs_X-150
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-150
        linePosB.y = (StartPos.y-10)
        TextPos.x = Offs_X-148
        TextPos.y = (StartPos.y-(30+(line*15)))
    else
        linePosA.x = Offs_X-125
        linePosA.y = (StartPos.y-(30+(line*15)))    
        linePosB.x = Offs_X-125
        linePosB.y = (StartPos.y-15)
    
        TextPos.x = Offs_X-122
        TextPos.y = (StartPos.y-(30+(line*15)))
    end

    DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(mytrans, 255, my_bluepart, 0))
    DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(mytrans, 255, my_bluepart, 0))
end

 
function _arrangePriorities()
    local priorityTable2 = {
        p5 = {"Alistar", "Amumu", "Blitzcrank", "Braum", "ChoGath", "DrMundo", "Garen", "Gnar", "Hecarim", "JarvanIV", "Leona", "Lulu", "Malphite", "Nasus", "Nautilus", "Nunu", "Olaf", "Rammus", "Renekton", "Sejuani", "Shen", "Shyvana", "Singed", "Sion", "Skarner", "TahmKench", "Taric", "Thresh", "Volibear", "Warwick", "MonkeyKing", "Yorick", "Zac"},
        p4 = {"Aatrox", "Darius", "Elise", "Evelynn", "Galio", "Gangplank", "Gragas", "Irelia", "Jax","LeeSin", "Maokai", "Morgana", "Nocturne", "Pantheon", "Poppy", "Rengar", "Rumble", "Ryze", "Swain","Trundle", "Tryndamere", "Udyr", "Urgot", "Vi", "XinZhao", "RekSai"},
        p3 = {"Akali", "Diana", "Fiddlesticks", "Fiora", "Fizz", "Heimerdinger", "Janna", "Jayce", "Kassadin","Kayle", "KhaZix", "Lissandra", "Mordekaiser", "Nami", "Nidalee", "Riven", "Shaco", "Sona", "Soraka", "Vladimir", "Yasuo", "Zilean", "Zyra"},
        p2 = {"Ahri", "Anivia", "Annie",  "Brand",  "Cassiopeia", "Ekko", "Karma", "Karthus", "Katarina", "Kennen", "LeBlanc",  "Lux", "Malzahar", "MasterYi", "Orianna", "Syndra", "Talon",  "TwistedFate", "Veigar", "VelKoz", "Viktor", "Xerath", "Zed", "Ziggs" },
        p1 = {"Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jinx", "Kalista", "KogMaw", "Lucian", "MissFortune", "Quinn", "Sivir", "Teemo", "Tristana", "Twitch", "Varus", "Vayne"},
    }
     local priorityOrder = {
        [1] = {1,1,1,1,1},
        [2] = {1,1,2,2,2},
        [3] = {1,1,2,3,3},
        [4] = {1,2,3,4,4},
        [5] = {1,2,3,4,5},
    }
    local function _SetPriority(tab, hero, priority)
        if table ~= nil and hero ~= nil and priority ~= nil and type(table) == "table" then
            for i=1, #tab, 1 do
                if hero.charName:find(tab[i]) ~= nil and type(priority) == "number" then
                    TS_SetHeroPriority(priority, hero.charName)
                end
            end
        end
    end
    local enemies = #GetEnemyHeroes()
    if priorityTable2~=nil and type(priorityTable2) == "table" and enemies > 0 then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            _SetPriority(priorityTable2.p1, enemy, math.min(1, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p2, enemy, math.min(2, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p3,  enemy, math.min(3, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p4,  enemy, math.min(4, #GetEnemyHeroes()))
            _SetPriority(priorityTable2.p5,  enemy, math.min(5, #GetEnemyHeroes()))
        end
    end
end

--CLASS: _AutoSmite
function _AutoSmite:__init()
    self.Spell = _Spell({Slot = FindSummonerSlot("smite"), DamageName = "SMITE", Range = 780, Type = SPELL_TYPE.TARGETTED})
    if self.Spell.Slot ~= nil then
        if _G.SimpleAutoSmite == nil then
            self.JungleMinions = minionManager(MINION_JUNGLE, self.Spell.Range + 100, myHero, MINION_SORT_MAXHEALTH_DEC)
            _G.SimpleAutoSmite = scriptConfig("SimpleLib - Auto Smite", "SimpleAutoSmite".."07072015"..myHero.charName)
            _G.SimpleAutoSmite:addParam("Baron", "Use Smite on Dragon/Baron", SCRIPT_PARAM_ONOFF, true)
            _G.SimpleAutoSmite:addParam("Killsteal", "Use Smite to Killsteal", SCRIPT_PARAM_ONOFF, true)
            AddTickCallback(
                function()
                    if self.Spell:IsReady() then
                        if _G.SimpleAutoSmite.Baron then
                            self.JungleMinions:update()
                            for i, minion in pairs(self.JungleMinions.objects) do
                                if self.Spell:ValidTarget(minion) and minion.health > 0 and (minion.charName:lower():find("dragon") or minion.charName:lower():find("baron")) then
                                    if self.Spell:Damage(minion) > minion.health then
                                        self.Spell:Cast(minion)
                                    end
                                end
                            end
                        end
                        if _G.SimpleAutoSmite.Killsteal then
                            for i, enemy in ipairs(GetEnemyHeroes()) do
                                if self.Spell:ValidTarget(enemy) and self.Spell:Damage(enemy) > enemy.health then
                                    self.Spell:Cast(enemy)
                                end
                            end
                        end
                    end
                end
            )
        end
    end
end

--CLASS: _CircleManager
function _CircleManager:__init()
    self.circles = {}
    AddDrawCallback(
        function()
            if #self.circles > 0 and not myHero.dead then
                for _, circle in ipairs(self.circles) do
                    local menu = circle.Menu
                    local condition = true
                    if circle.Condition ~= nil then
                        if type(circle.Condition) == "function" then
                            condition = circle.Condition()
                        elseif type(circle.Condition) == "boolean" then
                            condition = circle.Condition
                        end
                    end
                    if menu.Enable and condition then
                        local source = myHero
                        local range = 0
                        if circle.Source ~= nil then
                            if type(circle.Source) == "function" then
                                source = circle.Source()
                            elseif type(circle.Source) == "boolean" then
                                source = circle.Source
                            end
                        end
                        if circle.Range ~= nil then
                            if type(circle.Range) == "function" then
                                range = circle.Range()
                            elseif type(circle.Range) == "number" then
                                range = circle.Range
                            end
                        end
                        if source ~= nil and range > 0 then
                            local mode      = circle.Mode
                            local color     = menu.Color
                            local width     = menu.Width
                            local quality   = menu.Quality
                            local pos = WorldToScreen(D3DXVECTOR3(source.x , source.y, source.z))
                            if mode == CIRCLE_MANAGER.CIRCLE_2D and OnScreen(pos.x, pos.y) then
                                DrawCircle2D(source.x, source.y, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                            elseif mode == CIRCLE_MANAGER.CIRCLE_3D and OnScreen(pos.x, pos.y) then
                                if OnScreen(pos.x, pos.y) and range <= 1800 then
                                    DrawCircle3D(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                                elseif range > 1800 then
                                    DrawCircleMinimap(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                                end
                            elseif mode == CIRCLE_MANAGER.CIRCLE_MINIMAP then
                                DrawCircleMinimap(source.x, source.y, source.z, range, width, ARGB(color[1], color[2], color[3], color[4]), quality)
                            end
                        end
                    end
                end
            end
        end
    )
end

function _CircleManager:AddCircle(circle)
    table.insert(self.circles, circle)
end

--CLASS: _Circle
function _Circle:__init(t)
    self.Menu = nil
    assert(t and type(t) == "table", "_Circle: table is invalid!")
    assert(t.Menu ~= nil, "_Circle: Table doesn't have Menu!")
    self.Mode = nil
    self.Name = nil
    self.Text = nil
    self.Range = nil
    self.Condition = nil
    self.Source = nil
    if t ~= nil then
        if t.Menu ~= nil then
            local mode = t.Mode ~= nil and t.Mode or CIRCLE_MANAGER.CIRCLE_3D
            local name = t.Name ~= nil and t.Name or "Circle"..tostring(#CircleManager.circles + 1)
            local text = t.Text ~= nil and t.Text or name
            local range = 0
            if t.Range ~= nil then
                if type(t.Range) == "function" then
                    range = t.Range()
                elseif type(t.Range) == "number" then
                    range = t.Range
                end
            end
            t.Menu:addSubMenu(text, name)
            self.Menu = t.Menu[name]
            if self.Menu ~= nil then
                local enable = true
                if t.Enable ~= nil and type(t.Enable) == "boolean" then enable = t.Enable end
                local color = t.Color ~= nil and t.Color or { 255, 255, 255, 255 }
                local width = t.Width ~= nil and t.Width or 1
                local quality = t.Quality ~= nil and t.Quality or math.min(math.round((range/5 + 6)/2), 30)
                self.Menu:addParam("Enable", "Enable", SCRIPT_PARAM_ONOFF, enable)
                self.Menu:addParam("Color", "Color", SCRIPT_PARAM_COLOR, color)
                self.Menu:addParam("Width", "Width", SCRIPT_PARAM_SLICE, width, 1, 6)
                self.Menu:addParam("Quality", "Quality", SCRIPT_PARAM_SLICE, quality, 10, math.round(range/5))
            end
            self.Mode = mode
            self.Name = name
            self.Text = text
            self.Range = t.Range
            self.Condition = t.Condition
            self.Source = t.Source ~= nil and t.Source or myHero
            CircleManager:AddCircle(self)
        end
    end
    return self
end

function _SpellManager:__init()
    self.spells = {}
end

function _SpellManager:AddSpell(spell)
    table.insert(self.spells, spell)
end

function _SpellManager:InitMenu()
    if _G.SpellManagerMenu == nil then
        _G.SpellManagerMenu = scriptConfig("SimpleLib - Spell Manager", "SpellManager".."19052015"..myHero.charName)
        if VIP_USER then
            _G.SpellManagerMenu:addParam("Packet", "Enable Packets", SCRIPT_PARAM_ONOFF, false)
            _G.SpellManagerMenu:addParam("Exploit", "Enable No-Face Exploit", SCRIPT_PARAM_ONOFF, false)
        end
        _G.SpellManagerMenu:addParam("DisableDraws", "Disable All Draws", SCRIPT_PARAM_ONOFF, false)
        local tab = {" "}
        for i, name in ipairs(Prediction.PredictionList) do
            table.insert(tab, name)
        end
        _G.SpellManagerMenu:addParam("PredictionSelected", "Set All Skillshots to: ", SCRIPT_PARAM_LIST, 1, tab)
        _G.SpellManagerMenu.PredictionSelected = 1
        _G.SpellManagerMenu:setCallback("PredictionSelected",
            function(v)
                if v and v ~= 1 then
                    --print(tostring(_G.SpellManagerMenu._param[_G.SpellManagerMenu:getParamIndex("PredictionSelected")].listTable[v]))
                    for i, spell in ipairs(self.spells) do
                        if spell.Menu ~= nil then
                            if spell.Menu.PredictionSelected ~= nil then
                                spell.Menu.PredictionSelected = _G.SpellManagerMenu.PredictionSelected -1
                            end
                        end
                    end
                end
            end
            )
    end
end

function _SpellManager:AddLastHit()
    if _G.SpellManagerMenu ~= nil then
        if not _G.SpellManagerMenu.FarmDelay then
            _G.SpellManagerMenu:addParam("FarmDelay", "Delay for LastHit (in ms)", SCRIPT_PARAM_SLICE, 0, -150, 150)
        end
    end
end

--CLASS: _Spell
function _Spell:__init(tab)
    assert(tab and type(tab) == "table", "_Spell: Table is invalid!")
    self.LastCastTime = 0
    self.LastSentTime = 0
    self.Object = nil
    self.Source = myHero
    self.DrawSource = myHero
    self.TS = nil
    self.Menu = nil
    --self.LastHitMode = LASTHIT_MODE.NEVER
    if tab ~= nil then
        self.Type = tab.Type ~= nil and tab.Type or SPELL_TYPE.SELF
        self.Slot = tab.Slot
        self.IsForEnemies = true
        if tab.IsForEnemies ~= nil and type(tab.IsForEnemies) == "boolean" then self.IsForEnemies = tab.IsForEnemies end
        self.DamageName = nil
        if tab.DamageName ~= nil then
            self.DamageName = tab.DamageName
            self.Name = tab.DamageName
        elseif self.Slot ~= nil then
            self.DamageName = SlotToString(self.Slot)
            self.Name = SlotToString(self.Slot)
        else
            self.Name = "Spell"..tostring(#SpellManager.spells + 1)
        end
        assert(tab.Range and type(tab.Range) == "number", "_Spell: Range is invalid!")
        self.Range = tab.Range
        self.Width = tab.Width ~= nil and tab.Width or 1
        self.EnemyMinions = minionManager(MINION_ENEMY, self.Range + self.Width + 50, self.Source, MINION_SORT_MAXHEALTH_DEC)
        self.JungleMinions = minionManager(MINION_JUNGLE, self.Range + self.Width + 50, self.Source, MINION_SORT_MAXHEALTH_DEC)
        self.Delay = tab.Delay ~= nil and tab.Delay or 0
        self.Speed = tab.Speed ~= nil and tab.Speed or math.huge
        self.Collision = tab.Collision ~= nil and tab.Collision or false
        self.Aoe = tab.Aoe ~= nil and tab.Aoe or false
        self.IsVeryLowAccuracy = tab.IsVeryLowAccuracy
        if self:IsSkillShot() then
            self:AddToMenu()
            if self.Menu ~= nil then
                self.Menu:addParam("PredictionSelected", "Prediction Selection", SCRIPT_PARAM_LIST, 1, Prediction.PredictionList)
                Prediction:LoadPrediction(tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[self.Menu.PredictionSelected]))
                local lastest = self.Menu.PredictionSelected
                self.Menu:setCallback("PredictionSelected",
                    function(v)
                        if v then
                            Prediction:LoadPrediction(tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[v]))
                            if tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[v]) == "DivinePred" then
                                Prediction:BindSpell(self)
                            end
                            if tostring(self.Menu._param[self.Menu:getParamIndex("PredictionSelected")].listTable[lastest]) == "DivinePred" and v ~= lastest then
                                local boolean = true
                                for i, spell in ipairs(SpellManager.spells) do
                                    if spell.Menu ~= nil then
                                        if spell.Menu.PredictionSelected ~= nil then
                                            if tostring(spell.Menu._param[spell.Menu:getParamIndex("PredictionSelected")].listTable[spell.Menu.PredictionSelected]) == "DivinePred" then
                                                boolean = false
                                            end
                                        end
                                    end
                                end
                                if boolean then
                                    if not self.Draw then
                                        self.Draw = true
                                        AddDrawCallback(
                                            function()
                                                local p = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
                                                local boolean = true
                                                for i, spell in ipairs(SpellManager.spells) do
                                                    if spell.Menu ~= nil then
                                                        if spell.Menu.PredictionSelected ~= nil then
                                                            if tostring(spell.Menu._param[spell.Menu:getParamIndex("PredictionSelected")].listTable[spell.Menu.PredictionSelected]) == "DivinePred" then
                                                                boolean = false
                                                            end
                                                        end
                                                    end
                                                end
                                                if OnScreen(p.x, p.y) and boolean then
                                                    DrawText("Press 2x F9!", 25, p.x, p.y, ARGB(255, 255, 255, 255))
                                                end
                                            end
                                        )
                                    end
                                end
                            end
                            lastest = v
                        end
                    end
                    )
                self.Menu:addParam("Combo", "X % Combo Accuracy", SCRIPT_PARAM_SLICE, 60, 0, 100)
                self.Menu:addParam("Harass", "X % Harass Accuracy", SCRIPT_PARAM_SLICE, 70, 0, 100)
                self.Menu:addParam("info", "80 % ~ Super High Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info2", "60 % ~ High Accuracy (Recommended)", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info3", "30 % ~ Medium Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info4", "10 % ~ Low Accuracy", SCRIPT_PARAM_INFO, "")
            end
            Prediction:BindSpell(self)
        elseif self:IsSelf() then

        end
        SpellManager:AddSpell(self)
    end
    return self
end

function _Spell:AddDraw(t)
    self:AddToMenu()
    if self.Menu ~= nil then
        local table = {Menu = self.Menu, Name = "Draw", Text = "Drawing Settings", Source = function() if self.DrawSourceFunction ~= nil then return self.DrawSource end return self.Source end, Range = function() return self.Range end, Condition = function() return self:IsReady() and not _G.SpellManagerMenu.DisableDraws end}
        local enable = true
        if t ~= nil and t.Enable ~= nil and type(t.Enable) == "boolean" then enable = t.Enable end
        local color = t ~= nil and t.Color ~= nil and t.Color or { 255, 255, 255, 255 }
        local width = t ~= nil and t.Width ~= nil and t.Width or 1
        table.Enable = enable
        table.Color = color
        table.Width = width
        _Circle(table)
    end
    return self
end

function _Spell:AddTrackTime(t)
    assert(t and (type(t) == "string" or type(t) == "table"), "_Spell: AddTrackTime is invalid!")
    self.Track = type(t) == "table" and t or { t }
    self:LoadProcessSpellCallback()
    return self
end

function _Spell:AddTrackCallback(func)
    assert(self.Track and type(self.Track) == "table", "_Spell: AddTrackCallback needs TrackTime!")
    assert(func and type(func) == "function", "_Spell: AddTrackCallback needs function!")
    self.TrackCallback = func
    return self
end

function _Spell:AddRangeFunction(rngFunc)
    assert(rngFunc and type(rngFunc) == "function", "_Spell: RangeFunction is invalid!")
    self.RangeFunction = rngFunc
    self:LoadTickCallback()
    return self
end
function _Spell:AddWidthFunction(func)
    assert(func and type(func) == "function", "_Spell: WidthFunction is invalid!")
    self.WidthFunction = func
    self:LoadTickCallback()
    return self
end

function _Spell:AddTypeFunction(f)
    assert(f and type(f) == "function", "_Spell: TypeFunction is invalid!")
    self.TypeFunction = f
    self:LoadTickCallback()
    return self
end

function _Spell:AddDamageFunction(f)
    assert(f and type(f) == "function", "_Spell: DamageFunction is invalid!")
    self.DamageFunction = f
    return self
end

function _Spell:AddSlotFunction(f)
    assert(f and type(f) == "function", "_Spell: SlotFunction is invalid!")
    self.SlotFunction = f
    self:LoadTickCallback()
    return self
end

function _Spell:AddSourceFunction(srcFunc)
    assert(srcFunc and type(srcFunc) == "function", "_Spell: SourceFunction is invalid!")
    self.SourceFunction = srcFunc
    self:LoadTickCallback()
    return self
end

function _Spell:AddDrawSourceFunction(drawSrcFunc)
    assert(drawSrcFunc and type(drawSrcFunc) == "function", "_Spell: DrawSourceFunction is invalid!")
    self.DrawSourceFunction = drawSrcFunc
    self:LoadTickCallback()
    return self
end

function _Spell:AddTrackObject(t)
    assert(t and (type(t) == "string" or type(t) == "table"), "_Spell: AddTrackObject is invalid!")
    self.TrackObject = type(t) == "table" and t or { t }
    self:LoadCreateAndDeleteCallback()
    return self
end

function _Spell:SetAccuracy(int)
    if self.Menu ~= nil then
        assert(int and type(int) == "number", "_Spell: SetAccuracy is invalid!")
        self.Menu.Combo = int
        self.Menu.Harass = int + 10
    end
    return self
end

function _Spell:YasuoWall(vector)
    if YasuoWall ~= nil and self.Speed ~= math.huge and vector ~= nil then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if enemy.charName:lower():find("yasuo") then
                local level = enemy:GetSpellData(_W) ~= nil and enemy:GetSpellData(_W).level ~= nil and enemy:GetSpellData(_W).level or 0
                local width = 250 + level * 50
                local pos1 = Vector(YasuoWall.Object) + Vector(Vector(YasuoWall.Object) - Vector(YasuoWall.StartVector)):normalized():perpendicular() * width/2
                local pos2 = Vector(YasuoWall.Object) + Vector(Vector(YasuoWall.Object) - Vector(YasuoWall.StartVector)):normalized():perpendicular2() * width/2
                local p1 = WorldToScreen(D3DXVECTOR3(pos1.x, pos1.y, pos1.z))
                local p2 = WorldToScreen(D3DXVECTOR3(pos2.x, pos2.y, pos2.z))
                local p3 = WorldToScreen(D3DXVECTOR3(self.Source.x, self.Source.y, self.Source.z))
                local p4 = WorldToScreen(D3DXVECTOR3(vector.x, vector.y, vector.z))
                return IsLineSegmentIntersection(p1, p2, p3, p4)
            end
        end
    end
    return false
end

function _Spell:CastToVector(vector)
    if self:IsReady() and vector ~= nil and not IsEvading() then
        if self:YasuoWall(vector) then return end
        self.LastSentTime = os.clock()
        CastSpell(self.Slot, vector.x, vector.z)
    end
end

function _Spell:Cast(target, t)
    if self:IsReady() and not IsEvading() then
        if self:ValidTarget(target) then
            if OrbwalkManager:IsHarass() and target.type == myHero.type then
                if OrbwalkManager:IsAttacking() and OrbwalkManager.AA.LastTarget and OrbwalkManager.AA.LastTarget.type ~= myHero.type then return end
                if OrbwalkManager:ShouldWait() then return end
            end
            if self:IsSkillShot() then
                local CastPosition, WillHit = self:GetPrediction(target, t)
                if CastPosition ~= nil and WillHit then
                    self.LastSentTime = os.clock()
                    self:CastToVector(CastPosition)
                end
            elseif self:IsTargetted() then
                if self:YasuoWall(target) then return end
                self.LastSentTime = os.clock()
                CastSpell(self.Slot, target)
            elseif self:IsSelf() then
                local CastPosition,  WillHit = self:GetPrediction(target, t)
                if CastPosition ~= nil and GetDistanceSqr(self.Source, CastPosition) <= self.Range * self.Range then
                    if (target.type == myHero.type and WillHit) or (target.type ~= myHero.type) then
                        self.LastSentTime = os.clock()
                        CastSpell(self.Slot)
                    end
                end
            end
        elseif target == nil and self:IsSelf() then
            self.LastSentTime = os.clock()
            CastSpell(self.Slot)
        end
    end
end

function _Spell:GetPrediction(target, t)
    local range = t ~= nil and t.Range ~= nil and t.Range or self.Range
    if self:ValidTarget(target, range) then
        if self:IsSkillShot() then
            local pred = t ~= nil and t.TypeOfPrediction ~= nil and t.TypeOfPrediction or self:PredictionSelected()
            local accuracy = t ~= nil and t.Accuracy ~= nil and t.Accuracy or self:GetAccuracy()
            local source = t ~= nil and t.Source ~= nil and t.Source or self.Source
            local delay = t ~= nil and t.Delay ~= nil and t.Delay or self.Delay
            local speed = t ~= nil and t.Speed ~= nil and t.Speed or self.Speed
            local width = t ~= nil and t.Width ~= nil and t.Width or self.Width
            local type = t ~= nil and t.Type ~= nil and t.Type or self.Type
            local tab = {Delay = delay, Width = width, Speed = speed, Range = range, Source = source, Type = type, Collision = self.Collision, Aoe = self.Aoe, TypeOfPrediction = pred, Accuracy = accuracy, Slot = self.Slot, IsVeryLowAccuracy = self.IsVeryLowAccuracy, Name = self.Name}
            return Prediction:GetPrediction(target, tab)
        elseif self:IsSelf() then
            local pred = t ~= nil and t.TypeOfPrediction ~= nil and t.TypeOfPrediction or self:PredictionSelected()
            local accuracy = t ~= nil and t.Accuracy ~= nil and t.Accuracy or self:GetAccuracy()
            local source = t ~= nil and t.Source ~= nil and t.Source or self.Source
            local tab = {Delay = self.Delay, Speed = self.Speed, Source = source, Collision = self.Collision, TypeOfPrediction = pred, Accuracy = accuracy}
            return Prediction:GetPredictedPos(target, tab)
        end
    end
    return Vector(target), false, Vector(target)
end

function _Spell:LoadTickCallback()
    if not self.TickCallback then
        self.TickCallback = true
        local LastTick = 0
        local Interval = 10 --segs
        AddTickCallback(
            function()
                if myHero.dead then return end

                if self.SourceFunction ~= nil then
                    self.Source = self.SourceFunction()
                end

                if self.RangeFunction ~= nil then
                    self.Range = self.RangeFunction()
                end

                if self.TypeFunction ~= nil then
                    self.Type = self.TypeFunction()
                end

                if self.DrawSourceFunction ~= nil then
                    self.DrawSource = self.DrawSourceFunction()
                end

                if self.WidthFunction ~= nil then
                    self.Width = self.WidthFunction()
                end
                if self.SlotFunction ~= nil then
                    if os.clock() - LastTick > Interval then
                        self.Slot = self.SlotFunction()
                        LastTick = os.clock()
                    end
                end
            end
        )
    end
end

function _Spell:LoadCreateAndDeleteCallback()
    if not self.ObjectCallback then
        AddCreateObjCallback(
            function(obj)
                if obj and obj.name and self.Object == nil and obj.name:lower():find("missile") and os.clock() - self.LastCastTime > self.Delay * 0.8 and os.clock() - self.LastCastTime < self.Delay * 1.2 and ( (obj.spellOwner and obj.spellOwner.isMe) or GetDistanceSqr(self.Source, obj) < 10 * 10) then
                    for _, s in ipairs(self.TrackObject) do
                        if obj.name:lower():find(s:lower()) then
                            self.Object = obj
                        end
                    end
                end
            end
        )
        AddDeleteObjCallback(
            function(obj)
                if obj and obj.name and self.Object ~= nil and obj.name:lower():find("missile") and GetDistanceSqr(obj, self.Object) < math.pow(10, 2) then
                    for _, s in ipairs(self.TrackObject) do
                        if obj.name:lower():find(s:lower()) then
                            self.Object = nil
                        end
                    end
                end
            end
        )
        self.ObjectCallback = true
    end
end

function _Spell:LoadProcessSpellCallback()
    if not self.ProcessCallback then
        self.ProcessCallback = true
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        if AddProcessAttackCallback then
            AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
    end
end

function _Spell:OnProcessSpell(unit, spell)
    if unit and spell and spell.name and unit.isMe then
        if self.Track ~= nil then
            for _, s in ipairs(self.Track) do
                if spell.name:lower():find(s:lower()) then
                    self.LastCastTime = os.clock()
                    if self.TrackCallback ~= nil then
                        self.TrackCallback(spell)
                    end
                end
            end
        end
    end
end

function _Spell:IsLinear()
    return self.Type == SPELL_TYPE.LINEAR
end

function _Spell:IsCircular()
    return self.Type == SPELL_TYPE.CIRCULAR
end

function _Spell:IsCone()
    return self.Type == SPELL_TYPE.CONE
end

function _Spell:IsSkillShot()
    return self:IsLinear() or self.Type == SPELL_TYPE.CIRCULAR or self.Type == SPELL_TYPE.CONE
end

function _Spell:IsSelf()
    return self.Type == SPELL_TYPE.SELF
end

function _Spell:IsTargetted()
    return self.Type == SPELL_TYPE.TARGETTED
end

function _Spell:PredictionSelected()
    local int = self.Menu ~= nil and self.Menu.PredictionSelected or 1
    return Prediction.PredictionList[int] ~= nil and tostring(Prediction.PredictionList[int]) or "VPrediction"
end

function _Spell:ValidTarget(target, range)
    local source = self.DrawSourceFunction ~= nil and self.DrawSource or self.Source
    local extrarange = self:IsCircular() and self.Width or 0
    local range = range ~= nil and range or self.Range
    return IsValidTarget(target, math.huge, self.IsForEnemies) and GetDistanceSqr(source, target) <= math.pow(range + extrarange, 2)
end

function _Spell:ObjectsInArea(objects)
    local objects2 = {}
    if objects ~= nil and self:IsSelf() and self:IsReady() then
        for i, object in ipairs(objects) do
            if self:ValidTarget(object) then
                local Position, WillHit = self:GetPrediction(object)
                if GetDistanceSqr(self.Source, Position) <= self.Range * self.Range then
                    if object.type == myHero.type then
                        if WillHit then
                            table.insert(objects2, object)
                        end
                    else
                        table.insert(objects2, object)
                    end
                end
            end
        end
    end
    return objects2
end

function _Spell:IsReady()
    if myHero.charName == "Kennen" then
        if self.Slot ~= nil and self.Slot == _W then
            return myHero:CanUseSpell(self.Slot) == READY or myHero:CanUseSpell(self.Slot) == 3
        end
    end
    return self.Slot ~= nil and (self:CanUseSpell() == READY or ( self:GetSpellData().level > 0 and self:GetSpellData().currentCd <= Latency()))
end

function _Spell:GetSpellData()
    return self.Slot ~= nil and myHero:GetSpellData(self.Slot) or nil
end

function _Spell:CanUseSpell()
    return self.Slot ~= nil and myHero:CanUseSpell(self.Slot) or nil
end

function _Spell:Damage(target, stage)
    if self.DamageName ~= nil and self.Slot ~= nil then
        if myHero.charName == "Irelia" and self.Slot ~= nil and self.Slot == _Q then
            return getDmg(self.DamageName, target, myHero, stage) + getDmg("AD", target, myHero, stage)
        end
        if self.DamageFunction ~= nil then
            return self.DamageFunction(self.DamageName, target, stage)
        end
        if self.DamageName == "SMITE" then
            if IsValidTarget(target) then
                if target.type == myHero.type then
                    local name = self:GetSpellData() ~= nil and self:GetSpellData().name ~= nil and self:GetSpellData().name or ""
                    if name:lower():find("smiteduel") then
                        return getDmg("SMITESS", target, myHero, stage)
                    elseif name:lower():find("smiteplayerganker") then
                        return getDmg("SMITESB", target, myHero, stage)
                    end
                else
                    return math.max(20 * myHero.level + 370, 30 * myHero.level + 330, 40 * myHero.level + 240, 50 * myHero.level + 100)
                end
            end
            return 0
        end
        return getDmg(self.DamageName, target, myHero, stage)
    end
    return 0
end

function _Spell:Mana()
    return self.Slot ~= nil and myHero:GetSpellData(self.Slot) ~= nil and myHero:GetSpellData(self.Slot).mana ~= nil and myHero:GetSpellData(self.Slot).mana or 0
end

function _Spell:GetAccuracy()
    if self.Menu ~= nil then
        if not OrbwalkManager:IsNone() then
            if OrbwalkManager:IsHarass() then
                return self.Menu.Harass
            else
                return self.Menu.Combo
            end
        end
    end
    return 60
end
--TODO: Normalize this
function _Spell:LaneClear(tab)
    if self.EnemyMinions ~= nil and self:IsReady() then
        if self.SourceFunction ~= nil then
            self.EnemyMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.EnemyMinions.range = self.Range
        end
        self.EnemyMinions:update()
        local NumberOfHits = tab ~= nil and tab.NumberOfHits ~= nil and type(tab.NumberOfHits) == "number" and tab.NumberOfHits or 1
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if NumberOfHits >= 1 and #self.EnemyMinions.objects >= NumberOfHits then
            if self:IsLinear() then
                local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsCircular() then
                local bestMinion, hits = GetBestCircularFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsCone() then
                local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.EnemyMinions.objects)
                if hits >= NumberOfHits then
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return minion
                end
            elseif self:IsSelf() then
                local objects = self:ObjectsInArea(self.EnemyMinions.objects)
                local hits = #objects
                if hits >= NumberOfHits then
                    local bestMinion = nil
                    for i, minion in pairs(objects) do
                        bestMinion = minion
                        break
                    end
                    if UseCast then
                        self:Cast(bestMinion)
                    end
                    return bestMinion
                end
            elseif self:IsTargetted() then
                local bestMinion = nil
                for i, minion in pairs(self.EnemyMinions.objects) do
                    if self:IsReady() then
                        self:Cast(minion)
                        bestMinion = minion
                    end
                end
                return bestMinion
            end
        end
    end
    return nil
end

function _Spell:JungleClear(tab)
    if self.JungleMinions ~= nil and self:IsReady() then
        if self.SourceFunction ~= nil then
            self.JungleMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.JungleMinions.range = self.Range
        end
        self.JungleMinions:update()
        local NumberOfHits = 1
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if self:IsLinear() then
            local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsCircular() then
            local bestMinion, hits = GetBestCircularFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsCone() then
            local bestMinion, hits = GetBestLineFarmPosition(self.Range, self.Width, self.JungleMinions.objects)
            if hits >= NumberOfHits then
                if UseCast then
                    self:Cast(bestMinion)
                end
            end
            return bestMinion
        elseif self:IsSelf() then
            local objects = self:ObjectsInArea(self.JungleMinions.objects)
            local hits = #objects
            if hits >= NumberOfHits then
                local bestMinion = nil
                for i, minion in pairs(objects) do
                    bestMinion = minion
                    break
                end
                if UseCast then
                    self:Cast(bestMinion)
                end
                return bestMinion
            end
        elseif self:IsTargetted() then
            local bestMinion = nil
            for i, minion in pairs(self.JungleMinions.objects) do
                if self:IsReady() then
                    if UseCast then
                        self:Cast(minion)
                        bestMinion = minion
                    end
                end
            end
            return bestMinion
        end
    end
    return nil
end

function _Spell:LastHit(tab)
    SpellManager:AddLastHit()
    local mode = tab ~= nil and tab.Mode ~= nil and type(tab.Mode) == "number" and tab.Mode or LASTHIT_MODE.SMART
    if self.EnemyMinions ~= nil and (self:IsSkillShot() or self:IsTargetted() or self:IsSelf()) and mode ~= LASTHIT_MODE.NEVER and self:IsReady() and _G.VP then
        if self.SourceFunction ~= nil then
            self.EnemyMinions.fromPos = self.Source
        end
        if self.RangeFunction ~= nil then
            self.EnemyMinions.range = self.Range
        end        
        local UseCast = true
        if tab ~= nil and tab.UseCast ~= nil and type(tab.UseCast) == "boolean" then UseCast = tab.UseCast end
        if self:IsReady() then
            self.EnemyMinions:update()
            for i, object in pairs(self.EnemyMinions.objects) do
                if self:IsReady() and self:ValidTarget(object) and not object.dead and object.health > 0 then
                    local delay = _G.SpellManagerMenu.FarmDelay ~= nil and _G.SpellManagerMenu.FarmDelay or 0
                    local CanCalculate = false
                    if mode == LASTHIT_MODE.SMART then
                        if not OrbwalkManager:CanAttack() then
                            if  OrbwalkManager.AA.LastTarget and object.networkID ~= OrbwalkManager.AA.LastTarget.networkID and not OrbwalkManager:IsAttacking() then
                                CanCalculate = true
                            end
                        else
                            if not OrbwalkManager:InRange(object) then
                                CanCalculate = true
                            else
                                local ProjectileSpeed = _G.VP:GetProjectileSpeed(myHero)
                                local time = OrbwalkManager:WindUpTime() + GetDistance(myHero, object) / ProjectileSpeed + ExtraTime()
                                local predHealth = _G.VP:GetPredictedHealth(object, time, delay)
                                if predHealth <= 20 then
                                    CanCalculate = true
                                end
                            end
                        end
                    elseif mode == LASTHIT_MODE.ALWAYS then
                        CanCalculate = true
                    end
                    if CanCalculate then
                        local dmg = self:Damage(object)
                        local time = 0
                        if self:IsSkillShot() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        elseif self:IsTargetted() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        elseif self:IsSelf() then
                            time = self.Delay + GetDistance(object, self.Source) / self.Speed + ExtraTime()
                        end
                        local predHealth = _G.VP:GetPredictedHealth(object, time, delay)
                        if predHealth == object.health and self.Delay + GetDistance(object, self.Source) / self.Speed > 0 and mode == LASTHIT_MODE.SMART then return end 
                        if dmg > predHealth and predHealth > -1 then
                            if UseCast then
                               self:Cast(object)
                            end
                            return object
                        end
                    end
                end
            end
        end
    end
end

function _Spell:AddToMenu()
    SpellManager:InitMenu()
    if self.Menu == nil then
        _G.SpellManagerMenu:addSubMenu(self.Name.." Settings", self.Name)
        self.Menu = _G.SpellManagerMenu[self.Name]
    end
end

--CLASS: _Prediction
function _Prediction:__init()
    self.UnitsImmobile = {}
    self.PredictionList = {}
    self.Actives = {
        ["VPrediction"] = false,
        ["HPrediction"] = false,
        ["DivinePred"] = false,
        ["SPrediction"] = false,
        ["Prodiction"] = false,
    }
    if FileExist(LIB_PATH.."VPrediction.lua") then
        table.insert(self.PredictionList, "VPrediction")
        require "VPrediction"
        self.Actives["VPrediction"] = true
        self.VP = VPrediction()
        _G.VP = self.VP
        if _G.VP.version < 2.97 then
            PrintMessage("Downloading the lastest version of VPrediction...")
            local r = _Required()
            local d = _Downloader({Name = "VPrediction", Url = "raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua", Extension = "lua", UseHttps = true})
            table.insert(r.downloading, d)
            r:Check()
        end
        self.VP.projectilespeeds = {["Velkoz"]= 2000, ["TeemoMushroom"] = math.huge, ["TestCubeRender"] = math.huge ,["Xerath"] = 2000.0000 ,["Kassadin"] = math.huge ,["Rengar"] = math.huge ,["Thresh"] = 1000.0000 ,["Ziggs"] = 1500.0000 ,["ZyraPassive"] = 1500.0000 ,["ZyraThornPlant"] = 1500.0000 ,["KogMaw"] = 1800.0000 ,["HeimerTBlue"] = 1599.3999 ,["EliseSpider"] = 500.0000 ,["Skarner"] = 500.0000 ,["ChaosNexus"] = 500.0000 ,["Katarina"] = 467.0000 ,["Riven"] = 347.79999 ,["SightWard"] = 347.79999 ,["HeimerTYellow"] = 1599.3999 ,["Ashe"] = 2000.0000 ,["VisionWard"] = 2000.0000 ,["TT_NGolem2"] = math.huge ,["ThreshLantern"] = math.huge ,["TT_Spiderboss"] = math.huge ,["OrderNexus"] = math.huge ,["Soraka"] = 1000.0000 ,["Jinx"] = 2750.0000 ,["TestCubeRenderwCollision"] = 2750.0000 ,["Red_Minion_Wizard"] = 650.0000 ,["JarvanIV"] = 20.0000 ,["Blue_Minion_Wizard"] = 650.0000 ,["TT_ChaosTurret2"] = 1200.0000 ,["TT_ChaosTurret3"] = 1200.0000 ,["TT_ChaosTurret1"] = 1200.0000 ,["ChaosTurretGiant"] = 1200.0000 ,["Dragon"] = 1200.0000 ,["LuluSnowman"] = 1200.0000 ,["Worm"] = 1200.0000 ,["ChaosTurretWorm"] = 1200.0000 ,["TT_ChaosInhibitor"] = 1200.0000 ,["ChaosTurretNormal"] = 1200.0000 ,["AncientGolem"] = 500.0000 ,["ZyraGraspingPlant"] = 500.0000 ,["HA_AP_OrderTurret3"] = 1200.0000 ,["HA_AP_OrderTurret2"] = 1200.0000 ,["Tryndamere"] = 347.79999 ,["OrderTurretNormal2"] = 1200.0000 ,["Singed"] = 700.0000 ,["OrderInhibitor"] = 700.0000 ,["Diana"] = 347.79999 ,["HA_FB_HealthRelic"] = 347.79999 ,["TT_OrderInhibitor"] = 347.79999 ,["GreatWraith"] = 750.0000 ,["Yasuo"] = 347.79999 ,["OrderTurretDragon"] = 1200.0000 ,["OrderTurretNormal"] = 1200.0000 ,["LizardElder"] = 500.0000 ,["HA_AP_ChaosTurret"] = 1200.0000 ,["Ahri"] = 1750.0000 ,["Lulu"] = 1450.0000 ,["ChaosInhibitor"] = 1450.0000 ,["HA_AP_ChaosTurret3"] = 1200.0000 ,["HA_AP_ChaosTurret2"] = 1200.0000 ,["ChaosTurretWorm2"] = 1200.0000 ,["TT_OrderTurret1"] = 1200.0000 ,["TT_OrderTurret2"] = 1200.0000 ,["TT_OrderTurret3"] = 1200.0000 ,["LuluFaerie"] = 1200.0000 ,["HA_AP_OrderTurret"] = 1200.0000 ,["OrderTurretAngel"] = 1200.0000 ,["YellowTrinketUpgrade"] = 1200.0000 ,["MasterYi"] = math.huge ,["Lissandra"] = 2000.0000 ,["ARAMOrderTurretNexus"] = 1200.0000 ,["Draven"] = 1700.0000 ,["FiddleSticks"] = 1750.0000 ,["SmallGolem"] = math.huge ,["ARAMOrderTurretFront"] = 1200.0000 ,["ChaosTurretTutorial"] = 1200.0000 ,["NasusUlt"] = 1200.0000 ,["Maokai"] = math.huge ,["Wraith"] = 750.0000 ,["Wolf"] = math.huge ,["Sivir"] = 1750.0000 ,["Corki"] = 2000.0000 ,["Janna"] = 1200.0000 ,["Nasus"] = math.huge ,["Golem"] = math.huge ,["ARAMChaosTurretFront"] = 1200.0000 ,["ARAMOrderTurretInhib"] = 1200.0000 ,["LeeSin"] = math.huge ,["HA_AP_ChaosTurretTutorial"] = 1200.0000 ,["GiantWolf"] = math.huge ,["HA_AP_OrderTurretTutorial"] = 1200.0000 ,["YoungLizard"] = 750.0000 ,["Jax"] = 400.0000 ,["LesserWraith"] = math.huge ,["Blitzcrank"] = math.huge ,["ARAMChaosTurretInhib"] = 1200.0000 ,["Shen"] = 400.0000 ,["Nocturne"] = math.huge ,["Sona"] = 1500.0000 ,["ARAMChaosTurretNexus"] = 1200.0000 ,["YellowTrinket"] = 1200.0000 ,["OrderTurretTutorial"] = 1200.0000 ,["Caitlyn"] = 2500.0000 ,["Trundle"] = 347.79999 ,["Malphite"] = 1000.0000 ,["Mordekaiser"] = math.huge ,["ZyraSeed"] = math.huge ,["Vi"] = 1000.0000 ,["Tutorial_Red_Minion_Wizard"] = 650.0000 ,["Renekton"] = math.huge ,["Anivia"] = 1400.0000 ,["Fizz"] = math.huge ,["Heimerdinger"] = 1500.0000 ,["Evelynn"] = 467.0000 ,["Rumble"] = 347.79999 ,["Leblanc"] = 1700.0000 ,["Darius"] = math.huge ,["OlafAxe"] = math.huge ,["Viktor"] = 2300.0000 ,["XinZhao"] = 20.0000 ,["Orianna"] = 1450.0000 ,["Vladimir"] = 1400.0000 ,["Nidalee"] = 1750.0000 ,["Tutorial_Red_Minion_Basic"] = math.huge ,["ZedShadow"] = 467.0000 ,["Syndra"] = 1800.0000 ,["Zac"] = 1000.0000 ,["Olaf"] = 347.79999 ,["Veigar"] = 1100.0000 ,["Twitch"] = 2500.0000 ,["Alistar"] = math.huge ,["Akali"] = 467.0000 ,["Urgot"] = 1300.0000 ,["Leona"] = 347.79999 ,["Talon"] = math.huge ,["Karma"] = 1500.0000 ,["Jayce"] = 347.79999 ,["Galio"] = 1000.0000 ,["Shaco"] = math.huge ,["Taric"] = math.huge ,["TwistedFate"] = 1500.0000 ,["Varus"] = 2000.0000 ,["Garen"] = 347.79999 ,["Swain"] = 1600.0000 ,["Vayne"] = 2000.0000 ,["Fiora"] = 467.0000 ,["Quinn"] = 2000.0000 ,["Kayle"] = math.huge ,["Blue_Minion_Basic"] = math.huge ,["Brand"] = 2000.0000 ,["Teemo"] = 1300.0000 ,["Amumu"] = 500.0000 ,["Annie"] = 1200.0000 ,["Odin_Blue_Minion_caster"] = 1200.0000 ,["Elise"] = 1600.0000 ,["Nami"] = 1500.0000 ,["Poppy"] = 500.0000 ,["AniviaEgg"] = 500.0000 ,["Tristana"] = 2250.0000 ,["Graves"] = 3000.0000 ,["Morgana"] = 1600.0000 ,["Gragas"] = math.huge ,["MissFortune"] = 2000.0000 ,["Warwick"] = math.huge ,["Cassiopeia"] = 1200.0000 ,["Tutorial_Blue_Minion_Wizard"] = 650.0000 ,["DrMundo"] = math.huge ,["Volibear"] = 467.0000 ,["Irelia"] = 467.0000 ,["Odin_Red_Minion_Caster"] = 650.0000 ,["Lucian"] = 2800.0000 ,["Yorick"] = math.huge ,["RammusPB"] = math.huge ,["Red_Minion_Basic"] = math.huge ,["Udyr"] = 467.0000 ,["MonkeyKing"] = 20.0000 ,["Tutorial_Blue_Minion_Basic"] = math.huge ,["Kennen"] = 1600.0000 ,["Nunu"] = 500.0000 ,["Ryze"] = 2400.0000 ,["Zed"] = 467.0000 ,["Nautilus"] = 1000.0000 ,["Gangplank"] = 1000.0000 ,["Lux"] = 1600.0000 ,["Sejuani"] = 500.0000 ,["Ezreal"] = 2000.0000 ,["OdinNeutralGuardian"] = 1800.0000 ,["Khazix"] = 500.0000 ,["Sion"] = math.huge ,["Aatrox"] = 347.79999 ,["Hecarim"] = 500.0000 ,["Pantheon"] = 20.0000 ,["Shyvana"] = 467.0000 ,["Zyra"] = 1700.0000 ,["Karthus"] = 1200.0000 ,["Rammus"] = math.huge ,["Zilean"] = 1200.0000 ,["Chogath"] = 500.0000 ,["Malzahar"] = 2000.0000 ,["YorickRavenousGhoul"] = 347.79999 ,["YorickSpectralGhoul"] = 347.79999 ,["JinxMine"] = 347.79999 ,["YorickDecayedGhoul"] = 347.79999 ,["XerathArcaneBarrageLauncher"] = 347.79999 ,["Odin_SOG_Order_Crystal"] = 347.79999 ,["TestCube"] = 347.79999 ,["ShyvanaDragon"] = math.huge ,["FizzBait"] = math.huge ,["Blue_Minion_MechMelee"] = math.huge ,["OdinQuestBuff"] = math.huge ,["TT_Buffplat_L"] = math.huge ,["TT_Buffplat_R"] = math.huge ,["KogMawDead"] = math.huge ,["TempMovableChar"] = math.huge ,["Lizard"] = 500.0000 ,["GolemOdin"] = math.huge ,["OdinOpeningBarrier"] = math.huge ,["TT_ChaosTurret4"] = 500.0000 ,["TT_Flytrap_A"] = 500.0000 ,["TT_NWolf"] = math.huge ,["OdinShieldRelic"] = math.huge ,["LuluSquill"] = math.huge ,["redDragon"] = math.huge ,["MonkeyKingClone"] = math.huge ,["Odin_skeleton"] = math.huge ,["OdinChaosTurretShrine"] = 500.0000 ,["Cassiopeia_Death"] = 500.0000 ,["OdinCenterRelic"] = 500.0000 ,["OdinRedSuperminion"] = math.huge ,["JarvanIVWall"] = math.huge ,["ARAMOrderNexus"] = math.huge ,["Red_Minion_MechCannon"] = 1200.0000 ,["OdinBlueSuperminion"] = math.huge ,["SyndraOrbs"] = math.huge ,["LuluKitty"] = math.huge ,["SwainNoBird"] = math.huge ,["LuluLadybug"] = math.huge ,["CaitlynTrap"] = math.huge ,["TT_Shroom_A"] = math.huge ,["ARAMChaosTurretShrine"] = 500.0000 ,["Odin_Windmill_Propellers"] = 500.0000 ,["TT_NWolf2"] = math.huge ,["OdinMinionGraveyardPortal"] = math.huge ,["SwainBeam"] = math.huge ,["Summoner_Rider_Order"] = math.huge ,["TT_Relic"] = math.huge ,["odin_lifts_crystal"] = math.huge ,["OdinOrderTurretShrine"] = 500.0000 ,["SpellBook1"] = 500.0000 ,["Blue_Minion_MechCannon"] = 1200.0000 ,["TT_ChaosInhibitor_D"] = 1200.0000 ,["Odin_SoG_Chaos"] = 1200.0000 ,["TrundleWall"] = 1200.0000 ,["HA_AP_HealthRelic"] = 1200.0000 ,["OrderTurretShrine"] = 500.0000 ,["OriannaBall"] = 500.0000 ,["ChaosTurretShrine"] = 500.0000 ,["LuluCupcake"] = 500.0000 ,["HA_AP_ChaosTurretShrine"] = 500.0000 ,["TT_NWraith2"] = 750.0000 ,["TT_Tree_A"] = 750.0000 ,["SummonerBeacon"] = 750.0000 ,["Odin_Drill"] = 750.0000 ,["TT_NGolem"] = math.huge ,["AramSpeedShrine"] = math.huge ,["OriannaNoBall"] = math.huge ,["Odin_Minecart"] = math.huge ,["Summoner_Rider_Chaos"] = math.huge ,["OdinSpeedShrine"] = math.huge ,["TT_SpeedShrine"] = math.huge ,["odin_lifts_buckets"] = math.huge ,["OdinRockSaw"] = math.huge ,["OdinMinionSpawnPortal"] = math.huge ,["SyndraSphere"] = math.huge ,["Red_Minion_MechMelee"] = math.huge ,["SwainRaven"] = math.huge ,["crystal_platform"] = math.huge ,["MaokaiSproutling"] = math.huge ,["Urf"] = math.huge ,["TestCubeRender10Vision"] = math.huge ,["MalzaharVoidling"] = 500.0000 ,["GhostWard"] = 500.0000 ,["MonkeyKingFlying"] = 500.0000 ,["LuluPig"] = 500.0000 ,["AniviaIceBlock"] = 500.0000 ,["TT_OrderInhibitor_D"] = 500.0000 ,["Odin_SoG_Order"] = 500.0000 ,["RammusDBC"] = 500.0000 ,["FizzShark"] = 500.0000 ,["LuluDragon"] = 500.0000 ,["OdinTestCubeRender"] = 500.0000 ,["TT_Tree1"] = 500.0000 ,["ARAMOrderTurretShrine"] = 500.0000 ,["Odin_Windmill_Gears"] = 500.0000 ,["ARAMChaosNexus"] = 500.0000 ,["TT_NWraith"] = 750.0000 ,["TT_OrderTurret4"] = 500.0000 ,["Odin_SOG_Chaos_Crystal"] = 500.0000 ,["OdinQuestIndicator"] = 500.0000 ,["JarvanIVStandard"] = 500.0000 ,["TT_DummyPusher"] = 500.0000 ,["OdinClaw"] = 500.0000 ,["EliseSpiderling"] = 2000.0000 ,["QuinnValor"] = math.huge ,["UdyrTigerUlt"] = math.huge ,["UdyrTurtleUlt"] = math.huge ,["UdyrUlt"] = math.huge ,["UdyrPhoenixUlt"] = math.huge ,["ShacoBox"] = 1500.0000 ,["HA_AP_Poro"] = 1500.0000 ,["AnnieTibbers"] = math.huge ,["UdyrPhoenix"] = math.huge ,["UdyrTurtle"] = math.huge ,["UdyrTiger"] = math.huge ,["HA_AP_OrderShrineTurret"] = 500.0000 ,["HA_AP_Chains_Long"] = 500.0000 ,["HA_AP_BridgeLaneStatue"] = 500.0000 ,["HA_AP_ChaosTurretRubble"] = 500.0000 ,["HA_AP_PoroSpawner"] = 500.0000 ,["HA_AP_Cutaway"] = 500.0000 ,["HA_AP_Chains"] = 500.0000 ,["ChaosInhibitor_D"] = 500.0000 ,["ZacRebirthBloblet"] = 500.0000 ,["OrderInhibitor_D"] = 500.0000 ,["Nidalee_Spear"] = 500.0000 ,["Nidalee_Cougar"] = 500.0000 ,["TT_Buffplat_Chain"] = 500.0000 ,["WriggleLantern"] = 500.0000 ,["TwistedLizardElder"] = 500.0000 ,["RabidWolf"] = math.huge ,["HeimerTGreen"] = 1599.3999 ,["HeimerTRed"] = 1599.3999 ,["ViktorFF"] = 1599.3999 ,["TwistedGolem"] = math.huge ,["TwistedSmallWolf"] = math.huge ,["TwistedGiantWolf"] = math.huge ,["TwistedTinyWraith"] = 750.0000 ,["TwistedBlueWraith"] = 750.0000 ,["TwistedYoungLizard"] = 750.0000 ,["Red_Minion_Melee"] = math.huge ,["Blue_Minion_Melee"] = math.huge ,["Blue_Minion_Healer"] = 1000.0000 ,["Ghast"] = 750.0000 ,["blueDragon"] = 800.0000 ,["Red_Minion_MechRange"] = 3000, 
            ["SRU_OrderMinionRanged"] = 650, ["SRU_ChaosMinionRanged"] = 650, ["SRU_OrderMinionSiege"] = 1200, ["SRU_ChaosMinionSiege"] = 1200, 
            ["SRUAP_Turret_Chaos1"]  = 1200, ["SRUAP_Turret_Chaos2"]  = 1200, ["SRUAP_Turret_Chaos3"] = 1200, ["SRUAP_Turret_Chaos3_Test"] = 1200, ["SRUAP_Turret_Chaos4"] = 1200, ["SRUAP_Turret_Chaos5"] = 500, 
            ["SRUAP_Turret_Order1"]  = 1200, ["SRUAP_Turret_Order2"]  = 1200, ["SRUAP_Turret_Order3"] = 1200, ["SRUAP_Turret_Order3_Test"] = math.huge, ["SRUAP_Turret_Order4"] = math.huge, ["SRUAP_Turret_Order5"] = 500,
            ["Kalista"] = 2600,
            ["BW_Ocklepod"] = 750, ["BW_Plundercrab"] = 1000,
            ["BW_AP_ChaosTurret"] = 1200, ["BW_AP_ChaosTurret2"] = 1200, ["BW_AP_ChaosTurret3"] = 1200,
            ["BW_AP_OrderTurret"] = 1200, ["BW_AP_OrderTurret2"] = 1200, ["BW_AP_OrderTurret3"] = 1200, 
        }
        self.ProjectileSpeed = self.VP:GetProjectileSpeed(myHero)
    end
    --[[if VIP_USER and FileExist(LIB_PATH.."Prodiction.lua") then 
        require "Prodiction" 
        table.insert(self.PredictionList, "Prodiction")
        self.Actives["Prodiction"] = true
    end ]]
    if FileExist(LIB_PATH.."HPrediction.lua") then
        table.insert(self.PredictionList, "HPrediction") 
    end
    if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
        table.insert(self.PredictionList, "DivinePred") 
        self.BindedSpells = {}
    end
    if FileExist(LIB_PATH.."SPrediction.lua") and FileExist(LIB_PATH.."Collision.lua") then
        table.insert(self.PredictionList, "SPrediction") 
    end
    self.LastRequest = 0
    local ImmobileBuffs = {
        [5] = true,
        [11] = true,
        [29] = true,
        [24] = true,
    }
    AddApplyBuffCallback(
        function(source, unit, buff)
            if unit and buff and buff.type then
                if ImmobileBuffs[buff.type] ~= nil then
                    for i = 1, unit.buffCount do
                        local buf = unit:getBuff(i)
                        if buf and buf.name ~= nil and buf.endT ~= nil and buf.startT ~= nil and type(buf.name) == "string" and type(buf.endT) == "number" and type(buf.startT) == "number" and buf.name == buff.name then
                            self.UnitsImmobile[unit.networkID] = {Time = os.clock() - Latency(), Duration = buf.endT - buf.startT}
                        end
                    end
                end
            end
        end
    )
    AddRemoveBuffCallback(
        function(unit, buff)
            if unit and buff and buff.type then
                if ImmobileBuffs[buff.type] ~= nil then
                    self.UnitsImmobile[unit.networkID] = nil
                end
            end
        end
    )
end

function _Prediction:LoadPrediction(TypeOfPrediction)
    if TypeOfPrediction == "VPrediction" then
    elseif TypeOfPrediction == "Prodiction" then
    elseif TypeOfPrediction == "DivinePred" then
        if self.DP == nil then
            require "DivinePred"
            self.Actives["DivinePred"] = true
            self.DP = DivinePred()
            _G.DP = self.DP
            DelayAction(function()
                PrintMessage("DivinePred is causing a lot of fps drops, take care!")
            end, 0.8)
        end
    elseif TypeOfPrediction == "HPrediction" then
        if self.HP == nil then
            require "HPrediction"
            self.Actives["HPrediction"] = true
            self.HP = HPrediction()
            _G.HP = self.HP
        end
    elseif TypeOfPrediction == "SPrediction" then
        if self.SP == nil then
            require "SPrediction"
            self.Actives["SPrediction"] = true
            self.SP = SPrediction()
            _G.SP = self.SP
        end
    end
end

function _Prediction:BindSpell(sp)
    if self.DP ~= nil and sp ~= nil then
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local name = sp.Name ~= nil and sp.Name or "Q"
        local col = collision and 0 or math.huge
        if self.BindedSpells[name] == nil then
            local spell = nil
            if skillshotType == SPELL_TYPE.LINEAR then
                spell = LineSS(speed, range, width, delay * 1000, col)
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                spell = CircleSS(speed, range, width, delay * 1000, col)
            elseif skillshotType == SPELL_TYPE.CONE then
                spell = ConeSS(speed, range, width, delay * 1000, col)
            end
            self.BindedSpells[name] = self.DP:bindSS(name, spell, 50)
        end
    end
end


function _Prediction:ValidRequest(TypeOfPrediction)
    if os.clock() - self.LastRequest < self:TimeRequest(TypeOfPrediction) then
        return false
    else
        self.LastRequest = os.clock()
        return true
    end
end

function _Prediction:AccuracyToHitChance(TypeOfPrediction, Accuracy)
    if TypeOfPrediction == "VPrediction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    elseif TypeOfPrediction == "Prodiction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    elseif TypeOfPrediction == "DivinePred" then
        if Accuracy >= 90 then
            return math.max((Accuracy / 2)/100 + 1 - 0, 1)
        elseif Accuracy >= 80 then
            return math.max((Accuracy / 2)/100 + 1 - 0.05, 1)
        elseif Accuracy >= 50 then
            return math.max((Accuracy / 2)/100 + 1 - 0.1, 1)
        elseif Accuracy >= 20 then
            return math.max((Accuracy / 2)/100 + 1 - 0.05, 1)
        else
            return math.max((Accuracy / 2)/100 + 1 - 0, 1)
        end
    elseif TypeOfPrediction == "HPrediction" then
        return (Accuracy/100) * 3
    elseif TypeOfPrediction == "SPrediction" then
        if Accuracy >= 90 then
            return 3
        elseif Accuracy >= 60 then
            return 2
        elseif Accuracy >= 30 then
            return 1
        else
            return 0
        end
    end
end

function _Prediction:TimeRequest(TypeOfPrediction)
    if TypeOfPrediction == "VPrediction" then
        return 0
    elseif TypeOfPrediction == "Prodiction" then
        return 0
    elseif TypeOfPrediction == "DivinePred" then
        return 0.15
    elseif TypeOfPrediction == "HPrediction" then
        return 0
    elseif TypeOfPrediction == "SPrediction" then
        return 0
    end
end

function _Prediction:IsImmobile(target, sp)
    if IsValidTarget(target) and self.UnitsImmobile[target.networkID] ~= nil then
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local ExtraDelay = speed == math.huge and 0 or (GetDistance(source, target) / speed)
        range = range + (skillshotType == SPELL_TYPE.CIRCULAR and width or 0)
        local ExtraDelay2 = skillshotType == SPELL_TYPE.CIRCULAR and 0 or (width / target.ms)
        if not collision and self.UnitsImmobile[target.networkID].Duration - (os.clock() + Latency() - self.UnitsImmobile[target.networkID].Time) + ExtraDelay2 >= delay + ExtraDelay and GetDistanceSqr(source, target) <= math.pow(range , 2) then
            return true
        end
    end
    return false
end

function _Prediction:GetPrediction(target, sp)
    assert(sp and type(sp) == "table", "Prediction:GetPrediction() Table is invalid!")
    local TypeOfPrediction = sp.TypeOfPrediction ~= nil and sp.TypeOfPrediction or "VPrediction"
    local CastPosition, WillHit, NumberOfHits, Position = nil, -1, 1, nil
    if target ~= nil and IsValidTarget(target, math.huge, target.team ~= myHero.team) and self:ValidRequest(TypeOfPrediction) then
        CastPosition = Vector(target)
        Position = Vector(target)
        local delay = sp.Delay ~= nil and sp.Delay or 0
        local width = sp.Width ~= nil and sp.Width or 1
        local range = sp.Range ~= nil and sp.Range or math.huge
        local speed = sp.Speed ~= nil and sp.Speed or math.huge
        local skillshotType = sp.Type ~= nil and sp.Type or SPELL_TYPE.CIRCULAR
        local collision = sp.Collision ~= nil and sp.Collision or false
        local aoe = sp.Aoe ~= nil and sp.Aoe or false
        local accuracy = sp.Accuracy ~= nil and sp.Accuracy or 60
        local source = sp.Source ~= nil and sp.Source or myHero
        local name = sp.Name ~= nil and sp.Name or "Q"
        TypeOfPrediction = (not target.type:lower():find("hero")) and "VPrediction" or TypeOfPrediction
        TypeOfPrediction = self.Actives[TypeOfPrediction] == true and TypeOfPrediction or "VPrediction"
        -- VPrediction
        if TypeOfPrediction == "Prodiction" and self.Actives[TypeOfPrediction] then
            local aoe = false
            if aoe then
                if skillshotType == SPELL_TYPE.LINEAR then
                    local CastPosition1, info, objects = Prodiction.GetLineAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                elseif skillshotType == SPELL_TYPE.CIRCULAR then
                    local CastPosition1, info, objects = Prodiction.GetCircularAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                 elseif skillshotType == SPELL_TYPE.CONE then
                    local CastPosition1, info, objects = Prodiction.GetConeAOEPrediction(target, range, speed, delay, width, source)
                    local WillHit = collision and info.mCollision() and -1 or info.hitchance
                    NumberOfHits = #objects
                    CastPosition = CastPosition1
                    Position = CastPosition1
                end
            else
                local CastPosition1, info = Prodiction.GetPrediction(target, range, speed, delay, width, source)
                local WillHit = collision and info.mCollision() and -1 or info.hitchance
                CastPosition = CastPosition1
                Position = CastPosition1
            end
        elseif TypeOfPrediction == "DivinePred" and self.Actives[TypeOfPrediction] then
            local col = collision and 0 or math.huge
            if self.BindedSpells[name] == nil then
                self:BindSpell(sp)
            else
                self.BindedSpells[name].range = range
                self.BindedSpells[name].speed = speed
                self.BindedSpells[name].radius = width
                self.BindedSpells[name].delay = delay * 1000
                self.BindedSpells[name].allowedCollisionCount = col
                if skillshotType == SPELL_TYPE.LINEAR then
                    self.BindedSpells[name].type = "LineSS"
                elseif skillshotType == SPELL_TYPE.CIRCULAR then
                    self.BindedSpells[name].type = "CircleSS"
                elseif skillshotType == SPELL_TYPE.CONE then
                    self.BindedSpells[name].type = "ConeSS"
                end
            end
            local state, pos, perc = self.DP:predict(name, target, Vector(source))
            if state and pos and perc then
                --local hitchance = self:AccuracyToHitChance(TypeOfPrediction, accuracy)
                --local state, pos, perc = self.DP:predict(DPTarget(target), spell, hitchance, source)
                WillHit = ((state == SkillShot.STATUS.SUCCESS_HIT and perc >= 50) or self:IsImmobile(target, sp)) 
                CastPosition = pos
                Position = pos
            end
        elseif TypeOfPrediction == "HPrediction" and self.Actives[TypeOfPrediction] then
            local tipo = "PromptCircle"
            local tab = {}
            range = GetDistance(source, myHero) + range
            local time = delay + range/speed
            if sp.IsVeryLowAccuracy ~= nil then
                tab.IsVeryLowAccuracy = sp.IsVeryLowAccuracy
            end
            if time > 1 and width <= 120 then
                tab.IsVeryLowAccuracy = true
            elseif time > 0.8 and width <= 100 then
                tab.IsVeryLowAccuracy = true
            elseif time > 0.6 and width <= 60 then
                tab.IsVeryLowAccuracy = true
            elseif width <= 40 then
                tab.IsVeryLowAccuracy = true
            end
            if skillshotType == SPELL_TYPE.LINEAR then
                width = 2 * width
                if speed ~= math.huge then 
                    tipo = "DelayLine"
                    tab.speed = speed
                else
                    tipo = "PromptLine"
                end
                if collision then
                    tab.collisionM = collision
                    tab.collisionH = collision
                end
                tab.width = width
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                tab.radius = width
                if speed ~= math.huge then 
                    tipo = "DelayCircle"
                    tab.speed = speed
                else
                    tipo = "PromptCircle"
                end
            elseif skillshotType == SPELL_TYPE.CONE then
                tab.angle = width
                tipo = "CircularArc"
                tab.speed = speed
                aoe = false
            end
            tab.range = range
            tab.delay = delay
            tab.type = tipo
            if aoe then
                CastPosition, WillHit, NumberOfHits = self.HP:GetPredict(HPSkillshot(tab), target, source, aoe)
                Position = CastPosition
            else
                CastPosition, WillHit = self.HP:GetPredict(HPSkillshot(tab), target, source)
                Position = CastPosition
            end
        elseif TypeOfPrediction == "SPrediction" and self.Actives[TypeOfPrediction] then
            CastPosition, WillHit, Position = self.SP:Predict(target, range, speed, delay, width, collision, source)
        elseif TypeOfPrediction == "VPrediction" and self.Actives[TypeOfPrediction] then
            if skillshotType == SPELL_TYPE.LINEAR then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetLineAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetLineCastPosition(target, delay, width, range, speed, source, collision)
                end
            elseif skillshotType == SPELL_TYPE.CIRCULAR then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetCircularAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetCircularCastPosition(target, delay, width, range, speed, source, collision)
                end
             elseif skillshotType == SPELL_TYPE.CONE then
                if aoe then
                    CastPosition, WillHit, NumberOfHits, Position = self.VP:GetConeAOECastPosition(target, delay, width, range, speed, source)
                else
                    CastPosition, WillHit, Position = self.VP:GetLineCastPosition(target, delay, width, range, speed, source, collision)
                end
            end
        end
        if WillHit then
            if type(WillHit) == "number" then
                WillHit = ((WillHit >= self:AccuracyToHitChance(TypeOfPrediction, accuracy)) or self:IsImmobile(target, sp))
            end
        else
            WillHit = false
        end
        if aoe then
            return CastPosition, WillHit, NumberOfHits, Position
        else
            return CastPosition, WillHit, Position
        end
    end
    return nil, false, nil
end

function _Prediction:GetPredictedPos(target, tab)
    if IsValidTarget(target, math.huge, target.team ~= myHero.team) then
        local delay = tab.Delay ~= nil and tab.Delay or 0
        local speed = tab.Speed or nil
        local from = tab.Source or nil
        local collision = tab.Collision or nil
        local TypeOfPrediction = tab.TypeOfPrediction ~= nil and tab.TypeOfPrediction or "VPrediction"
        local accuracy = tab.Accuracy ~= nil and tab.Accuracy or 60
        local CastPosition, HitChance, Position = self.VP:GetPredictedPos(target, delay, speed, from, collision)
        local WillHit = false
        if HitChance >= 0 then
            WillHit = true
        else
            WillHit = false
        end
        return CastPosition, WillHit, Position
    end
    return Vector(target), false, Vector(target)
end


--CLASS: _OrbwalkManager
function _OrbwalkManager:__init()
    self.OrbLoaded = ""
    self.OrbwalkList = {}
    self.KeyMan = _KeyManager()
    DelayAction(function()
        if _G.Reborn_Loaded or _G.Reborn_Initialised or _G.AutoCarry ~= nil then
            table.insert(self.OrbwalkList, "AutoCarry")
        end
        if _G.MMA_IsLoaded then
            table.insert(self.OrbwalkList, "MMA")
        end
        if FileExist(LIB_PATH .. "SxOrbWalk.lua") then
            table.insert(self.OrbwalkList, "SxOrbWalk")
        end
        if FileExist(LIB_PATH.."Nebelwolfi's Orb Walker.lua") then
            table.insert(self.OrbwalkList, "NOW")
        end
        if FileExist(LIB_PATH .. "Big Fat Orbwalker.lua") then
            table.insert(self.OrbwalkList, "Big Fat Walk")
        end
        if FileExist(LIB_PATH .. "SOW.lua") then
            table.insert(self.OrbwalkList, "SOW")
        end
        if _G.OrbwalkManagerMenu == nil then
            _G.OrbwalkManagerMenu = scriptConfig("SimpleLib - Orbwalk Manager", "OrbwalkManager".."24052015"..myHero.charName)
        end
        if #self.OrbwalkList > 0 then
            _G.OrbwalkManagerMenu:addParam("OrbwalkerSelected", "Orbwalker Selection", SCRIPT_PARAM_LIST, 1, self.OrbwalkList)
            local default = _G.OrbwalkManagerMenu.OrbwalkerSelected
            if #self.OrbwalkList > 1 then
                --_G.OrbwalkManagerMenu:addParam("info", "Requires 2x F9 when changing selection", SCRIPT_PARAM_INFO, "")
                _G.OrbwalkManagerMenu:setCallback("OrbwalkerSelected",
                    function(v)
                        if v and v ~= default then
                            if not self.Draw then
                                self.Draw = true
                                AddDrawCallback(
                                    function()
                                        local p = WorldToScreen(D3DXVECTOR3(myHero.x, myHero.y, myHero.z))
                                        if OnScreen(p.x, p.y) and _G.OrbwalkManagerMenu.OrbwalkerSelected ~= default then
                                            DrawText("Press 2x F9!", 25, p.x, p.y, ARGB(255, 255, 255, 255))
                                        end
                                    end
                                )
                            end
                        end
                    end
                    )
            end
        end
        DelayAction(function() self:OrbLoad() end, 1)
    end, 1)
    self.NoAttacks = { 
        jarvanivcataclysmattack = true, 
        monkeykingdoubleattack = true, 
        shyvanadoubleattack = true, 
        shyvanadoubleattackdragon = true, 
        zyragraspingplantattack = true, 
        zyragraspingplantattack2 = true, 
        zyragraspingplantattackfire = true, 
        zyragraspingplantattack2fire = true, 
        viktorpowertransfer = true, 
        sivirwattackbounce = true,
    }
    self.Attacks = {
        caitlynheadshotmissile = true, 
        frostarrow = true, 
        garenslash2 = true, 
        kennenmegaproc = true, 
        lucianpassiveattack = true, 
        masteryidoublestrike = true, 
        quinnwenhanced = true, 
        renektonexecute = true, 
        renektonsuperexecute = true, 
        rengarnewpassivebuffdash = true, 
        trundleq = true, 
        xenzhaothrust = true, 
        xenzhaothrust2 = true, 
        xenzhaothrust3 = true, 
        viktorqbuff = true,
    }
    self.Resets = {
        dariusnoxiantacticsonh = true,
        garenq = true,
        hecarimrapidslash = true, 
        jaxempowertwo = true, 
        jaycehypercharge = true,
        leonashieldofdaybreak = true, 
        luciane = true, 
        lucianq = true,
        monkeykingdoubleattack = true, 
        mordekaisermaceofspades = true, 
        nasusq = true, 
        nautiluspiercinggaze = true, 
        netherblade = true,
        parley = true, 
        poppydevastatingblow = true, 
        powerfist = true, 
        renektonpreexecute = true, 
        shyvanadoubleattack = true,
        sivirw = true, 
        takedown = true, 
        talonnoxiandiplomacy = true, 
        trundletrollsmash = true, 
        vaynetumble = true, 
        vie = true, 
        volibearq = true,
        xenzhaocombotarget = true, 
        yorickspectral = true,
        reksaiq = true,
        riventricleave = true,
        itemtiamatcleave = true,
        fioraflurry = true, 
        rengarq = true,
    }
    self.Attack = true
    self.Move = true
    self.KeysMenu = nil
    self.GotReset = false
    self.DataUpdated = false
    self.BaseWindUpTime = 3
    self.BaseAnimationTime = 0.665
    self.Mode = ORBWALK_MODE.NONE
    self.AfterAttackCallbacks = {}
    self.LastAnimationName = ""
    self.AA = {LastTime = 0, LastTarget = nil, IsAttacking = false, Object = nil}
    self.LastKeyAdded = os.clock()
    
    self.EnemyMinions = minionManager(MINION_ENEMY, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_HEALTH_ASC)
    self.JungleMinions = minionManager(MINION_JUNGLE, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_MAXHEALTH_DEC)

    AddCreateObjCallback(
        function(obj)
            if self.AA.Object == nil and obj.name:lower() == "missile" and self:GetTime() - self.AA.LastTime + self:Latency() < 1.2 * self:WindUpTime() and obj.spellOwner and obj.spellName and obj.spellOwner.isMe and self:IsAutoAttack(obj.spellName) then
                self:ResetMove()
                self.AA.Object = obj
            end
        end
    )

    AddDeleteObjCallback(
        function(obj)
            if obj and obj.name and self.AA.Object ~= nil and obj.name == self.AA.Object.name and obj.networkID == self.AA.Object.networkID then
                self.AA.Object = nil
            end
        end
    )
    AddAnimationCallback(
        function(unit, animation)
            if unit.isMe then
                if self:IsAttacking() then
                    if not animation:lower():find("attack") then
                        self:ResetMove()
                    end
                end
                self.LastAnimationName = animation
            end
        end
    )
    if AddProcessSpellCallback then
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
    end
    if AddProcessAttackCallback then
        AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
    end
    AddTickCallback(
        function()
            self.Mode = self.KeyMan:ModePressed()
            if not self:IsAttacking() then
                if self.AA.IsAttacking then
                    self:TriggerAfterAttackCallback(spell)
                    self.AA.IsAttacking = false
                    if self.GotReset then self.GotReset = false end
                end
            end
            if self.OrbLoaded == self:GetOrbwalkSelected() then
                if self.RegisterCommon and not self.RegisteredCommon then
                    self.RegisteredCommon = true
                    self.AddedCommon = true
                    self:AddKey({ Name = "Combo", Text = "Combo", Type = SCRIPT_PARAM_ONKEYDOWN, Key = 32, Mode = ORBWALK_MODE.COMBO})
                    self:AddKey({ Name = "Harass", Text = "Harass", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("C"), Mode = ORBWALK_MODE.HARASS})
                    self:AddKey({ Name = "Clear", Text = "LaneClear or JungleClear", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("V"), Mode = ORBWALK_MODE.CLEAR })
                    self:AddKey({ Name = "LastHit", Text = "LastHit", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("X"), Mode = ORBWALK_MODE.LASTHIT})
                end
                if self.Register and os.clock() - self.LastKeyAdded > 0.15 then
                    self.Register = false
                    self.KeyMan:RegisterKeys()
                end
            end
        end
    )
end

function _OrbwalkManager:GetOrbwalkSelected()
    local int = _G.OrbwalkManagerMenu ~= nil and _G.OrbwalkManagerMenu.OrbwalkerSelected or 1
    return #self.OrbwalkList > 0 and tostring(self.OrbwalkList[int]) or nil
end

function _OrbwalkManager:IsAutoAttack(name)
    return name and ((name:lower():find("attack") and not self.NoAttacks[name:lower()]) or self.Attacks[name:lower()])
end

function _OrbwalkManager:IsReset(name)
    return name and self.Resets[name:lower()]
end

function _OrbwalkManager:LoadCommonKeys(m)
    local menu = nil
    if m == nil then
        if _G.OrbwalkManagerMenu ~= nil then
            _G.OrbwalkManagerMenu:addSubMenu(myHero.charName.." - Key Settings", "Keys")
            menu = _G.OrbwalkManagerMenu.Keys
        end
    else
        menu = m
    end
    self.KeysMenu = menu
    if self.KeysMenu ~= nil then
        self.KeysMenu:addParam("Common", "Use main keys from your Orbwalker", SCRIPT_PARAM_ONOFF, true)
        self.RegisterCommon = self.KeysMenu.Common == false
         self.KeysMenu:setCallback("Common",
            function(v)
                if v == false and not self.AddedCommon then
                    self.AddedCommon = true
                    self:AddKey({ Name = "Combo", Text = "Combo (Space)", Type = SCRIPT_PARAM_ONKEYDOWN, Key = 32, Mode = ORBWALK_MODE.COMBO})
                    self:AddKey({ Name = "Harass", Text = "Harass", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("C"), Mode = ORBWALK_MODE.HARASS})
                    self:AddKey({ Name = "Clear", Text = "LaneClear or JungleClear", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("V"), Mode = ORBWALK_MODE.CLEAR })
                    self:AddKey({ Name = "LastHit", Text = "LastHit", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("X"), Mode = ORBWALK_MODE.LASTHIT})
                    --[[
                    if not self.Registered2 then
                        AddTickCallback(
                            function()
                                if self.OrbLoaded == self:GetOrbwalkSelected() then
                                    if not self.Registered2 then
                                        self.Registered2 = true
                                        self.KeyMan:RegisterKeys()
                                    end
                                end
                            end
                        )
                    end
                    ]]
                elseif v == true and self.AddedCommon then
                    self.KeysMenu:removeParam("Combo")
                    self.KeysMenu:removeParam("Combo".."TypeList")
                    self.KeysMenu:removeParam("Harass")
                    self.KeysMenu:removeParam("Harass".."TypeList")
                    self.KeysMenu:removeParam("Clear")
                    self.KeysMenu:removeParam("Clear".."TypeList")
                    self.KeysMenu:removeParam("LastHit")
                    self.KeysMenu:removeParam("LastHit".."TypeList")
                    self.AddedCommon = false
                end
            end
        )
    end
end

function _OrbwalkManager:OnProcessSpell(unit, spell)
    if unit and unit.isMe and spell and spell.name then
        if self:IsAutoAttack(spell.name) then
            if not self.DataUpdated then
                self.BaseAnimationTime = 1 / (spell.animationTime * myHero.attackSpeed)
                self.BaseWindUpTime = 1 / (spell.windUpTime * myHero.attackSpeed)
                self.DataUpdated = true
            end
            self.AA.LastTarget = spell.target
            self.AA.IsAttacking = true
            self.AA.LastTime = self:GetTime() - self:Latency()
        elseif self:IsReset(spell.name) then
            self.GotReset = true
            DelayAction(
                function()
                    self:ResetAA()
                end
                ,2 * Latency())
        end
    end
end

function _OrbwalkManager:GetTime()
    return 1 * os.clock()
end

function _OrbwalkManager:Latency()
    return GetLatency() / 2000
end

function _OrbwalkManager:ExtraWindUp()
    return _G.OrbwalkManagerMenu ~= nil and _G.OrbwalkManagerMenu.ExtraWindUp ~= nil and _G.OrbwalkManagerMenu.ExtraWindUp/1000 or 0
end

function _OrbwalkManager:WindUpTime()
    return (1 / (myHero.attackSpeed * self.BaseWindUpTime)) + self:ExtraWindUp()
end

function _OrbwalkManager:AnimationTime()
    return (1 / (myHero.attackSpeed * self.BaseAnimationTime))
end

function _OrbwalkManager:CanAttack(ExtraTime)
    local int = ExtraTime ~= nil and ExtraTime or 0
    return self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:AnimationTime() - 25/1000 + int and not IsEvading()
end

function _OrbwalkManager:CanMove(ExtraTime)
    local int = ExtraTime ~= nil and ExtraTime or 0
    return self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:WindUpTime() + int and not IsEvading()
end

function _OrbwalkManager:IsAttacking()
    return (not self:CanMove()) or (self.AA.Object ~= nil and self.AA.Object.valid)
end

function _OrbwalkManager:CanCast()
    return not self:IsAttacking()
end

function _OrbwalkManager:Evade()
    return _G.evade or _G.Evade
end

function _OrbwalkManager:MyRange(target)
    local int1 = 0
    if IsValidTarget(target) then int1 = target.boundingRadius end
    return myHero.range + myHero.boundingRadius + int1
end

function _OrbwalkManager:InRange(target, off)
    local offset = off ~= nil and off or 0
    return IsValidTarget(target, self:MyRange(target) + offset)
end

function _OrbwalkManager:IsCombo()
    return self.KeyMan.Combo
end
function _OrbwalkManager:IsHarass()
    return self.KeyMan.Harass
end
function _OrbwalkManager:IsClear()
    return self.KeyMan.Clear
end
function _OrbwalkManager:IsLastHit()
    return self.KeyMan.LastHit
end

function _OrbwalkManager:IsNone()
    return not (self:IsCombo() or self:IsHarass() or self:IsClear() or self:IsLastHit())
end

function _OrbwalkManager:TakeControl()
    _G.OrbwalkManagerMenu:addParam("ExtraWindUp","Extra WindUpTime", SCRIPT_PARAM_SLICE, 15, -40, 160, 1)
    AddTickCallback(function()
        if not self:IsAttacking() then
            self:EnableMovement() 
        else 
            self:DisableMovement() 
        end
        if self:CanAttack() then
            self:EnableAttacks()
        else 
            self:DisableAttacks()
        end
    end)
    if VIP_USER then 
        HookPackets()
        AddSendPacketCallback(
            function(p)
                p.pos = 2
                if _G.OrbwalkManagerMenu ~= nil and myHero.networkID == p:DecodeF() then
                    if self:GetTime() - self.AA.LastTime + self:Latency() < 1 * self:WindUpTime() * 1/2 and not IsEvading() then
                        Packet(p):block()
                    end
                end
            end
        ) 
    end
end

--boring part
function _OrbwalkManager:ShouldWait()
    if self.EnemyMinions ~= nil and _G.VP then
        self.EnemyMinions:update()
        if #self.EnemyMinions.objects > 0 and self:CanAttack() then
            for i, minion in pairs(self.EnemyMinions.objects) do
                if self:InRange(minion) and not minion.dead then
                    local delay = _G.SpellManagerMenu ~= nil and _G.SpellManagerMenu.FarmDelay ~= nil and _G.SpellManagerMenu.FarmDelay or 0
                    local ProjectileSpeed = _G.VP:GetProjectileSpeed(myHero)
                    local time = self:WindUpTime() + GetDistance(myHero.pos, minion.pos) / ProjectileSpeed + ExtraTime()
                    local predHealth = _G.VP:GetPredictedHealth(minion, time, delay)
                    local damage = _G.VP:CalcDamageOfAttack(myHero, minion, {name = "Basic"}, 0)
                    if predHealth > 0 then
                        if damage > predHealth * 0.9 and predHealth < minion.health then
                            return true
                        else
                            --[[
                            time = self:AnimationTime() + GetDistance(myHero.pos, minion.pos) / ProjectileSpeed + ExtraTime()
                            time = time * 2
                            predHealth = _G.VP:GetPredictedHealth2(minion, time)
                            if damage > predHealth and predHealth < minion.health then
                                return true
                            end]]
                        end
                    end
                end
            end
        end
    end
    return false
end

function _OrbwalkManager:ObjectInRange(off)
    local offset = off ~= nil and off or 0
    if self:IsCombo() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
    elseif self:IsHarass() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    elseif self:IsClear() then
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
        self.JungleMinions:update()
        for i, object in ipairs(self.JungleMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    elseif self:IsLastHit() then
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    else
        for i, enemy in ipairs(GetEnemyHeroes()) do
            if self:InRange(enemy, offset) then return enemy end
        end
        self.EnemyMinions:update()
        for i, object in ipairs(self.EnemyMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
        self.JungleMinions:update()
        for i, object in ipairs(self.JungleMinions.objects) do
            if self:InRange(object, offset) then return object end
        end
    end
    return nil
end

function _OrbwalkManager:GetClearMode()
    local bestMinion = nil
    self.EnemyMinions:update()
    self.JungleMinions:update()
    if #self.EnemyMinions.objects > #self.JungleMinions.objects then
        return "laneclear"
    elseif #self.EnemyMinions.objects < #self.JungleMinions.objects then
        return "jungleclear"
    end
    return nil
end

function _OrbwalkManager:RegisterAfterAttackCallback(func)
    table.insert(self.AfterAttackCallbacks, func)
end

function _OrbwalkManager:TriggerAfterAttackCallback(spell)
    for i, func in ipairs(self.AfterAttackCallbacks) do
        func(spell)
    end
end

function _OrbwalkManager:OrbLoad()
    if self:GetOrbwalkSelected() ~= nil then
        if _G.Reborn_Initialised then
            if self:GetOrbwalkSelected() == "AutoCarry" then
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
                return
            else
                _G.AutoCarry.MyHero:MovementEnabled(false)
                _G.AutoCarry.MyHero:AttacksEnabled(false)
                PrintMessage("Disabling Movement and Attacks from SAC:R because you decided to use "..self:GetOrbwalkSelected()..".")
            end
        end
        if _G.Reborn_Loaded and not _G.Reborn_Initialised then
            DelayAction(function() self:OrbLoad() end, 1)
        end
        if self.Loaded == nil then
            self.Loaded = true
            if self:GetOrbwalkSelected() == "MMA" then
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "SxOrbWalk" then
                if _G.SxOrb == nil then
                    require 'SxOrbWalk'
                    self.OrbLoaded = self:GetOrbwalkSelected()
                    _G.SxOrb:LoadToMenu()
                    self:EnableMovement()
                    self:EnableAttacks()
                end
            elseif self:GetOrbwalkSelected() == "SOW" then
                if _G.SOWi == nil then
                    require 'SOW'
                    self.OrbLoaded = self:GetOrbwalkSelected()
                    if _G.VP then
                        _G.SOWi = SOW(_G.VP)
                    end
                    _G.SOWi:LoadToMenu()
                    if AddProcessAttackCallback then
                        AddProcessAttackCallback(function(unit, spell) _G.SOWi:OnProcessSpell(unit, spell) end)
                    end
                    self:EnableMovement()
                    self:EnableAttacks()
                end
            elseif self:GetOrbwalkSelected() == "Big Fat Walk" then
                require "Big Fat Orbwalker"
                self.OrbLoaded = self:GetOrbwalkSelected()
                self:EnableMovement()
                self:EnableAttacks()
            elseif self:GetOrbwalkSelected() == "NOW" then
                if _G.NOWi == nil then
                    require "Nebelwolfi's Orb Walker"
                    _G.NOWi = NebelwolfisOrbWalker()
                    self.OrbLoaded = self:GetOrbwalkSelected()
                    self:EnableMovement()
                    self:EnableAttacks()
                end
            end
        end
    else
        _Required():Add({Name = "SxOrbWalk", Url = "raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"}):Check()
    end
end

function _OrbwalkManager:AddKey(t)
    assert(t and type(t) == "table", "OrbwalkManager: AddKey Table is invalid!")
    if self.KeysMenu ~= nil then
        local name = t.Name
        assert(name and type(name) == "string", "OrbwalkManager: AddKey Name is invalid!")
        local text = t.Text
        assert(text and type(text) == "string", "OrbwalkManager: AddKey Text is invalid!")
        local tipo = t.Type ~= nil and t.Type or SCRIPT_PARAM_ONKEYDOWN
        local key = t.Key
        assert(key and type(key) == "number", "OrbwalkManager: AddKey Key is invalid!")
        local mode = t.Mode 
        assert(mode and type(mode) == "number", "OrbwalkManager: AddKey Mode is invalid!")

        self.KeysMenu:addDynamicParam(name, text, tipo, false, key)
        self.KeysMenu[name] = false
        self.KeyMan:RegisterKey(self.KeysMenu, name, mode)
        self.Register = true
        self.LastKeyAdded = os.clock()
    end
end

function _OrbwalkManager:ResetMove()
    self.AA.LastTime = self:GetTime() + self:Latency() - self:WindUpTime()
    self.AA.Object = nil
end

function _OrbwalkManager:ResetAA()
    self.AA.LastTime = self:GetTime() + self:Latency() - self:AnimationTime()
    self.GotReset = true
    if self.OrbLoaded == "AutoCarry" then
        _G.AutoCarry.Orbwalker:ResetAttackTimer()
    elseif self.OrbLoaded == "SxOrbWalk" then
        _G.SxOrb:ResetAA()
    elseif self.OrbLoaded == "SOW" then
        _G.SOWi:resetAA()
    elseif self.OrbLoaded == "NOW" then
        _G.NOWi.orbTable.lastAA = os.clock() - GetLatency() / 2000 - _G.NOWi.orbTable.animation
    elseif self.OrbLoaded == "MMA" then
        _G.MMA_ResetAutoAttack()
    end
end

function _OrbwalkManager:DisableMovement()
    if self.Move then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:MovementEnabled(false)
            self.Move = false
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:DisableMove()
            self.Move = false
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Move = false
            self.Move = false
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableMove"] = true
            self.Move = false
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_AvoidMovement(true)
            self.Move = false
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetMove(false)
            self.Move = false
        end
    end
end

function _OrbwalkManager:EnableMovement()
    if not self.Move then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:MovementEnabled(true)
            self.Move = true
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:EnableMove()
            self.Move = true
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Move = true
            self.Move = true
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableMove"] = false
            self.Move = true
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_AvoidMovement(false)
            self.Move = true
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetMove(true)
            self.Move = true
        end
    end
end

function _OrbwalkManager:DisableAttacks()
    if self.Attack then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:AttacksEnabled(false)
            self.Attack = false
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:DisableAttacks()
            self.Attack = false
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Attacks = false
            self.Attack = false
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableAttacks"] = true
            self.Attack = false
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_StopAttacks(true)
            self.Attack = false
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetAA(false)
            self.Attack = false
        end
    end
end

function _OrbwalkManager:EnableAttacks()
    if not self.Attack then
        if self.OrbLoaded == "AutoCarry" then
            _G.AutoCarry.MyHero:AttacksEnabled(true)
            self.Attack = true
        elseif self.OrbLoaded == "SxOrbWalk" then
            _G.SxOrb:EnableAttacks()
            self.Attack = true
        elseif self.OrbLoaded == "SOW" then
            _G.SOWi.Attacks = true
            self.Attack = true
        elseif self.OrbLoaded == "Big Fat Walk" then
            _G["BigFatOrb_DisableAttacks"] = false
            self.Attack = true
        elseif self.OrbLoaded == "MMA" then
            _G.MMA_StopAttacks(false)
            self.Attack = true
        elseif self.OrbLoaded == "NOW" then
            _G.NOWi:SetAA(true)
            self.Attack = true
        end
    end
end

--CLASS INITIATOR
function _Initiator:__init(menu)
    self.Callbacks = {}
    self.ActiveSpells = {}
    assert(menu, "_Initiator: menu is invalid!")
    self.Menu = menu
    if #GetAllyHeroes() > 0 and self.Menu~=nil then
        for idx, ally in ipairs(GetAllyHeroes()) do
            self.Menu:addParam(ally.charName.."Q", ally.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."W", ally.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."E", ally.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(ally.charName.."R", ally.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Initiate", SCRIPT_PARAM_SLICE, 2.5, 0, 8, 0)
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        if AddProcessAttackCallback then
            AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local spell = self.ActiveSpells[i]
                        if os.clock() + Latency() - spell.Time <= self.Menu.Time then
                            self:TriggerCallbacks(spell.Unit)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
end

function _Initiator:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team == myHero.team then
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then 
                    table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit})
                end
            end
        end
    end
end

function _Initiator:CheckChannelingSpells()
    if #GetAllyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CHANELLING_SPELLS[enemy.charName] then
                for i, spell in pairs(CHANELLING_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Initiator:CheckGapcloserSpells()
    if #GetAllyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if GAPCLOSER_SPELLS[enemy.charName] then
                for i, spell in pairs(GAPCLOSER_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Initiator:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end

function _Initiator:TriggerCallbacks(unit)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit)
    end
end

--CLASS EVADER
function _Evader:__init(menu)
    assert(menu, "_Evader: menu is invalid!")
    self.Callbacks = {}
    self.ActiveSpells = {}
    self.Menu = menu
    if #GetEnemyHeroes() > 0 and self.Menu~=nil then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            self.Menu:addParam(enemy.charName.."Q", enemy.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."W", enemy.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."E", enemy.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."R", enemy.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Evade", SCRIPT_PARAM_SLICE, 0.7, 0, 4, 1)
        self.Menu:addParam("Humanizer",  "% of Humanizer", SCRIPT_PARAM_SLICE, 0, 0, 100)
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        if AddProcessAttackCallback then
            AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local sp = self.ActiveSpells[i]
                        if os.clock() + Latency() - sp.Time <= self.Menu.Time then
                            local unit = sp.Unit
                            local spell = sp.Spell
                            local spelltype = sp.SpellType
                            self:CheckHitChampion(unit, spell, spelltype)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
    return self
end

function _Evader:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team ~= myHero.team then
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then
                    DelayAction(
                        function() 
                            table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell, SpellType = spelltype})
                            self:CheckHitChampion(unit, spell, spelltype)
                        end
                    , 
                        math.max(spell.windUpTime * self.Menu.Humanizer/100 - 2 * Latency(), 0)
                    )
                end
            end
        end
    end
end

function _Evader:CheckHitChampion(unit, spell, spelltype, champion)
    if unit and spell and spelltype and unit.valid then
        local hitchampion = false
        local champion = champion ~= nil and champion or myHero
        if skillData[unit.charName] ~= nil and skillData[unit.charName][spelltype] ~= nil then
            local shottype  = skillData[unit.charName][spelltype].type
            local radius    = skillData[unit.charName][spelltype].radius
            local maxdistance = skillData[unit.charName][spelltype].maxdistance
            if shottype == 0 then hitchampion = spell.target and spell.target.networkID == champion.networkID or false
            elseif shottype == 1 then hitchampion = checkhitlinepass(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 2 then hitchampion = checkhitlinepoint(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 3 then hitchampion = checkhitaoe(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 4 then hitchampion = checkhitcone(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 5 then hitchampion = checkhitwall(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 6 then hitchampion = checkhitlinepass(unit, spell.endPos, radius, maxdistance, champion, champion.boundingRadius) or checkhitlinepass(unit, Vector(unit)*2-spell.endPos, radius, maxdistance, champion, champion.boundingRadius)
            elseif shottype == 7 then hitchampion = checkhitcone(spell.endPos, unit, radius, maxdistance, champion, champion.boundingRadius)
            end
        else
            if spell.target ~= nil and spell.target.networkID == champion.networkID then hitchampion = true end
            if spell.endPos ~= nil then
                local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(Vector(unit), Vector(spell.endPos.x, unit.y, spell.endPos.y), champion)
                if isOnSegment and GetDistanceSqr(pointSegment, champion) < math.pow(300, 2)  then
                    hitchampion = true
                end
            end
        end
        if hitchampion then
            self:TriggerCallbacks(unit, spell)
        end
    end
end

function _Evader:CheckCC()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CC_SPELLS[enemy.charName] then
                for i, spell in pairs(CC_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Evader:CheckYasuoWall()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if YASUO_WALL_SPELLS[enemy.charName] then
                for i, spell in pairs(YASUO_WALL_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Evader:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end


function _Evader:TriggerCallbacks(unit, spell)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit, spell)
    end
end

function _Interrupter:__init(menu)
    self.Callbacks = {}
    assert(menu, "_Interrupter: menu is invalid!")
    self.Menu = menu
    self.ActiveSpells = {}
    if #GetEnemyHeroes() > 0 and self.Menu~=nil then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            self.Menu:addParam(enemy.charName.."Q", enemy.charName.." (Q)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."W", enemy.charName.." (W)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."E", enemy.charName.." (E)", SCRIPT_PARAM_ONOFF, false)
            self.Menu:addParam(enemy.charName.."R", enemy.charName.." (R)", SCRIPT_PARAM_ONOFF, false)
        end
        self.Menu:addParam("Time",  "Time Limit to Interrupt", SCRIPT_PARAM_SLICE, 2.5, 0, 8, 1)
        if AddProcessSpellCallback then
            AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        if AddProcessAttackCallback then
            AddProcessAttackCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
        AddTickCallback(
            function()
                if #self.ActiveSpells > 0 then
                    for i = #self.ActiveSpells, 1, -1 do
                        local spell = self.ActiveSpells[i]
                        if os.clock() + Latency() - spell.Time <= self.Menu.Time then
                            self:TriggerCallbacks(spell.Unit, spell.Spell)
                        else
                            table.remove(self.ActiveSpells, i)
                        end
                    end
                end
            end
        )
    end
    return self
end

function _Interrupter:OnProcessSpell(unit, spell)
    if not myHero.dead and unit and spell and spell.name and not unit.isMe and unit.type and unit.team and GetDistanceSqr(myHero, unit) < 2000 * 2000 then
        if unit.type == myHero.type and unit.team ~= myHero.team then
            local spelltype, casttype = getSpellType(unit, spell.name)
            if spelltype == "Q" or spelltype == "W" or spelltype == "E" or spelltype == "R" then
                if self.Menu[unit.charName..spelltype] then 
                    table.insert(self.ActiveSpells, {Time = os.clock() - Latency(), Unit = unit, Spell = spell})
                end
            end
        end
    end
end

function _Interrupter:CheckChannelingSpells()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if CHANELLING_SPELLS[enemy.charName] then
                for i, spell in pairs(CHANELLING_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Interrupter:CheckGapcloserSpells()
    if #GetEnemyHeroes() > 0 then
        for idx, enemy in ipairs(GetEnemyHeroes()) do
            if GAPCLOSER_SPELLS[enemy.charName] then
                for i, spell in pairs(GAPCLOSER_SPELLS[enemy.charName]) do
                    self.Menu[enemy.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Interrupter:AddCallback(cb)
    table.insert(self.Callbacks, cb)
    return self
end

function _Interrupter:TriggerCallbacks(unit, spell)
    for i, callback in ipairs(self.Callbacks) do
        callback(unit, spell)
    end
end


-- CLASS: _ScriptUpdate
function _ScriptUpdate:__init(tab)
    assert(tab and type(tab) == "table", "_ScriptUpdate: table is invalid!")
    self.LocalVersion = tab.LocalVersion
    assert(self.LocalVersion and type(self.LocalVersion) == "number", "_ScriptUpdate: LocalVersion is invalid!")
    local UseHttps = tab.UseHttps ~= nil and tab.UseHttps or true
    local VersionPath = tab.VersionPath
    assert(VersionPath and type(VersionPath) == "string", "_ScriptUpdate: VersionPath is invalid!")
    local ScriptPath = tab.ScriptPath
    assert(ScriptPath and type(ScriptPath) == "string", "_ScriptUpdate: ScriptPath is invalid!")
    local SavePath = tab.SavePath
    assert(SavePath and type(SavePath) == "string", "_ScriptUpdate: SavePath is invalid!")
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = tab.CallbackUpdate
    self.CallbackNoUpdate = tab.CallbackNoUpdate
    self.CallbackNewVersion = tab.CallbackNewVersion
    self.CallbackError = tab.CallbackError
    --AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function _ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function _ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' then
    end
end

function _ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.tcp()
    if not self.Socket then
        print('Socket Error')
    else
        self.Socket:settimeout(0, 'b')
        self.Socket:settimeout(99999999, 't')
        self.Socket:connect('sx-bol.eu', 80)
        self.Url = url
        self.Started = false
        self.LastPrint = ""
        self.File = ""
    end
end

function _ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function _ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            if self.OnlineVersion ~= nil then
                self.OnlineVersion = tonumber(self.OnlineVersion)
                if self.OnlineVersion ~= nil and self.LocalVersion ~= nil and type(self.OnlineVersion) == "number" and type(self.LocalVersion) == "number" and self.OnlineVersion > self.LocalVersion then
                    if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                        self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                    end
                    self:CreateSocket(self.ScriptPath)
                    self.DownloadStatus = 'Connect to Server for ScriptDownload'
                    AddTickCallback(function() self:DownloadUpdate() end)
                else
                    if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                        self.CallbackNoUpdate(self.LocalVersion)
                    end
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function _ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end

--CLASS: _KeyManager
function _KeyManager:__init()
    self.ComboKeys = {}
    self.Combo = false
    self.HarassKeys = {}
    self.Harass = false
    self.LastHitKeys = {}
    self.LastHit = false
    self.ClearKeys = {}
    self.Clear = false
    AddTickCallback(function() self:OnTick() end)
end

function _KeyManager:ModePressed()
    if self.Combo then return ORBWALK_MODE.COMBO
    elseif self.Harass then return ORBWALK_MODE.HARASS
    elseif self.Clear then return ORBWALK_MODE.CLEAR
    elseif self.LastHit then return ORBWALK_MODE.LASTHIT
    else return ORBWALK_MODE.NONE end
end

function _KeyManager:IsKeyPressed(list)
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param and menu[param] then
                        return true
                    end
                end
            end
        end
    end
    return false
end
function _KeyManager:IsComboPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.AutoCarry then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isFight then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode0 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsOrbwalking() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "Combo" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.Combo then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.ComboKeys)
end

function _KeyManager:IsHarassPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.MixedMode then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isHarass then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode1 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsDualCarrying() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "Harass" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.Harass then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.HarassKeys)
end

function _KeyManager:IsClearPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.LaneClear then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isLaneClear then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode2 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsClearing() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "LaneClear" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.LaneClear then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.ClearKeys)
end

function _KeyManager:IsLastHitPressed()
    if OrbwalkManager.KeysMenu and OrbwalkManager.KeysMenu.Common then
        if OrbwalkManager.OrbLoaded == "AutoCarry" then
            if _G.AutoCarry.Keys.LastHit then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
            if _G.SxOrb.isLastHit then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "SOW" then
            if _G.SOWi.Menu.Mode3 then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "MMA" then
            if _G.MMA_IsLasthitting() then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "Big Fat Walk" then
            if _G["BigFatOrb_Mode"] == "LastHit" then
                return true
            end
        elseif OrbwalkManager.OrbLoaded == "NOW" then
            if _G.NOWi.Config.k.LastHit then
                return true
            end
        end
    end
    return self:IsKeyPressed(self.LastHitKeys)
end

function _KeyManager:OnTick()
    self.Combo      = self:IsComboPressed()
    self.Harass     = self:IsHarassPressed()
    self.LastHit    = self:IsLastHitPressed()
    self.Clear      = self:IsClearPressed()
end

function _KeyManager:RegisterKey(menu, param, mode)
    if mode == ORBWALK_MODE.COMBO then
        table.insert(self.ComboKeys, {menu, param})
    elseif mode == ORBWALK_MODE.HARASS then
        table.insert(self.HarassKeys, {menu, param})
    elseif mode == ORBWALK_MODE.CLEAR then
        table.insert(self.ClearKeys, {menu, param})
    elseif mode == ORBWALK_MODE.LASTHIT then
        table.insert(self.LastHitKeys, {menu, param})
    end
end

function _KeyManager:RegisterKeys()
    local list = self.ComboKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    --menu._param[menu:getParamIndex(param)].listTable[v]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_AUTOCARRY)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("fight",  menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(menu._param[menu:getParamIndex(param)].key, 'Orbwalking', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.HarassKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_MIXEDMODE)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("harass", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(menu._param[menu:getParamIndex(param)].key, 'Orbwalking', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.ClearKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LANECLEAR)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("laneclear", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(menu._param[menu:getParamIndex(param)].key, 'Laneclearing', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
    local list = self.LastHitKeys
    if #list > 0 then
        for i = 1, #list do
            if list[i] then
                local key = list[i]
                if #key > 0 then
                    local menu = key[1]
                    local param = key[2]
                    if menu and param then
                        if OrbwalkManager.OrbLoaded == "AutoCarry" then
                            _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LASTHIT)
                        elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                            _G.SxOrb:RegisterHotKey("lasthit", menu, param)
                        elseif OrbwalkManager.OrbLoaded == "MMA" then
                            if menu._param[menu:getParamIndex(param)].key then
                                _G.MMA_AddKey(menu._param[menu:getParamIndex(param)].key, 'Lasthitting', menu._param[menu:getParamIndex(param)].pType)
                            end
                        end
                    end
                end
            end
        end
    end
end


--CLASS: _Required
function _Required:__init()
    self.requirements = {}
    self.downloading = {}
    return self
end

function _Required:Add(t)
    assert(t and type(t) == "table", "_Required: table is invalid!")
    local name = t.Name
    assert(name and type(name) == "string", "_Required: name is invalid!")
    local url = t.Url
    assert(url and type(url) == "string", "_Required: url is invalid!")
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    table.insert(self.requirements, {Name = name, Url = url, Extension = extension, UseHttps = usehttps})
    return self
end

function _Required:Check()
    for i, tab in pairs(self.requirements) do
        local name = tab.Name
        local url = tab.Url
        local extension = tab.Extension
        local usehttps = tab.UseHttps
        if not FileExist(LIB_PATH..name.."."..extension) then
            PrintMessage("Downloading a required library called "..name.. ". Please wait...")
            local d = _Downloader(tab)
            table.insert(self.downloading, d)
        end
    end
    
    if #self.downloading > 0 then
        for i = 1, #self.downloading, 1 do 
            local d = self.downloading[i]
            AddTickCallback(function() d:Download() end)
        end
        self:CheckDownloads()
    else
        for i, tab in pairs(self.requirements) do
            local name = tab.Name
            local url = tab.Url
            local extension = tab.Extension
            local usehttps = tab.UseHttps
            if FileExist(LIB_PATH..name.."."..extension) and extension == "lua" then
                require(name)
            end
        end
    end
    return self
end

function _Required:CheckDownloads()
    if #self.downloading == 0 then 
        PrintMessage("Required libraries downloaded. Please reload with 2x F9.")
    else
        for i = 1, #self.downloading, 1 do
            local d = self.downloading[i]
            if d.GotScript then
                table.remove(self.downloading, i)
                break
            end
        end
        DelayAction(function() self:CheckDownloads() end, 2) 
    end
    return self
end

function _Required:IsDownloading()
    return self.downloading ~= nil and #self.downloading > 0 or false
end

-- CLASS: _Downloader
function _Downloader:__init(t)
    local name = t.Name
    local url = t.Url
    local extension = t.Extension ~= nil and t.Extension or "lua"
    local usehttps = t.UseHttps ~= nil and t.UseHttps or true
    self.SavePath = LIB_PATH..name.."."..extension
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(usehttps and '5' or '6')..'.php?script='..self:Base64Encode(url)..'&rand='..math.random(99999999)
    self:CreateSocket(self.ScriptPath)
    self.DownloadStatus = 'Connect to Server'
    self.GotScript = false
end

function _Downloader:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.Socket = self.LuaSocket.tcp()
    if not self.Socket then
        print('Socket Error')
    else
        self.Socket:settimeout(0, 'b')
        self.Socket:settimeout(99999999, 't')
        self.Socket:connect('sx-bol.eu', 80)
        self.Url = url
        self.Started = false
        self.LastPrint = ""
        self.File = ""
    end
end

function _Downloader:Download()
    if self.GotScript then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScript = true
    end
end

function _Downloader:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

-- _SimpleTS
function _SimpleTargetSelector:__init(mode, range, damageType)
    self.TS = TargetSelector(mode, range, damageType)
    self.target = nil
    self.range = range
    self.Menu = nil
    self.multiplier = 1.2
    self.selected = nil
    AddTickCallback(function() self:update() end)
    AddMsgCallback(
        function(msg, key)
            if msg == WM_LBUTTONDOWN then
                local best = nil
                for i, enemy in ipairs(GetEnemyHeroes()) do
                    if IsValidTarget(enemy) then
                        if GetDistanceSqr(enemy, mousePos) < math.pow(150, 2) then
                            local p = WorldToScreen(D3DXVECTOR3(enemy.x, enemy.y, enemy.z))
                            if OnScreen(p.x, p.y) then
                                if best == nil then
                                    best = enemy
                                elseif GetPriority(best) > GetPriority(enemy) then
                                    best = enemy
                                end
                            end
                        end
                    end
                end
                if best then
                    if self.selected and self.selected.networkID == best.networkID then
                        print("<font color=\"#c30000\"><b>Target Selector:</b></font> <font color=\"#FFFFFF\">" .. "New target unselected: "..best.charName.. "</font>") 
                        self.selected = nil
                    else
                        print("<font color=\"#c30000\"><b>Target Selector:</b></font> <font color=\"#FFFFFF\">" .. "New target selected: "..best.charName.. "</font>") 
                        self.selected = best
                    end
                end
            end
        end
    )
end

function _SimpleTargetSelector:update()
    self.TS.range = self.range
    self.TS:update()
    self.target = self.TS.target
    if IsValidTarget(self.selected, self.range * self.multiplier) and self.selected.type == myHero.type then
        self.target = self.selected
    end
end

function _SimpleTargetSelector:AddToMenu(Menu)
    if Menu then
        Menu:addSubMenu(myHero.charName.." - Target Selector Settings", "TS")
        self.Menu = Menu.TS
        self.Menu:addTS(self.TS)
        _Circle({Menu = self.Menu, Name = "Draw", Text = "Draw circle on Target", Source = function() return self.target end, Range = 120, Condition = function() return ValidTarget(self.target) end, Color = {255, 255, 0, 0}, Width = 4})
        _Circle({Menu = self.Menu, Name = "Range", Text = "Draw circle for Range", Range = function() return self.range end, Color = {255, 255, 0, 0}, Enable = false})
    end
end

--CREDIT TO EXTRAGOZ
local spellsFile = LIB_PATH.."missedspells.txt"
local spellslist = {}
local textlist = ""
local spellexists = false
local spelltype = "Unknown"
 
function writeConfigsspells()
        local file = io.open(spellsFile, "w")
        if file then
                textlist = "return {"
                for i=1,#spellslist do
                        textlist = textlist.."'"..spellslist[i].."', "
                end
                textlist = textlist.."}"
                if spellslist[1] ~=nil then
                        file:write(textlist)
                        file:close()
                end
        end
end
if FileExist(spellsFile) then spellslist = dofile(spellsFile) end
 
local Others = {"Recall","recall","OdinCaptureChannel","LanternWAlly","varusemissiledummy","khazixqevo","khazixwevo","khazixeevo","khazixrevo","braumedummyvoezreal","braumedummyvonami","braumedummyvocaitlyn","braumedummyvoriven","braumedummyvodraven","braumedummyvoashe","azirdummyspell"}
local Items = {"RegenerationPotion","FlaskOfCrystalWater","ItemCrystalFlask","ItemMiniRegenPotion","PotionOfBrilliance","PotionOfElusiveness","PotionOfGiantStrength","OracleElixirSight","OracleExtractSight","VisionWard","SightWard","sightward","ItemGhostWard","ItemMiniWard","ElixirOfRage","ElixirOfIllumination","wrigglelantern","DeathfireGrasp","HextechGunblade","shurelyascrest","IronStylus","ZhonyasHourglass","YoumusBlade","randuinsomen","RanduinsOmen","Mourning","OdinEntropicClaymore","BilgewaterCutlass","QuicksilverSash","HextechSweeper","ItemGlacialSpike","ItemMercurial","ItemWraithCollar","ItemSoTD","ItemMorellosBane","ItemPromote","ItemTiamatCleave","Muramana","ItemSeraphsEmbrace","ItemSwordOfFeastAndFamine","ItemFaithShaker","OdynsVeil","ItemHorn","ItemPoroSnack","ItemBlackfireTorch","HealthBomb","ItemDervishBlade","TrinketTotemLvl1","TrinketTotemLvl2","TrinketTotemLvl3","TrinketTotemLvl3B","TrinketSweeperLvl1","TrinketSweeperLvl2","TrinketSweeperLvl3","TrinketOrbLvl1","TrinketOrbLvl2","TrinketOrbLvl3","OdinTrinketRevive","RelicMinorSpotter","RelicSpotter","RelicGreaterLantern","RelicLantern","RelicSmallLantern","ItemFeralFlare","trinketorblvl2","trinketsweeperlvl2","trinkettotemlvl2","SpiritLantern","RelicGreaterSpotter"}
local MSpells = {"JayceStaticField","JayceToTheSkies","JayceThunderingBlow","Takedown","Pounce","Swipe","EliseSpiderQCast","EliseSpiderW","EliseSpiderEInitial","elisespidere","elisespideredescent","gnarbigq","gnarbigw","gnarbige","GnarBigQMissile"}
local PSpells = {"CaitlynHeadshotMissile","RumbleOverheatAttack","JarvanIVMartialCadenceAttack","ShenKiAttack","MasterYiDoubleStrike","sonaqattackupgrade","sonawattackupgrade","sonaeattackupgrade","NocturneUmbraBladesAttack","NautilusRavageStrikeAttack","ZiggsPassiveAttack","QuinnWEnhanced","LucianPassiveAttack","SkarnerPassiveAttack","KarthusDeathDefiedBuff","AzirTowerClick","azirtowerclick","azirtowerclickchannel"}
 
local QSpells = {"TrundleQ","LeonaShieldOfDaybreakAttack","XenZhaoThrust","NautilusAnchorDragMissile","RocketGrabMissile","VayneTumbleAttack","VayneTumbleUltAttack","NidaleeTakedownAttack","ShyvanaDoubleAttackHit","ShyvanaDoubleAttackHitDragon","frostarrow","FrostArrow","MonkeyKingQAttack","MaokaiTrunkLineMissile","FlashFrostSpell","xeratharcanopulsedamage","xeratharcanopulsedamageextended","xeratharcanopulsedarkiron","xeratharcanopulsediextended","SpiralBladeMissile","EzrealMysticShotMissile","EzrealMysticShotPulseMissile","jayceshockblast","BrandBlazeMissile","UdyrTigerAttack","TalonNoxianDiplomacyAttack","LuluQMissile","GarenSlash2","VolibearQAttack","dravenspinningattack","karmaheavenlywavec","ZiggsQSpell","UrgotHeatseekingHomeMissile","UrgotHeatseekingLineMissile","JavelinToss","RivenTriCleave","namiqmissile","NasusQAttack","BlindMonkQOne","ThreshQInternal","threshqinternal","QuinnQMissile","LissandraQMissile","EliseHumanQ","GarenQAttack","JinxQAttack","JinxQAttack2","yasuoq","xeratharcanopulse2","VelkozQMissile","KogMawQMis","BraumQMissile","KarthusLayWasteA1","KarthusLayWasteA2","KarthusLayWasteA3","karthuslaywastea3","karthuslaywastea2","karthuslaywastedeada1","MaokaiSapling2Boom","gnarqmissile","GnarBigQMissile","viktorqbuff"}
local WSpells = {"KogMawBioArcaneBarrageAttack","SivirWAttack","TwitchVenomCaskMissile","gravessmokegrenadeboom","mordekaisercreepingdeath","DrainChannel","jaycehypercharge","redcardpreattack","goldcardpreattack","bluecardpreattack","RenektonExecute","RenektonSuperExecute","EzrealEssenceFluxMissile","DariusNoxianTacticsONHAttack","UdyrTurtleAttack","talonrakemissileone","LuluWTwo","ObduracyAttack","KennenMegaProc","NautilusWideswingAttack","NautilusBackswingAttack","XerathLocusOfPower","yoricksummondecayed","Bushwhack","karmaspiritbondc","SejuaniBasicAttackW","AatroxWONHAttackLife","AatroxWONHAttackPower","JinxWMissile","GragasWAttack","braumwdummyspell","syndrawcast","SorakaWParticleMissile"}
local ESpells = {"KogMawVoidOozeMissile","ToxicShotAttack","LeonaZenithBladeMissile","PowerFistAttack","VayneCondemnMissile","ShyvanaFireballMissile","maokaisapling2boom","VarusEMissile","CaitlynEntrapmentMissile","jayceaccelerationgate","syndrae5","JudicatorRighteousFuryAttack","UdyrBearAttack","RumbleGrenadeMissile","Slash","hecarimrampattack","ziggse2","UrgotPlasmaGrenadeBoom","SkarnerFractureMissile","YorickSummonRavenous","BlindMonkEOne","EliseHumanE","PrimalSurge","Swipe","ViEAttack","LissandraEMissile","yasuodummyspell","XerathMageSpearMissile","RengarEFinal","RengarEFinalMAX","KarthusDefileSoundDummy2"}
local RSpells = {"Pantheon_GrandSkyfall_Fall","LuxMaliceCannonMis","infiniteduresschannel","JarvanIVCataclysmAttack","jarvanivcataclysmattack","VayneUltAttack","RumbleCarpetBombDummy","ShyvanaTransformLeap","jaycepassiverangedattack", "jaycepassivemeleeattack","jaycestancegth","MissileBarrageMissile","SprayandPrayAttack","jaxrelentlessattack","syndrarcasttime","InfernalGuardian","UdyrPhoenixAttack","FioraDanceStrike","xeratharcanebarragedi","NamiRMissile","HallucinateFull","QuinnRFinale","lissandrarenemy","SejuaniGlacialPrisonCast","yasuordummyspell","xerathlocuspulse","tempyasuormissile","PantheonRFall"}
 
local casttype2 = {"blindmonkqtwo","blindmonkwtwo","blindmonketwo","infernalguardianguide","KennenMegaProc","sonawattackupgrade","redcardpreattack","fizzjumptwo","fizzjumpbuffer","gragasbarrelrolltoggle","LeblancSlideM","luxlightstriketoggle","UrgotHeatseekingHomeMissile","xeratharcanopulseextended","xeratharcanopulsedamageextended","XenZhaoThrust3","ziggswtoggle","khazixwlong","khazixelong","renektondice","SejuaniNorthernWinds","shyvanafireballdragon2","shyvanaimmolatedragon","ShyvanaDoubleAttackHitDragon","talonshadowassaulttoggle","viktorchaosstormguide","zedw2","ZedR2","khazixqlong","AatroxWONHAttackLife","viktorqbuff"}
local casttype3 = {"sonaeattackupgrade","bluecardpreattack","LeblancSoulShackleM","UdyrPhoenixStance","RenektonSuperExecute"}
local casttype4 = {"FrostShot","PowerFist","DariusNoxianTacticsONH","EliseR","JaxEmpowerTwo","JaxRelentlessAssault","JayceStanceHtG","jaycestancegth","jaycehypercharge","JudicatorRighteousFury","kennenlrcancel","KogMawBioArcaneBarrage","LissandraE","MordekaiserMaceOfSpades","mordekaisercotgguide","NasusQ","Takedown","NocturneParanoia","QuinnR","RengarQ","HallucinateFull","DeathsCaressFull","SivirW","ThreshQInternal","threshqinternal","PickACard","goldcardlock","redcardlock","bluecardlock","FullAutomatic","VayneTumble","MonkeyKingDoubleAttack","YorickSpectral","ViE","VorpalSpikes","FizzSeastonePassive","GarenSlash3","HecarimRamp","leblancslidereturn","leblancslidereturnm","Obduracy","UdyrTigerStance","UdyrTurtleStance","UdyrBearStance","UrgotHeatseekingMissile","XenZhaoComboTarget","dravenspinning","dravenrdoublecast","FioraDance","LeonaShieldOfDaybreak","MaokaiDrain3","NautilusPiercingGaze","RenektonPreExecute","RivenFengShuiEngine","ShyvanaDoubleAttack","shyvanadoubleattackdragon","SyndraW","TalonNoxianDiplomacy","TalonCutthroat","talonrakemissileone","TrundleTrollSmash","VolibearQ","AatroxW","aatroxw2","AatroxWONHAttackLife","JinxQ","GarenQ","yasuoq","XerathArcanopulseChargeUp","XerathLocusOfPower2","xerathlocuspulse","velkozqsplitactivate","NetherBlade","GragasQToggle","GragasW","SionW","sionpassivespeed"}
local casttype5 = {"VarusQ","ZacE","ViQ","SionQ"}
local casttype6 = {"VelkozQMissile","KogMawQMis","RengarEFinal","RengarEFinalMAX","BraumQMissile","KarthusDefileSoundDummy2","gnarqmissile","GnarBigQMissile","SorakaWParticleMissile"}
--,"PoppyDevastatingBlow"--,"Deceive" -- ,"EliseRSpider"
function getSpellType(unit, spellName)
        spelltype = "Unknown"
        casttype = 1
        if unit ~= nil and unit.type == "AIHeroClient" then
                if spellName == nil or unit:GetSpellData(_Q).name == nil or unit:GetSpellData(_W).name == nil or unit:GetSpellData(_E).name == nil or unit:GetSpellData(_R).name == nil then
                        return "Error name nil", casttype
                end
                if spellName:find("SionBasicAttackPassive") or spellName:find("zyrapassive") then
                        spelltype = "P"
                elseif (spellName:find("BasicAttack") and spellName ~= "SejuaniBasicAttackW") or spellName:find("basicattack") or spellName:find("JayceRangedAttack") or spellName == "SonaQAttack" or spellName == "SonaWAttack" or spellName == "SonaEAttack" or spellName == "ObduracyAttack" or spellName == "GnarBigAttackTower" then
                        spelltype = "BAttack"
                elseif spellName:find("CritAttack") or spellName:find("critattack") then
                        spelltype = "CAttack"
                elseif unit:GetSpellData(_Q).name:find(spellName) then
                        spelltype = "Q"
                elseif unit:GetSpellData(_W).name:find(spellName) then
                        spelltype = "W"
                elseif unit:GetSpellData(_E).name:find(spellName) then
                        spelltype = "E"
                elseif unit:GetSpellData(_R).name:find(spellName) then
                        spelltype = "R"
                elseif spellName:find("Summoner") or spellName:find("summoner") or spellName == "teleportcancel" then
                        spelltype = "Summoner"
                else
                        if spelltype == "Unknown" then
                                for i=1,#Others do
                                        if spellName:find(Others[i]) then
                                                spelltype = "Other"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#Items do
                                        if spellName:find(Items[i]) then
                                                spelltype = "Item"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#PSpells do
                                        if spellName:find(PSpells[i]) then
                                                spelltype = "P"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#QSpells do
                                        if spellName:find(QSpells[i]) then
                                                spelltype = "Q"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#WSpells do
                                        if spellName:find(WSpells[i]) then
                                                spelltype = "W"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#ESpells do
                                        if spellName:find(ESpells[i]) then
                                                spelltype = "E"
                                        end
                                end
                        end
                        if spelltype == "Unknown" then
                                for i=1,#RSpells do
                                        if spellName:find(RSpells[i]) then
                                                spelltype = "R"
                                        end
                                end
                        end
                end
                for i=1,#MSpells do
                        if spellName == MSpells[i] then
                                spelltype = spelltype.."M"
                        end
                end
                local spellexists = spelltype ~= "Unknown"
                if #spellslist > 0 and not spellexists then
                        for i=1,#spellslist do
                                if spellName == spellslist[i] then
                                        spellexists = true
                                end
                        end
                end
                if not spellexists then
                        table.insert(spellslist, spellName)
                        --writeConfigsspells()
                       -- PrintChat("Skill Detector - Unknown spell: "..spellName)
                end
        end
        for i=1,#casttype2 do
                if spellName == casttype2[i] then casttype = 2 end
        end
        for i=1,#casttype3 do
                if spellName == casttype3[i] then casttype = 3 end
        end
        for i=1,#casttype4 do
                if spellName == casttype4[i] then casttype = 4 end
        end
        for i=1,#casttype5 do
                if spellName == casttype5[i] then casttype = 5 end
        end
        for i=1,#casttype6 do
                if spellName == casttype6[i] then casttype = 6 end
        end
 
        return spelltype, casttype
end

if _G.SimpleLibLoaded == nil then
    SpellManager = _SpellManager()
    Prediction = _Prediction()
    CircleManager = _CircleManager()
    AutoSmite = _AutoSmite()
    OrbwalkManager = _OrbwalkManager()
    if _Required():Add({Name = "VPrediction", Url = "raw.githubusercontent.com/SidaBoL/Scripts/master/Common/VPrediction.lua"}):Check():IsDownloading() then return end
    DelayAction(function() CheckUpdate() end, 1)
    YasuoWall = nil
    for i, enemy in ipairs(GetEnemyHeroes()) do
        EnemiesInGame[enemy.charName] = true
    end
    if EnemiesInGame["Yasuo"] then 
        AddProcessSpellCallback(
            function(unit, spell)
                if myHero.dead then return end
                if unit and spell and unit.charName and spell.name then
                    if unit.charName:lower():find("yasuo") and spell.name:lower():find("yasuow") then
                        YasuoWall = {StartVector = Vector(unit), EndVector = Vector(spell.endPos.x, unit.y, spell.endPos.z)}
                        DelayAction(function() YasuoWall = nil end, 4.5)
                    end
                end
            end
        )
        AddCreateObjCallback(
            function(obj)
                if obj and obj.name then
                    if obj.name:lower():find("yasuo_base_w_windwall") and not obj.name:lower():find("activate") then
                        if YasuoWall ~= nil then
                            YasuoWall.Object = obj
                        end
                    end
                end
            end
        )
        AddDeleteObjCallback(
            function(obj)
                if obj and obj.name then
                    if obj.name:lower():find("yasuo_base_w_windwall") and not obj.name:lower():find("activate") then
                        if YasuoWall ~= nil then
                            YasuoWall = nil
                        end
                    end
                end
            end
        )
    end
    if VIP_USER then
        _G.ScriptCode = Base64Decode("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D8SKVgAAAAAAD8RtegAAAAAAD8RGVgAAAAAAD8RtJAAAAAAAD8TTVgAAAAAAD8RtRgAAAAAAD8R5VgAAAAAAD8RtAAAAAAAAD8TgVgAAAAAAD8RGegAAAAAAD8TZVgAAAAAAD8RGJAAAAAAAD8RGvAAAAAAAD8RfVgAAAAAAD8RGRgAAAAAAD8RJVgAAAAAAD8RcUAAAAAAAD8RtVgAAAAAAD8RcxAAAAAAAD8R/VgAAAAAAD8SIUAAAAAAAD8SIxAAAAAAAD8QSVgAAAAAAD8SbxAAAAAAAD8QGUAAAAAAAD8RhxAAAAAAAD8QGxAAAAAAAD8T0xAAAAAAAD8Q7UAAAAAAAD8Q7vAAAAAAAD8Q7xAAAAAAAD8SqxAAAAAAAD8SKxAAAAAAAD8R4UAAAAAAAD8RGxAAAAAAAD8R4xAAAAAAAD8TVvAAAAAAAD8Q0xAAAAAAAD8R5xAAAAAAAD8Q0AAAAAAAAD8TgxAAAAAAAD8TaUAAAAAAAD8TavAAAAAAAD8RfxAAAAAAAD8TVUAAAAAAAD8SIvAAAAAAAD8TVxAAAAAAAD8RJxAAAAAAAD8SDUAAAAAAAD8RtxAAAAAAAD8SDxAAAAAAAD8R/xAAAAAAAD8SWUAAAAAAAD8SWvAAAAAAAD8Q0vAAAAAAAD8SWxAAAAAAAD8RJUAAAAAAAD8STUAAAAAAAD8T7vAAAAAAAD8STvAAAAAAAD8RtUAAAAAAAD8STxAAAAAAAD8R/UAAAAAAAD8SlUAAAAAAAD8SlvAAAAAAAD8R4vAAAAAAAD8SlxAAAAAAAD8QSUAAAAAAAD8RfUAAAAAAAD8T7UAAAAAAAD8RcvAAAAAAAD8T7xAAAAAAAD8RRUAAAAAAAD8TZUAAAAAAAD8SNUAAAAAAAD8SNvAAAAAAAD8SDvAAAAAAAD8SNxAAAAAAAD8TgUAAAAAAAD8SNAAAAAAAAD8SbUAAAAAAAD8RaUAAAAAAAD8RhUAAAAAAAD8RaxAAAAAAAD8T0UAAAAAAAD8RvUAAAAAAAD8RvvAAAAAAAD8QGvAAAAAAAD8RvxAAAAAAAD8SqUAAAAAAAD8SKUAAAAAAAD8SmvAAAAAAAD8RavAAAAAAAD8SmAAAAAAAAD8RGUAAAAAAAD8TDvAAAAAAAD8TTUAAAAAAAD8TuvAAAAAAAD8TuAAAAAAAAD8SbvAAAAAAA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D+nxugAYbvFF1vG6ALvW8SCvbroPLW66APga8fCLGroP1xq6APhu8VDW8boA5PHxD2YaugAa1vEP+W66ABpu8a16Gror1vG6AO7W8Q/CbroAo/huAMQa8S0uGroPU266AMRu8e3W8boAw/HxD4HWugDu8fFAjda67dnWukp/8bol/vG6etbxugBg8fGaARq6nW7xugD4GvFFbvG6AMNu8ZWl1rr6XG66Wzsaui5J1rreSBq6rT8augzeGrrb/da6tjXWuprW8boAxNbxxgcauvqVGrrp1vG6ABhu8RdX8boENfG6oKDWumZG1rqgUda6IxduukD2GrqXq/G6gcHxutH+broCqfG6AqbxuktF8bp21vG6ABjW8fZnGrr5bvG6ALTW8bZhGrrmNm66D8JuugAa+G4AyPHxrNbxugAYGvFM0266U4PWukh4brqf1vG6ACbW8Q/CbroAJvhuAOvx8U1G8bpm2xq6TLbxui/6brodbvG6AMga8ZXW8boAxPHxV9bxugDkGvGRSPG68QjWuqn88bqpbvG6ALRu8az7brqe7W66NuDxuvxu8boAGtbxem7xugD4bvE5bvG6AOvx8Rycbrr51vG6AOvW8dxTGrqxq9a6Y27xugC78fH81vG6AOTW8en71rqieRq6hPnWuoRu8boAGvHxV27xugDIbvHQ2ta6B9Uautfb1rott/G6ItbxugA+1vHN4Na6l/ZuusGX8bppL/G6NW7xugCj1vHXbvG6ABjx8d6Nbrp7Jda6sm7xugDu8fGOhG66D5XWugCmbvHA1/G6OfrWunUubroPrBq6ALvW8XNJbrpz8G660dbxugA+bvFx1vG6AO5u8TPNbrr9bvG6AMjx8SJu8boA+NbxDyUaugAaGvGH1vG6APjx8ceK8bpN1vG6ACbx8Swl8bosbvG6ALTx8Q7TGrrxbvG6AGDW8VCK1rq4CPG6D8JuugC7ZG4A7m7xe27xugAmbvEEO/G66MxuuqLW8boAYBrxndxuujyabro8AfG6FTTWuodu8boAw9bx5v4aupIM1rqx8Bq6StbxugDDGvHfJW6632HxuqiL8bozqxq6dl9uulmv1rq+bvG6AD4a8WlVGrrGbvG6AMQa8SCXGrroAm66HdbxugCjbvGu126696zxuiRCGrqeWhq6KzTxupKW1rqhXPG6wJjxuiNu8boAyNbxpAYaulJu8boAvG4skC0augDYGgtS1tbID8JuugBgwm4Aw/Hx8Afxug/w1roA+PHxOlPWug+XGroAoxrxD6waugDD1vEPlW66AMMa8ST5broPevG6AMNu8cFJ8boPSxq6ALtu8XF51roPQG66AO7W8UuKGroPAta6AO4a8VkC8boPTBq6AGDx8dxJGroP9vG6AMTx8TBMbroPgda6AMjW8Q9I1roAtPHxCAJuug+21roAtNbxD0DxugC0bvEPSG66AKPx8Q9L1roA69bxA0zxug9AGroAo9bxU1NuuluBbrquqm66DwgaugBg1vHQ0Bq6D+luugDrbvEO1vG6AGAa8Q+X1roAtBrxSKzxui6V1rr3iNa6D/waugBgbvEH2xq6D63WugA+1vGOQta6DxcaugDIbvEIivG6D1MaugDE1vEw/hq6D1PxugDIGvE27Rq6D8JuugDEwm4A+NbxOqvWug+aGroAo27xL27xugAm8fHbbvG6AD7W8Q/CbroA+MJuAGAa8Q/CbroA62RuAOTW8TXW8boA5PHxD8JuugDIZG4AJvHx/dbxugCjbvEPwm66ALT4bgDk8fH21vG6AOTW8SXW8boAYG7xvtbxugDIGvEPwm66AOT4bgDkGvFjLW66D1fxugAY1vEP/Na6AORu8Q81GroAPvHxn6bxugx/brqhYxq6DxzxugA+GvHNHNa6D6nxugA+bvF1YRq6D5XxugC78fGBRta6D5HxugC7GvGorG66D2ZuugAm1vEcHG66D6kaugAa8fEV/PG6D8JuugCmZG4AJm7xkUZuuhdu8boAu9bxD8JuugAa+G4A6xrxDy/WugAY8fGy1vG6AO5u8Q+RGroAJhrxxzbWug8vbroAGBrxD/xuugAYbvFFlRq6INnWug9m1roA+Brx8JPWug+EGroA+G7xUNbxugDrGvEPNfG6ABrW8Q828boAGm7xrZHWuitj8boPwm66AORkbgDEGvEt1vG6ABhu8Q8M1roAxG7x7UDWug+g1roA7vHxQF8auu2bGrpKUfG6JaoaunolGrqabvG6ALsa8Z3l1rpFnG66lW7xugAmGvH6bvG6AD5u8Vtu8boAGvHxLm7xugAY1vHe1vG6ABga8a1u8boAu/HxDNbxugAmbvHb1vG6AD7x8bbW8boAGPHxmtbxugA+GvHG1vG6ACbW8frW8boAw/Hx6c3WuhdXGroEF9a6oNfxumZhbrqg09a6I+nxukAcGrqXZxq6gQxuutH+8boCoG66AlXxukuf1rp2S2669hLxuvlC8bq2mPG65vpuug8ubroAyPHxrNbxugDr8fFMzPG6U2fWukjl8bqfoBq6DwwaugDr8fFNbvG6AMjx8WYuGrpMF266L60auh2YbrqVWxq6V81uupHQ8brx1vG6ALTW8anXGrqpphq6rNNuup7pGro2iPG6/BHxunqY1ro5bvG6ALTx8Rxu8boAw9bx+dbxugCj8fHcn266sarWumMSGrr8mvG66W7xugDuGvGit/G6hNbxugDDGvGEbvG6AOvW8Vdu8boAu27x0G7xugDE8fEHbvG6APjx8dfW8boAo9bxLW7xugDu1vEi1vG6AMjW8c1u8boAoxrxl9bxugC0bvHB1vG6AMNu8WnW8boAYPHxNT7WuteD1rre+/G6e8EaurKNbrqOhNa6Dy3xugCmbvHA3G66OTVuunVX1roPzfG6ALvW8XM7brpzl2660fAaunEH1roz3PG6/W/WuiLVbroPzRq6ABoa8Yfp1rrHjda6TYTxuiwHbrosBhq6DlrWuvHabrpQkxq6uGPWug/XbroA7m7xezTxugSDbrroiBq6ogcaup3wbro8mta6PI3xuhWcGrqHP/G65gbWupJ6Grqx+vG6Sq1uut8IbrrfbvG6ABpu8ahf8bozm/G6dgEaulkSbrq+G/G6aT/WusarbrogRfG66EXWuh3W8boAxG7xriXWuvfW8boA+G7xJKvxup5u8boA7vHxKxtuupJu8boAGtbxoYtuusBu8boAxBrxIz9uuqRu8boA+BrxUm7xugC8biyQhG66ANgaC5Bu1sgPwm66AGD4bgDD8fHwU9a6D5rWugD48fEPwm66AOv4bgCjGvEP/Na6AMPW8Q8X1roAwxrxJNbxugC01vEPwm66AMhkbgDDbvHBUda6D8JuugDuDm4Au27xcdpuug/CbroAuw5uAO7W8Ut/GroPDBq6AO4a8TA11roPwm66ABj4bgDI1vEPwm66AO5kbgC08fEIoBq6D8JuugCjwm4AtNbxD8JuugC0+G4AtG7xD8JuugD4Dm4Ao/HxD8JuugAawm4A69bxD8JuugA+Dm4Ao9bxrm7xugCjGvEPwm66AKNkbgBg1vHQTPG6DyVuugDrbvFINta6LtbxugDI8fH3bvG6AMjW8Q/CbroAyPhuAGBu8Qf2broP7W66AD7W8Q/CbroAJsJuAMhu8QjZ1roP2266AMTW8TBu8boAYPHxNmbWui+IGrrbQhq6D8JuugBgwm4AYBrxD8JuugBgZG4A5NbxNYFuug/CbroAxPhuACbx8f3w8boPwm66AD74bgDk8fH2lRq6Ja0aug/CbroA5MJuAOQa8WNTbroPmm66ABjW8Q/XbroA5G7xD8JuugAYDm4APvHxn21uugwRbroPwm66AD7CbgA+GvHNAm66D8JuugDEZG4APm7xddrxug/CbroAPmRuALvx8YFu8boAu9bxDwzxugC7GvGo1vG6ALtu8Q/CbroAJg5uACbW8RxI1roPRda6ABrx8Q/CbroAJvhuACZu8ZFGbroXbvG6AOvx8Q/CbroA68JuAOsa8Q/CbroA62RuABjx8bJA8boPwm66ABjCbgAYGvEPL9a6ABhu8UUu8bogbvG6APjx8Q/CbroA+MJuAPga8fAS1roPJda6APhu8VAHbroPwm66ABoObgAa1vEPwm66ABr4bgAabvGt+ta6K9bxugDE8fEPwm66AMTCbgDEGvEt9vG6D+3WugDEbvHtV266QNMauu2Y8bolPxq6ep8aupob8bpFGxq6lVxuuvpC8bpbi/G6Losaut6B1rqtnPG6DOnWuttFbrr6W9a66UxuuhdbbrqgLta6Zm3xuqBnbrojrfG6QK3WupdRGrqBrW660dXWugIM1roC0/G6Swxuunbb1rr2mBq6+UnxurZn8bqsHNa6TGcaulMR8bpIERq6n0Buuk07brpmoNa6L6BuupUI1rpXTNa6kQhuuvHN8bqpQNa6qWEauqz+8bo2/hq6/AHxunoBGro5lta6HFHxuvmsbrrcS266sarWumOqGrrpEvG6ohIauoS2brqEBvG6V3kautDg8boH4Bq6LZvxuiLwGrrNmxq6l5HxusGf1rppn266NYrxuteKGrreX/G6e5duurJfGrqOeta6OZXWunWVbrpz2ta6c5HWutGRbrpxqda6M6luuv3Z8boi2Rq6h8Fuusdh8bpN3vG6LDZuuiymGroObRq68UbxulBGGrq43G66e1zxugRcGrroiPG6ovnWup35bro83Na6PJPxuhU78bqHOxq65njxupLpGrqx6W66SvDWut/wbrrfg9a6qNoaujPV8bp21Rq6WYPxur6DGrpplvG6xpYauiD91rroLda6HS1uuq7N1rr3zW66JPvWup77GrorjfG6ko0auqFa8brAWhq6I2/xuqRvGrpSo9a6kNduugAF1gsJ1tbIAABuCwmm8chE3tbIRKYayLPW1sgAAG4Ls6ZuyDh11sjOddbIAGTxowBubgXJbgBzUqPW55BQ8ecAANYFUtYAc1Kj1ueQUPHnAADWBZBuAHNSo9bnkFDx5wAA1gUJ1gBzAABuBQnEUHNEUFBzRMRQc7PWAHMAAG4Fs6O8czh1vHPOdbxzAGRQdeIAxJIAow3iAMgs/QDITl4AyBg+AMgP4gBgDv0AYMJeAGD4PgBgZOIA5PH9AOTWXgDkGj4A5G7iAD5Q/eIAAAt0/bzIdMRQyFRQUMhUxFDIAG4AowC8xAYAu8Q+DwDEBgAAbk4AJm4+AHxubgBqUPEATcS0ACwAPgDEAD4PAMQGAABuTgAmbj4AatZuAGrE8QBNxLQALAA+AMQAPg8AxAYAvG5OACZuPgAN8W4ADbzxAE3EtAAsAD4AxAA+4QC8yG68vMlkbhqMAA1uGgAP8W4AD7zxABjEXgDEAD5uAMQGAGRQ1gD4xD4AvABrbgDEBgBkvNYA+MQ+vABQKAAAxHgA+AA+P+28KLwAACgA8VDVABq8Pj/tvCi8AAAoALy81QAaxF4AvLwGABoAPtbEUMgAxAA+AMTE4gDEAHwAAE+caG4AAAAAAAAAAADnQ+dYHycAdw0NDW4AjW0RtHDtJZpFWy6tDNv6F6AIQIECS/a2TFNIn2YvlZGprDb8ehz53GPp8IRX0ActzZfBNdfeso45dXPRcf0ix00sDvFQewQ6op08FYfmMLFK36gzdlm+acYg6B2u954rkqHAIyS4A8lSkAlEszjO3X4fIbC9pHRUKQu6chNe4RBsTsLWvD8bi5yr5bfMmGcRVUKv/gFRqhJ54JtJil/0f9PZYW1GXIgGO3g02tWDlpOl+41ab6bD7rSjyGDkPrsm6xj4GsS/0qc9z/XFYl19uco3hcuAQY8ZKkfziZTUMmWG6h7vVmsxmf9wQycKKIwUFuy1aE/ygljYBefjd+J8ag0PZG4=")
        _G.ScriptENV = _ENV
        SSL2({221,246,97,90,180,218,181,98,124,113,104,32,168,212,132,54,12,137,8,140,7,239,125,39,56,177,11,67,47,147,82,219,27,194,220,88,138,110,148,94,252,34,172,50,255,63,171,35,122,139,95,20,183,178,65,150,24,76,99,197,3,211,163,114,242,161,160,145,233,229,59,213,198,237,245,130,192,52,209,71,107,75,117,93,158,128,45,115,152,58,204,244,31,92,195,69,38,103,159,37,57,175,134,85,187,225,105,87,210,120,182,23,51,5,206,141,235,106,248,116,6,112,18,223,100,174,14,84,200,123,224,55,179,61,13,214,189,190,226,101,21,42,156,72,2,129,202,48,22,16,234,127,136,133,196,25,247,185,207,109,121,135,176,41,249,68,188,80,169,131,238,30,126,222,77,70,215,102,167,91,46,199,60,143,217,191,36,231,17,146,111,166,149,96,79,232,251,201,208,186,44,227,216,64,154,228,153,108,49,119,184,157,4,1,241,15,78,155,89,254,205,250,170,151,62,29,236,253,164,28,40,73,81,10,243,19,118,193,173,53,83,162,240,142,144,203,230,165,33,43,74,66,86,9,26,11,130,235,38,75,0,221,90,90,90,98,0,56,202,168,113,177,113,0,0,0,0,0,0,0,0,0,221,168,245,218,0,0,104,0,0,0,229,0,114,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,61,114,114,0,13,84,114,221,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,166,114,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,218,149,114,0,11,242,0,0,125,84,246,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,0,242,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,218,242,242,0,11,242,0,0,125,166,246,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,218,200,242,0,98,0,200,123,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,221,149,221,0,158,221,0,221,200,149,221,0,27,221,90,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,181,246,96,0,59,161,96,0,84,246,0,221,166,246,84,97,0,97,84,97,31,246,0,246,47,123,0,0,113,0,123,97,219,242,74,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,104,221,0,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,242,149,221,0,22,221,0,0,149,149,221,0,38,200,246,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,59,246,246,0,113,242,246,90,69,149,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,242,149,221,0,200,200,246,0,149,149,221,0,38,221,97,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,52,96,242,90,52,161,246,179,59,161,246,246,113,114,246,90,69,242,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,245,221,0,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,200,149,221,0,4,221,0,0,221,96,221,0,121,200,246,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,13,161,246,0,237,200,123,90,109,149,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,200,149,221,0,149,200,246,0,221,96,221,0,121,221,97,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,42,96,149,90,42,123,246,179,13,123,123,246,113,84,123,90,109,242,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,226,221,0,0,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,149,149,221,0,7,246,0,0,242,96,221,0,62,200,246,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,208,123,246,0,190,149,246,180,151,149,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,149,149,221,0,221,123,246,0,242,96,221,0,62,221,97,84,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,228,96,242,180,228,96,246,179,208,96,246,97,113,166,246,180,151,242,66,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,160,61,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,160,13,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,145,214,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,145,189,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,233,190,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,233,226,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,229,101,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,229,21,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,59,42,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,59,156,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,213,72,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,213,2,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,198,129,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,198,202,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,237,48,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,237,22,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,245,16,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,245,234,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,130,127,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,130,136,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,192,133,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,192,196,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,52,25,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,52,247,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,209,185,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,209,207,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,71,109,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,71,121,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,107,135,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,107,176,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,75,41,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,75,249,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,117,68,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,117,188,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,93,80,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,93,169,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,158,131,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,158,238,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,128,30,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,128,126,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,45,222,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,45,77,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,115,70,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,115,215,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,152,102,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,152,167,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,58,91,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,58,46,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,204,199,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,204,60,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,244,143,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,244,217,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,58,191,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,205,191,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,250,36,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,250,231,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,170,17,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,170,146,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,151,111,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,151,166,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,62,149,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,62,96,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,29,79,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,29,232,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,236,251,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,236,201,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,253,208,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,253,186,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,164,44,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,164,227,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,28,216,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,28,64,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,40,154,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,40,228,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,221,73,153,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,200,73,108,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,85,72,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,187,119,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,187,184,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,225,157,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,225,4,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,105,1,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,105,241,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,87,15,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,87,78,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,210,155,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,210,89,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,120,254,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,120,205,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,182,250,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,182,170,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,23,151,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,23,62,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,51,29,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,51,236,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,5,253,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,5,164,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,206,28,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,149,206,40,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,227,242,141,73,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,208,149,96,97,218,161,242,0,47,123,84,0,227,221,246,81,98,166,142,123,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,227,149,142,123,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,166,221,84,221,0,246,0,0,205,242,0,221,98,166,142,200,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,98,166,142,123,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,227,149,142,200,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,114,0,84,125,114,26,14,125,166,26,14,125,0,0,84,125,114,26,14,201,242,114,0,227,149,142,123,82,0,84,0,157,0,0,0,90,181,0,0,0,206,141,5,187,120,134,0,90,97,0,0,0,195,59,0,90,104,0,0,0,117,159,5,187,23,141,160,182,37,57,0,90,180,0,0,0,117,117,130,95,0,90,90,0,0,0,117,117,130,0,90,124,0,0,0,59,57,141,158,206,57,5,139,0,90,98,0,0,0,59,57,141,158,206,57,5,0,97,0,0,0,0,0,0,53,163,90,180,0,0,0,103,6,141,57,0,90,90,0,0,0,206,235,103,0,97,0,0,0,0,84,11,62,114,90,113,0,0,0,117,159,5,187,23,141,233,52,128,0,97,0,0,0,0,0,18,60,114,97,0,0,0,0,84,169,96,114,97,0,0,0,0,0,92,135,114,97,0,0,0,0,0,104,70,114,97,0,0,0,0,0,150,127,114,97,0,0,0,0,0,149,149,114,97,0,0,0,0,0,169,215,114,97,0,0,0,0,0,169,96,114,97,0,0,0,0,0,93,185,114,97,0,0,0,0,0,84,207,114,97,0,0,0,0,0,162,222,114,97,0,0,0,0,0,37,60,114,97,0,0,0,0,0,30,48,114,97,0,0,0,0,0,34,91,114,97,0,0,0,0,0,156,146,114,97,0,0,0,0,0,137,143,114,97,0,0,0,0,0,43,77,114,97,0,0,0,0,0,49,231,114,97,0,0,0,0,0,177,167,114,97,0,0,0,0,0,153,167,114,97,0,0,0,0,0,243,46,114,97,0,0,0,0,0,248,91,114,97,0,0,0,0,0,101,247,114,97,0,0,0,0,84,151,166,114,97,0,0,0,0,0,184,70,114,97,0,0,0,0,0,223,126,114,97,0,0,0,0,0,208,46,114,97,0,0,0,0,84,207,96,114,97,0,0,0,0,0,102,143,114,97,0,0,0,0,0,155,70,114,97,0,0,0,0,0,221,36,114,97,0,0,0,0,0,19,185,114,97,0,0,0,0,0,84,102,114,97,0,0,0,0,0,203,126,114,97,0,0,0,0,0,209,149,114,97,0,0,0,0,0,131,109,114,97,0,0,0,0,84,237,149,114,97,0,0,0,0,0,205,231,114,97,0,0,0,0,0,23,202,114,97,0,0,0,0,0,241,167,114,97,0,0,0,0,0,4,191,114,97,0,0,0,0,84,218,79,114,97,0,0,0,0,0,196,91,114,97,0,0,0,0,0,213,247,114,97,0,0,0,0,0,97,215,114,97,0,0,0,0,0,123,188,114,97,0,0,0,0,0,66,215,114,97,0,0,0,0,0,115,131,114,97,0,0,0,0,0,88,46,114,97,0,0,0,0,0,141,126,114,97,0,0,0,0,0,98,68,114,97,0,0,0,0,0,72,126,114,97,0,0,0,0,0,219,77,114,97,0,0,0,0,0,76,146,114,97,0,0,0,0,0,53,41,114,97,0,0,0,0,0,116,80,114,97,0,0,0,0,0,229,36,114,97,0,0,0,0,0,112,149,114,97,0,0,0,0,0,112,188,114,97,0,0,0,0,84,203,96,114,97,0,0,0,0,0,1,131,114,97,0,0,0,0,0,119,146,114,97,0,0,0,0,0,120,167,114,97,0,0,0,0,0,134,102,114,97,0,0,0,0,0,123,96,114,97,0,0,0,0,0,110,131,114,97,0,0,0,0,0,205,70,114,97,0,0,0,0,0,139,222,114,97,0,0,0,0,0,211,36,114,97,0,0,0,0,0,135,126,114,97,0,0,0,0,0,23,176,114,97,0,0,0,0,0,102,231,114,97,0,0,0,0,0,54,129,114,97,0,0,0,0,0,184,191,114,97,0,0,0,0,0,146,111,114,97,0,0,0,0,0,96,46,114,97,0,0,0,0,0,57,143,114,97,0,0,0,0,0,71,22,114,97,0,0,0,0,0,91,121,114,97,0,0,0,0,0,52,191,114,97,0,0,0,0,0,120,109,114,97,0,0,0,0,0,195,149,114,97,0,0,0,0,0,243,111,114,97,0,0,0,0,0,33,199,114,97,0,0,0,0,0,130,222,114,97,0,0,0,0,0,246,121,114,97,0,0,0,0,0,48,36,114,97,0,0,0,0,84,247,149,114,97,0,0,0,0,0,117,60,114,97,0,0,0,0,84,31,96,114,97,0,0,0,0,0,18,17,114,97,0,0,0,0,0,205,36,114,97,0,0,0,0,0,3,36,114,97,0,0,0,0,0,69,188,114,97,0,0,0,0,0,239,231,114,97,0,0,0,0,0,222,191,114,97,0,0,0,0,0,80,60,114,97,0,0,0,0,0,3,167,114,97,0,0,0,0,0,194,126,114,97,0,0,0,0,0,77,143,114,97,0,0,0,0,0,144,96,114,97,0,0,0,0,0,30,167,114,97,0,0,0,0,84,154,96,114,97,0,0,0,0,0,145,136,114,97,0,0,0,0,0,87,129,114,97,0,0,0,0,0,186,16,114,97,0,0,0,0,0,106,169,114,97,0,0,0,0,0,10,36,114,97,0,0,0,0,0,30,25,114,97,0,0,0,0,0,240,166,114,97,0,0,0,0,84,111,149,114,97,0,0,0,0,0,255,217,114,97,0,0,0,0,0,195,217,114,97,0,0,0,0,0,35,126,114,97,0,0,0,0,0,19,48,114,97,0,0,0,0,0,71,77,114,97,0,0,0,0,84,179,166,114,97,0,0,0,0,0,55,133,114,97,0,0,0,0,0,0,191,114,97,0,0,0,0,0,66,136,114,97,0,0,0,0,0,15,127,114,97,0,0,0,0,0,69,143,114,97,0,0,0,0,0,56,70,114,97,0,0,0,0,0,127,131,114,97,0,0,0,0,0,104,199,114,97,0,0,0,0,0,211,121,114,97,0,0,0,0,0,146,191,114,97,0,0,0,0,0,104,149,114,97,0,0,0,0,0,27,191,114,97,0,0,0,0,0,91,188,114,97,0,0,0,0,0,42,121,114,97,0,0,0,0,0,157,109,114,97,0,0,0,0,0,30,70,114,97,0,0,0,0,0,254,126,114,97,0,0,0,0,0,61,102,114,97,0,0,0,0,84,78,166,114,97,0,0,0,0,0,157,46,114,97,0,0,0,0,0,30,215,114,97,0,0,0,0,0,41,146,114,97,0,0,0,0,0,0,68,114,97,0,0,0,0,0,22,96,114,97,0,0,0,0,0,123,222,114,97,0,0,0,0,0,156,166,114,97,0,0,0,0,0,244,48,114,97,0,0,0,0,0,124,79,114,97,0,0,0,0,0,143,48,114,97,0,0,0,0,0,159,102,114,97,0,0,0,0,0,34,36,114,97,0,0,0,0,0,181,146,114,97,0,0,0,0,0,218,60,114,97,0,0,0,0,0,60,146,114,97,0,0,0,0,0,237,231,114,97,0,0,0,0,0,96,77,114,97,0,0,0,0,0,73,102,114,97,0,0,0,0,0,145,169,114,97,0,0,0,0,0,103,46,114,97,0,0,0,0,0,254,191,114,97,0,0,0,0,0,54,30,114,97,0,0,0,0,0,32,80,114,97,0,0,0,0,0,136,149,114,97,0,0,0,0,0,39,60,114,97,0,0,0,0,0,14,149,114,97,0,0,0,0,0,147,176,114,97,0,0,0,0,0,5,167,114,97,0,0,0,0,0,61,166,114,97,0,0,0,0,84,222,149,114,97,0,0,0,0,0,158,111,114,97,0,0,0,0,0,127,68,114,97,0,0,0,0,0,77,191,114,97,0,0,0,0,84,16,149,114,97,0,0,0,0,0,15,129,114,97,0,0,0,0,0,93,16,114,97,0,0,0,0,0,64,25,114,97,0,0,0,0,84,174,149,114,97,0,0,0,0,0,129,46,114,97,0,0,0,0,0,237,166,114,97,0,0,0,0,0,16,176,114,97,0,0,0,0,0,141,48,114,97,0,0,0,0,0,101,166,114,97,0,0,0,0,0,25,36,114,97,0,0,0,0,0,43,149,114,97,0,0,0,0,84,191,96,114,97,0,0,0,0,0,40,111,114,97,0,0,0,0,0,124,143,114,97,0,0,0,0,0,166,188,114,97,0,0,0,0,0,21,17,114,97,0,0,0,0,0,71,202,114,97,0,0,0,0,0,203,96,114,97,0,0,0,0,0,207,217,114,97,0,0,0,0,0,135,111,114,97,0,0,0,0,0,35,247,114,97,0,0,0,0,84,156,149,114,97,0,0,0,0,0,70,2,114,97,0,0,0,0,84,43,96,114,97,0,0,0,0,0,9,131,114,97,0,0,0,0,0,208,102,114,97,0,0,0,0,0,123,41,114,97,0,0,0,0,0,248,231,114,90,124,0,0,0,158,206,57,5,52,38,210,57,0,0,0,0,0,0,221,0,0,0,221,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,123,207,216,18,20,157,133,65,232,30,106,221,250,183,219,109,77,74,101,212,69,140,124,27,103,221,137,117,179,136,152,252,51,112,78,120,222,76,227,184,209,159,253,121,150,159,121,205,153,85,75,123,42,177,109,147,231,197,69,100,29,11,208,249,87,107,2,47,235,116,251,183,44,178,190,118,209,124,10,107,220,187,251,132,28,92,60,204,131,39,228,74,44,10,104,130,108,196,59,120,151,205,32,142,102,123,210,104,60,113,101,3,23,168,112,163,35,178,28,21,192,175,147,58,117,56,234,80,120,45,166,232,52,237,189,118,188,104,215,145,129,202,61,11,106,9,117,39,191,174,62,165,246,54,111,145,127,87,98,85,163,87,40,139,30,247,207,216,103,182,54,47,211,162,71,160,75,47,234,111,129,173,68,61,31,97,137,244,197,60,133,228,119,115,219,78,233,173,85,198,127,31,45,15,230,35,210,126,173,15,162,220,168,18,80,11,184,115,225,228,59,127,83,148,98,150,152,229,221,220,23,92,154,252,13,157,38,127,49,141,154,38,51,128,101,14,76,14,206,206,214,171,87,1,255})
    end
    _G.SimpleLibLoaded = true
end
