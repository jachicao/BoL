local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.30

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
            if _G.MMA_IsLaneClearing() then
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
            if _G.MMA_IsLastHitting() then
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
        SSL2({217,200,69,221,159,160,68,67,182,185,205,196,156,45,133,220,150,53,163,89,49,188,189,187,92,134,63,41,47,242,118,10,75,111,229,44,210,141,37,207,101,235,147,167,34,213,6,106,36,173,178,55,249,52,107,26,238,12,231,246,209,157,253,27,22,15,204,117,158,154,62,3,113,14,5,138,172,171,98,108,79,214,82,129,120,222,130,35,30,65,224,144,39,56,11,64,50,190,61,77,43,227,212,73,91,81,201,142,164,76,151,19,38,96,155,86,234,166,194,42,122,195,135,202,90,109,170,125,180,57,20,66,4,225,175,72,206,137,40,123,191,102,100,251,32,236,51,59,243,23,71,162,254,78,211,97,114,25,119,161,247,218,33,88,126,16,228,87,80,241,46,149,128,148,7,244,8,165,21,239,54,146,143,29,110,169,115,121,9,203,31,240,116,112,232,127,215,223,252,248,13,58,17,199,174,181,153,70,83,136,24,95,237,124,250,226,186,193,1,208,74,93,99,60,2,219,105,179,184,28,183,84,152,104,139,131,168,230,132,198,216,255,18,197,145,48,103,176,245,94,140,233,192,177,85,63,138,234,50,214,0,217,221,221,221,67,0,92,51,156,185,134,185,0,0,0,0,0,0,0,0,0,217,12,212,67,0,0,205,0,0,0,154,0,27,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,225,27,27,0,175,125,27,217,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,223,240,27,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,160,116,27,0,63,22,0,0,189,125,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,223,0,22,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,160,22,22,0,63,22,0,0,189,240,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,160,180,22,0,67,0,180,57,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,217,116,217,0,120,217,0,217,180,116,217,0,75,217,221,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,68,200,112,0,62,15,112,0,125,200,0,217,240,200,125,69,0,69,125,69,39,200,0,200,47,57,0,0,185,0,57,69,10,22,140,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,205,217,0,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,22,116,217,0,243,217,0,0,116,116,217,0,50,180,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,62,200,200,0,185,22,200,221,64,116,233,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,22,116,217,0,180,180,200,0,116,116,217,0,50,217,69,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,171,112,22,221,171,15,200,4,62,15,200,200,185,27,200,221,64,22,233,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,5,217,0,89,180,116,200,0,116,217,69,0,217,15,69,0,22,57,69,0,180,112,69,0,116,200,221,0,217,204,221,0,22,20,221,0,180,232,221,0,116,69,159,0,217,117,159,0,22,66,159,0,180,127,159,0,116,221,160,0,217,158,160,0,22,158,159,0,180,4,160,0,116,215,160,0,217,160,68,0,22,154,68,0,180,225,68,0,116,223,68,0,217,68,67,0,22,62,67,0,180,175,67,0,116,252,67,0,217,67,182,0,22,248,67,0,180,3,182,0,116,72,182,0,217,13,182,0,22,182,185,0,180,113,185,0,116,206,185,0,217,58,185,0,22,137,185,0,180,185,205,0,116,14,205,0,217,40,205,0,22,17,205,0,180,205,196,0,116,5,196,0,217,123,196,0,22,123,159,0,180,199,196,0,116,196,156,0,217,172,156,0,22,172,69,0,180,191,156,0,116,174,156,0,77,22,0,92,180,217,45,0,116,22,45,0,217,57,45,0,22,112,45,0,180,200,133,0,116,15,133,0,217,69,133,0,22,204,196,0,180,20,133,0,116,232,133,0,217,221,220,0,22,117,220,0,180,66,220,0,116,127,220,0,217,159,150,0,22,158,150,0,180,4,150,0,116,215,150,0,217,160,53,0,22,154,53,0,180,225,53,0,116,223,53,0,217,68,163,0,22,62,163,0,180,175,163,0,116,68,68,0,217,72,156,0,22,248,163,0,180,67,156,0,116,67,89,0,217,113,89,0,22,206,89,0,180,13,89,0,116,182,49,0,217,137,150,0,22,14,49,0,180,137,49,0,116,14,185,0,217,17,49,0,22,205,188,0,180,40,53,0,116,5,188,0,217,196,89,0,22,123,188,0,180,199,188,0,116,196,189,0,217,172,49,0,22,172,189,0,180,174,156,0,116,191,189,0,77,180,0,92,180,217,221,0,116,116,189,0,217,200,187,0,22,112,68,0,180,15,187,0,116,57,187,0,217,20,69,0,22,232,187,0,180,232,189,0,116,69,92,0,217,117,92,0,22,66,92,0,180,127,205,0,116,66,49,0,217,4,49,0,22,215,185,0,180,215,92,0,116,159,134,0,217,154,134,0,22,225,134,0,180,223,134,0,116,160,63,0,217,175,45,0,77,116,125,205,180,116,217,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,116,116,217,0,217,15,63,0,22,112,217,0,2,180,41,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,116,112,217,0,217,20,200,0,22,232,217,0,2,57,89,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,252,20,180,200,191,116,22,69,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,92,125,180,71,189,125,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,180,116,217,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,68,66,69,0,156,127,69,67,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,92,0,221,143,189,125,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,45,127,224,67,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,185,0,221,68,60,112,104,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,60,116,219,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,17,217,125,89,217,112,200,0,22,200,182,0,180,200,41,0,116,15,156,0,217,204,41,0,22,20,41,0,180,232,41,0,116,204,187,0,217,66,45,0,22,127,150,0,180,66,188,0,116,221,134,0,217,159,47,0,22,4,69,0,180,159,182,0,116,158,47,0,217,154,92,0,22,225,47,0,180,160,220,0,116,223,47,0,217,68,156,0,22,68,163,0,180,68,185,0,116,68,242,0,217,3,242,0,22,72,242,0,180,72,49,0,116,248,242,0,217,182,118,0,22,113,118,0,180,206,49,0,116,206,118,0,217,58,118,0,22,185,10,0,180,14,10,0,116,14,163,0,217,205,150,0,22,40,10,0,180,17,10,0,116,205,75,0,217,123,160,0,22,196,205,0,180,196,182,0,116,138,75,0,217,174,92,0,22,191,75,0,180,174,92,0,116,174,75,0,217,45,49,0,22,45,111,0,179,22,0,92,217,112,188,0,22,112,47,0,180,112,69,0,116,57,196,0,217,69,134,0,22,204,111,0,180,20,68,0,116,20,67,0,217,127,220,0,22,117,68,0,180,66,111,0,116,66,53,0,217,158,221,0,22,215,111,0,180,159,229,0,116,158,229,0,217,154,189,0,22,225,229,0,180,223,229,0,116,225,134,0,217,252,185,0,22,68,44,0,180,62,44,0,116,68,160,0,217,72,44,0,22,72,41,0,180,248,44,0,116,67,67,0,217,113,111,0,22,13,229,0,180,182,210,0,116,113,150,0,217,14,159,0,22,58,134,0,180,137,89,0,116,137,133,0,217,40,189,0,22,17,156,0,180,5,210,0,116,17,229,0,217,199,205,0,22,123,159,0,180,123,69,0,116,123,75,0,217,156,41,0,22,172,53,0,180,156,160,0,116,172,163,0,217,171,189,0,22,102,210,0,179,180,0,92,217,112,210,0,22,200,133,0,180,57,45,0,116,57,45,0,217,69,133,0,22,232,160,0,180,69,141,0,116,20,92,0,217,221,69,0,22,117,210,0,180,221,67,0,116,127,229,0,217,215,92,0,22,158,141,0,180,158,45,0,116,4,163,0,217,154,41,0,22,225,141,0,180,154,187,0,116,223,220,0,217,175,163,0,22,175,69,0,180,252,49,0,116,252,141,0,217,248,200,0,22,3,150,0,180,248,229,0,116,67,118,0,217,182,37,0,22,206,159,0,180,113,37,0,116,113,89,0,217,185,111,0,22,14,47,0,180,58,182,0,116,137,187,0,217,17,160,0,22,5,68,0,180,40,37,0,116,17,221,0,217,123,133,0,22,196,37,0,180,123,37,0,116,199,156,0,179,116,0,188,217,112,217,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,22,112,217,0,180,57,229,0,116,112,217,0,50,57,41,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,22,232,217,0,180,20,200,0,116,232,217,0,50,20,89,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,62,221,57,69,156,112,22,221,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,92,0,200,247,189,125,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,217,112,217,0,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,175,221,221,0,102,117,221,182,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,92,240,212,182,189,125,200,125,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,191,127,224,182,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,185,125,221,67,64,232,104,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,64,112,219,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,84,70,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,152,83,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,152,136,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,104,24,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,104,95,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,139,237,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,139,124,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,131,250,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,131,226,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,168,186,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,168,193,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,230,1,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,230,208,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,132,74,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,132,93,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,198,99,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,198,60,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,216,2,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,216,219,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,255,105,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,255,179,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,18,184,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,18,28,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,197,183,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,197,84,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,145,152,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,145,104,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,48,139,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,48,131,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,103,168,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,103,230,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,176,132,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,176,198,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,245,216,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,245,255,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,94,18,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,94,197,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,140,145,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,140,48,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,233,103,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,233,176,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,192,245,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,192,94,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,177,140,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,177,233,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,200,85,192,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,14,57,85,177,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,27,0,14,57,57,85,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,27,0,116,57,27,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,27,0,116,200,22,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,22,0,116,57,22,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,22,0,116,200,15,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,15,0,116,57,15,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,15,0,116,200,204,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,204,0,116,57,204,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,204,0,116,200,117,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,117,0,116,57,117,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,117,0,116,200,158,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,158,0,116,57,158,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,158,0,116,200,154,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,154,0,116,57,154,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,154,0,116,200,62,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,62,0,116,57,62,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,62,0,116,200,3,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,3,0,116,57,3,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,3,0,116,200,113,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,113,0,116,57,113,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,113,0,116,200,14,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,14,0,116,57,14,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,14,0,116,200,5,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,15,5,0,116,57,5,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,112,5,0,14,15,202,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,138,0,116,15,138,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,138,0,116,112,138,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,172,0,116,15,172,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,172,0,116,112,172,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,171,0,116,15,171,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,171,0,116,112,171,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,98,0,116,15,98,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,98,0,116,112,98,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,108,0,116,15,108,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,108,0,116,112,108,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,79,0,116,15,79,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,79,0,116,112,79,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,214,0,116,15,214,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,214,0,116,112,214,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,82,0,116,15,82,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,82,0,116,112,82,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,129,0,116,15,129,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,129,0,116,112,129,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,120,0,116,15,120,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,120,0,116,112,120,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,222,0,116,15,222,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,222,0,116,112,222,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,130,0,116,15,130,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,130,0,116,112,130,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,35,0,116,15,35,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,35,0,116,112,35,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,30,0,116,15,30,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,57,30,0,116,112,30,0,14,112,200,159,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,62,200,84,221,180,200,65,0,223,15,22,0,74,57,125,0,14,112,200,159,117,200,0,0,67,27,57,57,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,66,200,0,0,14,57,57,57,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,27,200,125,217,125,200,0,0,39,15,0,217,117,200,0,0,67,27,57,180,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,117,200,0,0,67,27,57,57,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,66,200,0,0,14,57,57,180,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,27,0,125,189,27,85,170,189,240,85,170,189,0,0,125,189,27,85,170,154,15,27,0,66,200,0,0,14,57,57,57,118,0,125,0,91,217,0,0,221,68,0,0,0,155,86,96,91,76,212,0,221,69,0,0,0,11,62,0,221,205,0,0,0,82,61,96,91,19,86,204,151,77,43,0,221,159,0,0,0,82,82,138,178,0,221,221,0,0,0,82,82,138,0,221,182,0,0,0,62,43,86,120,155,43,96,173,0,221,67,0,0,0,62,43,86,120,155,43,96,0,69,0,0,0,0,0,0,198,253,221,159,0,0,0,190,122,86,43,0,221,221,0,0,0,155,234,190,0,69,0,0,0,0,240,51,99,27,69,0,0,0,0,0,0,209,27,69,0,0,0,0,0,0,64,27,69,0,0,0,0,0,240,108,27,69,0,0,0,0,0,125,61,27,69,0,0,0,0,0,0,231,27,69,0,0,0,0,0,240,64,27,69,0,0,0,0,0,27,190,27,69,0,0,0,0,0,125,64,27,69,0,0,0,0,0,161,64,27,69,0,0,0,0,0,0,130,27,69,0,0,0,0,0,0,56,27,69,0,0,0,0,0,0,157,27,69,0,0,0,0,0,0,120,27,69,0,0,0,0,0,64,227,27,69,0,0,0,0,0,64,73,27,69,0,0,0,0,0,125,224,27,69,0,0,0,0,0,0,65,27,69,0,0,0,0,0,240,61,27,69,0,0,0,0,0,161,73,27,69,0,0,0,0,0,125,154,27,69,0,0,0,0,0,125,212,27,69,0,0,0,0,0,125,138,27,69,0,0,0,0,0,0,227,27,69,0,0,0,0,0,0,222,27,69,0,0,0,0,0,27,11,27,69,0,0,0,0,0,125,172,27,69,0,0,0,0,0,0,89,27,69,0,0,0,0,0,161,227,27,69,0,0,0,0,0,27,61,27,69,0,0,0,0,0,27,73,27,69,0,0,0,0,0,27,130,27,69,0,0,0,0,0,60,50,27,69,0,0,0,0,0,0,5,27,69,0,0,0,0,0,27,30,27,69,0,0,0,0,0,60,43,27,69,0,0,0,0,0,60,64,27,69,0,0,0,0,0,240,56,27,69,0,0,0,0,0,0,173,27,69,0,0,0,0,0,27,82,27,69,0,0,0,0,0,0,91,27,69,0,0,0,0,0,64,50,27,69,0,0,0,0,0,125,144,27,69,0,0,0,0,0,0,30,27,69,0,0,0,0,0,125,65,27,69,0,0,0,0,0,0,39,27,69,0,0,0,0,0,240,43,27,69,0,0,0,0,0,0,204,27,69,0,0,0,0,0,240,50,27,69,0,0,0,0,0,0,111,27,69,0,0,0,0,0,60,77,27,69,0,0,0,0,0,0,178,27,69,0,0,0,0,0,64,212,27,69,0,0,0,0,0,125,11,27,69,0,0,0,0,0,0,12,27,69,0,0,0,0,0,125,39,27,69,0,0,0,0,0,0,190,27,69,0,0,0,0,0,0,141,27,69,0,0,0,0,0,0,144,27,69,0,0,0,0,0,10,73,27,69,0,0,0,0,0,125,15,27,69,0,0,0,0,0,0,253,27,69,0,0,0,0,0,0,67,27,69,0,0,0,0,0,10,50,27,69,0,0,0,0,0,10,190,27,69,0,0,0,0,0,0,35,27,69,0,0,0,0,0,0,249,27,69,0,0,0,0,0,240,39,27,69,0,0,0,0,0,0,214,27,69,0,0,0,0,0,0,246,27,69,0,0,0,0,0,64,190,27,69,0,0,0,0,0,10,64,27,69,0,0,0,0,0,64,43,27,69,0,0,0,0,0,240,120,27,69,0,0,0,0,0,125,35,27,69,0,0,0,0,0,0,98,27,69,0,0,0,0,0,125,222,27,69,0,0,0,0,0,125,50,27,69,0,0,0,0,0,60,227,27,69,0,0,0,0,0,161,77,27,69,0,0,0,0,0,27,35,27,69,0,0,0,0,0,240,227,27,69,0,0,0,0,0,0,43,27,69,0,0,0,0,0,125,73,27,69,0,0,0,0,0,10,43,27,69,0,0,0,0,0,27,79,27,69,0,0,0,0,0,0,129,27,69,0,0,0,0,0,10,227,27,69,0,0,0,0,0,64,77,27,69,0,0,0,0,0,0,0,27,69,0,0,0,0,0,125,56,27,69,0,0,0,0,0,125,120,27,69,0,0,0,0,0,125,98,27,69,0,0,0,0,0,125,190,27,69,0,0,0,0,0,161,190,27,69,0,0,0,0,0,240,79,27,69,0,0,0,0,0,240,144,27,69,0,0,0,0,0,0,224,27,69,0,0,0,0,0,240,212,27,69,0,0,0,0,0,0,187,27,69,0,0,0,0,0,60,151,27,69,0,0,0,0,0,0,19,27,69,0,0,0,0,0,0,50,27,69,0,0,0,0,0,125,204,27,69,0,0,0,0,0,125,43,27,69,0,0,0,0,0,27,222,27,69,0,0,0,0,0,161,212,27,69,0,0,0,0,0,0,27,27,69,0,0,0,0,0,125,108,27,69,0,0,0,0,0,10,61,27,69,0,0,0,0,0,125,130,27,69,0,0,0,0,0,240,11,27,69,0,0,0,0,0,27,43,27,69,0,0,0,0,0,125,113,27,69,0,0,0,0,0,240,222,27,69,0,0,0,0,0,0,14,27,69,0,0,0,0,0,0,52,27,69,0,0,0,0,0,60,190,27,69,0,0,0,0,0,27,39,27,69,0,0,0,0,0,240,129,27,69,0,0,0,0,0,0,207,27,69,0,0,0,0,0,125,22,27,69,0,0,0,0,0,0,238,27,69,0,0,0,0,0,125,129,27,69,0,0,0,0,0,0,77,27,69,0,0,0,0,0,0,117,27,69,0,0,0,0,0,27,56,27,69,0,0,0,0,0,0,15,27,69,0,0,0,0,0,240,190,27,69,0,0,0,0,0,125,27,27,69,0,0,0,0,0,0,154,27,69,0,0,0,0,0,0,138,27,69,0,0,0,0,0,0,36,27,69,0,0,0,0,0,0,26,27,69,0,0,0,0,0,0,171,27,69,0,0,0,0,0,240,130,27,69,0,0,0,0,0,0,213,27,69,0,0,0,0,0,0,107,27,69,0,0,0,0,0,125,82,27,69,0,0,0,0,0,0,61,27,69,0,0,0,0,0,27,129,27,69,0,0,0,0,0,27,77,27,69,0,0,0,0,0,240,35,27,69,0,0,0,0,0,240,77,27,69,0,0,0,0,0,161,61,27,69,0,0,0,0,0,125,171,27,69,0,0,0,0,0,27,64,27,69,0,0,0,0,0,60,61,27,69,0,0,0,0,0,0,220,27,69,0,0,0,0,0,0,0,0,221,185,0,0,0,82,61,96,91,19,86,158,171,222,0,69,0,0,0,0,0,205,244,27,69,0,0,0,0,0,122,116,27,69,0,0,0,0,125,48,240,27,69,0,0,0,0,0,237,240,27,69,0,0,0,0,0,51,21,27,69,0,0,0,0,0,82,143,27,69,0,0,0,0,0,60,80,27,69,0,0,0,0,0,131,241,27,69,0,0,0,0,125,40,112,27,69,0,0,0,0,0,105,116,27,69,0,0,0,0,0,21,110,27,69,0,0,0,0,0,68,165,27,69,0,0,0,0,0,44,78,27,69,0,0,0,0,125,106,232,27,69,0,0,0,0,125,24,240,27,69,0,0,0,0,0,81,241,27,69,0,0,0,0,0,14,244,27,69,0,0,0,0,0,200,88,27,69,0,0,0,0,0,81,110,27,69,0,0,0,0,0,53,203,27,69,0,0,0,0,0,167,165,27,69,0,0,0,0,0,94,228,27,69,0,0,0,0,0,214,232,27,69,0,0,0,0,0,89,232,27,69,0,0,0,0,0,129,16,27,69,0,0,0,0,125,21,116,27,69,0,0,0,0,0,5,116,27,69,0,0,0,0,125,93,116,27,69,0,0,0,0,0,33,116,27,69,0,0,0,0,0,4,121,27,69,0,0,0,0,0,119,116,27,69,0,0,0,0,0,240,218,27,69,0,0,0,0,0,9,112,27,69,0,0,0,0,0,24,203,27,69,0,0,0,0,0,132,116,27,69,0,0,0,0,0,196,228,27,69,0,0,0,0,0,171,29,27,69,0,0,0,0,0,244,254,27,69,0,0,0,0,125,148,112,27,69,0,0,0,0,0,67,116,27,69,0,0,0,0,0,3,232,27,69,0,0,0,0,0,157,112,27,69,0,0,0,0,0,74,115,27,69,0,0,0,0,0,163,203,27,69,0,0,0,0,0,150,21,27,69,0,0,0,0,0,106,115,27,69,0,0,0,0,0,41,126,27,69,0,0,0,0,0,42,21,27,69,0,0,0,0,125,39,232,27,69,0,0,0,0,0,167,251,27,69,0,0,0,0,0,246,149,27,69,0,0,0,0,0,254,110,27,69,0,0,0,0,0,20,146,27,69,0,0,0,0,0,205,203,27,69,0,0,0,0,0,198,21,27,69,0,0,0,0,0,219,228,27,69,0,0,0,0,0,64,211,27,69,0,0,0,0,0,129,162,27,69,0,0,0,0,0,41,218,27,69,0,0,0,0,0,16,244,27,69,0,0,0,0,0,10,9,27,69,0,0,0,0,0,116,116,27,69,0,0,0,0,0,146,33,27,69,0,0,0,0,0,54,240,27,69,0,0,0,0,125,234,240,27,69,0,0,0,0,0,45,116,27,69,0,0,0,0,0,59,239,27,69,0,0,0,0,0,12,240,27,69,0,0,0,0,0,149,236,27,69,0,0,0,0,0,190,228,27,69,0,0,0,0,125,216,112,27,69,0,0,0,0,0,41,240,27,69,0,0,0,0,0,57,143,27,69,0,0,0,0,0,53,148,27,69,0,0,0,0,0,27,239,27,69,0,0,0,0,0,58,240,27,69,0,0,0,0,0,65,218,27,69,0,0,0,0,0,112,33,27,69,0,0,0,0,0,163,169,27,69,0,0,0,0,0,250,116,27,69,0,0,0,0,0,20,169,27,69,0,0,0,0,0,124,161,27,69,0,0,0,0,0,217,203,27,69,0,0,0,0,0,248,80,27,69,0,0,0,0,0,46,169,27,69,0,0,0,0,0,17,143,27,69,0,0,0,0,0,68,29,27,69,0,0,0,0,0,36,115,27,69,0,0,0,0,0,43,232,27,69,0,0,0,0,0,117,239,27,69,0,0,0,0,0,246,232,27,69,0,0,0,0,0,67,161,27,69,0,0,0,0,125,78,112,27,69,0,0,0,0,0,195,9,27,69,0,0,0,0,125,121,240,27,69,0,0,0,0,0,2,146,27,69,0,0,0,0,0,164,146,27,69,0,0,0,0,0,88,251,27,69,0,0,0,0,0,86,148,27,69,0,0,0,0,0,246,110,27,69,0,0,0,0,125,93,112,27,69,0,0,0,0,0,29,148,27,69,0,0,0,0,125,166,116,27,69,0,0,0,0,125,126,240,27,69,0,0,0,0,0,16,116,27,69,0,0,0,0,0,168,21,27,69,0,0,0,0,0,57,203,27,69,0,0,0,0,0,51,143,27,69,0,0,0,0,0,177,146,27,69,0,0,0,0,0,207,128,27,69,0,0,0,0,0,131,115,27,69,0,0,0,0,0,244,51,27,69,0,0,0,0,0,144,115,27,69,0,0,0,0,0,48,241,27,69,0,0,0,0,0,87,8,27,69,0,0,0,0,0,134,240,27,69,0,0,0,0,0,191,244,27,69,0,0,0,0,0,3,165,27,69,0,0,0,0,0,233,169,27,69,0,0,0,0,0,47,112,27,69,0,0,0,0,0,162,112,27,69,0,0,0,0,125,29,112,27,69,0,0,0,0,0,242,148,27,69,0,0,0,0,0,13,240,27,69,0,0,0,0,125,8,112,27,69,0,0,0,0,0,156,9,27,69,0,0,0,0,0,91,29,27,69,0,0,0,0,0,146,9,27,69,0,0,0,0,0,84,115,27,69,0,0,0,0,0,233,244,27,69,0,0,0,0,0,44,236,27,69,0,0,0,0,0,241,33,27,69,0,0,0,0,0,103,146,27,69,0,0,0,0,0,44,8,27,69,0,0,0,0,0,184,110,27,69,0,0,0,0,0,223,239,27,69,0,0,0,0,0,255,31,27,69,0,0,0,0,0,52,126,27,69,0,0,0,0,0,244,243,27,69,0,0,0,0,125,179,116,27,69,0,0,0,0,0,0,21,27,69,0,0,0,0,0,244,110,27,69,0,0,0,0,0,52,143,27,69,0,0,0,0,0,91,121,27,69,0,0,0,0,0,199,31,27,69,0,0,0,0,0,205,169,27,69,0,0,0,0,0,206,203,27,69,0,0,0,0,0,125,78,27,69,0,0,0,0,125,27,240,27,69,0,0,0,0,0,227,244,27,69,0,0,0,0,0,144,232,27,69,0,0,0,0,0,97,149,27,69,0,0,0,0,0,9,31,27,69,0,0,0,0,0,117,23,27,69,0,0,0,0,0,235,244,27,69,0,0,0,0,0,176,29,27,69,0,0,0,0,0,70,32,27,69,0,0,0,0,0,165,115,27,69,0,0,0,0,0,196,21,27,69,0,0,0,0,0,115,169,27,69,0,0,0,0,0,88,247,27,69,0,0,0,0,125,104,240,27,69,0,0,0,0,0,66,114,27,69,0,0,0,0,0,202,97,27,69,0,0,0,0,0,40,21,27,69,0,0,0,0,0,35,211,27,69,0,0,0,0,0,176,161,27,69,0,0,0,0,0,27,241,27,69,0,0,0,0,0,129,33,27,69,0,0,0,0,0,221,80,27,69,0,0,0,0,125,46,116,27,69,0,0,0,0,0,248,218,27,69,0,0,0,0,0,126,9,27,69,0,0,0,0,0,124,46,27,69,0,0,0,0,0,104,8,27,69,0,0,0,0,0,232,116,27,69,0,0,0,0,0,114,110,27,69,0,0,0,0,0,184,203,27,69,0,0,0,0,0,4,244,27,69,0,0,0,0,0,94,161,27,69,0,0,0,0,0,70,218,27,69,0,0,0,0,0,240,169,27,69,0,0,0,0,0,233,149,27,69,0,0,0,0,0,244,244,27,69,0,0,0,0,0,99,143,27,69,0,0,0,0,0,244,161,27,69,0,0,0,0,0,52,232,27,69,0,0,0,0,0,43,115,27,69,0,0,0,0,0,18,240,27,69,0,0,0,0,0,200,121,27,69,0,0,0,0,0,181,218,27,69,0,0,0,0,125,150,112,27,69,0,0,0,0,125,179,240,27,69,0,0,0,0,0,239,116,27,69,0,0,0,0,0,213,203,27,69,0,0,0,0,0,52,149,27,69,0,0,0,0,0,145,116,27,69,0,0,0,0,0,166,244,27,69,0,0,0,0,0,108,7,27,221,182,0,0,0,120,155,43,96,171,50,164,43,0,0,0,0,0,217,0,0,0,217,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,129,178,114,174,196,119,188,21,201,108,74,209,28,220,3,255,12,188,92,197,245,250,213,234,191,201,111,176,117,28,26,72,168,76,51,222,169,248,51,76,233,20,107,175,19,4,97,172,232,151,111,149,138,180,145,11,108,104,166,74,151,158,100,31,29,211,119,117,218,237,98,117,170,128,221,31,64,168,115,19,141,222,8,254,61,111,237,215,55,198,7,236,66,251,90,41,230,7,61,233,111,97,108,84,140,15,187,145,136,242,193,76,101,107,153,40,69,228,232,198,232,9,170,157,60,10,2,241,133,1,100,198,186,196,94,201,159,159,110,30,211,125,191,159,186,93,52,207,234,214,214,114,204,29,86,108,64,131,65,62,148,191,218,250,2,228,91,150,183,95,113,32,29,205,110,83,180,66,89,84,162,110,57,207,202,101,173,67,28,21,184,10,100,146,124,136,206,191,76,226,50,45,241,239,1,106,176,111,134,214,31,4,75,161,73,44,1,115,121,216,64,74,187,222,153,61,209,67,33,240,232,94,75,85,215,103,200,225,125,112,63,201,228,54,124,91,130,8,201,121,160,211,94,56,1,255})
    end
    _G.SimpleLibLoaded = true
end



