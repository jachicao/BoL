local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.33

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
                WillHit = ((state == SkillShot.STATUS.SUCCESS_HIT) or self:IsImmobile(target, sp)) 
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
    AddAnimationCallback(function(unit, animation) self:OnAnimation(unit, animation) end)
    if AddProcessSpellCallback then
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
    end
    if AddProcessAttackCallback then
        AddProcessAttackCallback(function(unit, spell) self:OnProcessAttack(unit, spell) end)
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

function _OrbwalkManager:OnAnimation(unit, animation)
    if unit and animation then
        if unit.isMe then
            if self:GetTime() - self.AA.LastTime + self:Latency() < 1 * self:WindUpTime() then
                if not animation:lower():find("attack") then
                    self:ResetMove()
                end
            else
                if animation:lower():find("attack") and self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:AnimationTime() - 25/1000 then
                    self.AA.IsAttacking = true
                    self.AA.LastTime = self:GetTime() - self:Latency()
                end
            end
            self.LastAnimationName = animation
        end
    end
end

function _OrbwalkManager:OnProcessAttack(unit, spell)
    if unit and spell and unit.isMe and spell.name then
        if self:IsAutoAttack(spell.name) then
            if not self.DataUpdated then
                self.BaseAnimationTime = 1 / (spell.animationTime * myHero.attackSpeed)
                self.BaseWindUpTime = 1 / (spell.windUpTime * myHero.attackSpeed)
                self.DataUpdated = true
            end
            self.AA.LastTarget = spell.target
            self.AA.IsAttacking = false
            self.AA.LastTime = self:GetTime() - self:Latency() - self:WindUpTime()
        end
    end
end

function _OrbwalkManager:OnProcessSpell(unit, spell)
    if unit and unit.isMe and spell and spell.name then
        if self:IsReset(spell.name) then
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
    if self.OrbLoaded == "AutoCarry" then
        return _G.AutoCarry.Orbwalker:CanShoot()
    elseif self.OrbLoaded == "SxOrbWalk" then
        return _G.SxOrb:CanAttack()
    elseif self.OrbLoaded == "SOW" then
    elseif self.OrbLoaded == "Big Fat Walk" then
    elseif self.OrbLoaded == "MMA" then
        return _G.MMA_CanAttack()
    elseif self.OrbLoaded == "NOW" then
        return _G.NOWi:TimeToAttack()
    end
    local int = ExtraTime ~= nil and ExtraTime or 0
    return self:GetTime() - self.AA.LastTime + self:Latency() >= 1 * self:AnimationTime() - 25/1000 + int and not IsEvading()
end

