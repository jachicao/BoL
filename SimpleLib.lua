local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.11

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
    ["Caitlyn"]                     = "R",
    ["Katarina"]                    = "R",
    ["MasterYi"]                    = "W",
    ["Fiddlesticks"]                = "R",
    ["Galio"]                       = "R",
    ["Lucian"]                      = "R",
    ["MissFortune"]                 = "R",
    ["VelKoz"]                      = "R",
    ["Nunu"]                        = "R",
    ["Shen"]                        = "R",
    ["Karthus"]                     = "R",
    ["Malzahar"]                    = "R",
    ["Pantheon"]                    = "R",
    ["Warwick"]                     = "R",
    ["Xerath"]                      = "R",
}

local GAPCLOSER_SPELLS = {
    ["Aatrox"]                      = "Q",
    ["Akali"]                       = "R",
    ["Alistar"]                     = "W",
    ["Amumu"]                       = "Q",
    ["Corki"]                       = "W",
    ["Diana"]                       = "R",
    ["Elise"]                       = "Q",
    ["Elise"]                       = "E",
    ["Fiddlesticks"]                = "R",
    ["Fiora"]                       = "Q",
    ["Fizz"]                        = "Q",
    ["Gnar"]                        = "E",
    ["Gragas"]                      = "E",
    ["Graves"]                      = "E",
    ["Hecarim"]                     = "R",
    ["Irelia"]                      = "Q",
    ["JarvanIV"]                    = "Q",
    ["JarvanIV"]                    = "R",
    ["Jax"]                         = "Q",
    ["Jayce"]                       = "Q",
    ["Katarina"]                    = "E",
    ["Kassadin"]                    = "R",
    ["Kennen"]                      = "E",
    ["KhaZix"]                      = "E",
    ["Lissandra"]                   = "E",
    ["LeBlanc"]                     = "W",
    ["LeBlanc"]                     = "R",
    ["LeeSin"]                      = "Q",
    ["Leona"]                       = "E",
    ["Lucian"]                      = "E",
    ["Malphite"]                    = "R",
    ["MasterYi"]                    = "Q",
    ["MonkeyKing"]                  = "E",
    ["Nautilus"]                    = "Q",
    ["Nocturne"]                    = "R",
    ["Olaf"]                        = "R",
    ["Pantheon"]                    = "W",
    ["Pantheon"]                    = "R",
    ["Poppy"]                       = "E",
    ["RekSai"]                      = "E",
    ["Renekton"]                    = "E",
    ["Riven"]                       = "Q",
    ["Riven"]                       = "E",
    ["Rengar"]                      = "R",
    ["Sejuani"]                     = "Q",
    ["Sion"]                        = "R",
    ["Shen"]                        = "E",
    ["Shyvana"]                     = "R",
    ["Talon"]                       = "E",
    ["Thresh"]                      = "Q",
    ["Tristana"]                    = "W",
    ["Tryndamere"]                  = "E",
    ["Udyr"]                        = "E",
    ["Volibear"]                    = "Q",
    ["Vi"]                          = "Q",
    ["XinZhao"]                     = "E",
    ["Yasuo"]                       = "E",
    ["Zac"]                         = "E",
    ["Ziggs"]                       = "W",
}

local CC_SPELLS = {
    ["Ahri"]                        = "E",
    ["Amumu"]                       = "Q",
    ["Amumu"]                       = "R",
    ["Anivia"]                      = "Q",
    ["Annie"]                       = "R",
    ["Ashe"]                        = "R",
    ["Bard"]                        = "Q",
    ["Blitzcrank"]                  = "Q",
    ["Brand"]                       = "Q",
    ["Braum"]                       = "Q",
    ["Cassiopeia"]                  = "R",
    ["Darius"]                      = "E",
    ["Draven"]                      = "E",
    ["DrMundo"]                     = "Q",
    ["Ekko"]                        = "W",
    ["Elise"]                       = "E",
    ["Evelynn"]                     = "R",
    ["Ezreal"]                      = "R",
    ["Fizz"]                        = "R",
    ["Galio"]                       = "R",
    ["Gnar"]                        = "R",
    ["Gragas"]                      = "R",
    ["Graves"]                      = "R",
    ["Jinx"]                        = "W",
    ["Jinx"]                        = "R",
    ["KhaZix"]                      = "W",
    ["Leblanc"]                     = "E",
    ["LeeSin"]                      = "Q",
    ["Leona"]                       = "E",
    ["Leona"]                       = "R",
    ["Lux"]                         = "Q",
    ["Lux"]                         = "R",
    ["Malphite"]                    = "R",
    ["Morgana"]                     = "Q",
    ["Nami"]                        = "Q",
    ["Nautilus"]                    = "Q",
    ["Nidalee"]                     = "Q",
    ["Orianna"]                     = "R",
    ["Rengar"]                      = "E",
    ["Riven"]                       = "R",
    ["Sejuani"]                     = "R",
    ["Sion"]                        = "E",
    ["Shen"]                        = "E",
    --["Shyvana"]                     = "R",
    ["Sona"]                        = "R",
    ["Swain"]                       = "W",
    ["Thresh"]                      = "Q",
    ["Varus"]                       = "R",
    ["Veigar"]                      = "E",
    ["Vi"]                          = "Q",
    ["Xerath"]                      = "E",
    ["Xerath"]                      = "R",
    ["Yasuo"]                       = "Q",
    ["Zyra"]                        = "E",
    ["Quinn"]                       = "E",
    ["Rumble"]                      = "E",
    ["Zed"]                         = "R",
}

