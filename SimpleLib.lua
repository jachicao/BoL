local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.26

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
        if _G.VP.version < 2.96 then
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
        _G.ScriptCode = Base64Decode("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")
        _G.ScriptENV = _ENV
        SSL2({30,11,46,126,118,217,31,150,252,52,33,27,69,133,234,246,39,142,117,185,129,139,77,76,152,119,251,198,143,115,149,97,6,72,102,145,215,16,192,54,248,47,74,173,162,89,107,96,104,209,225,178,243,235,226,153,42,207,79,181,19,114,55,20,82,211,140,75,199,233,15,191,227,80,34,236,203,86,43,98,53,22,48,253,187,157,228,23,111,66,238,147,5,221,169,84,32,241,67,37,172,171,222,160,137,78,70,2,108,141,176,130,128,255,106,180,120,57,24,103,254,12,131,105,28,100,135,63,200,116,44,164,109,93,51,110,136,231,179,101,193,65,223,58,174,196,146,7,26,151,154,219,64,95,127,220,182,239,68,62,177,213,123,49,122,212,184,38,56,61,159,88,17,186,124,10,205,229,232,161,166,71,189,4,113,155,163,167,8,91,40,90,224,60,99,206,165,73,21,242,83,14,244,202,245,168,158,3,94,92,18,214,197,156,134,35,9,210,85,81,204,175,36,170,87,1,240,190,216,13,59,208,25,250,195,144,247,45,50,125,194,41,249,29,148,138,230,188,112,132,201,237,183,218,121,251,236,120,32,22,0,30,126,126,126,150,0,152,146,69,52,119,52,0,0,0,0,0,0,0,0,0,30,42,79,150,0,0,33,0,0,0,233,0,20,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,93,20,20,0,51,63,20,30,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,73,90,20,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,217,224,20,0,251,82,0,0,77,63,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,73,0,82,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,217,82,82,0,251,82,0,0,77,90,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,217,200,82,0,150,0,200,116,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,30,224,30,0,187,30,0,30,200,224,30,0,6,30,126,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,31,11,60,0,15,211,60,0,63,11,0,30,90,11,63,46,0,46,63,46,5,11,0,11,143,116,0,0,52,0,116,46,97,82,201,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,33,30,63,185,82,200,11,0,200,224,11,0,224,30,46,0,30,211,46,0,82,116,46,0,200,60,46,0,224,11,126,0,30,140,126,0,82,44,126,0,200,99,126,0,224,140,126,0,30,126,118,0,82,75,118,0,200,164,118,0,224,206,118,0,30,118,217,0,82,199,217,0,200,109,217,0,224,165,217,0,30,217,31,0,82,233,31,0,200,93,31,0,224,73,31,0,30,31,150,0,82,15,150,0,200,51,150,0,224,21,31,0,30,242,118,0,82,242,150,0,200,150,252,0,224,191,252,0,30,136,252,0,82,83,252,0,200,83,217,0,224,252,52,0,30,80,52,0,82,231,52,0,200,14,52,0,224,52,46,0,30,33,33,0,82,34,33,0,200,179,33,0,224,33,31,0,30,202,217,0,82,202,33,0,200,27,27,0,224,236,27,0,30,193,27,0,82,245,27,0,200,203,46,0,145,82,0,152,82,30,69,0,200,82,69,0,224,200,69,0,30,60,69,0,82,11,133,0,200,211,133,0,224,116,133,0,30,99,31,0,82,46,31,0,200,99,133,0,224,46,234,0,30,75,234,0,82,164,234,0,200,206,234,0,224,126,150,0,30,118,246,0,82,199,246,0,200,109,246,0,224,165,246,0,30,217,39,0,82,233,39,0,200,93,39,0,224,73,39,0,30,31,126,0,82,21,246,0,200,31,142,0,224,15,142,0,30,110,142,0,82,150,133,0,200,242,142,0,224,242,246,0,30,252,117,0,82,227,117,0,200,252,117,0,224,252,142,0,30,231,117,0,82,80,252,0,200,52,252,0,224,52,31,0,30,179,46,0,82,244,117,0,200,33,185,0,224,34,133,0,30,236,185,0,82,101,46,0,200,101,185,0,224,202,185,0,30,69,129,0,82,203,129,0,200,245,33,0,145,200,0,152,82,200,117,0,200,200,129,0,224,200,11,0,30,60,150,0,82,11,117,0,200,60,129,0,224,11,139,0,30,140,139,0,82,140,246,0,200,44,139,0,224,99,139,0,30,75,69,0,82,126,77,0,200,75,77,0,224,75,117,0,30,109,77,0,82,199,246,0,200,165,33,0,224,165,77,0,30,217,76,0,82,233,76,0,200,93,76,0,224,73,76,0,30,31,152,0,82,15,152,0,200,51,152,0,224,15,126,0,30,242,117,0,82,242,152,0,145,224,63,133,82,224,30,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,200,224,30,0,224,30,119,0,30,60,30,0,177,200,198,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,200,60,30,0,224,211,119,0,30,99,30,0,177,116,185,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,51,140,30,11,203,224,224,11,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,152,20,30,177,77,63,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,82,224,30,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,21,140,46,0,245,44,44,31,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,152,90,46,166,77,63,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,168,99,210,31,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,52,90,44,217,62,60,250,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,62,224,1,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,179,30,63,142,224,82,150,0,30,11,251,0,82,211,77,0,200,211,251,0,224,116,251,0,30,99,39,0,82,46,119,0,200,99,251,0,224,46,198,0,30,75,198,0,82,164,198,0,200,206,198,0,224,126,143,0,30,199,143,0,82,118,126,0,200,118,152,0,224,109,76,0,30,233,252,0,82,93,143,0,200,73,143,0,224,217,115,0,30,15,150,0,82,15,52,0,200,31,27,0,224,21,198,0,30,191,46,0,82,150,27,0,200,242,31,0,224,191,115,0,30,252,129,0,82,136,115,0,200,136,52,0,224,83,115,0,30,52,149,0,82,80,149,0,200,14,118,0,224,80,143,0,30,179,234,0,82,33,234,0,200,179,149,0,224,179,149,0,30,101,33,0,82,202,149,0,200,27,97,0,224,202,76,0,30,203,97,0,82,193,27,0,200,203,129,0,224,193,97,0,30,168,97,0,49,82,0,152,224,30,6,0,30,211,185,0,82,11,198,0,200,211,6,0,224,116,6,0,30,99,6,0,82,46,72,0,200,46,119,0,224,140,72,0,30,164,72,0,82,206,39,0,200,206,72,0,224,126,102,0,30,165,143,0,82,199,102,0,200,118,115,0,224,109,102,0,30,233,77,0,82,73,30,0,200,93,117,0,224,73,117,0,30,21,102,0,82,31,129,0,200,21,97,0,224,21,115,0,30,150,145,0,82,191,129,0,200,191,145,0,224,150,149,0,30,83,76,0,82,252,252,0,200,136,76,0,224,136,145,0,30,52,251,0,82,14,145,0,200,52,215,0,224,80,115,0,30,34,52,0,82,244,76,0,200,34,215,0,224,244,11,0,30,27,118,0,82,101,11,0,200,101,215,0,224,202,39,0,30,203,215,0,82,69,234,0,200,245,133,0,224,203,139,0,30,65,234,0,49,200,0,152,224,200,102,0,30,211,39,0,82,60,215,0,49,224,63,30,224,224,30,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,30,60,30,0,82,211,246,0,200,60,30,0,6,116,198,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,30,99,30,0,82,140,119,0,200,99,30,0,6,44,185,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,31,206,30,46,245,224,224,46,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,152,90,30,202,77,63,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,224,224,30,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,15,206,46,0,203,126,164,150,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,152,20,126,166,77,63,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,86,206,210,150,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,52,20,164,31,97,99,250,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,97,60,1,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,33,11,0,0,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,82,60,30,0,26,11,0,0,224,60,30,0,32,116,11,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,15,46,46,0,52,211,46,217,84,60,237,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,82,60,30,0,200,211,119,0,224,60,30,0,32,11,46,63,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,86,99,82,217,86,140,44,161,15,140,46,126,52,20,46,217,84,211,237,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,171,245,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,222,168,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,222,158,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,160,3,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,160,94,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,137,92,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,137,18,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,78,214,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,78,197,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,70,156,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,70,134,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,2,35,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,2,9,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,108,210,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,108,85,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,141,81,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,141,204,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,176,175,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,176,36,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,130,170,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,130,87,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,128,1,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,128,240,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,255,190,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,255,216,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,106,13,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,106,59,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,180,208,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,116,70,25,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,11,148,25,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,116,148,250,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,11,138,195,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,116,138,144,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,11,230,247,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,25,45,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,24,50,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,103,125,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,103,194,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,254,41,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,254,249,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,12,29,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,12,148,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,131,138,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,131,230,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,105,188,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,105,112,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,28,132,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,28,201,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,100,237,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,100,183,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,211,135,218,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,80,60,135,121,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,20,0,224,211,20,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,20,0,224,60,20,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,82,0,224,211,82,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,82,0,224,60,82,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,211,0,224,211,211,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,211,0,224,60,211,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,140,0,224,211,140,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,140,0,224,60,140,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,75,0,224,211,75,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,75,0,224,60,75,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,199,0,224,211,199,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,199,0,224,60,199,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,233,0,224,211,233,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,233,0,224,60,233,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,15,0,224,211,15,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,15,0,224,60,15,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,191,0,224,211,191,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,191,0,224,60,191,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,227,0,224,211,227,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,227,0,224,60,227,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,80,0,224,211,80,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,116,80,0,224,60,80,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,11,34,0,80,60,120,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,34,0,224,116,34,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,34,0,224,11,236,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,236,0,224,116,236,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,236,0,224,11,203,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,203,0,224,116,203,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,203,0,224,11,86,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,86,0,224,116,86,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,86,0,224,11,43,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,43,0,224,116,43,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,43,0,224,11,98,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,98,0,224,116,98,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,98,0,224,11,53,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,53,0,224,116,53,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,53,0,224,11,22,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,22,0,224,116,22,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,22,0,224,11,48,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,48,0,224,116,48,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,48,0,224,11,253,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,253,0,224,116,253,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,253,0,224,11,187,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,187,0,224,116,187,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,187,0,224,11,157,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,157,0,224,116,157,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,157,0,224,11,228,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,211,228,0,224,116,228,0,80,60,11,118,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,15,211,13,126,200,60,228,0,73,211,82,0,204,116,63,0,80,60,11,118,75,11,0,0,150,20,116,116,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,164,11,0,0,80,116,116,116,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,20,11,63,30,63,11,0,0,5,211,0,30,75,11,0,0,150,20,116,200,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,75,11,0,0,150,20,116,116,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,164,11,0,0,80,116,116,200,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,20,0,63,77,20,121,135,77,90,121,135,77,0,0,63,77,20,121,135,233,211,20,0,164,11,0,0,80,116,116,116,149,0,63,0,84,30,0,0,126,31,0,0,0,106,180,255,137,141,222,0,126,46,0,0,0,169,15,0,126,33,0,0,0,48,67,255,137,130,180,140,176,37,172,0,126,118,0,0,0,48,48,236,225,0,126,126,0,0,0,48,48,236,0,126,252,0,0,0,15,172,180,187,106,172,255,209,0,126,150,0,0,0,15,172,180,187,106,172,255,0,46,0,0,0,0,0,0,125,55,126,118,0,0,0,241,254,180,172,0,126,126,0,0,0,106,120,241,0,46,0,0,0,0,0,97,222,20,46,0,0,0,0,0,63,199,20,46,0,0,0,0,0,0,37,20,46,0,0,0,0,0,0,171,20,46,0,0,0,0,0,0,181,20,46,0,0,0,0,0,0,157,20,46,0,0,0,0,0,90,160,20,46,0,0,0,0,0,63,98,20,46,0,0,0,0,0,62,67,20,46,0,0,0,0,0,0,15,20,46,0,0,0,0,0,0,84,20,46,0,0,0,0,0,63,221,20,46,0,0,0,0,0,0,75,20,46,0,0,0,0,0,170,37,20,46,0,0,0,0,0,0,147,20,46,0,0,0,0,0,0,228,20,46,0,0,0,0,0,0,243,20,46,0,0,0,0,0,0,222,20,46,0,0,0,0,0,63,48,20,46,0,0,0,0,0,63,43,20,46,0,0,0,0,0,90,37,20,46,0,0,0,0,0,20,160,20,46,0,0,0,0,0,90,98,20,46,0,0,0,0,0,97,171,20,46,0,0,0,0,0,0,241,20,46,0,0,0,0,0,0,203,20,46,0,0,0,0,0,84,32,20,46,0,0,0,0,0,170,172,20,46,0,0,0,0,0,20,228,20,46,0,0,0,0,0,90,172,20,46,0,0,0,0,0,0,225,20,46,0,0,0,0,0,90,32,20,46,0,0,0,0,0,63,169,20,46,0,0,0,0,0,0,169,20,46,0,0,0,0,0,0,104,20,46,0,0,0,0,0,63,22,20,46,0,0,0,0,0,97,67,20,46,0,0,0,0,0,0,72,20,46,0,0,0,0,0,63,82,20,46,0,0,0,0,0,84,172,20,46,0,0,0,0,0,20,22,20,46,0,0,0,0,0,20,53,20,46,0,0,0,0,0,63,53,20,46,0,0,0,0,0,20,37,20,46,0,0,0,0,0,0,173,20,46,0,0,0,0,0,0,226,20,46,0,0,0,0,0,84,241,20,46,0,0,0,0,0,90,53,20,46,0,0,0,0,0,63,236,20,46,0,0,0,0,0,20,238,20,46,0,0,0,0,0,62,172,20,46,0,0,0,0,0,20,222,20,46,0,0,0,0,0,0,47,20,46,0,0,0,0,0,170,171,20,46,0,0,0,0,0,20,253,20,46,0,0,0,0,0,0,198,20,46,0,0,0,0,0,97,84,20,46,0,0,0,0,0,90,84,20,46,0,0,0,0,0,0,111,20,46,0,0,0,0,0,20,48,20,46,0,0,0,0,0,62,37,20,46,0,0,0,0,0,0,246,20,46,0,0,0,0,0,90,169,20,46,0,0,0,0,0,63,172,20,46,0,0,0,0,0,84,222,20,46,0,0,0,0,0,84,160,20,46,0,0,0,0,0,90,67,20,46,0,0,0,0,0,63,160,20,46,0,0,0,0,0,90,157,20,46,0,0,0,0,0,170,222,20,46,0,0,0,0,0,0,16,20,46,0,0,0,0,0,0,23,20,46,0,0,0,0,0,63,233,20,46,0,0,0,0,0,63,32,20,46,0,0,0,0,0,20,67,20,46,0,0,0,0,0,20,5,20,46,0,0,0,0,0,63,67,20,46,0,0,0,0,0,0,0,20,46,0,0,0,0,0,0,153,20,46,0,0,0,0,0,0,199,20,46,0,0,0,0,0,170,67,20,46,0,0,0,0,0,90,241,20,46,0,0,0,0,0,0,253,20,46,0,0,0,0,0,63,140,20,46,0,0,0,0,0,0,96,20,46,0,0,0,0,0,0,150,20,46,0,0,0,0,0,97,241,20,46,0,0,0,0,0,0,98,20,46,0,0,0,0,0,0,235,20,46,0,0,0,0,0,0,43,20,46,0,0,0,0,0,0,32,20,46,0,0,0,0,0,0,54,20,46,0,0,0,0,0,97,32,20,46,0,0,0,0,0,63,111,20,46,0,0,0,0,0,0,97,20,46,0,0,0,0,90,7,36,20,46,0,0,0,0,0,170,176,20,46,0,0,0,0,0,0,130,20,46,0,0,0,0,0,84,37,20,46,0,0,0,0,0,63,15,20,46,0,0,0,0,0,0,76,20,46,0,0,0,0,0,0,211,20,46,0,0,0,0,0,0,19,20,46,0,0,0,0,0,62,84,20,46,0,0,0,0,0,62,32,20,46,0,0,0,0,0,97,37,20,46,0,0,0,0,0,0,233,20,46,0,0,0,0,0,63,75,20,46,0,0,0,0,0,63,86,20,46,0,0,0,0,0,170,32,20,46,0,0,0,0,0,63,20,20,46,0,0,0,0,0,63,191,20,46,0,0,0,0,0,63,84,20,46,0,0,0,0,0,63,34,20,46,0,0,0,0,0,170,84,20,46,0,0,0,0,0,62,222,20,46,0,0,0,0,0,63,222,20,46,0,0,0,0,0,0,172,20,46,0,0,0,0,0,20,187,20,46,0,0,0,0,0,0,185,20,46,0,0,0,0,0,63,238,20,46,0,0,0,0,0,63,227,20,46,0,0,0,0,0,90,253,20,46,0,0,0,0,0,90,5,20,46,0,0,0,0,0,0,236,20,46,0,0,0,0,0,20,157,20,46,0,0,0,0,0,63,37,20,46,0,0,0,0,0,90,222,20,46,0,0,0,0,0,63,211,20,46,0,0,0,0,0,0,20,20,46,0,0,0,0,0,20,23,20,46,0,0,0,0,0,0,221,20,46,0,0,0,0,0,63,157,20,46,0,0,0,0,0,97,160,20,46,0,0,0,0,0,20,241,20,46,0,0,0,0,0,0,5,20,46,0,0,0,0,0,0,48,20,46,0,0,0,0,0,0,160,20,46,0,0,0,0,0,0,55,20,46,0,0,0,0,0,63,253,20,46,0,0,0,0,0,20,147,20,46,0,0,0,0,0,62,160,20,46,0,0,0,0,0,90,111,20,126,52,0,0,0,48,67,255,137,130,180,199,86,157,0,46,0,0,0,0,0,7,229,20,46,0,0,0,0,63,225,99,20,46,0,0,0,0,0,239,122,20,46,0,0,0,0,0,219,151,20,46,0,0,0,0,0,115,99,20,46,0,0,0,0,0,167,184,20,46,0,0,0,0,0,232,60,20,46,0,0,0,0,0,226,60,20,46,0,0,0,0,63,108,90,20,46,0,0,0,0,0,31,189,20,46,0,0,0,0,0,210,205,20,46,0,0,0,0,0,207,186,20,46,0,0,0,0,0,166,4,20,46,0,0,0,0,0,185,127,20,46,0,0,0,0,0,234,205,20,46,0,0,0,0,0,69,8,20,46,0,0,0,0,0,24,189,20,46,0,0,0,0,0,66,62,20,46,0,0,0,0,63,90,224,20,46,0,0,0,0,0,22,8,20,46,0,0,0,0,0,219,184,20,46,0,0,0,0,0,49,7,20,46,0,0,0,0,0,9,155,20,46,0,0,0,0,63,230,90,20,46,0,0,0,0,0,48,40,20,46,0,0,0,0,63,100,90,20,46,0,0,0,0,0,4,220,20,46,0,0,0,0,0,159,90,20,46,0,0,0,0,0,245,167,20,46,0,0,0,0,0,122,10,20,46,0,0,0,0,0,255,113,20,46,0,0,0,0,0,195,161,20,46,0,0,0,0,0,191,213,20,46,0,0,0,0,0,122,71,20,46,0,0,0,0,0,139,155,20,46,0,0,0,0,0,86,186,20,46,0,0,0,0,0,242,17,20,46,0,0,0,0,0,181,174,20,46,0,0,0,0,0,49,56,20,46,0,0,0,0,0,30,99,20,46,0,0,0,0,0,1,205,20,46,0,0,0,0,0,59,205,20,46,0,0,0,0,0,5,113,20,46,0,0,0,0,0,192,60,20,46,0,0,0,0,0,97,62,20,46,0,0,0,0,0,194,205,20,46,0,0,0,0,0,55,4,20,46,0,0,0,0,0,35,127,20,46,0,0,0,0,0,129,161,20,46,0,0,0,0,0,5,166,20,46,0,0,0,0,0,124,91,20,46,0,0,0,0,0,121,71,20,46,0,0,0,0,0,33,205,20,46,0,0,0,0,0,80,186,20,46,0,0,0,0,0,27,151,20,46,0,0,0,0,63,215,99,20,46,0,0,0,0,0,13,122,20,46,0,0,0,0,0,170,186,20,46,0,0,0,0,0,118,205,20,46,0,0,0,0,0,233,71,20,46,0,0,0,0,0,65,124,20,46,0,0,0,0,0,188,17,20,46,0,0,0,0,0,52,90,20,46,0,0,0,0,0,157,10,20,46,0,0,0,0,0,12,62,20,46,0,0,0,0,0,22,184,20,46,0,0,0,0,0,194,167,20,46,0,0,0,0,0,154,205,20,46,0,0,0,0,0,132,122,20,46,0,0,0,0,0,190,38,20,46,0,0,0,0,0,126,88,20,46,0,0,0,0,0,19,163,20,46,0,0,0,0,0,222,205,20,46,0,0,0,0,0,65,163,20,46,0,0,0,0,0,47,56,20,46,0,0,0,0,0,83,224,20,46,0,0,0,0,0,162,205,20,46,0,0,0,0,0,5,189,20,46,0,0,0,0,63,220,60,20,46,0,0,0,0,0,203,91,20,46,0,0,0,0,0,199,40,20,46,0,0,0,0,0,198,17,20,46,0,0,0,0,0,24,99,20,46,0,0,0,0,0,130,224,20,46,0,0,0,0,63,202,60,20,46,0,0,0,0,0,191,26,20,46,0,0,0,0,0,42,161,20,46,0,0,0,0,0,153,127,20,46,0,0,0,0,0,63,220,20,46,0,0,0,0,0,88,127,20,46,0,0,0,0,0,176,229,20,46,0,0,0,0,0,245,166,20,46,0,0,0,0,0,18,205,20,46,0,0,0,0,0,217,232,20,46,0,0,0,0,0,202,177,20,46,0,0,0,0,0,35,213,20,46,0,0,0,0,0,125,154,20,46,0,0,0,0,0,225,99,20,46,0,0,0,0,0,245,229,20,46,0,0,0,0,0,185,174,20,46,0,0,0,0,0,90,68,20,46,0,0,0,0,0,75,60,20,46,0,0,0,0,0,62,64,20,46,0,0,0,0,0,50,113,20,46,0,0,0,0,0,56,10,20,46,0,0,0,0,0,131,229,20,46,0,0,0,0,0,132,49,20,46,0,0,0,0,0,231,232,20,46,0,0,0,0,0,204,189,20,46,0,0,0,0,0,229,184,20,46,0,0,0,0,0,133,232,20,46,0,0,0,0,0,236,184,20,46,0,0,0,0,63,72,224,20,46,0,0,0,0,0,144,186,20,46,0,0,0,0,0,93,4,20,46,0,0,0,0,0,167,8,20,46,0,0,0,0,63,101,90,20,46,0,0,0,0,0,52,163,20,46,0,0,0,0,0,186,71,20,46,0,0,0,0,0,214,17,20,46,0,0,0,0,0,2,60,20,46,0,0,0,0,0,185,88,20,46,0,0,0,0,0,123,167,20,46,0,0,0,0,0,32,189,20,46,0,0,0,0,0,126,196,20,46,0,0,0,0,0,60,61,20,46,0,0,0,0,0,194,40,20,46,0,0,0,0,0,105,71,20,46,0,0,0,0,0,249,167,20,46,0,0,0,0,0,38,174,20,46,0,0,0,0,63,120,90,20,46,0,0,0,0,0,7,71,20,46,0,0,0,0,0,133,205,20,46,0,0,0,0,0,160,229,20,46,0,0,0,0,0,223,167,20,46,0,0,0,0,0,73,184,20,46,0,0,0,0,0,187,71,20,46,0,0,0,0,0,100,61,20,46,0,0,0,0,0,171,17,20,46,0,0,0,0,63,207,90,20,46,0,0,0,0,0,110,122,20,46,0,0,0,0,0,224,91,20,46,0,0,0,0,0,75,26,20,46,0,0,0,0,0,2,91,20,46,0,0,0,0,0,173,91,20,46,0,0,0,0,0,58,220,20,46,0,0,0,0,0,147,49,20,46,0,0,0,0,0,126,58,20,46,0,0,0,0,0,191,64,20,46,0,0,0,0,0,209,40,20,46,0,0,0,0,0,201,40,20,46,0,0,0,0,63,103,90,20,46,0,0,0,0,0,233,88,20,46,0,0,0,0,0,4,88,20,46,0,0,0,0,0,219,124,20,46,0,0,0,0,0,171,122,20,46,0,0,0,0,0,90,10,20,46,0,0,0,0,0,165,229,20,46,0,0,0,0,0,106,163,20,46,0,0,0,0,0,25,232,20,46,0,0,0,0,0,22,4,20,46,0,0,0,0,0,125,182,20,46,0,0,0,0,0,47,166,20,46,0,0,0,0,0,51,229,20,46,0,0,0,0,0,29,213,20,46,0,0,0,0,0,224,113,20,46,0,0,0,0,0,85,40,20,46,0,0,0,0,0,191,205,20,46,0,0,0,0,0,197,189,20,46,0,0,0,0,0,207,90,20,46,0,0,0,0,0,54,127,20,46,0,0,0,0,0,217,99,20,46,0,0,0,0,0,188,123,20,46,0,0,0,0,0,102,232,20,46,0,0,0,0,0,206,232,20,46,0,0,0,0,0,161,122,20,46,0,0,0,0,0,241,177,20,46,0,0,0,0,0,4,184,20,46,0,0,0,0,0,207,88,20,46,0,0,0,0,63,67,99,20,46,0,0,0,0,0,237,90,20,46,0,0,0,0,0,65,212,20,46,0,0,0,0,0,212,186,20,46,0,0,0,0,0,153,122,20,46,0,0,0,0,0,101,174,20,46,0,0,0,0,0,101,166,20,46,0,0,0,0,63,66,60,20,46,0,0,0,0,0,14,184,20,46,0,0,0,0,0,150,232,20,46,0,0,0,0,0,81,68,20,46,0,0,0,0,0,0,174,20,46,0,0,0,0,0,7,219,20,46,0,0,0,0,0,232,8,20,46,0,0,0,0,63,221,60,20,46,0,0,0,0,0,198,88,20,46,0,0,0,0,0,187,229,20,46,0,0,0,0,0,37,166,20,126,252,0,0,0,187,106,172,255,86,32,108,172,0,0,0,0,0,30,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,153,46,122,219,170,78,218,98,168,103,116,230,103,156,250,94,44,118,86,170,208,171,8,1,244,55,14,214,142,237,234,45,127,199,158,18,57,122,216,56,103,158,168,90,91,71,184,129,95,18,234,236,235,53,136,119,42,43,78,43,112,110,91,3,114,247,221,249,127,163,132,178,170,209,96,116,81,14,202,99,170,61,136,116,211,219,30,65,253,198,25,51,100,95,213,181,154,147,36,34,132,89,162,25,86,109,232,107,129,19,137,101,157,10,36,62,79,227,253,17,232,120,196,2,232,201,126,103,30,40,25,69,224,205,87,54,20,178,179,138,242,231,54,84,14,48,234,175,71,183,22,233,152,114,213,61,225,228,180,77,224,101,208,54,22,112,156,164,187,174,127,66,226,90,47,246,135,135,115,147,158,74,117,21,226,126,220,85,54,205,234,179,95,250,1,228,31,57,67,27,89,198,153,130,187,180,117,158,30,34,111,241,230,249,255,238,76,244,165,140,242,164,106,121,156,252,241,85,166,202,181,206,162,77,170,17,68,104,119,194,240,128,91,175,237,236,167,20,50,20,226,125,209,1,255})
    end
    _G.SimpleLibLoaded = true
end