function _OrbwalkManager:CanMove(ExtraTime)
    if self.OrbLoaded == "AutoCarry" then
        return _G.AutoCarry.Orbwalker:CanMove()
    elseif self.OrbLoaded == "SxOrbWalk" then
        return _G.SxOrb:CanMove()
    elseif self.OrbLoaded == "SOW" then
    elseif self.OrbLoaded == "Big Fat Walk" then
    elseif self.OrbLoaded == "MMA" then
        return _G.MMA_CanMove()
    elseif self.OrbLoaded == "NOW" then
        return _G.NOWi:TimeToMove()
    end
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
        SSL2({37,96,123,234,109,146,44,46,167,88,43,169,89,35,110,62,247,33,79,188,57,91,131,6,156,95,66,18,157,183,233,160,134,31,94,237,21,254,250,217,52,159,245,26,136,235,179,76,103,181,150,227,187,166,204,196,180,60,86,11,246,198,111,220,171,7,210,133,59,138,200,165,38,97,105,173,25,178,129,139,168,50,218,100,75,242,164,69,155,20,163,151,208,191,51,90,182,113,132,174,230,98,29,144,127,8,41,84,106,219,115,112,119,255,71,202,78,126,248,241,244,161,15,117,229,221,22,175,82,64,99,190,124,228,197,1,93,92,102,226,201,101,223,195,77,72,34,65,54,122,154,85,9,56,61,107,128,158,83,125,170,137,42,121,252,70,239,39,32,40,186,130,108,145,225,184,68,12,45,152,55,14,58,116,215,236,147,214,74,118,49,199,141,28,193,251,238,23,222,224,27,19,185,36,24,149,63,2,73,206,114,194,67,207,87,189,30,153,10,209,232,176,17,81,80,192,104,172,240,16,142,231,3,53,4,162,205,243,135,143,249,203,253,140,211,213,212,148,47,177,13,5,48,120,216,66,173,78,182,50,0,37,234,234,234,46,0,156,34,89,88,95,88,0,0,0,0,0,0,0,0,0,37,86,115,167,0,0,43,0,0,0,138,0,220,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,220,220,0,197,175,220,37,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,23,199,220,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,146,141,220,0,66,171,0,0,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,23,0,171,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,146,171,171,0,66,171,0,0,131,199,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,146,82,171,0,46,0,82,64,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,37,141,37,0,75,37,0,37,82,141,37,0,134,37,234,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,44,96,28,0,200,7,28,0,175,96,0,37,199,96,175,123,0,123,175,123,208,96,0,96,157,64,0,0,88,0,64,123,160,171,13,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,43,37,0,188,171,82,96,0,82,141,96,0,141,37,123,0,37,7,123,0,171,64,123,0,82,28,123,0,141,96,234,0,37,210,234,0,171,99,234,0,82,193,234,0,141,123,109,0,37,133,109,0,171,190,109,0,82,251,109,0,141,234,146,0,37,59,146,0,171,124,146,0,82,238,146,0,141,59,123,0,37,146,44,0,171,138,44,0,82,146,234,0,141,228,44,0,37,222,44,0,171,44,109,0,82,44,46,0,141,200,46,0,37,224,109,0,171,1,46,0,82,224,46,0,141,46,167,0,37,38,167,0,171,93,167,0,82,27,167,0,141,167,88,0,37,88,123,0,171,97,88,0,82,92,88,0,141,19,88,0,37,43,43,0,171,105,43,0,82,102,43,0,141,185,43,0,37,169,169,0,171,173,169,0,82,226,169,0,141,36,169,0,37,24,234,0,171,89,89,0,82,25,89,0,237,171,0,156,171,141,44,0,82,82,89,0,141,141,89,0,37,7,43,0,171,96,35,0,82,7,35,0,141,64,35,0,37,193,35,0,171,123,110,0,82,99,123,0,141,210,110,0,37,190,110,0,171,251,110,0,82,190,88,0,141,234,62,0,37,59,46,0,171,59,62,0,82,124,62,0,141,238,62,0,37,146,247,0,171,138,247,0,82,228,247,0,141,23,247,0,37,44,33,0,171,200,33,0,82,197,33,0,141,222,88,0,37,165,89,0,171,224,33,0,82,46,79,0,141,165,79,0,37,93,79,0,171,27,79,0,82,93,234,0,141,167,188,0,37,97,188,0,171,92,188,0,82,19,188,0,141,88,57,0,37,105,57,0,171,102,57,0,82,185,57,0,141,43,91,0,37,36,146,0,171,173,57,0,82,173,91,0,141,226,91,0,37,24,91,0,171,89,131,0,82,89,43,0,237,82,0,156,171,82,33,0,82,171,131,0,141,82,131,0,37,28,109,0,171,7,33,0,82,64,247,0,141,64,43,0,37,193,131,0,171,210,57,0,82,123,46,0,141,210,110,0,37,234,6,0,171,234,167,0,82,190,109,0,141,133,6,0,37,238,247,0,171,124,79,0,82,238,35,0,141,124,167,0,37,228,6,0,171,146,167,0,82,138,247,0,141,23,6,0,37,200,234,0,171,197,247,0,82,44,156,0,141,200,156,0,37,224,44,0,237,141,0,35,171,141,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,82,141,37,0,141,141,44,0,37,28,37,0,170,82,18,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,82,28,37,0,141,64,156,0,37,193,37,0,170,64,188,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,197,210,37,96,25,141,141,96,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,220,82,45,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,171,141,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,222,210,123,0,24,99,99,44,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,199,123,152,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,149,210,153,44,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,88,199,99,146,125,28,53,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,125,141,192,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,102,37,0,57,141,82,95,0,37,7,35,0,171,28,95,0,82,96,66,0,141,7,66,0,37,99,66,0,171,193,66,0,82,123,79,0,141,123,18,0,37,234,156,0,171,133,18,0,82,190,18,0,141,251,18,0,37,124,110,0,171,109,157,0,82,59,46,0,141,59,157,0,37,228,157,0,171,146,131,0,82,146,89,0,141,138,146,0,37,200,131,0,171,44,43,0,82,197,88,0,141,222,157,0,37,46,123,0,171,1,131,0,82,224,43,0,141,224,6,0,37,38,6,0,171,167,183,0,82,167,88,0,141,38,183,0,37,97,62,0,171,92,183,0,82,19,183,0,141,92,43,0,37,43,233,0,171,105,233,0,82,105,157,0,141,102,57,0,37,226,233,0,171,36,233,0,82,36,43,0,141,169,160,0,37,201,96,0,171,24,79,0,82,201,131,0,141,89,79,0,37,178,160,0,121,171,0,156,141,82,160,0,37,7,110,0,171,28,66,0,82,96,234,0,141,28,160,0,37,193,91,0,171,123,134,0,82,210,134,0,141,99,134,0,37,190,91,0,171,133,123,0,82,251,134,0,141,234,31,0,37,59,31,0,171,59,35,0,82,109,44,0,141,109,66,0,37,228,157,0,171,228,31,0,82,23,131,0,141,23,31,0,37,222,95,0,171,44,62,0,82,44,94,0,141,44,62,0,37,1,131,0,171,165,94,0,82,46,57,0,141,224,96,0,37,167,188,0,171,93,94,0,82,27,94,0,141,167,44,0,37,92,110,0,171,88,237,0,82,97,237,0,141,19,62,0,37,105,91,0,171,102,109,0,82,185,131,0,141,102,237,0,37,36,237,0,171,169,91,0,82,226,94,0,141,226,79,0,37,25,18,0,171,201,157,0,82,201,169,0,141,89,21,0,37,149,35,0,121,82,0,156,141,37,33,0,37,28,134,0,171,64,169,0,82,7,21,0,141,7,66,0,37,99,167,0,171,193,237,0,82,193,6,0,141,210,167,0,37,190,21,0,171,251,21,0,82,234,254,0,141,234,62,0,37,124,62,0,171,124,167,0,82,124,157,0,141,109,44,0,37,23,109,0,171,138,169,0,82,138,57,0,141,23,91,0,37,222,247,0,171,222,131,0,82,44,35,0,141,197,95,0,37,165,254,0,171,224,234,0,82,224,160,0,141,224,89,0,37,38,62,0,171,27,91,0,82,38,35,0,141,93,43,0,37,97,33,0,171,19,21,0,82,92,95,0,141,19,157,0,37,185,233,0,171,43,123,0,82,105,62,0,141,105,160,0,37,36,237,0,171,169,234,0,82,173,157,0,141,226,254,0,37,201,123,0,171,24,31,0,82,25,43,0,141,201,123,0,121,141,175,6,141,141,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,37,28,37,0,171,64,254,0,82,28,37,0,134,64,18,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,37,193,37,0,171,99,156,0,82,193,37,0,134,99,188,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,44,251,37,123,24,141,141,123,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,199,82,24,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,141,141,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,200,251,123,0,178,234,190,46,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,0,142,46,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,25,133,153,46,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,88,220,190,44,160,193,53,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,160,28,192,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,43,96,0,57,171,28,91,0,82,64,234,0,141,7,250,0,37,99,250,0,171,210,21,0,82,123,234,0,141,193,43,0,37,133,146,0,171,251,250,0,82,251,46,0,141,251,234,0,37,238,66,0,171,59,18,0,82,238,250,0,141,124,234,0,37,146,167,0,171,146,157,0,82,146,91,0,141,146,79,0,37,222,95,0,171,222,18,0,82,197,44,0,141,44,123,0,37,224,44,0,171,46,217,0,82,46,237,0,141,165,217,0,37,27,88,0,171,27,37,0,82,27,79,0,141,93,217,0,37,19,89,0,171,19,31,0,82,19,217,0,141,19,46,0,37,102,250,0,171,43,52,0,82,43,167,0,141,43,146,0,37,169,237,0,171,36,234,0,82,173,167,0,141,173,52,0,37,25,89,0,171,24,57,0,82,201,237,0,141,201,52,0,37,101,247,0,171,101,96,0,82,101,33,0,237,7,0,156,171,28,52,0,82,96,66,0,141,96,159,0,37,210,159,0,171,193,96,0,82,210,156,0,141,99,159,0,37,251,159,0,171,234,57,0,82,234,245,0,141,190,250,0,37,59,245,0,171,124,245,0,82,59,43,0,141,238,245,0,37,228,146,0,171,23,31,0,82,138,52,0,141,228,254,0,37,44,26,0,171,222,245,0,82,200,94,0,141,44,52,0,37,165,57,0,171,46,66,0,82,224,131,0,141,46,21,0,37,27,33,0,171,27,95,0,82,93,110,0,141,167,217,0,37,19,18,0,171,19,89,0,82,97,131,0,141,88,26,0,37,102,183,0,171,43,110,0,82,105,217,0,141,185,44,0,37,169,26,0,171,169,46,0,82,36,233,0,141,173,35,0,37,89,62,0,171,24,94,0,82,25,217,0,141,201,35,0,37,101,233,0,171,178,94,0,82,101,131,0,237,64,0,156,171,7,66,0,82,96,33,0,141,7,247,0,37,193,46,0,171,123,237,0,82,193,62,0,141,193,46,0,37,133,26,0,171,133,52,0,82,190,26,0,141,234,134,0,37,109,159,0,171,238,26,0,82,109,136,0,141,238,146,0,37,23,88,0,171,138,136,0,82,228,247,0,141,23,6,0,37,222,33,0,171,197,136,0,82,44,31,0,141,200,217,0,37,46,160,0,171,165,52,0,82,224,136,0,141,46,235,0,37,167,159,0,171,27,110,0,82,38,91,0,141,38,33,0,37,92,136,0,171,88,44,0,82,88,217,0,141,92,233,0,37,102,110,0,171,43,62,0,82,43,169,0,141,105,235,0,37,169,157,0,171,226,89,0,82,169,131,0,141,226,235,0,37,25,109,0,171,89,21,0,237,28,175,91,171,28,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,82,28,37,0,141,64,254,0,37,193,37,0,170,64,18,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,82,193,37,0,141,99,156,0,37,251,37,0,170,99,188,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,197,133,96,234,25,28,141,234,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,220,96,92,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,171,28,37,0,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,222,133,234,0,24,190,190,167,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,156,199,234,152,131,175,96,175,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,149,133,153,167,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,88,199,190,46,125,193,53,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,125,28,192,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,115,176,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,115,17,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,112,81,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,112,80,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,119,192,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,119,104,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,255,172,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,255,240,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,71,16,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,71,142,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,202,231,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,202,3,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,78,53,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,78,4,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,126,162,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,126,205,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,248,243,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,248,135,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,241,143,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,241,249,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,244,203,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,244,253,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,161,140,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,161,211,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,15,213,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,15,212,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,117,148,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,117,47,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,229,177,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,229,13,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,221,5,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,221,48,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,7,22,120,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,92,28,22,216,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,220,0,37,210,220,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,220,0,37,193,220,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,171,0,37,210,171,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,171,0,37,193,171,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,7,0,37,210,7,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,7,0,37,193,7,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,210,0,37,210,210,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,210,0,37,193,210,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,133,0,37,210,133,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,133,0,37,193,133,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,59,0,37,210,59,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,59,0,37,193,59,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,138,0,37,210,138,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,138,0,37,193,138,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,200,0,37,210,200,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,200,0,37,193,200,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,165,0,37,210,165,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,165,0,37,193,165,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,38,0,37,210,38,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,38,0,37,193,38,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,97,0,37,210,97,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,97,0,37,193,97,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,105,0,37,210,105,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,105,0,37,193,105,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,173,0,37,210,173,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,173,0,37,193,173,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,25,0,37,210,25,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,25,0,37,193,25,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,178,0,37,210,178,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,178,0,37,193,178,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,129,0,37,210,129,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,129,0,37,193,129,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,139,0,37,210,139,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,139,0,37,193,139,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,168,0,37,210,168,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,168,0,37,193,168,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,50,0,37,210,50,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,50,0,37,193,50,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,218,0,37,210,218,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,218,0,37,193,218,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,100,0,37,210,100,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,100,0,37,193,100,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,75,0,37,210,75,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,75,0,37,193,75,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,242,0,37,210,242,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,242,0,37,193,242,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,164,0,37,210,164,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,164,0,37,193,164,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,69,0,37,210,69,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,69,0,37,193,69,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,155,0,37,210,155,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,155,0,37,193,155,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,20,0,37,210,20,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,20,0,37,193,20,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,163,0,37,210,163,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,163,0,37,193,163,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,151,0,37,210,151,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,151,0,37,193,151,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,208,0,37,210,208,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,208,0,37,193,208,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,191,0,37,210,191,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,191,0,37,193,191,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,51,0,37,210,51,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,51,0,37,193,51,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,90,0,37,210,90,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,64,90,0,37,193,90,0,92,96,99,109,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,197,28,219,109,141,96,182,0,146,210,171,0,157,99,175,0,92,96,99,109,190,96,0,0,46,175,64,64,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,251,96,0,0,92,28,64,64,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,175,96,175,37,199,96,0,0,128,7,0,37,190,96,0,0,46,175,64,82,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,190,96,0,0,46,175,64,64,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,251,96,0,0,92,28,64,82,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,220,0,175,131,220,216,22,131,199,216,22,131,0,0,175,131,220,216,22,228,7,220,0,251,96,0,0,92,28,64,64,233,0,175,0,124,37,0,0,234,44,0,0,0,71,202,255,127,219,29,0,234,123,0,0,0,51,200,0,234,43,0,0,0,218,132,255,127,112,202,210,115,174,230,0,234,109,0,0,0,218,218,173,150,0,234,234,0,0,0,218,218,173,0,234,167,0,0,0,200,230,202,75,71,230,255,181,0,234,46,0,0,0,200,230,202,75,71,230,255,0,123,0,0,0,0,0,0,143,111,234,109,0,0,0,113,244,202,230,0,234,234,0,0,0,71,78,113,0,123,0,0,0,0,0,0,187,220,123,0,0,0,0,0,199,29,220,123,0,0,0,0,0,199,168,220,123,0,0,0,0,0,175,174,220,123,0,0,0,0,0,0,129,220,123,0,0,0,0,0,0,29,220,123,0,0,0,0,0,175,200,220,123,0,0,0,0,0,0,138,220,123,0,0,0,0,0,81,230,220,123,0,0,0,0,0,0,25,220,123,0,0,0,0,0,160,113,220,123,0,0,0,0,0,220,164,220,123,0,0,0,0,0,0,75,220,123,0,0,0,0,0,220,90,220,123,0,0,0,0,0,0,105,220,123,0,0,0,0,0,0,246,220,123,0,0,0,0,0,199,230,220,123,0,0,0,0,0,175,20,220,123,0,0,0,0,0,0,173,220,123,0,0,0,0,0,0,26,220,123,0,0,0,0,0,175,164,220,123,0,0,0,0,0,0,188,220,123,0,0,0,0,0,0,191,220,123,0,0,0,0,0,220,168,220,123,0,0,0,0,0,199,51,220,123,0,0,0,0,0,160,29,220,123,0,0,0,0,0,220,98,220,123,0,0,0,0,0,0,97,220,123,0,0,0,0,0,199,191,220,123,0,0,0,0,0,175,98,220,123,0,0,0,0,0,0,165,220,123,0,0,0,0,0,125,29,220,123,0,0,0,0,0,175,132,220,123,0,0,0,0,0,81,132,220,123,0,0,0,0,0,220,113,220,123,0,0,0,0,0,220,230,220,123,0,0,0,0,0,220,51,220,123,0,0,0,0,0,175,90,220,123,0,0,0,0,0,125,182,220,123,0,0,0,0,0,125,230,220,123,0,0,0,0,0,199,174,220,123,0,0,0,0,0,175,220,220,123,0,0,0,0,0,175,69,220,123,0,0,0,0,0,220,132,220,123,0,0,0,0,0,175,105,220,123,0,0,0,0,0,0,254,220,123,0,0,0,0,0,220,50,220,123,0,0,0,0,0,125,132,220,123,0,0,0,0,0,175,210,220,123,0,0,0,0,0,220,182,220,123,0,0,0,0,0,0,38,220,123,0,0,0,0,0,160,230,220,123,0,0,0,0,0,90,132,220,123,0,0,0,0,0,0,98,220,123,0,0,0,0,0,0,86,220,123,0,0,0,0,0,0,76,220,123,0,0,0,0,0,175,182,220,123,0,0,0,0,0,175,7,220,123,0,0,0,0,0,81,113,220,123,0,0,0,0,0,175,38,220,123,0,0,0,0,0,175,230,220,123,0,0,0,0,0,0,6,220,123,0,0,0,0,0,0,220,220,123,0,0,0,0,0,0,20,220,123,0,0,0,0,0,160,90,220,123,0,0,0,0,0,0,159,220,123,0,0,0,0,0,220,151,220,123,0,0,0,0,0,0,168,220,123,0,0,0,0,0,199,242,220,123,0,0,0,0,0,0,164,220,123,0,0,0,0,0,175,218,220,123,0,0,0,0,0,160,144,220,123,0,0,0,0,0,0,181,220,123,0,0,0,0,0,175,144,220,123,0,0,0,0,0,175,163,220,123,0,0,0,0,0,199,208,220,123,0,0,0,0,0,175,139,220,123,0,0,0,0,0,0,163,220,123,0,0,0,0,0,0,18,220,123,0,0,0,0,0,90,98,220,123,0,0,0,0,0,0,51,220,123,0,0,0,0,0,199,90,220,123,0,0,0,0,0,199,144,220,123,0,0,0,0,0,0,200,220,123,0,0,0,0,0,0,182,220,123,0,0,0,0,0,0,208,220,123,0,0,0,0,0,0,151,220,123,0,0,0,0,0,160,98,220,123,0,0,0,0,0,125,144,220,123,0,0,0,0,0,0,31,220,123,0,0,0,0,0,0,155,220,123,0,0,0,0,0,0,178,220,123,0,0,0,0,160,11,80,220,123,0,0,0,0,0,0,90,220,123,0,0,0,0,0,81,115,220,123,0,0,0,0,0,0,112,220,123,0,0,0,0,0,0,210,220,123,0,0,0,0,0,0,100,220,123,0,0,0,0,0,0,69,220,123,0,0,0,0,0,175,208,220,123,0,0,0,0,0,220,100,220,123,0,0,0,0,0,220,242,220,123,0,0,0,0,0,90,230,220,123,0,0,0,0,0,0,204,220,123,0,0,0,0,0,160,174,220,123,0,0,0,0,0,0,150,220,123,0,0,0,0,0,175,113,220,123,0,0,0,0,0,90,144,220,123,0,0,0,0,0,0,50,220,123,0,0,0,0,0,0,160,220,123,0,0,0,0,0,0,62,220,123,0,0,0,0,0,199,50,220,123,0,0,0,0,0,125,90,220,123,0,0,0,0,0,0,180,220,123,0,0,0,0,0,175,50,220,123,0,0,0,0,0,175,25,220,123,0,0,0,0,0,175,133,220,123,0,0,0,0,0,90,174,220,123,0,0,0,0,0,175,155,220,123,0,0,0,0,0,199,151,220,123,0,0,0,0,0,0,103,220,123,0,0,0,0,0,220,29,220,123,0,0,0,0,0,220,69,220,123,0,0,0,0,0,90,29,220,123,0,0,0,0,0,0,218,220,123,0,0,0,0,0,0,60,220,123,0,0,0,0,0,0,46,220,123,0,0,0,0,0,90,182,220,123,0,0,0,0,0,175,165,220,123,0,0,0,0,0,175,75,220,123,0,0,0,0,0,220,174,220,123,0,0,0,0,0,0,139,220,123,0,0,0,0,0,220,144,220,123,0,0,0,0,0,199,163,220,123,0,0,0,0,0,199,69,220,123,0,0,0,0,0,175,191,220,123,0,0,0,0,0,175,168,220,123,0,0,0,0,0,199,75,220,123,0,0,0,0,0,199,113,220,123,0,0,0,0,0,0,198,220,123,0,0,0,0,0,0,171,220,123,0,0,0,0,0,175,97,220,123,0,0,0,0,0,175,151,220,123,0,0,0,0,0,175,171,220,123,0,0,0,0,0,0,237,220,123,0,0,0,0,0,125,113,220,123,0,0,0,0,0,0,0,0,123,0,0,0,0,0,90,90,220,123,0,0,0,0,0,199,182,220,123,0,0,0,0,0,199,20,220,123,0,0,0,0,0,199,100,220,123,0,0,0,0,0,160,182,220,123,0,0,0,0,0,0,59,220,123,0,0,0,0,0,0,242,220,123,0,0,0,0,0,81,174,220,123,0,0,0,0,0,220,75,220,123,0,0,0,0,0,199,218,220,123,0,0,0,0,0,0,235,220,123,0,0,0,0,0,0,227,220,123,0,0,0,0,0,199,164,220,123,0,0,0,0,0,81,182,220,123,0,0,0,0,0,175,138,220,123,0,0,0,0,0,0,11,220,123,0,0,0,0,0,175,100,220,123,0,0,0,0,0,220,218,220,123,0,0,0,0,0,81,98,220,123,0,0,0,0,0,199,98,220,123,0,0,0,0,0,90,113,220,123,0,0,0,0,0,125,98,220,123,0,0,0,0,0,220,155,220,123,0,0,0,0,0,0,196,220,123,0,0,0,0,0,220,139,220,123,0,0,0,0,0,175,29,220,123,0,0,0,0,0,175,178,220,123,0,0,0,0,0,0,144,220,123,0,0,0,0,0,0,127,220,123,0,0,0,0,0,220,20,220,234,88,0,0,0,218,132,255,127,112,202,59,178,242,0,123,0,0,0,0,0,64,236,220,123,0,0,0,0,0,117,42,220,123,0,0,0,0,0,207,225,220,123,0,0,0,0,0,250,14,220,123,0,0,0,0,0,146,125,220,123,0,0,0,0,0,138,193,220,123,0,0,0,0,0,234,118,220,123,0,0,0,0,0,220,32,220,123,0,0,0,0,175,5,199,220,123,0,0,0,0,0,234,72,220,123,0,0,0,0,0,58,236,220,123,0,0,0,0,0,166,45,220,123,0,0,0,0,0,185,141,220,123,0,0,0,0,0,107,141,220,123,0,0,0,0,0,8,58,220,123,0,0,0,0,0,183,147,220,123,0,0,0,0,0,191,28,220,123,0,0,0,0,0,36,199,220,123,0,0,0,0,0,80,28,220,123,0,0,0,0,0,236,39,220,123,0,0,0,0,0,137,239,220,123,0,0,0,0,0,161,58,220,123,0,0,0,0,0,148,85,220,123,0,0,0,0,0,173,61,220,123,0,0,0,0,0,152,145,220,123,0,0,0,0,0,175,152,220,123,0,0,0,0,0,94,193,220,123,0,0,0,0,0,41,184,220,123,0,0,0,0,0,114,147,220,123,0,0,0,0,0,151,77,220,123,0,0,0,0,0,1,45,220,123,0,0,0,0,0,226,45,220,123,0,0,0,0,0,249,68,220,123,0,0,0,0,0,96,68,220,123,0,0,0,0,0,69,40,220,123,0,0,0,0,0,226,12,220,123,0,0,0,0,175,117,199,220,123,0,0,0,0,0,59,45,220,123,0,0,0,0,0,119,214,220,123,0,0,0,0,0,62,32,220,123,0,0,0,0,0,83,214,220,123,0,0,0,0,175,203,141,220,123,0,0,0,0,0,156,74,220,123,0,0,0,0,0,51,141,220,123,0,0,0,0,0,203,130,220,123,0,0,0,0,0,170,55,220,123,0,0,0,0,0,169,137,220,123,0,0,0,0,0,50,55,220,123,0,0,0,0,0,200,152,220,123,0,0,0,0,0,100,193,220,123,0,0,0,0,0,74,14,220,123,0,0,0,0,0,221,118,220,123,0,0,0,0,0,212,214,220,123,0,0,0,0,0,127,45,220,123,0,0,0,0,175,238,199,220,123,0,0,0,0,0,221,252,220,123,0,0,0,0,0,46,108,220,123,0,0,0,0,0,253,152,220,123,0,0,0,0,0,117,122,220,123,0,0,0,0,0,175,108,220,123,0,0,0,0,0,18,158,220,123,0,0,0,0,0,202,170,220,123,0,0,0,0,0,1,152,220,123,0,0,0,0,0,197,152,220,123,0,0,0,0,0,10,49,220,123,0,0,0,0,0,204,141,220,123,0,0,0,0,175,191,141,220,123,0,0,0,0,0,104,214,220,123,0,0,0,0,0,77,141,220,123,0,0,0,0,0,90,130,220,123,0,0,0,0,0,55,12,220,123,0,0,0,0,0,44,215,220,123,0,0,0,0,0,58,74,220,123,0,0,0,0,0,190,54,220,123,0,0,0,0,0,99,55,220,123,0,0,0,0,0,195,83,220,123,0,0,0,0,0,5,72,220,123,0,0,0,0,0,231,54,220,123,0,0,0,0,0,135,12,220,123,0,0,0,0,175,120,199,220,123,0,0,0,0,0,207,74,220,123,0,0,0,0,0,18,32,220,123,0,0,0,0,0,244,12,220,123,0,0,0,0,0,24,236,220,123,0,0,0,0,0,50,58,220,123,0,0,0,0,0,72,141,220,123,0,0,0,0,0,125,121,220,123,0,0,0,0,0,207,236,220,123,0,0,0,0,0,131,199,220,123,0,0,0,0,0,98,215,220,123,0,0,0,0,0,17,14,220,123,0,0,0,0,0,127,147,220,123,0,0,0,0,0,152,49,220,123,0,0,0,0,0,174,107,220,123,0,0,0,0,175,47,199,220,123,0,0,0,0,0,231,118,220,123,0,0,0,0,0,137,55,220,123,0,0,0,0,0,201,45,220,123,0,0,0,0,0,174,56,220,123,0,0,0,0,175,116,28,220,123,0,0,0,0,0,204,152,220,123,0,0,0,0,0,94,215,220,123,0,0,0,0,0,187,215,220,123,0,0,0,0,175,220,141,220,123,0,0,0,0,0,121,68,220,123,0,0,0,0,0,232,116,220,123,0,0,0,0,0,143,107,220,123,0,0,0,0,175,80,28,220,123,0,0,0,0,175,245,199,220,123,0,0,0,0,0,3,49,220,123,0,0,0,0,0,160,28,220,123,0,0,0,0,0,14,225,220,123,0,0,0,0,0,219,125,220,123,0,0,0,0,0,17,147,220,123,0,0,0,0,0,51,58,220,123,0,0,0,0,0,143,239,220,123,0,0,0,0,0,233,141,220,123,0,0,0,0,0,81,107,220,123,0,0,0,0,0,188,118,220,123,0,0,0,0,0,81,186,220,123,0,0,0,0,0,183,214,220,123,0,0,0,0,0,183,152,220,123,0,0,0,0,175,17,28,220,123,0,0,0,0,175,118,28,220,123,0,0,0,0,0,196,70,220,123,0,0,0,0,0,77,184,220,123,0,0,0,0,175,84,28,220,123,0,0,0,0,0,73,152,220,123,0,0,0,0,0,246,116,220,123,0,0,0,0,0,194,125,220,123,0,0,0,0,0,85,65,220,123,0,0,0,0,0,89,236,220,123,0,0,0,0,0,167,147,220,123,0,0,0,0,0,225,152,220,123,0,0,0,0,0,207,45,220,123,0,0,0,0,0,96,152,220,123,0,0,0,0,0,48,14,220,123,0,0,0,0,0,101,121,220,123,0,0,0,0,0,41,215,220,123,0,0,0,0,0,189,12,220,123,0,0,0,0,0,173,147,220,123,0,0,0,0,0,116,77,220,123,0,0,0,0,0,19,39,220,123,0,0,0,0,0,189,199,220,123,0,0,0,0,0,103,152,220,123,0,0,0,0,175,191,193,220,123,0,0,0,0,0,148,147,220,123,0,0,0,0,0,170,118,220,123,0,0,0,0,0,11,215,220,123,0,0,0,0,0,82,184,220,123,0,0,0,0,0,161,121,220,123,0,0,0,0,0,68,199,220,123,0,0,0,0,0,100,236,220,123,0,0,0,0,0,112,125,220,123,0,0,0,0,0,125,147,220,123,0,0,0,0,0,9,152,220,123,0,0,0,0,0,172,34,220,123,0,0,0,0,0,74,147,220,123,0,0,0,0,175,187,28,220,123,0,0,0,0,175,32,199,220,123,0,0,0,0,0,121,58,220,123,0,0,0,0,0,145,252,220,123,0,0,0,0,0,188,40,220,123,0,0,0,0,0,24,45,220,123,0,0,0,0,0,227,215,220,123,0,0,0,0,0,1,56,220,123,0,0,0,0,0,119,55,220,123,0,0,0,0,0,173,141,220,123,0,0,0,0,0,254,39,220,123,0,0,0,0,0,195,154,220,123,0,0,0,0,0,152,154,220,123,0,0,0,0,0,70,137,220,123,0,0,0,0,0,186,152,220,123,0,0,0,0,0,69,70,220,123,0,0,0,0,0,161,236,220,123,0,0,0,0,0,26,9,220,123,0,0,0,0,175,161,193,220,123,0,0,0,0,0,121,147,220,123,0,0,0,0,175,67,141,220,123,0,0,0,0,0,53,225,220,123,0,0,0,0,0,107,9,220,123,0,0,0,0,0,83,74,220,123,0,0,0,0,0,34,14,220,123,0,0,0,0,0,176,116,220,123,0,0,0,0,0,41,236,220,123,0,0,0,0,0,241,49,220,123,0,0,0,0,0,146,137,220,123,0,0,0,0,0,46,56,220,123,0,0,0,0,0,133,54,220,123,0,0,0,0,0,151,28,220,123,0,0,0,0,175,178,193,220,123,0,0,0,0,175,26,28,220,123,0,0,0,0,0,2,45,220,123,0,0,0,0,0,0,12,220,123,0,0,0,0,0,217,54,220,123,0,0,0,0,0,172,186,220,123,0,0,0,0,0,48,147,220,123,0,0,0,0,0,65,54,220,123,0,0,0,0,0,211,236,220,123,0,0,0,0,0,76,28,220,234,167,0,0,0,75,71,230,255,178,182,106,230,0,0,0,0,0,37,0,0,0,37,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,153,131,199,52,87,127,37,169,105,112,218,168,22,63,107,58,104,50,237,39,115,176,124,59,9,195,41,16,210,207,152,66,213,88,106,129,46,142,221,10,47,149,198,52,85,175,67,159,199,248,229,46,11,3,110,176,108,100,179,232,59,33,87,131,82,249,245,240,122,85,87,112,78,228,129,138,102,203,81,73,230,26,88,123,223,21,67,227,227,172,148,171,114,18,251,226,149,182,145,180,176,83,219,144,62,197,65,166,183,47,237,81,5,31,103,19,33,89,90,125,227,135,28,95,112,167,254,38,17,171,186,40,20,89,171,218,38,82,160,110,211,160,236,2,130,219,67,212,47,212,183,156,229,50,163,106,206,103,35,75,205,57,245,72,175,27,248,44,42,149,18,100,255,130,98,211,152,245,211,250,21,41,130,16,235,69,62,99,90,4,57,150,70,35,177,60,247,222,74,80,20,201,85,146,104,128,166,177,176,179,118,226,124,208,143,142,186,217,165,179,207,106,186,10,58,72,114,159,26,194,249,45,94,245,63,234,152,95,238,120,16,94,127,216,133,217,101,135,214,242,158,210,3,122,1,255})
    end
    _G.SimpleLibLoaded = true
end