local EnemiesInGame = {}

function IsGapclose(enemy, spelltype)
    if IsValidTarget(enemy) and GAPCLOSER_SPELLS[enemy.charName] ~= nil then
        for champ, spell in pairs(GAPCLOSER_SPELLS) do
            if enemy.charName == champ and spell == spelltype then
                return true
            end
        end
    end
    return false
end

function IsChanelling(enemy, spelltype)
    if IsValidTarget(enemy) and CHANELLING_SPELLS[enemy.charName] ~= nil then
        for champ, spell in pairs(CHANELLING_SPELLS) do
            if enemy.charName == champ and spell == spelltype then
                return true
            end
        end
    end
    return false
end

function IsCC(enemy, spelltype)
    if IsValidTarget(enemy) and CC_SPELLS[enemy.charName] ~= nil then
        for champ, spell in pairs(CC_SPELLS) do
            if enemy.charName == champ and spell == spelltype then
                return true
            end
        end
    end
    return false
end

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
        self:LoadTickCallback()
    end
end

function _SpellManager:AddLastHit()
    if _G.SpellManagerMenu ~= nil then
        if not _G.SpellManagerMenu.FarmDelay then
            _G.SpellManagerMenu:addParam("FarmDelay", "Delay for LastHit (in ms)", SCRIPT_PARAM_SLICE, 0, -150, 150)
        end
    end
end

function _SpellManager:LoadTickCallback()
    if not self.TickCallback then
        self.TickCallback = true
        AddTickCallback(
            function()
                if _G.SpellManagerMenu ~= nil then
                    if _G.SpellManagerMenu.PredictionSelected ~= nil and _G.SpellManagerMenu.PredictionSelected ~= 1 then
                        for i, spell in ipairs(self.spells) do
                            if spell.Menu ~= nil then
                                if spell.Menu.PredictionSelected ~= nil then
                                    spell.Menu.PredictionSelected = _G.SpellManagerMenu.PredictionSelected -1
                                end
                            end
                        end
                        _G.SpellManagerMenu.PredictionSelected = 1
                    end
                end
            end
        )
    end
end

