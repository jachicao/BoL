local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.08

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
        AddProcessSpellCallback(
            function(unit, spell)
                if unit and unit.valid and spell and spell.name and unit.isMe then
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
        )
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
        AddProcessSpellCallback(
            function(unit, spell)
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
        )
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
        AddProcessSpellCallback(
            function(unit, spell)
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
        )

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
        AddProcessSpellCallback(
            function(unit, spell)
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
        )
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
        SSL2({182,34,31,162,56,138,191,247,103,63,4,69,207,226,71,41,193,198,52,81,58,212,250,216,167,159,145,21,232,107,158,156,79,134,201,76,242,249,234,205,224,93,171,217,203,14,85,17,199,200,151,70,240,184,244,146,77,27,192,92,190,180,96,233,209,32,124,121,83,185,221,175,142,220,168,115,117,129,163,133,116,160,7,45,245,147,239,62,141,35,38,101,140,13,123,153,144,170,43,26,9,10,73,135,251,118,105,120,130,47,1,5,128,206,231,87,57,218,48,109,102,178,230,98,150,152,188,16,44,228,174,136,229,176,12,75,84,227,53,30,114,65,39,112,252,186,223,36,164,61,235,54,91,219,143,236,18,148,157,204,67,187,183,24,210,68,64,131,23,243,42,28,6,122,173,88,19,211,29,169,225,161,196,179,149,59,15,108,215,110,139,55,78,89,111,99,2,119,155,241,20,254,97,181,40,166,74,90,106,154,237,189,95,125,248,213,60,253,165,46,113,172,238,82,197,137,132,195,202,66,246,194,86,25,126,3,214,94,127,104,100,33,37,22,8,208,49,222,11,255,50,80,51,177,72,145,115,57,144,160,0,182,162,162,162,247,0,167,223,207,63,159,63,0,0,0,0,0,0,0,0,0,182,27,85,247,0,0,4,0,0,0,185,0,233,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,176,233,233,0,12,16,233,182,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,119,55,233,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,138,78,233,0,145,209,0,0,250,16,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,119,0,209,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,138,209,209,0,145,209,0,0,250,55,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,138,44,209,0,247,0,44,228,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,182,78,182,0,245,182,0,182,44,78,182,0,79,182,162,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,191,34,89,0,221,32,89,0,16,34,0,182,55,34,16,31,0,31,16,31,140,34,0,34,232,228,0,0,63,0,228,31,156,209,50,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,4,182,0,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,209,78,182,0,164,182,0,0,78,78,182,0,144,44,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,221,34,34,0,63,209,34,162,153,78,80,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,209,78,182,0,44,44,34,0,78,78,182,0,144,182,31,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,129,89,209,162,129,32,34,229,221,32,34,34,63,233,34,162,153,209,80,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,168,182,16,52,44,78,34,0,78,182,31,0,182,32,31,0,209,228,31,0,44,89,31,0,78,34,162,0,182,124,162,0,209,174,162,0,44,111,162,0,78,31,56,0,182,121,56,0,209,136,56,0,44,99,56,0,78,162,138,0,182,83,138,0,209,229,138,0,44,2,138,0,78,56,191,0,182,185,191,0,209,176,191,0,44,119,191,0,78,138,247,0,182,221,247,0,209,12,247,0,44,155,247,0,78,155,138,0,182,247,103,0,209,175,191,0,44,175,103,0,78,75,138,0,182,84,103,0,209,20,103,0,44,103,63,0,78,142,63,0,182,227,63,0,209,254,63,0,44,63,4,0,78,220,4,0,182,53,247,0,209,53,4,0,44,97,4,0,78,4,69,0,182,115,69,0,209,30,69,0,44,181,69,0,78,69,207,0,182,114,63,0,209,40,247,0,44,117,207,0,78,114,207,0,26,209,0,167,44,44,4,0,78,182,138,0,182,89,207,0,209,34,226,0,44,228,247,0,78,34,103,0,182,124,226,0,209,174,226,0,44,111,226,0,78,31,71,0,182,99,207,0,209,121,71,0,44,121,56,0,78,136,71,0,182,83,226,0,209,2,71,0,44,83,71,0,78,56,41,0,182,185,41,0,209,176,41,0,44,119,41,0,78,138,247,0,182,191,193,0,209,221,193,0,44,155,41,0,78,155,103,0,182,75,193,0,209,241,193,0,44,247,198,0,78,75,41,0,182,103,138,0,209,20,182,0,44,103,198,0,78,142,198,0,182,227,198,0,209,254,198,0,44,63,52,0,78,63,138,0,182,168,52,0,209,53,52,0,44,53,63,0,78,97,138,0,182,30,56,0,209,181,52,0,44,69,81,0,78,69,138,0,182,117,81,0,209,114,81,0,44,40,81,0,78,207,58,0,26,44,0,167,44,209,58,0,78,44,103,0,182,228,58,0,209,89,58,0,44,89,226,0,78,34,212,0,182,124,212,0,209,174,69,0,44,174,212,0,78,111,212,0,182,162,250,0,209,121,250,0,44,99,69,0,78,99,31,0,182,229,250,0,209,2,250,0,26,78,0,247,44,78,182,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,78,78,182,0,182,89,63,0,209,89,182,0,197,44,21,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,78,89,182,0,182,174,34,0,209,111,182,0,197,228,81,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,155,174,44,34,114,78,209,31,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,167,16,182,88,250,16,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,44,78,182,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,191,136,31,0,207,99,31,247,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,167,0,136,88,250,16,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,226,136,62,247,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,63,0,162,191,82,89,25,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,82,78,137,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,97,182,0,52,182,89,216,0,209,228,193,0,44,228,4,0,78,34,41,0,182,31,247,0,209,31,167,0,44,111,63,0,78,124,52,0,182,162,193,0,209,121,167,0,44,136,167,0,78,99,167,0,182,83,69,0,209,56,159,0,44,83,193,0,78,83,159,0,182,176,63,0,209,176,159,0,44,119,159,0,78,138,145,0,182,221,145,0,209,12,145,0,44,155,145,0,78,155,226,0,182,247,21,0,209,175,21,0,44,75,21,0,78,175,52,0,182,20,21,0,209,103,232,0,44,103,56,0,78,20,34,0,182,220,232,0,209,227,145,0,44,220,212,0,78,63,159,0,182,53,58,0,209,53,232,0,44,97,162,0,78,97,232,0,182,69,107,0,209,115,107,0,44,69,162,0,78,181,58,0,182,114,107,0,209,207,52,0,44,40,107,0,78,114,207,0,182,226,103,0,209,166,58,0,195,209,0,167,182,34,103,0,209,32,193,0,44,34,158,0,78,89,31,0,182,31,207,0,209,124,158,0,44,31,232,0,78,124,107,0,182,136,56,0,209,136,158,0,44,99,41,0,78,99,138,0,182,2,207,0,209,56,158,0,44,2,103,0,78,2,158,0,182,138,58,0,209,185,167,0,44,119,182,0,78,138,156,0,182,221,156,0,209,12,63,0,44,191,21,0,78,12,156,0,182,241,156,0,209,247,79,0,44,175,71,0,78,175,79,0,182,84,79,0,209,142,247,0,44,20,79,0,78,142,103,0,182,63,134,0,209,63,21,0,44,254,41,0,78,220,134,0,182,53,134,0,209,4,134,0,44,97,134,0,78,168,81,0,182,69,201,0,209,115,201,0,44,30,63,0,78,181,182,0,182,117,103,0,209,207,79,0,44,114,158,0,78,40,63,0,182,65,201,0,209,166,201,0,195,44,0,167,182,34,76,0,209,34,58,0,44,32,76,0,78,32,107,0,182,174,158,0,209,31,250,0,44,124,56,0,78,124,52,0,195,78,0,162,182,89,182,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,209,89,182,0,44,228,76,0,78,89,182,0,144,228,21,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,209,111,182,0,44,174,34,0,78,111,182,0,144,174,81,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,221,162,228,31,207,89,209,162,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,167,0,228,187,250,16,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,182,89,182,0,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,12,162,162,0,114,121,162,103,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,167,16,136,88,250,16,34,16,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,65,136,62,103,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,63,16,162,247,153,111,25,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,153,89,137,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,9,254,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,9,97,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,10,181,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,10,40,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,73,166,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,73,74,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,135,90,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,135,106,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,251,154,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,251,237,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,118,189,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,118,95,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,105,125,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,105,248,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,120,213,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,120,60,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,130,253,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,130,165,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,47,46,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,47,113,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,1,172,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,1,238,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,5,82,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,5,197,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,128,137,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,128,132,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,206,195,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,206,202,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,231,66,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,231,246,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,87,194,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,87,86,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,57,25,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,57,126,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,218,3,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,218,214,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,48,94,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,48,127,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,109,104,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,109,100,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,102,33,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,102,37,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,178,22,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,178,8,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,230,208,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,230,49,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,98,222,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,98,11,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,150,255,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,150,50,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,152,80,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,152,51,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,32,188,177,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,220,89,188,72,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,233,0,78,32,233,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,233,0,78,89,233,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,209,0,78,32,209,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,209,0,78,89,209,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,32,0,78,32,32,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,89,233,0,78,228,32,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,89,32,0,78,34,124,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,32,124,0,78,228,124,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,89,124,0,78,34,121,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,32,121,0,220,228,228,80,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,121,0,78,89,121,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,83,0,78,32,83,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,83,0,78,89,83,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,185,0,78,32,185,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,185,0,78,89,185,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,221,0,78,32,221,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,221,0,78,89,221,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,175,0,78,32,175,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,175,0,78,89,175,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,142,0,78,32,142,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,142,0,78,89,142,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,220,0,78,32,220,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,220,0,78,89,220,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,168,0,78,32,168,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,168,0,78,89,168,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,115,0,78,32,115,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,115,0,78,89,115,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,117,0,78,32,117,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,117,0,78,89,117,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,129,0,78,32,129,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,129,0,78,89,129,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,163,0,78,32,163,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,163,0,78,89,163,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,133,0,78,32,133,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,133,0,78,89,133,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,116,0,78,32,116,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,116,0,78,89,116,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,160,0,78,32,160,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,160,0,78,89,160,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,7,0,78,32,7,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,7,0,78,89,7,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,45,0,78,32,45,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,45,0,78,89,45,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,245,0,78,32,245,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,245,0,78,89,245,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,34,147,0,78,32,147,0,220,89,34,56,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,221,89,195,162,44,228,147,0,119,32,209,0,113,228,16,0,220,89,34,56,121,34,0,0,247,233,228,228,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,136,34,0,0,220,228,228,228,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,233,34,16,182,16,34,0,0,140,32,0,182,121,34,0,0,247,233,228,44,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,121,34,0,0,247,233,228,228,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,136,34,0,0,220,228,228,44,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,233,0,16,250,233,72,188,250,55,72,188,250,0,0,16,250,233,72,188,185,32,233,0,136,34,0,0,220,228,228,228,158,0,16,0,38,182,0,0,162,191,0,0,0,231,87,206,251,47,73,0,162,31,0,0,0,123,221,0,162,4,0,0,0,7,43,206,251,5,87,124,1,26,9,0,162,56,0,0,0,7,7,115,151,0,162,162,0,0,0,7,7,115,0,162,103,0,0,0,221,9,87,245,231,9,206,200,0,162,247,0,0,0,221,9,87,245,231,9,206,0,31,0,0,0,0,0,0,104,96,162,56,0,0,0,170,102,87,9,0,162,162,0,0,0,231,57,170,0,31,0,0,0,0,16,176,46,233,31,0,0,0,0,0,16,141,233,31,0,0,0,0,0,233,140,233,31,0,0,0,0,0,16,175,233,31,0,0,0,0,0,55,153,233,31,0,0,0,0,0,0,35,233,31,0,0,0,0,0,0,240,233,31,0,0,0,0,0,233,10,233,31,0,0,0,0,0,16,123,233,31,0,0,0,0,0,16,62,233,31,0,0,0,0,0,82,135,233,31,0,0,0,0,0,233,153,233,31,0,0,0,0,0,233,45,233,31,0,0,0,0,0,55,43,233,31,0,0,0,0,0,204,43,233,31,0,0,0,0,0,16,153,233,31,0,0,0,0,0,0,249,233,31,0,0,0,0,0,16,45,233,31,0,0,0,0,0,233,7,233,31,0,0,0,0,0,153,10,233,31,0,0,0,0,0,82,73,233,31,0,0,0,0,0,82,43,233,31,0,0,0,0,0,0,160,233,31,0,0,0,0,0,16,38,233,31,0,0,0,0,0,55,116,233,31,0,0,0,0,0,16,32,233,31,0,0,0,0,0,156,170,233,31,0,0,0,0,0,0,117,233,31,0,0,0,0,0,233,245,233,31,0,0,0,0,0,0,129,233,31,0,0,0,0,0,16,129,233,31,0,0,0,0,0,16,233,233,31,0,0,0,0,0,16,124,233,31,0,0,0,0,0,0,81,233,31,0,0,0,0,0,0,216,233,31,0,0,0,0,0,0,221,233,31,0,0,0,0,0,16,185,233,31,0,0,0,0,0,0,83,233,31,0,0,0,0,0,0,0,233,31,0,0,0,0,0,16,83,233,31,0,0,0,0,0,153,144,233,31,0,0,0,0,0,82,144,233,31,0,0,0,0,0,16,35,233,31,0,0,0,0,0,233,26,233,31,0,0,0,0,0,55,135,233,31,0,0,0,0,0,0,217,233,31,0,0,0,0,0,55,13,233,31,0,0,0,0,0,0,180,233,31,0,0,0,0,0,233,73,233,31,0,0,0,0,0,0,251,233,31,0,0,0,0,0,0,163,233,31,0,0,0,0,0,16,101,233,31,0,0,0,0,0,16,163,233,31,0,0,0,0,0,0,70,233,31,0,0,0,0,0,233,123,233,31,0,0,0,0,0,16,142,233,31,0,0,0,0,0,0,10,233,31,0,0,0,0,0,0,115,233,31,0,0,0,0,0,233,35,233,31,0,0,0,0,0,0,38,233,31,0,0,0,0,0,0,121,233,31,0,0,0,0,0,0,205,233,31,0,0,0,0,0,55,73,233,31,0,0,0,0,0,0,101,233,31,0,0,0,0,0,0,199,233,31,0,0,0,0,0,16,73,233,31,0,0,0,0,0,0,244,233,31,0,0,0,0,0,55,7,233,31,0,0,0,0,0,233,38,233,31,0,0,0,0,0,233,141,233,31,0,0,0,0,0,0,116,233,31,0,0,0,0,0,0,21,233,31,0,0,0,0,0,153,153,233,31,0,0,0,0,0,55,26,233,31,0,0,0,0,0,233,116,233,31,0,0,0,0,0,153,26,233,31,0,0,0,0,0,16,43,233,31,0,0,0,0,0,153,73,233,31,0,0,0,0,0,0,92,233,31,0,0,0,0,0,0,147,233,31,0,0,0,0,0,0,93,233,31,0,0,0,0,0,16,209,233,31,0,0,0,0,0,0,26,233,31,0,0,0,0,0,153,43,233,31,0,0,0,0,0,0,76,233,31,0,0,0,0,0,16,13,233,31,0,0,0,0,0,0,140,233,31,0,0,0,0,0,82,1,233,31,0,0,0,0,0,0,5,233,31,0,0,0,0,0,0,190,233,31,0,0,0,0,0,156,43,233,31,0,0,0,0,0,156,26,233,31,0,0,0,0,0,16,115,233,31,0,0,0,0,0,0,245,233,31,0,0,0,0,0,233,135,233,31,0,0,0,0,0,0,32,233,31,0,0,0,0,0,16,26,233,31,0,0,0,0,0,0,73,233,31,0,0,0,0,0,16,221,233,31,0,0,0,0,0,16,245,233,31,0,0,0,0,0,0,156,233,31,0,0,0,0,0,0,220,233,31,0,0,0,0,0,55,160,233,31,0,0,0,0,0,55,38,233,31,0,0,0,0,0,16,220,233,31,0,0,0,0,0,0,170,233,31,0,0,0,0,0,55,140,233,31,0,0,0,0,0,156,73,233,31,0,0,0,0,0,153,135,233,31,0,0,0,0,0,0,233,233,31,0,0,0,0,0,16,7,233,31,0,0,0,0,0,82,26,233,31,0,0,0,0,0,0,153,233,31,0,0,0,0,0,156,9,233,31,0,0,0,0,0,233,144,233,31,0,0,0,0,0,0,141,233,31,0,0,0,0,0,204,170,233,31,0,0,0,0,0,16,144,233,31,0,0,0,0,0,82,10,233,31,0,0,0,0,0,0,133,233,31,0,0,0,0,0,82,153,233,31,0,0,0,0,0,0,135,233,31,0,0,0,0,0,16,135,233,31,0,0,0,0,0,16,239,233,31,0,0,0,0,0,16,160,233,31,0,0,0,0,0,82,170,233,31,0,0,0,0,0,16,140,233,31,0,0,0,0,0,16,117,233,31,0,0,0,0,0,0,151,233,31,0,0,0,0,0,233,13,233,31,0,0,0,0,0,204,9,233,31,0,0,0,0,0,156,10,233,31,0,0,0,0,0,156,153,233,31,0,0,0,0,0,0,168,233,31,0,0,0,0,0,55,9,233,31,0,0,0,0,0,0,62,233,31,0,0,0,0,0,0,134,233,162,63,0,0,0,7,43,206,251,5,87,83,129,147,0,31,0,0,0,0,0,145,149,233,31,0,0,0,0,0,178,6,233,31,0,0,0,0,0,89,23,233,31,0,0,0,0,0,28,78,233,31,0,0,0,0,0,146,19,233,31,0,0,0,0,0,178,204,233,31,0,0,0,0,0,22,186,233,31,0,0,0,0,0,54,110,233,31,0,0,0,0,0,98,42,233,31,0,0,0,0,0,109,67,233,31,0,0,0,0,0,217,157,233,31,0,0,0,0,0,136,183,233,31,0,0,0,0,0,179,186,233,31,0,0,0,0,0,69,210,233,31,0,0,0,0,0,99,131,233,31,0,0,0,0,0,136,91,233,31,0,0,0,0,0,64,149,233,31,0,0,0,0,0,3,225,233,31,0,0,0,0,0,92,122,233,31,0,0,0,0,16,7,89,233,31,0,0,0,0,0,198,243,233,31,0,0,0,0,0,93,169,233,31,0,0,0,0,0,175,179,233,31,0,0,0,0,0,220,183,233,31,0,0,0,0,0,115,243,233,31,0,0,0,0,0,46,64,233,31,0,0,0,0,0,98,110,233,31,0,0,0,0,0,165,78,233,31,0,0,0,0,0,246,225,233,31,0,0,0,0,0,85,211,233,31,0,0,0,0,0,21,148,233,31,0,0,0,0,0,1,169,233,31,0,0,0,0,0,185,88,233,31,0,0,0,0,0,185,42,233,31,0,0,0,0,0,193,89,233,31,0,0,0,0,0,157,15,233,31,0,0,0,0,0,230,211,233,31,0,0,0,0,0,175,122,233,31,0,0,0,0,0,183,110,233,31,0,0,0,0,0,122,68,233,31,0,0,0,0,0,170,19,233,31,0,0,0,0,0,110,78,233,31,0,0,0,0,0,39,59,233,31,0,0,0,0,16,165,89,233,31,0,0,0,0,0,18,110,233,31,0,0,0,0,0,0,28,233,31,0,0,0,0,0,67,15,233,31,0,0,0,0,0,91,139,233,31,0,0,0,0,16,206,78,233,31,0,0,0,0,0,33,210,233,31,0,0,0,0,0,22,157,233,31,0,0,0,0,0,125,23,233,31,0,0,0,0,0,132,55,233,31,0,0,0,0,0,158,149,233,31,0,0,0,0,0,249,108,233,31,0,0,0,0,0,62,131,233,31,0,0,0,0,0,104,164,233,31,0,0,0,0,0,88,112,233,31,0,0,0,0,0,29,179,233,31,0,0,0,0,0,23,55,233,31,0,0,0,0,0,104,89,233,31,0,0,0,0,0,162,225,233,31,0,0,0,0,0,217,23,233,31,0,0,0,0,0,65,28,233,31,0,0,0,0,0,179,204,233,31,0,0,0,0,0,140,110,233,31,0,0,0,0,0,51,169,233,31,0,0,0,0,0,83,78,233,31,0,0,0,0,16,220,111,233,31,0,0,0,0,16,117,78,233,31,0,0,0,0,0,175,42,233,31,0,0,0,0,16,92,55,233,31,0,0,0,0,0,36,55,233,31,0,0,0,0,0,154,29,233,31,0,0,0,0,0,239,215,233,31,0,0,0,0,0,183,215,233,31,0,0,0,0,0,226,64,233,31,0,0,0,0,0,35,243,233,31,0,0,0,0,0,109,186,233,31,0,0,0,0,0,81,89,233,31,0,0,0,0,0,47,108,233,31,0,0,0,0,0,24,173,233,31,0,0,0,0,0,53,169,233,31,0,0,0,0,0,200,187,233,31,0,0,0,0,0,34,179,233,31,0,0,0,0,0,181,59,233,31,0,0,0,0,0,17,148,233,31,0,0,0,0,0,24,204,233,31,0,0,0,0,0,212,28,233,31,0,0,0,0,0,45,61,233,31,0,0,0,0,0,241,143,233,31,0,0,0,0,0,187,68,233,31,0,0,0,0,0,80,67,233,31,0,0,0,0,0,69,89,233,31,0,0,0,0,16,47,111,233,31,0,0,0,0,0,166,6,233,31,0,0,0,0,0,175,173,233,31,0,0,0,0,0,127,19,233,31,0,0,0,0,0,187,183,233,31,0,0,0,0,0,147,187,233,31,0,0,0,0,16,134,89,233,31,0,0,0,0,0,38,15,233,31,0,0,0,0,0,26,211,233,31,0,0,0,0,0,243,196,233,31,0,0,0,0,0,126,88,233,31,0,0,0,0,0,242,78,233,31,0,0,0,0,0,112,139,233,31,0,0,0,0,0,41,68,233,31,0,0,0,0,0,89,196,233,31,0,0,0,0,0,158,196,233,31,0,0,0,0,0,172,196,233,31,0,0,0,0,0,103,108,233,31,0,0,0,0,0,217,19,233,31,0,0,0,0,0,200,64,233,31,0,0,0,0,0,19,225,233,31,0,0,0,0,0,40,15,233,31,0,0,0,0,0,15,88,233,31,0,0,0,0,0,185,55,233,31,0,0,0,0,0,224,19,233,31,0,0,0,0,0,189,173,233,31,0,0,0,0,0,156,131,233,31,0,0,0,0,16,166,78,233,31,0,0,0,0,0,136,179,233,31,0,0,0,0,0,151,55,233,31,0,0,0,0,0,76,179,233,31,0,0,0,0,0,232,225,233,31,0,0,0,0,0,6,225,233,31,0,0,0,0,0,177,68,233,31,0,0,0,0,0,28,59,233,31,0,0,0,0,0,233,89,233,31,0,0,0,0,0,28,143,233,31,0,0,0,0,0,204,173,233,31,0,0,0,0,0,5,161,233,31,0,0,0,0,0,29,108,233,31,0,0,0,0,0,22,68,233,31,0,0,0,0,0,194,173,233,31,0,0,0,0,0,184,204,233,31,0,0,0,0,0,167,211,233,31,0,0,0,0,0,28,36,233,31,0,0,0,0,16,79,78,233,31,0,0,0,0,0,54,204,233,31,0,0,0,0,0,28,161,233,31,0,0,0,0,0,180,111,233,31,0,0,0,0,16,48,78,233,31,0,0,0,0,0,83,149,233,31,0,0,0,0,0,201,149,233,31,0,0,0,0,0,95,161,233,31,0,0,0,0,0,50,139,233,31,0,0,0,0,0,183,196,233,31,0,0,0,0,0,95,179,233,31,0,0,0,0,0,194,225,233,31,0,0,0,0,0,75,215,233,31,0,0,0,0,0,16,148,233,31,0,0,0,0,16,75,78,233,31,0,0,0,0,0,250,211,233,31,0,0,0,0,0,92,204,233,31,0,0,0,0,0,194,183,233,31,0,0,0,0,0,44,169,233,31,0,0,0,0,0,90,143,233,31,0,0,0,0,0,198,23,233,31,0,0,0,0,0,36,157,233,31,0,0,0,0,0,80,210,233,31,0,0,0,0,0,166,210,233,31,0,0,0,0,0,49,149,233,31,0,0,0,0,0,80,29,233,31,0,0,0,0,16,111,89,233,31,0,0,0,0,0,5,252,233,31,0,0,0,0,0,4,78,233,31,0,0,0,0,16,248,55,233,31,0,0,0,0,0,151,15,233,31,0,0,0,0,0,222,139,233,31,0,0,0,0,0,98,236,233,31,0,0,0,0,0,27,131,233,31,0,0,0,0,0,141,29,233,31,0,0,0,0,0,80,23,233,31,0,0,0,0,0,58,59,233,31,0,0,0,0,0,196,15,233,31,0,0,0,0,0,232,88,233,31,0,0,0,0,0,156,143,233,31,0,0,0,0,16,96,111,233,31,0,0,0,0,0,239,55,233,31,0,0,0,0,0,122,42,233,31,0,0,0,0,0,231,179,233,31,0,0,0,0,0,59,89,233,31,0,0,0,0,0,159,183,233,31,0,0,0,0,0,173,108,233,31,0,0,0,0,0,0,23,233,31,0,0,0,0,0,79,59,233,31,0,0,0,0,16,153,55,233,31,0,0,0,0,0,99,36,233,31,0,0,0,0,0,189,148,233,31,0,0,0,0,0,189,215,233,31,0,0,0,0,0,87,173,233,31,0,0,0,0,0,253,243,233,31,0,0,0,0,0,16,24,233,31,0,0,0,0,0,186,149,233,31,0,0,0,0,0,244,111,233,31,0,0,0,0,0,61,28,233,162,103,0,0,0,245,231,9,206,129,144,130,9,0,0,0,0,0,182,0,0,0,182,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,47,44,175,18,59,148,113,168,104,193,180,100,237,89,179,67,45,47,134,200,73,11,26,251,140,54,28,251,114,95,104,42,154,148,217,122,24,247,157,33,159,182,219,171,185,2,243,227,241,224,98,36,73,119,31,42,245,166,201,50,89,153,11,41,202,71,116,41,66,244,225,50,167,49,62,232,222,10,180,131,98,112,110,119,146,17,214,154,23,77,167,210,189,161,220,57,188,61,123,28,129,18,252,142,53,70,157,19,78,188,217,181,13,101,207,250,194,139,132,255,41,225,19,91,158,39,66,167,29,246,73,22,155,35,49,59,136,96,186,20,117,228,23,124,118,217,149,181,100,41,34,247,78,144,69,106,84,121,158,168,175,145,150,229,89,93,203,215,246,51,132,246,149,222,221,100,100,124,214,111,17,21,97,56,107,248,17,142,91,51,148,23,78,149,239,207,94,236,183,120,57,166,84,213,29,238,82,250,85,68,208,234,63,2,187,82,146,146,58,68,179,252,30,161,93,176,244,79,11,1,129,45,246,206,226,204,88,143,172,134,198,40,106,81,253,131,158,117,190,164,67,233,97,1,255})
    end
    _G.SimpleLibLoaded = true
end



