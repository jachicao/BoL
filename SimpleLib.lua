local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.25

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
        if GetGameRegion():lower():find("na") or GetGameRegion():lower():find("euw") then
            if AddProcessSpellNACallback then
                AddProcessSpellNACallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
            end
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
    if GetGameRegion():lower():find("na") or GetGameRegion():lower():find("euw") then
        if AddProcessSpellNACallback then
            AddProcessSpellNACallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
        end
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
                    if GetGameRegion():lower():find("na") or GetGameRegion():lower():find("euw") then
                        if AddProcessSpellNACallback then
                            AddProcessSpellNACallback(function(unit, spell) _G.SOWi:OnProcessSpell(unit, spell) end)
                        end
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
        if GetGameRegion():lower():find("na") or GetGameRegion():lower():find("euw") then
            if AddProcessSpellNACallback then
                AddProcessSpellNACallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
            end
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
        if GetGameRegion():lower():find("na") or GetGameRegion():lower():find("euw") then
            if AddProcessSpellNACallback then
                AddProcessSpellNACallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
            end
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
        SSL2({145,184,139,237,193,57,209,129,3,236,85,203,198,17,1,180,252,189,165,66,2,29,239,167,68,31,235,142,247,30,230,64,84,95,231,123,233,176,106,90,49,190,179,53,14,33,197,242,226,39,215,9,194,245,63,115,38,146,217,26,212,126,248,88,109,77,143,136,183,175,100,82,202,103,58,96,61,7,37,118,173,19,131,101,207,75,21,25,182,16,187,42,51,174,35,133,98,67,159,62,144,86,185,15,81,158,6,246,56,249,130,141,201,152,186,48,121,206,110,94,188,195,210,120,253,34,78,220,13,116,122,70,105,80,135,156,74,104,157,41,150,170,177,91,229,128,60,244,134,44,149,73,168,227,99,46,72,234,154,50,24,102,137,79,43,192,205,89,114,117,32,151,12,251,213,204,238,178,160,199,71,69,200,8,76,214,169,243,240,119,155,83,18,22,113,107,221,196,254,97,250,5,162,59,171,23,219,111,161,228,191,153,127,54,108,52,216,20,93,147,36,211,255,222,225,132,87,223,65,28,140,163,241,138,125,112,47,11,27,4,208,232,172,164,40,148,92,181,10,124,55,45,224,218,166,235,96,121,98,19,0,145,237,237,237,129,0,68,60,198,236,31,236,0,0,0,0,0,0,0,0,0,145,38,100,129,0,0,85,0,0,0,175,0,88,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,80,88,88,0,135,220,88,145,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,196,83,88,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,57,18,88,0,235,109,0,0,239,220,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,196,0,109,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,57,109,109,0,235,109,0,0,239,83,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,57,13,109,0,129,0,13,116,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,145,18,145,0,207,145,0,145,13,18,145,0,84,145,237,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,209,184,22,0,100,77,22,0,220,184,0,145,83,184,220,139,0,139,220,139,51,184,0,184,247,116,0,0,236,0,116,139,64,109,55,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,85,145,220,165,109,13,184,0,13,18,184,0,18,145,139,0,145,77,139,0,109,116,139,0,13,22,139,0,18,184,237,0,145,122,139,0,109,143,237,0,13,122,237,0,18,113,237,0,145,237,193,0,109,136,193,0,13,70,193,0,18,107,193,0,145,193,57,0,109,183,57,0,13,105,57,0,18,221,57,0,145,57,209,0,109,80,57,0,13,175,209,0,18,80,209,0,145,254,209,0,109,209,129,0,13,100,129,0,18,135,129,0,145,97,129,0,109,156,237,0,13,129,3,0,18,129,237,0,145,202,3,0,109,74,3,0,13,250,3,0,18,3,236,0,145,103,236,0,109,104,236,0,13,5,236,0,18,104,237,0,145,162,237,0,109,85,85,0,13,58,85,0,18,58,237,0,145,41,85,0,109,59,85,0,13,203,193,0,18,203,203,0,145,61,203,0,109,150,203,0,13,171,193,0,123,109,0,68,109,18,203,0,13,109,3,0,18,145,198,0,145,22,193,0,109,116,203,0,13,77,198,0,18,116,198,0,145,113,198,0,109,139,17,0,13,113,129,0,18,143,17,0,145,70,17,0,109,107,3,0,13,107,17,0,18,237,1,0,145,183,1,0,109,105,1,0,13,221,1,0,18,193,180,0,145,175,180,0,109,80,180,0,13,57,57,0,18,57,1,0,145,254,57,0,109,254,180,0,13,209,252,0,18,209,237,0,145,82,252,0,109,156,252,0,13,97,252,0,18,82,209,0,145,3,189,0,109,202,189,0,13,74,189,0,18,250,189,0,145,103,203,0,109,236,165,0,13,103,165,0,18,5,57,0,145,157,165,0,109,162,189,0,13,162,165,0,18,85,66,0,145,96,66,0,109,41,66,0,13,59,66,0,18,203,209,0,145,61,236,0,109,198,2,0,13,61,2,0,123,13,0,68,109,145,165,0,13,18,209,0,18,18,17,0,145,116,2,0,109,116,209,0,13,22,2,0,18,184,29,0,145,143,29,0,109,122,29,0,13,113,29,0,18,139,239,0,145,136,239,0,109,70,239,0,123,18,220,57,109,18,145,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,13,18,145,0,18,18,239,0,145,22,145,0,24,13,142,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,13,22,145,0,18,184,167,0,145,113,145,0,24,116,66,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,135,143,145,184,61,18,18,184,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,68,88,13,204,239,220,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,109,18,145,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,254,143,139,0,23,122,122,209,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,68,220,52,209,239,220,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,171,113,52,209,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,236,83,122,57,50,22,138,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,50,18,132,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,157,145,0,66,18,18,209,0,145,184,68,0,109,77,68,0,13,116,68,0,18,116,29,0,145,113,68,0,109,139,31,0,13,143,31,0,18,143,1,0,145,70,31,0,109,107,31,0,13,70,57,0,18,237,66,0,145,193,3,0,109,193,235,0,13,105,17,0,18,183,235,0,145,196,180,0,109,80,235,0,13,57,180,0,18,196,235,0,145,254,57,0,109,209,142,0,13,100,239,0,18,100,142,0,145,156,142,0,109,97,142,0,13,97,165,0,18,82,236,0,145,250,236,0,109,202,189,0,13,250,239,0,18,3,247,0,145,104,198,0,109,103,247,0,13,104,189,0,18,104,209,0,145,58,165,0,109,157,247,0,13,162,247,0,18,85,2,0,145,96,29,0,109,203,30,0,13,41,239,0,18,203,68,0,145,61,236,0,109,150,66,0,13,171,3,0,18,171,57,0,145,7,30,0,79,109,0,68,18,13,30,0,145,22,30,0,109,184,230,0,13,77,230,0,18,77,198,0,145,122,230,0,109,113,230,0,13,139,180,0,18,139,64,0,145,107,17,0,109,237,66,0,13,107,237,0,18,107,68,0,145,105,209,0,109,193,247,0,13,193,189,0,18,193,142,0,145,57,142,0,109,175,64,0,13,175,165,0,18,80,64,0,145,254,129,0,109,254,64,0,13,209,84,0,18,254,239,0,145,129,203,0,109,82,180,0,13,82,84,0,18,156,84,0,145,250,84,0,109,250,165,0,13,202,139,0,18,3,2,0,145,103,68,0,109,236,95,0,13,103,165,0,18,103,95,0,145,58,209,0,109,157,95,0,13,58,57,0,18,85,236,0,145,96,165,0,109,59,139,0,13,96,230,0,18,203,1,0,145,61,165,0,109,150,237,0,13,171,95,0,18,198,231,0,145,7,231,0,79,13,0,68,18,18,165,0,145,116,252,0,109,77,129,0,13,116,252,0,18,116,231,0,145,143,231,0,109,122,66,0,13,113,247,0,18,139,57,0,145,107,57,0,109,70,142,0,13,237,139,0,18,70,139,0,145,193,198,0,109,193,139,0,13,221,231,0,18,193,123,0,145,175,29,0,109,175,123,0,13,196,230,0,18,80,66,0,79,18,220,236,18,18,145,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,145,22,145,0,109,22,239,0,13,22,145,0,84,116,142,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,145,113,145,0,109,139,167,0,13,113,145,0,84,122,66,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,209,107,145,139,171,18,18,139,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,68,83,145,229,239,220,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,18,18,145,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,100,107,139,0,7,237,70,129,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,68,220,52,129,239,220,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,61,107,52,129,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,236,88,70,209,64,113,138,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,64,22,132,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,237,184,0,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,109,22,145,0,13,184,167,0,18,22,145,0,98,116,1,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,235,77,0,0,239,83,184,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,209,184,139,0,239,83,193,220,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,7,113,109,57,135,139,139,0,236,220,122,57,236,0,184,57,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,237,184,0,0,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,133,22,27,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,65,250,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,65,5,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,28,162,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,28,59,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,140,171,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,140,23,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,163,219,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,163,111,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,241,161,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,241,228,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,138,191,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,138,153,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,125,127,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,125,54,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,112,108,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,112,52,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,47,216,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,47,20,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,11,93,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,11,147,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,27,36,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,27,211,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,4,255,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,4,222,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,208,225,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,208,132,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,232,87,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,232,223,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,172,65,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,172,28,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,65,140,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,48,163,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,48,241,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,121,138,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,121,125,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,206,112,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,206,47,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,110,11,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,110,27,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,94,4,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,94,208,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,188,232,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,188,172,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,195,164,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,22,195,40,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,77,210,148,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,48,92,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,45,92,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,45,181,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,224,10,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,224,124,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,218,55,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,218,45,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,184,166,224,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,103,116,166,218,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,184,88,0,103,116,116,166,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,88,0,18,116,88,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,88,0,18,184,109,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,109,0,18,116,109,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,109,0,18,184,77,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,77,0,18,116,77,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,77,0,18,184,143,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,143,0,18,116,143,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,143,0,18,184,136,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,136,0,18,116,136,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,136,0,18,184,183,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,183,0,18,116,183,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,183,0,18,184,175,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,175,0,18,116,175,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,175,0,18,184,100,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,100,0,18,116,100,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,100,0,18,184,82,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,82,0,18,116,82,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,82,0,18,184,202,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,202,0,18,116,202,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,202,0,18,184,103,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,103,0,18,116,103,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,103,0,18,184,58,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,58,0,18,116,58,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,58,0,18,184,96,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,96,0,18,116,96,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,96,0,18,184,61,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,61,0,18,116,61,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,61,0,18,184,7,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,7,0,18,116,7,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,7,0,18,184,37,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,37,0,18,116,37,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,37,0,18,184,118,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,118,0,18,116,118,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,118,0,18,184,173,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,173,0,18,116,173,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,173,0,18,184,19,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,19,0,18,116,19,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,19,0,18,184,131,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,131,0,18,116,131,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,131,0,18,184,101,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,101,0,18,116,101,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,101,0,18,184,207,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,207,0,18,116,207,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,22,207,0,18,184,75,0,103,22,184,193,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,100,116,223,237,13,77,75,0,196,77,109,0,36,116,220,0,103,22,184,193,136,184,0,0,129,88,116,116,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,70,184,0,0,103,116,116,116,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,88,184,220,145,220,184,0,0,51,77,0,145,136,184,0,0,129,88,116,13,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,136,184,0,0,129,88,116,116,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,70,184,0,0,103,116,116,13,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,88,0,220,239,88,166,78,239,83,166,78,239,0,0,220,239,88,166,78,175,77,88,0,70,184,0,0,103,116,116,116,230,0,220,0,16,145,0,0,237,209,0,0,0,186,48,152,81,249,185,0,237,139,0,0,0,35,100,0,237,85,0,0,0,131,159,152,81,141,48,143,130,62,144,0,237,193,0,0,0,131,131,96,215,0,237,237,0,0,0,131,131,96,0,237,3,0,0,0,100,144,48,207,186,144,152,39,0,237,129,0,0,0,100,144,48,207,186,144,152,0,139,0,0,0,0,0,0,4,248,237,193,0,0,0,67,188,48,144,0,237,237,0,0,0,186,121,67,0,139,0,0,0,0,0,0,180,88,139,0,0,0,0,0,88,185,88,139,0,0,0,0,0,133,86,88,139,0,0,0,0,0,0,67,88,139,0,0,0,0,0,220,143,88,139,0,0,0,0,0,0,176,88,139,0,0,0,0,0,222,98,88,139,0,0,0,0,0,0,118,88,139,0,0,0,0,0,222,15,88,139,0,0,0,0,0,0,248,88,139,0,0,0,0,0,220,51,88,139,0,0,0,0,0,64,133,88,139,0,0,0,0,0,0,187,88,139,0,0,0,0,0,0,133,88,139,0,0,0,0,0,0,35,88,139,0,0,0,0,0,0,16,88,139,0,0,0,0,0,0,62,88,139,0,0,0,0,0,220,15,88,139,0,0,0,0,0,0,129,88,139,0,0,0,0,0,220,182,88,139,0,0,0,0,0,83,25,88,139,0,0,0,0,0,50,98,88,139,0,0,0,0,0,0,21,88,139,0,0,0,0,0,64,86,88,139,0,0,0,0,0,88,174,88,139,0,0,0,0,0,50,67,88,139,0,0,0,0,0,0,64,88,139,0,0,0,0,0,0,183,88,139,0,0,0,0,0,83,159,88,139,0,0,0,0,0,88,21,88,139,0,0,0,0,0,220,144,88,139,0,0,0,0,0,50,86,88,139,0,0,0,0,0,0,217,88,139,0,0,0,0,0,133,133,88,139,0,0,0,0,0,0,81,88,139,0,0,0,0,0,83,19,88,139,0,0,0,0,0,83,207,88,139,0,0,0,0,0,0,58,88,139,0,0,0,0,0,220,42,88,139,0,0,0,0,0,0,38,88,139,0,0,0,0,0,0,42,88,139,0,0,0,0,0,88,133,88,139,0,0,0,0,0,220,61,88,139,0,0,0,0,0,0,126,88,139,0,0,0,0,0,220,77,88,139,0,0,0,0,0,220,133,88,139,0,0,0,0,0,50,15,88,139,0,0,0,0,0,220,159,88,139,0,0,0,0,0,220,98,88,139,0,0,0,0,0,220,202,88,139,0,0,0,0,0,220,100,88,139,0,0,0,0,0,0,167,88,139,0,0,0,0,0,88,16,88,139,0,0,0,0,0,220,187,88,139,0,0,0,0,0,50,185,88,139,0,0,0,0,0,83,144,88,139,0,0,0,0,0,64,159,88,139,0,0,0,0,0,220,109,88,139,0,0,0,0,0,0,63,88,139,0,0,0,0,0,220,136,88,139,0,0,0,0,0,88,98,88,139,0,0,0,0,0,88,19,88,139,0,0,0,0,0,0,75,88,139,0,0,0,0,0,0,19,88,139,0,0,0,0,0,0,25,88,139,0,0,0,0,0,222,185,88,139,0,0,0,0,0,0,142,88,139,0,0,0,0,0,0,15,88,139,0,0,0,0,0,220,67,88,139,0,0,0,0,0,220,25,88,139,0,0,0,0,0,50,159,88,139,0,0,0,0,0,0,131,88,139,0,0,0,0,0,0,136,88,139,0,0,0,0,0,0,103,88,139,0,0,0,0,0,83,118,88,139,0,0,0,0,0,220,174,88,139,0,0,0,0,0,220,88,88,139,0,0,0,0,0,88,35,88,139,0,0,0,0,0,83,16,88,139,0,0,0,0,0,88,207,88,139,0,0,0,0,0,0,144,88,139,0,0,0,0,0,0,53,88,139,0,0,0,0,0,220,175,88,139,0,0,0,0,0,220,86,88,139,0,0,0,0,0,0,185,88,139,0,0,0,0,0,0,39,88,139,0,0,0,0,83,244,255,88,139,0,0,0,0,0,88,42,88,139,0,0,0,0,0,0,0,0,139,0,0,0,0,0,0,141,88,139,0,0,0,0,0,0,190,88,139,0,0,0,0,0,88,159,88,139,0,0,0,0,0,64,67,88,139,0,0,0,0,0,88,182,88,139,0,0,0,0,0,0,226,88,139,0,0,0,0,0,220,118,88,139,0,0,0,0,0,0,95,88,139,0,0,0,0,0,64,144,88,139,0,0,0,0,0,83,62,88,139,0,0,0,0,0,0,100,88,139,0,0,0,0,0,0,96,88,139,0,0,0,0,0,0,88,88,139,0,0,0,0,0,220,207,88,139,0,0,0,0,0,88,144,88,139,0,0,0,0,0,133,185,88,139,0,0,0,0,0,0,37,88,139,0,0,0,0,0,222,133,88,139,0,0,0,0,0,83,35,88,139,0,0,0,0,0,0,90,88,139,0,0,0,0,0,64,98,88,139,0,0,0,0,0,83,133,88,139,0,0,0,0,0,50,133,88,139,0,0,0,0,0,222,86,88,139,0,0,0,0,0,88,67,88,139,0,0,0,0,0,133,98,88,139,0,0,0,0,0,133,62,88,139,0,0,0,0,0,0,7,88,139,0,0,0,0,0,0,212,88,139,0,0,0,0,0,0,207,88,139,0,0,0,0,0,83,51,88,139,0,0,0,0,0,0,159,88,139,0,0,0,0,0,222,62,88,139,0,0,0,0,0,220,82,88,139,0,0,0,0,0,88,86,88,139,0,0,0,0,0,0,146,88,139,0,0,0,0,0,133,159,88,139,0,0,0,0,0,220,35,88,139,0,0,0,0,0,88,75,88,139,0,0,0,0,0,220,21,88,139,0,0,0,0,0,0,175,88,139,0,0,0,0,0,0,202,88,139,0,0,0,0,0,88,187,88,139,0,0,0,0,0,220,103,88,139,0,0,0,0,0,0,82,88,139,0,0,0,0,0,83,98,88,139,0,0,0,0,0,83,182,88,237,236,0,0,0,131,159,152,81,141,48,183,7,75,0,139,0,0,0,0,0,227,240,88,139,0,0,0,0,220,179,18,88,139,0,0,0,0,0,59,119,88,139,0,0,0,0,0,161,169,88,139,0,0,0,0,0,103,213,88,139,0,0,0,0,0,184,102,88,139,0,0,0,0,0,78,83,88,139,0,0,0,0,220,107,22,88,139,0,0,0,0,0,117,155,88,139,0,0,0,0,0,192,151,88,139,0,0,0,0,0,116,243,88,139,0,0,0,0,0,67,69,88,139,0,0,0,0,0,103,79,88,139,0,0,0,0,0,100,119,88,139,0,0,0,0,220,236,83,88,139,0,0,0,0,0,115,102,88,139,0,0,0,0,0,236,8,88,139,0,0,0,0,0,24,243,88,139,0,0,0,0,220,129,83,88,139,0,0,0,0,0,132,117,88,139,0,0,0,0,0,244,128,88,139,0,0,0,0,220,40,18,88,139,0,0,0,0,0,144,76,88,139,0,0,0,0,0,184,137,88,139,0,0,0,0,220,101,22,88,139,0,0,0,0,0,89,177,88,139,0,0,0,0,0,42,154,88,139,0,0,0,0,0,224,199,88,139,0,0,0,0,0,193,155,88,139,0,0,0,0,220,16,83,88,139,0,0,0,0,0,242,83,88,139,0,0,0,0,0,192,200,88,139,0,0,0,0,0,4,227,88,139,0,0,0,0,0,80,117,88,139,0,0,0,0,220,180,22,88,139,0,0,0,0,0,249,200,88,139,0,0,0,0,0,27,155,88,139,0,0,0,0,220,192,83,88,139,0,0,0,0,220,39,113,88,139,0,0,0,0,0,59,168,88,139,0,0,0,0,0,91,168,88,139,0,0,0,0,0,44,160,88,139,0,0,0,0,220,105,22,88,139,0,0,0,0,0,134,240,88,139,0,0,0,0,0,80,243,88,139,0,0,0,0,0,106,169,88,139,0,0,0,0,0,48,44,88,139,0,0,0,0,0,88,50,88,139,0,0,0,0,0,255,119,88,139,0,0,0,0,0,80,214,88,139,0,0,0,0,0,67,169,88,139,0,0,0,0,0,0,73,88,139,0,0,0,0,0,199,114,88,139,0,0,0,0,0,17,243,88,139,0,0,0,0,0,70,50,88,139,0,0,0,0,0,246,238,88,139,0,0,0,0,0,73,50,88,139,0,0,0,0,0,210,155,88,139,0,0,0,0,0,101,114,88,139,0,0,0,0,0,197,71,88,139,0,0,0,0,0,168,204,88,139,0,0,0,0,0,52,244,88,139,0,0,0,0,0,186,71,88,139,0,0,0,0,0,133,8,88,139,0,0,0,0,0,252,204,88,139,0,0,0,0,0,17,114,88,139,0,0,0,0,0,11,199,88,139,0,0,0,0,0,126,24,88,139,0,0,0,0,220,99,22,88,139,0,0,0,0,0,209,155,88,139,0,0,0,0,220,93,22,88,139,0,0,0,0,220,189,113,88,139,0,0,0,0,0,217,178,88,139,0,0,0,0,0,159,71,88,139,0,0,0,0,0,162,8,88,139,0,0,0,0,0,213,238,88,139,0,0,0,0,0,251,76,88,139,0,0,0,0,220,66,83,88,139,0,0,0,0,0,214,137,88,139,0,0,0,0,0,147,8,88,139,0,0,0,0,0,21,199,88,139,0,0,0,0,0,139,113,88,139,0,0,0,0,0,24,160,88,139,0,0,0,0,0,242,128,88,139,0,0,0,0,0,64,134,88,139,0,0,0,0,0,248,113,88,139,0,0,0,0,0,133,243,88,139,0,0,0,0,0,62,22,88,139,0,0,0,0,0,245,102,88,139,0,0,0,0,0,101,8,88,139,0,0,0,0,0,178,151,88,139,0,0,0,0,0,106,18,88,139,0,0,0,0,0,49,214,88,139,0,0,0,0,220,37,22,88,139,0,0,0,0,0,106,8,88,139,0,0,0,0,220,211,22,88,139,0,0,0,0,0,13,113,88,139,0,0,0,0,0,226,155,88,139,0,0,0,0,0,116,117,88,139,0,0,0,0,0,134,76,88,139,0,0,0,0,0,138,178,88,139,0,0,0,0,0,1,169,88,139,0,0,0,0,0,223,169,88,139,0,0,0,0,0,100,240,88,139,0,0,0,0,220,159,113,88,139,0,0,0,0,0,149,240,88,139,0,0,0,0,0,220,168,88,139,0,0,0,0,0,61,71,88,139,0,0,0,0,0,163,8,88,139,0,0,0,0,0,167,83,88,139,0,0,0,0,0,143,119,88,139,0,0,0,0,0,196,119,88,139,0,0,0,0,0,70,91,88,139,0,0,0,0,0,183,238,88,139,0,0,0,0,220,212,83,88,139,0,0,0,0,0,200,204,88,139,0,0,0,0,0,204,102,88,139,0,0,0,0,0,167,113,88,139,0,0,0,0,0,33,238,88,139,0,0,0,0,220,109,83,88,139,0,0,0,0,0,26,149,88,139,0,0,0,0,0,179,238,88,139,0,0,0,0,0,90,24,88,139,0,0,0,0,0,180,79,88,139,0,0,0,0,0,76,71,88,139,0,0,0,0,0,64,99,88,139,0,0,0,0,0,197,119,88,139,0,0,0,0,0,152,214,88,139,0,0,0,0,0,178,43,88,139,0,0,0,0,0,66,154,88,139,0,0,0,0,0,66,168,88,139,0,0,0,0,0,167,119,88,139,0,0,0,0,0,216,155,88,139,0,0,0,0,0,212,119,88,139,0,0,0,0,0,250,169,88,139,0,0,0,0,220,34,22,88,139,0,0,0,0,0,13,199,88,139,0,0,0,0,0,42,119,88,139,0,0,0,0,0,119,200,88,139,0,0,0,0,0,239,169,88,139,0,0,0,0,0,199,72,88,139,0,0,0,0,0,118,22,88,139,0,0,0,0,0,48,243,88,139,0,0,0,0,0,148,8,88,139,0,0,0,0,0,218,137,88,139,0,0,0,0,0,165,200,88,139,0,0,0,0,0,53,169,88,139,0,0,0,0,0,131,178,88,139,0,0,0,0,0,113,214,88,139,0,0,0,0,0,133,151,88,139,0,0,0,0,0,141,71,88,139,0,0,0,0,0,16,113,88,139,0,0,0,0,0,118,204,88,139,0,0,0,0,0,225,200,88,139,0,0,0,0,0,89,91,88,139,0,0,0,0,220,52,18,88,139,0,0,0,0,0,67,117,88,139,0,0,0,0,220,197,18,88,139,0,0,0,0,220,179,113,88,139,0,0,0,0,0,82,32,88,139,0,0,0,0,0,175,113,88,139,0,0,0,0,0,68,178,88,139,0,0,0,0,0,88,46,88,139,0,0,0,0,220,242,22,88,139,0,0,0,0,0,95,200,88,139,0,0,0,0,0,35,199,88,139,0,0,0,0,0,62,12,88,139,0,0,0,0,0,176,137,88,139,0,0,0,0,0,125,83,88,139,0,0,0,0,0,189,114,88,139,0,0,0,0,0,6,240,88,139,0,0,0,0,0,235,169,88,139,0,0,0,0,0,128,238,88,139,0,0,0,0,0,227,213,88,139,0,0,0,0,0,243,160,88,139,0,0,0,0,0,2,113,88,139,0,0,0,0,0,26,119,88,139,0,0,0,0,0,235,113,88,139,0,0,0,0,0,12,83,88,139,0,0,0,0,0,93,18,88,139,0,0,0,0,0,160,69,88,139,0,0,0,0,0,73,199,88,139,0,0,0,0,0,56,243,88,139,0,0,0,0,0,64,114,88,139,0,0,0,0,0,208,200,88,139,0,0,0,0,0,126,238,88,139,0,0,0,0,0,163,234,88,139,0,0,0,0,0,229,69,88,139,0,0,0,0,220,160,22,88,139,0,0,0,0,0,107,24,88,139,0,0,0,0,0,83,99,88,139,0,0,0,0,0,89,205,88,139,0,0,0,0,220,197,113,88,139,0,0,0,0,0,213,243,88,139,0,0,0,0,0,174,119,88,139,0,0,0,0,0,93,178,88,139,0,0,0,0,0,174,192,88,139,0,0,0,0,0,83,79,88,237,3,0,0,0,207,186,144,152,7,98,56,144,0,0,0,0,0,145,0,0,0,145,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,122,105,89,138,43,127,75,12,250,214,119,73,155,85,91,34,66,45,191,186,124,93,40,125,101,44,97,136,20,144,140,235,146,143,90,169,43,195,198,166,82,129,32,18,82,98,95,33,82,243,120,102,72,184,170,96,69,9,2,80,127,192,11,87,168,27,227,95,244,78,220,129,103,91,120,100,100,52,200,209,239,196,168,142,130,248,36,22,2,114,69,224,151,91,41,167,217,197,215,176,177,193,207,146,61,201,70,219,84,231,107,221,167,181,225,93,90,31,110,92,230,101,70,200,39,140,200,201,170,111,246,203,228,54,185,101,182,11,34,111,4,112,146,100,137,44,83,7,171,86,87,80,94,135,172,35,110,90,236,100,199,91,90,52,60,244,49,91,65,228,252,250,126,23,106,27,247,12,146,253,28,254,81,147,196,190,86,224,226,187,192,111,193,60,250,113,126,233,161,196,95,142,218,109,154,128,173,211,220,31,149,24,70,83,103,72,234,204,202,55,114,119,224,108,41,1,48,233,18,67,33,34,182,9,7,181,70,192,31,239,200,62,11,54,26,191,146,233,128,217,181,105,86,1,255})
    end
    _G.SimpleLibLoaded = true
end