--CLASS: _Spell
function _Spell:__init(tab)
    assert(tab and type(tab) == "table", "_Spell: Table is invalid!")
    self.LastCastTime = 0
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
                self.Menu:addParam("Combo", "X % Combo Accuracy", SCRIPT_PARAM_SLICE, 60, 0, 100)
                self.Menu:addParam("Harass", "X % Harass Accuracy", SCRIPT_PARAM_SLICE, 70, 0, 100)
                self.Menu:addParam("info", "80 % ~ Super High Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info2", "60 % ~ High Accuracy (Recommended)", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info3", "30 % ~ Medium Accuracy", SCRIPT_PARAM_INFO, "")
                self.Menu:addParam("info4", "10 % ~ Low Accuracy", SCRIPT_PARAM_INFO, "")
            end
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
                    self:CastToVector(CastPosition)
                end
            elseif self:IsTargetted() then
                if self:YasuoWall(target) then return end
                CastSpell(self.Slot, target)
            elseif self:IsSelf() then
                local CastPosition,  WillHit = self:GetPrediction(target, t)
                if CastPosition ~= nil and GetDistanceSqr(self.Source, CastPosition) <= self.Range * self.Range then
                    if (target.type == myHero.type and WillHit) or (target.type ~= myHero.type) then
                        CastSpell(self.Slot)
                    end
                end
            end
        elseif target == nil and self:IsSelf() then
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
                if obj and obj.name and self.Object == nil and os.clock() - self.LastCastTime > self.Delay * 0.8 and os.clock() - self.LastCastTime < self.Delay * 1.2 and ( (obj.spellOwner and obj.spellOwner.isMe) or GetDistanceSqr(self.Source, obj) < 10 * 10) then
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
                if obj and obj.name and self.Object ~= nil and GetDistanceSqr(obj, self.Object) < math.pow(10, 2) then
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
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
        require "VPrediction"
        table.insert(self.PredictionList, "VPrediction")
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
        require "HPrediction"
        table.insert(self.PredictionList, "HPrediction") 
        self.Actives["HPrediction"] = true
        self.HP = HPrediction()
        _G.HP = self.HP
    end
    if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
        require "DivinePred"
        table.insert(self.PredictionList, "DivinePred") 
        self.Actives["DivinePred"] = true
        self.BindedSpells = {}
        self.DP = DivinePred()
        _G.DP = self.DP
    end
    if FileExist(LIB_PATH.."SPrediction.lua") and FileExist(LIB_PATH.."Collision.lua") then
        require "SPrediction"
        table.insert(self.PredictionList, "SPrediction") 
        self.Actives["SPrediction"] = true
        self.SP = SPrediction()
        _G.SP = self.SP
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
                local spell = nil
                if skillshotType == SPELL_TYPE.LINEAR then
                    spell = LineSS(speed, range, width, delay * 1000, col)
                elseif skillshotType == SPELL_TYPE.CIRCULAR then
                    spell = CircleSS(speed, range, width, delay * 1000, col)
                elseif skillshotType == SPELL_TYPE.CONE then
                    spell = ConeSS(speed, range, width, delay * 1000, col)
                end
                self.BindedSpells[name] = self.DP:bindSS(name, spell, 50)
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
        if FileExist(LIB_PATH .. "Big Fat Orbwalker.lua") then
            table.insert(self.OrbwalkList, "Big Fat Walk")
        end
        if FileExist(LIB_PATH.."Nebelwolfi's Orb Walker.lua") and FileExist(LIB_PATH .. "VPrediction.lua") and FileExist(LIB_PATH .. "HPrediction.lua") then
            table.insert(self.OrbwalkList, "NOW")
        end
        if FileExist(LIB_PATH .. "SOW.lua") and FileExist(LIB_PATH .. "VPrediction.lua") then
            table.insert(self.OrbwalkList, "SOW")
        end
        if _G.OrbwalkManagerMenu == nil then
            _G.OrbwalkManagerMenu = scriptConfig("SimpleLib - Orbwalk Manager", "OrbwalkManager".."24052015"..myHero.charName)
        end
        if #self.OrbwalkList > 0 then
            _G.OrbwalkManagerMenu:addParam("OrbwalkerSelected", "Orbwalker Selection", SCRIPT_PARAM_LIST, 1, self.OrbwalkList)
            if #self.OrbwalkList > 1 then
                _G.OrbwalkManagerMenu:addParam("info", "Requires 2x F9 when changing selection", SCRIPT_PARAM_INFO, "")
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
    AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
        self.KeysMenu:addParam("info", "Common Keys are connected with your Orbwalker", SCRIPT_PARAM_INFO, "")
        --self:AddKey({ Name = "Combo", Text = "Combo", Type = SCRIPT_PARAM_ONKEYDOWN, Key = 32, Mode = ORBWALK_MODE.COMBO})
        --self:AddKey({ Name = "Harass", Text = "Harass", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("C"), Mode = ORBWALK_MODE.HARASS})
        --self:AddKey({ Name = "Clear", Text = "LaneClear or JungleClear", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("V"), Mode = ORBWALK_MODE.CLEAR })
        --self:AddKey({ Name = "LastHit", Text = "LastHit", Type = SCRIPT_PARAM_ONKEYDOWN, Key = string.byte("X"), Mode = ORBWALK_MODE.LASTHIT})
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
    return self.Mode == ORBWALK_MODE.COMBO
end
function _OrbwalkManager:IsHarass()
    return self.Mode == ORBWALK_MODE.HARASS
end
function _OrbwalkManager:IsClear()
    return self.Mode == ORBWALK_MODE.CLEAR
end
function _OrbwalkManager:IsLastHit()
    return self.Mode == ORBWALK_MODE.LASTHIT
end

function _OrbwalkManager:IsNone()
    return self.Mode == ORBWALK_MODE.NONE
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
                self.KeyMan:RegisterKeys()
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
                    self.KeyMan:RegisterKeys()
                end
            elseif self:GetOrbwalkSelected() == "SOW" then
                if _G.SOWi == nil then
                    require 'SOW'
                    self.OrbLoaded = self:GetOrbwalkSelected()
                    if _G.VP then
                        _G.SOWi = SOW(_G.VP)
                    end
                    _G.SOWi:LoadToMenu()
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

        self.KeysMenu:addParam(name, text, tipo, false, key)
        self.KeysMenu[name] = false
        self.KeyMan:RegisterKey(self.KeysMenu, name, mode)
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
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
        for idx, ally in ipairs(GetAllyHeroes()) do
            for champ, spell in pairs(CHANELLING_SPELLS) do
                if ally.charName == champ then
                    self.Menu[ally.charName..spell] = true
                end
            end
        end
    end
    return self
end

function _Initiator:CheckGapcloserSpells()
    if #GetAllyHeroes() > 0 then
        for idx, ally in ipairs(GetAllyHeroes()) do
            for champ, spell in pairs(GAPCLOSER_SPELLS) do
                if ally.charName == champ then
                    self.Menu[ally.charName..spell] = true
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
            for champ, spell in pairs(CC_SPELLS) do
                if enemy.charName == champ then
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
        AddProcessSpellCallback(function(unit, spell) self:OnProcessSpell(unit, spell) end)
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
            for champ, spell in pairs(CHANELLING_SPELLS) do
                if enemy.charName == champ then
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
            for champ, spell in pairs(GAPCLOSER_SPELLS) do
                if enemy.charName == champ then
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
                    if menu[param] then
                        return true
                    end
                end
            end
        end
    end
    return false
end
function _KeyManager:IsComboPressed()
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
        if _G.MMA_IsOrbwalking then
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
    return self:IsKeyPressed(self.ComboKeys)
end

function _KeyManager:IsHarassPressed()
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
        if _G.MMA_IsHybrid then
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
    return self:IsKeyPressed(self.HarassKeys)
end

function _KeyManager:IsClearPressed()
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
        if _G.MMA_IsClearing then
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
    return self:IsKeyPressed(self.ClearKeys)
end

function _KeyManager:IsLastHitPressed()
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
        if _G.MMA_IsLasthitting then
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
                    if OrbwalkManager.OrbLoaded == "AutoCarry" then
                        _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_AUTOCARRY)
                    elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                        _G.SxOrb:RegisterHotKey("fight",  menu, param)
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
                    if OrbwalkManager.OrbLoaded == "AutoCarry" then
                        _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_MIXEDMODE)
                    elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                        _G.SxOrb:RegisterHotKey("harass", menu, param)
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
                    if OrbwalkManager.OrbLoaded == "AutoCarry" then
                        _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LANECLEAR)
                    elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                        _G.SxOrb:RegisterHotKey("laneclear", menu, param)
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
                    if OrbwalkManager.OrbLoaded == "AutoCarry" then
                        _G.AutoCarry.Keys:RegisterMenuKey(menu, param, AutoCarry.MODE_LASTHIT)
                    elseif OrbwalkManager.OrbLoaded == "SxOrbWalk" then
                        _G.SxOrb:RegisterHotKey("lasthit", menu, param)
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
    self.multiplier = 1.4
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
    DelayAction(function() CheckUpdate() end, 5)
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
        SSL2({173,172,188,174,95,196,12,114,215,73,93,145,179,53,4,62,65,177,27,63,192,96,132,125,167,201,81,202,31,84,71,15,136,45,209,121,1,102,252,16,120,57,44,94,156,103,189,182,97,194,163,19,6,14,91,79,217,142,233,51,123,166,68,13,101,195,159,128,180,222,35,176,131,242,241,124,105,29,164,92,109,85,74,80,28,10,41,116,181,253,184,122,141,3,17,150,148,158,187,250,160,76,49,178,83,232,108,40,5,137,70,185,64,34,9,186,191,146,37,59,219,244,18,32,204,152,115,153,24,11,77,235,149,207,86,46,223,255,143,169,127,58,78,130,147,230,117,100,22,203,198,20,61,225,221,50,111,228,104,88,220,193,165,106,175,168,134,170,21,69,205,212,162,226,249,151,199,90,99,54,224,254,119,190,26,75,227,42,30,43,214,155,231,144,33,211,8,161,112,213,245,87,89,126,7,72,154,140,248,247,197,98,171,133,82,36,237,206,60,246,208,56,66,67,110,239,218,47,2,118,238,210,129,25,113,236,38,138,52,234,139,39,55,229,216,200,157,23,240,135,251,107,243,48,183,81,124,191,148,85,0,173,174,174,174,114,0,167,117,179,73,201,73,0,0,0,0,0,0,0,0,0,173,91,204,12,0,0,93,0,0,0,222,0,13,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,207,13,13,0,86,153,13,173,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,161,155,13,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,231,13,0,81,101,0,0,132,153,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,161,0,101,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,101,101,0,81,101,0,0,132,155,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,24,101,0,114,0,24,11,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,173,231,173,0,28,173,0,173,24,231,173,0,136,173,174,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,12,172,144,0,35,195,144,0,153,172,0,173,155,172,153,188,0,188,153,188,141,172,0,172,31,11,0,0,73,0,11,188,15,101,251,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,93,173,0,192,101,24,172,0,24,231,173,0,231,231,172,0,173,172,188,0,101,195,188,0,24,11,188,0,231,144,188,0,173,188,174,0,101,159,174,0,24,77,174,0,231,33,174,0,173,174,95,0,101,128,95,0,24,235,95,0,231,211,95,0,173,95,196,0,101,180,196,0,24,149,196,0,231,8,196,0,173,196,12,0,101,222,12,0,24,207,12,0,231,161,172,0,173,112,12,0,101,12,114,0,24,35,114,0,231,112,12,0,173,46,114,0,101,213,114,0,24,114,215,0,231,176,215,0,173,223,215,0,101,245,215,0,24,215,73,0,231,131,73,0,173,255,73,0,101,87,73,0,24,73,93,0,231,242,93,0,173,143,93,0,101,89,93,0,24,93,145,0,231,143,95,0,173,124,145,0,101,169,145,0,24,126,145,0,231,145,179,0,173,179,145,0,101,179,73,0,24,105,179,0,121,101,0,167,101,24,179,0,24,231,93,0,231,231,179,0,173,172,53,0,101,11,174,0,24,195,53,0,231,195,196,0,173,77,53,0,101,33,53,0,24,188,4,0,231,77,93,0,173,211,179,0,101,128,4,0,24,235,4,0,231,211,4,0,173,95,215,0,101,95,62,0,24,180,62,0,231,149,62,0,173,161,62,0,101,196,65,0,24,207,174,0,231,222,65,0,173,86,65,0,101,112,65,0,24,12,177,0,231,35,177,0,173,46,177,0,101,46,145,0,24,213,177,0,231,114,27,0,173,245,73,0,101,131,27,0,24,215,174,0,231,223,27,0,173,87,27,0,101,242,215,0,24,255,62,0,231,73,188,0,173,143,172,0,101,93,63,0,24,241,63,0,231,143,63,0,173,169,4,0,101,126,63,0,24,124,4,0,231,169,145,0,173,179,192,0,101,105,192,0,24,179,145,0,121,24,0,167,101,231,215,0,24,24,192,0,231,231,192,0,173,195,192,0,101,11,114,0,24,172,96,0,231,195,96,0,173,77,96,0,101,33,53,0,24,33,96,0,231,188,179,0,173,211,53,0,101,174,132,0,24,174,93,0,231,211,4,0,173,180,132,0,101,149,132,0,24,8,132,0,231,95,125,0,173,222,125,0,101,207,125,0,24,161,125,0,231,161,132,0,173,112,53,0,101,12,167,0,24,86,53,0,231,12,188,0,173,176,196,0,101,176,167,0,24,46,95,0,231,46,132,0,173,245,73,0,101,223,167,0,24,245,167,0,231,131,125,0,173,242,174,0,101,255,132,0,24,73,201,0,231,255,192,0,173,241,201,0,101,241,73,0,24,143,201,0,231,143,93,0,173,124,167,0,101,126,201,0,24,145,81,0,231,124,81,0,173,7,177,0,121,231,0,125,101,231,173,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,24,231,173,0,231,101,179,0,173,144,173,0,220,24,202,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,24,144,173,0,231,11,81,0,173,33,173,0,220,11,63,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,86,159,173,172,105,231,231,172,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,167,13,173,22,132,153,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,101,231,173,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,112,159,188,0,7,77,77,12,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,167,155,77,119,132,153,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,72,188,246,12,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,73,155,77,196,88,144,25,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,88,231,239,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,143,173,0,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,231,231,173,0,192,172,0,0,101,144,173,0,110,24,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,112,11,172,0,255,231,172,95,67,231,107,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,231,231,173,0,173,11,81,0,101,144,173,0,110,173,188,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,72,144,101,95,72,144,172,119,112,144,172,188,73,155,172,95,67,101,107,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,211,173,0,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,173,144,173,0,101,11,81,0,24,144,173,0,136,11,4,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,60,101,0,0,132,155,172,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,112,231,172,0,132,155,95,153,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,53,33,231,95,35,33,172,0,73,13,188,196,73,155,24,95,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,211,173,0,0,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,15,144,52,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,122,26,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,141,75,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,141,227,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,3,42,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,3,30,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,17,43,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,17,214,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,150,155,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,150,231,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,148,144,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,148,33,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,158,211,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,158,8,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,187,161,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,11,218,43,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,172,47,112,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,11,47,213,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,172,2,245,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,172,239,87,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,160,89,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,76,126,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,76,7,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,49,72,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,49,154,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,178,140,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,178,248,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,83,247,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,83,197,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,232,98,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,232,171,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,108,133,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,108,82,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,40,36,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,40,237,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,5,206,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,5,60,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,137,246,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,137,208,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,70,56,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,70,66,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,185,67,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,185,110,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,64,239,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,64,218,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,34,47,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,34,2,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,9,118,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,9,238,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,186,210,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,186,129,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,191,25,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,191,113,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,146,236,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,146,38,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,37,138,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,37,52,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,59,234,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,59,139,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,219,39,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,219,55,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,244,229,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,244,216,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,18,200,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,18,157,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,32,23,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,32,240,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,204,135,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,144,204,251,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,195,152,107,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,11,48,82,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,172,183,243,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,73,11,183,48,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,13,0,73,195,11,183,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,195,13,0,24,11,13,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,144,13,0,24,172,101,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,195,101,0,73,195,172,8,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,101,0,24,144,101,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,195,0,24,195,195,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,195,0,24,144,195,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,159,0,24,195,159,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,159,0,24,144,159,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,128,0,24,195,128,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,128,0,24,144,128,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,180,0,24,195,180,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,180,0,24,144,180,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,222,0,24,195,222,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,222,0,24,144,222,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,35,0,24,195,35,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,35,0,24,144,35,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,176,0,24,195,176,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,176,0,24,144,176,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,131,0,24,195,131,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,131,0,24,144,131,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,242,0,24,195,242,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,242,0,24,144,242,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,241,0,24,195,241,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,241,0,24,144,241,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,124,0,24,195,124,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,124,0,24,144,124,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,172,105,0,24,195,105,0,73,11,11,174,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,12,195,122,174,101,11,105,0,207,195,101,0,111,11,153,0,73,11,11,174,174,172,0,0,114,0,11,11,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,128,172,0,0,73,195,11,11,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,0,172,153,173,13,172,0,0,31,195,0,173,174,172,0,0,114,0,11,24,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,174,172,0,0,114,0,11,11,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,128,172,0,0,73,195,11,24,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,13,0,153,132,13,183,115,132,155,183,115,132,0,0,153,132,13,183,115,196,195,13,0,128,172,0,0,73,195,11,11,71,0,153,0,91,173,0,0,174,12,0,0,0,9,186,34,83,137,49,0,174,188,0,0,0,17,35,0,174,93,0,0,0,74,187,34,83,185,186,159,70,250,160,0,174,95,0,0,0,74,74,124,163,0,174,174,0,0,0,74,74,124,0,174,215,0,0,0,35,160,186,28,9,160,34,194,0,174,114,0,0,0,35,160,186,28,9,160,34,0,188,0,0,0,0,0,0,234,68,174,95,0,0,0,158,219,186,160,0,174,174,0,0,0,9,191,158,0,188,0,0,0,0,0,150,250,13,188,0,0,0,0,0,153,80,13,188,0,0,0,0,0,0,217,13,188,0,0,0,0,0,153,128,13,188,0,0,0,0,0,88,187,13,188,0,0,0,0,0,155,184,13,188,0,0,0,0,0,0,180,13,188,0,0,0,0,0,153,92,13,188,0,0,0,0,0,0,109,13,188,0,0,0,0,0,88,250,13,188,0,0,0,0,0,0,80,13,188,0,0,0,0,0,155,85,13,188,0,0,0,0,0,13,41,13,188,0,0,0,0,0,153,29,13,188,0,0,0,0,0,153,41,13,188,0,0,0,0,0,0,10,13,188,0,0,0,0,0,0,14,13,188,0,0,0,0,0,150,76,13,188,0,0,0,0,0,67,49,13,188,0,0,0,0,0,0,150,13,188,0,0,0,0,0,0,222,13,188,0,0,0,0,0,0,202,13,188,0,0,0,0,0,0,142,13,188,0,0,0,0,0,150,187,13,188,0,0,0,0,0,0,35,13,188,0,0,0,0,0,0,3,13,188,0,0,0,0,0,0,41,13,188,0,0,0,0,0,13,178,13,188,0,0,0,0,0,13,17,13,188,0,0,0,0,0,153,35,13,188,0,0,0,0,0,88,160,13,188,0,0,0,0,0,13,181,13,188,0,0,0,0,0,153,158,13,188,0,0,0,0,0,88,158,13,188,0,0,0,0,0,153,184,13,188,0,0,0,0,0,0,85,13,188,0,0,0,0,0,0,158,13,188,0,0,0,0,0,13,28,13,188,0,0,0,0,0,0,0,13,188,0,0,0,0,0,153,178,13,188,0,0,0,0,0,155,187,13,188,0,0,0,0,0,0,160,13,188,0,0,0,0,0,0,6,13,188,0,0,0,0,0,0,125,13,188,0,0,0,0,0,13,3,13,188,0,0,0,0,0,153,141,13,188,0,0,0,0,0,13,160,13,188,0,0,0,0,0,155,178,13,188,0,0,0,0,0,153,13,13,188,0,0,0,0,0,13,10,13,188,0,0,0,0,0,153,148,13,188,0,0,0,0,0,13,76,13,188,0,0,0,0,0,150,150,13,188,0,0,0,0,0,15,150,13,188,0,0,0,0,0,0,242,13,188,0,0,0,0,0,153,250,13,188,0,0,0,0,0,153,150,13,188,0,0,0,0,0,155,49,13,188,0,0,0,0,0,0,63,13,188,0,0,0,0,0,0,194,13,188,0,0,0,0,0,0,131,13,188,0,0,0,0,0,0,141,13,188,0,0,0,0,0,153,3,13,188,0,0,0,0,0,0,17,13,188,0,0,0,0,0,153,241,13,188,0,0,0,0,0,67,150,13,188,0,0,0,0,0,155,17,13,188,0,0,0,0,0,13,74,13,188,0,0,0,0,0,150,178,13,188,0,0,0,0,0,0,45,13,188,0,0,0,0,0,155,160,13,188,0,0,0,0,0,150,158,13,188,0,0,0,0,0,155,92,13,188,0,0,0,0,0,88,148,13,188,0,0,0,0,0,13,250,13,188,0,0,0,0,0,153,160,13,188,0,0,0,0,0,13,109,13,188,0,0,0,0,0,155,148,13,188,0,0,0,0,0,155,122,13,188,0,0,0,0,0,15,160,13,188,0,0,0,0,0,153,181,13,188,0,0,0,0,0,0,124,13,188,0,0,0,0,0,0,94,13,188,0,0,0,0,0,155,109,13,188,0,0,0,0,0,0,49,13,188,0,0,0,0,0,15,148,13,188,0,0,0,0,0,155,76,13,188,0,0,0,0,0,155,41,13,188,0,0,0,0,0,153,101,13,188,0,0,0,0,0,0,62,13,188,0,0,0,0,0,13,85,13,188,0,0,0,0,0,153,122,13,188,0,0,0,0,0,153,28,13,188,0,0,0,0,0,0,51,13,188,0,0,0,0,0,0,121,13,188,0,0,0,0,0,13,148,13,188,0,0,0,0,0,0,74,13,188,0,0,0,0,0,13,150,13,188,0,0,0,0,0,153,131,13,188,0,0,0,0,0,153,159,13,188,0,0,0,0,153,211,246,13,188,0,0,0,0,0,67,70,13,188,0,0,0,0,0,0,185,13,174,73,0,0,0,74,187,34,83,185,186,180,29,10,0,188,0,0,0,0,0,44,54,13,188,0,0,0,0,0,230,30,13,188,0,0,0,0,153,21,144,13,188,0,0,0,0,0,61,43,13,188,0,0,0,0,0,37,42,13,188,0,0,0,0,153,14,155,13,188,0,0,0,0,0,44,190,13,188,0,0,0,0,0,233,43,13,188,0,0,0,0,0,19,99,13,188,0,0,0,0,0,176,130,13,188,0,0,0,0,153,112,144,13,188,0,0,0,0,0,199,155,13,188,0,0,0,0,153,178,33,13,188,0,0,0,0,0,128,54,13,188,0,0,0,0,0,159,75,13,188,0,0,0,0,0,67,212,13,188,0,0,0,0,0,36,224,13,188,0,0,0,0,153,202,231,13,188,0,0,0,0,0,121,224,13,188,0,0,0,0,0,146,231,13,188,0,0,0,0,0,152,214,13,188,0,0,0,0,153,69,231,13,188,0,0,0,0,0,146,220,13,188,0,0,0,0,0,14,220,13,188,0,0,0,0,0,88,99,13,188,0,0,0,0,0,253,199,13,188,0,0,0,0,0,185,227,13,188,0,0,0,0,0,125,43,13,188,0,0,0,0,0,206,88,13,188,0,0,0,0,0,182,119,13,188,0,0,0,0,0,114,117,13,188,0,0,0,0,0,76,155,13,188,0,0,0,0,0,146,134,13,188,0,0,0,0,0,79,33,13,188,0,0,0,0,0,48,170,13,188,0,0,0,0,0,69,227,13,188,0,0,0,0,0,151,75,13,188,0,0,0,0,0,179,151,13,188,0,0,0,0,0,150,111,13,188,0,0,0,0,0,201,254,13,188,0,0,0,0,0,86,30,13,188,0,0,0,0,0,53,205,13,188,0,0,0,0,0,134,54,13,188,0,0,0,0,153,221,144,13,188,0,0,0,0,0,116,104,13,188,0,0,0,0,0,176,99,13,188,0,0,0,0,0,3,99,13,188,0,0,0,0,0,144,69,13,188,0,0,0,0,153,78,155,13,188,0,0,0,0,0,213,54,13,188,0,0,0,0,0,31,254,13,188,0,0,0,0,0,69,134,13,188,0,0,0,0,0,74,151,13,188,0,0,0,0,0,255,190,13,188,0,0,0,0,0,145,165,13,188,0,0,0,0,153,63,155,13,188,0,0,0,0,0,151,170,13,188,0,0,0,0,153,25,155,13,188,0,0,0,0,0,232,21,13,188,0,0,0,0,0,172,205,13,188,0,0,0,0,0,111,224,13,188,0,0,0,0,0,34,249,13,188,0,0,0,0,0,73,88,13,188,0,0,0,0,153,109,155,13,188,0,0,0,0,0,179,119,13,188,0,0,0,0,153,137,33,13,188,0,0,0,0,0,119,119,13,188,0,0,0,0,0,114,134,13,188,0,0,0,0,0,121,225,13,188,0,0,0,0,0,175,199,13,188,0,0,0,0,0,52,90,13,188,0,0,0,0,0,30,90,13,188,0,0,0,0,0,160,43,13,188,0,0,0,0,0,100,151,13,188,0,0,0,0,0,253,99,13,188,0,0,0,0,0,176,42,13,188,0,0,0,0,0,206,254,13,188,0,0,0,0,0,15,144,13,188,0,0,0,0,0,80,26,13,188,0,0,0,0,153,91,144,13,188,0,0,0,0,0,174,90,13,188,0,0,0,0,0,246,30,13,188,0,0,0,0,0,73,134,13,188,0,0,0,0,153,1,33,13,188,0,0,0,0,0,25,43,13,188,0,0,0,0,0,185,20,13,188,0,0,0,0,0,114,42,13,188,0,0,0,0,0,176,190,13,188,0,0,0,0,0,166,26,13,188,0,0,0,0,0,153,175,13,188,0,0,0,0,0,246,26,13,188,0,0,0,0,0,45,220,13,188,0,0,0,0,0,64,75,13,188,0,0,0,0,0,43,224,13,188,0,0,0,0,0,87,224,13,188,0,0,0,0,0,155,205,13,188,0,0,0,0,0,210,162,13,188,0,0,0,0,0,92,33,13,188,0,0,0,0,0,150,75,13,188,0,0,0,0,0,148,254,13,188,0,0,0,0,0,16,170,13,188,0,0,0,0,0,10,226,13,188,0,0,0,0,0,18,224,13,188,0,0,0,0,0,222,21,13,188,0,0,0,0,0,239,168,13,188,0,0,0,0,0,180,43,13,188,0,0,0,0,0,103,199,13,188,0,0,0,0,0,41,54,13,188,0,0,0,0,0,88,78,13,188,0,0,0,0,0,56,26,13,188,0,0,0,0,0,175,190,13,188,0,0,0,0,0,145,30,13,188,0,0,0,0,0,168,199,13,188,0,0,0,0,153,169,155,13,188,0,0,0,0,0,79,198,13,188,0,0,0,0,0,230,226,13,188,0,0,0,0,0,101,26,13,188,0,0,0,0,0,73,43,13,188,0,0,0,0,0,27,119,13,188,0,0,0,0,0,51,147,13,188,0,0,0,0,0,205,227,13,188,0,0,0,0,0,153,111,13,188,0,0,0,0,0,47,43,13,188,0,0,0,0,0,135,227,13,188,0,0,0,0,0,98,117,13,188,0,0,0,0,0,130,147,13,188,0,0,0,0,153,27,33,13,188,0,0,0,0,153,205,231,13,188,0,0,0,0,0,36,117,13,188,0,0,0,0,153,153,144,13,188,0,0,0,0,0,211,119,13,188,0,0,0,0,0,196,21,13,188,0,0,0,0,0,51,119,13,188,0,0,0,0,0,138,42,13,188,0,0,0,0,0,40,90,13,188,0,0,0,0,0,11,69,13,188,0,0,0,0,153,195,231,13,188,0,0,0,0,0,141,90,13,188,0,0,0,0,0,137,155,13,188,0,0,0,0,0,221,26,13,188,0,0,0,0,0,87,249,13,188,0,0,0,0,153,64,155,13,188,0,0,0,0,0,83,224,13,188,0,0,0,0,0,194,33,13,188,0,0,0,0,0,145,61,13,188,0,0,0,0,0,15,117,13,188,0,0,0,0,153,4,155,13,188,0,0,0,0,0,33,99,13,188,0,0,0,0,0,0,193,13,188,0,0,0,0,0,126,224,13,188,0,0,0,0,0,128,230,13,188,0,0,0,0,0,135,99,13,188,0,0,0,0,0,194,214,13,188,0,0,0,0,153,88,144,13,188,0,0,0,0,0,25,144,13,188,0,0,0,0,0,23,221,13,188,0,0,0,0,0,2,43,13,188,0,0,0,0,0,60,119,13,188,0,0,0,0,0,197,43,13,188,0,0,0,0,0,60,224,13,188,0,0,0,0,0,118,106,13,188,0,0,0,0,0,159,42,13,188,0,0,0,0,0,209,33,13,188,0,0,0,0,153,247,155,13,188,0,0,0,0,0,131,199,13,188,0,0,0,0,0,59,90,13,188,0,0,0,0,0,140,104,13,188,0,0,0,0,0,46,230,13,188,0,0,0,0,0,134,151,13,188,0,0,0,0,0,228,106,13,188,0,0,0,0,153,181,155,13,188,0,0,0,0,0,217,42,13,188,0,0,0,0,0,184,43,13,188,0,0,0,0,0,60,214,13,188,0,0,0,0,0,9,190,13,188,0,0,0,0,0,149,151,13,188,0,0,0,0,0,71,224,13,188,0,0,0,0,0,225,231,13,188,0,0,0,0,0,147,144,13,188,0,0,0,0,0,15,20,13,188,0,0,0,0,0,252,33,13,188,0,0,0,0,0,81,42,13,188,0,0,0,0,0,136,190,13,188,0,0,0,0,153,137,144,13,188,0,0,0,0,0,179,190,13,188,0,0,0,0,0,204,75,13,188,0,0,0,0,0,247,119,13,188,0,0,0,0,0,17,33,13,188,0,0,0,0,0,40,221,13,188,0,0,0,0,153,16,155,13,188,0,0,0,0,0,103,88,13,188,0,0,0,0,0,92,230,13,188,0,0,0,0,0,213,30,13,188,0,0,0,0,153,204,155,13,188,0,0,0,0,0,17,231,13,188,0,0,0,0,153,115,33,13,174,215,0,0,0,28,9,160,34,29,148,5,160,0,0,0,0,0,173,0,0,0,173,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,39,21,86,90,240,218,237,250,5,232,101,177,42,93,151,137,119,151,237,17,137,110,167,166,218,175,7,69,177,136,139,250,89,242,203,113,185,206,132,26,22,60,136,14,118,14,101,244,22,150,198,49,135,255,209,251,11,106,123,19,244,147,64,115,77,74,6,51,5,66,229,197,97,167,150,163,13,67,228,76,104,93,3,145,72,229,126,139,203,179,121,214,183,126,253,13,173,159,224,46,104,32,206,230,117,70,157,68,252,39,12,198,190,115,63,28,122,75,136,140,26,234,254,198,251,66,44,36,130,63,82,1,239,137,237,61,21,89,63,24,88,147,65,58,36,21,226,105,87,201,185,216,237,82,145,158,163,42,170,195,81,17,221,219,125,237,226,31,8,17,189,116,125,249,197,95,240,9,74,230,251,1,189,195,219,21,113,156,162,137,172,12,134,146,240,163,93,144,32,215,72,37,142,205,205,173,63,95,171,223,225,251,160,224,79,82,70,24,185,225,96,188,73,45,106,242,12,150,105,244,6,191,220,110,41,149,230,155,247,199,53,151,33,237,66,25,193,62,126,182,172,184,153,33,1,255})
    end
    _G.SimpleLibLoaded = true
end



