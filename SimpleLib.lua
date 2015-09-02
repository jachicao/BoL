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
        SSL2({22,253,239,88,63,93,241,212,177,87,205,225,227,238,210,78,133,126,156,233,127,174,216,79,10,16,162,70,86,28,211,230,54,42,222,121,203,122,125,92,137,146,12,7,43,130,56,110,179,165,147,39,113,72,190,117,57,191,229,120,217,140,184,139,131,188,166,226,23,249,118,91,158,105,5,20,234,108,17,219,62,103,144,64,231,172,218,173,164,150,83,123,153,178,19,47,182,145,151,148,169,38,94,74,129,49,50,4,201,154,30,251,32,214,135,136,160,209,180,244,81,243,254,163,224,15,95,11,171,149,13,116,134,89,31,245,197,183,104,194,228,143,24,77,236,84,106,33,248,119,199,235,21,232,161,46,138,2,186,198,34,240,99,221,223,55,115,114,58,85,170,59,18,142,195,157,247,242,132,51,193,102,41,82,90,202,73,35,53,60,176,6,215,124,155,246,220,196,111,61,112,68,26,65,141,200,152,213,69,8,181,40,185,45,109,189,175,250,252,97,48,14,1,207,66,3,187,36,204,128,37,29,107,167,80,168,98,208,9,75,67,159,206,71,255,44,96,27,52,25,101,76,100,237,192,162,20,160,182,103,0,22,88,88,88,212,0,10,106,227,87,16,87,0,0,0,0,0,0,0,0,0,22,117,151,241,0,0,205,0,0,0,249,0,139,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,89,139,139,0,31,11,139,22,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,196,6,139,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,215,139,0,162,131,0,0,216,11,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,196,0,131,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,131,131,0,162,131,0,0,216,6,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,171,131,0,212,0,171,149,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,22,215,22,0,231,22,0,22,171,215,22,0,54,22,88,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,241,253,124,0,118,188,124,0,11,253,0,22,6,253,11,239,0,239,11,239,153,253,0,253,86,149,0,0,87,0,149,239,230,131,101,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,88,22,0,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,131,215,22,0,171,171,253,0,215,215,22,0,182,171,210,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,162,131,0,0,216,6,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,241,22,253,0,216,6,63,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,108,124,131,88,31,253,253,0,87,11,149,88,87,0,22,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,88,22,0,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,47,215,9,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,5,22,0,233,171,215,253,0,215,22,239,0,22,188,239,0,131,149,239,0,171,124,239,0,215,253,88,0,22,166,88,0,131,13,88,0,171,155,88,0,215,239,63,0,22,226,63,0,131,116,63,0,171,246,63,0,215,88,93,0,22,23,93,0,131,220,63,0,171,134,93,0,215,220,93,0,22,93,241,0,131,249,241,0,171,89,241,0,215,196,241,0,22,241,212,0,131,118,212,0,171,31,212,0,215,241,63,0,22,61,212,0,131,245,212,0,171,212,177,0,215,91,177,0,22,197,177,0,131,112,177,0,171,177,87,0,215,158,87,0,22,183,87,0,131,68,87,0,171,87,205,0,215,105,205,0,22,205,177,0,131,104,205,0,171,26,205,0,215,205,225,0,22,20,225,0,131,194,225,0,171,65,225,0,215,225,227,0,22,234,227,0,131,227,225,0,171,228,227,0,215,141,205,0,148,131,0,10,171,215,227,0,215,22,238,0,22,253,225,0,131,188,238,0,171,124,22,0,215,253,205,0,22,13,238,0,131,239,225,0,171,155,227,0,215,155,238,0,22,88,210,0,131,226,210,0,171,116,210,0,215,246,210,0,22,220,225,0,131,63,177,0,171,63,78,0,215,23,78,0,22,89,78,0,131,196,78,0,171,93,88,0,215,93,133,0,22,118,133,0,131,31,133,0,171,111,133,0,215,241,126,0,22,91,126,0,131,245,126,0,171,61,126,0,215,91,227,0,22,158,87,0,131,177,156,0,171,158,156,0,215,197,156,0,22,183,156,0,131,68,156,0,171,87,233,0,215,105,233,0,22,26,212,0,131,205,225,0,171,205,63,0,215,104,233,0,22,20,156,0,131,225,212,0,171,65,233,0,215,20,210,0,22,227,127,0,131,228,126,0,171,234,127,0,215,227,227,0,148,171,0,10,171,171,233,0,215,171,93,0,22,149,127,0,131,124,127,0,171,253,174,0,215,188,174,0,22,13,174,0,131,155,227,0,171,239,227,0,215,155,174,0,22,88,216,0,131,226,216,0,171,116,216,0,215,246,216,0,22,23,87,0,131,63,79,0,171,23,79,0,215,134,79,0,22,249,238,0,131,249,63,0,171,89,233,0,215,196,79,0,22,111,78,0,131,241,156,0,171,31,78,0,215,241,10,0,22,91,10,0,131,91,63,0,148,215,0,238,171,215,22,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,215,215,22,0,22,149,10,0,131,124,22,0,66,171,70,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,215,124,22,0,22,13,253,0,131,155,22,0,66,149,233,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,111,13,171,253,228,215,131,239,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,10,11,171,132,216,11,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,171,215,22,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,241,116,239,0,227,246,239,212,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,10,0,88,51,216,11,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,238,226,150,212,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,87,0,88,241,207,124,167,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,207,215,3,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,26,22,0,0,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,22,124,22,0,231,253,0,0,171,124,22,0,54,149,253,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,241,155,253,0,68,22,13,63,230,124,76,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,22,124,22,0,131,149,253,0,171,124,22,0,54,253,239,11,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,238,155,215,63,238,239,239,134,241,239,13,239,87,0,13,63,230,188,76,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,252,193,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,252,102,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,97,41,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,97,82,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,48,90,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,48,202,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,14,73,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,14,35,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,1,53,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,1,60,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,207,176,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,207,6,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,66,215,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,66,124,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,3,155,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,3,246,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,187,220,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,187,196,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,36,111,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,36,61,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,204,112,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,204,68,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,128,26,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,128,65,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,37,141,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,37,200,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,29,152,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,29,213,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,107,69,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,107,8,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,167,181,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,167,40,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,80,185,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,80,45,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,168,109,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,168,189,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,98,175,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,98,250,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,208,252,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,208,97,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,9,48,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,9,14,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,75,1,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,75,207,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,67,66,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,67,3,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,159,187,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,159,36,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,206,204,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,206,128,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,71,37,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,71,29,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,255,107,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,255,167,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,44,80,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,44,168,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,96,98,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,96,208,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,27,9,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,27,75,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,52,67,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,52,159,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,25,206,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,25,71,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,101,255,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,101,44,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,76,96,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,76,27,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,100,52,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,100,25,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,237,101,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,237,76,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,253,192,100,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,87,149,192,237,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,139,0,87,188,149,192,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,139,0,87,188,253,35,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,139,0,171,124,139,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,131,0,171,188,131,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,131,0,171,124,131,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,188,0,171,188,188,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,188,0,171,124,188,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,166,0,171,188,166,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,166,0,171,124,166,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,226,0,171,188,226,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,226,0,171,124,226,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,23,0,171,188,23,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,23,0,171,124,23,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,249,0,87,188,149,128,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,249,0,171,149,249,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,124,249,0,171,253,118,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,118,0,171,149,118,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,124,118,0,171,253,91,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,91,0,171,149,91,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,124,91,0,171,253,158,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,158,0,171,149,158,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,124,158,0,171,253,105,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,188,105,0,87,188,97,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,105,0,171,124,105,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,5,0,171,188,5,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,149,5,0,171,124,5,0,87,149,149,88,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,241,149,150,88,131,253,20,0,89,188,131,0,138,149,11,0,87,149,149,88,88,253,0,0,212,0,149,149,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,226,253,0,0,87,188,149,149,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,0,253,11,22,139,253,0,0,86,188,0,22,88,253,0,0,212,0,149,171,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,88,253,0,0,212,0,149,149,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,226,253,0,0,87,188,149,171,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,139,0,11,216,139,192,95,216,6,192,95,216,0,0,11,216,139,192,95,93,188,139,0,226,253,0,0,87,188,149,149,211,0,11,0,179,22,0,0,88,241,0,0,0,135,136,214,129,154,94,0,88,239,0,0,0,19,118,0,88,205,0,0,0,144,151,214,129,251,136,166,30,148,169,0,88,63,0,0,0,144,144,20,147,0,88,88,0,0,0,144,144,20,0,88,177,0,0,0,118,169,136,231,135,169,214,165,0,88,212,0,0,0,118,169,136,231,135,169,214,0,239,0,0,0,0,0,0,75,184,88,63,0,0,0,145,81,136,169,0,88,88,0,0,0,135,160,145,0,239,0,0,0,0,11,89,97,139,239,0,0,0,0,0,0,217,139,239,0,0,0,0,0,198,169,139,239,0,0,0,0,0,11,38,139,239,0,0,0,0,0,0,130,139,239,0,0,0,0,0,6,19,139,239,0,0,0,0,0,11,231,139,239,0,0,0,0,0,0,230,139,239,0,0,0,0,0,6,172,139,239,0,0,0,0,0,11,188,139,239,0,0,0,0,0,6,62,139,239,0,0,0,0,0,6,231,139,239,0,0,0,0,0,207,94,139,239,0,0,0,0,0,0,129,139,239,0,0,0,0,0,139,148,139,239,0,0,0,0,0,139,169,139,239,0,0,0,0,0,11,166,139,239,0,0,0,0,0,11,145,139,239,0,0,0,0,0,6,74,139,239,0,0,0,0,0,11,20,139,239,0,0,0,0,0,0,182,139,239,0,0,0,0,0,47,94,139,239,0,0,0,0,0,11,218,139,239,0,0,0,0,0,0,123,139,239,0,0,0,0,0,207,38,139,239,0,0,0,0,0,230,94,139,239,0,0,0,0,0,0,118,139,239,0,0,0,0,0,230,151,139,239,0,0,0,0,0,0,226,139,239,0,0,0,0,0,139,151,139,239,0,0,0,0,0,230,38,139,239,0,0,0,0,0,11,91,139,239,0,0,0,0,0,0,122,139,239,0,0,0,0,0,0,173,139,239,0,0,0,0,0,11,173,139,239,0,0,0,0,0,0,164,139,239,0,0,0,0,0,11,182,139,239,0,0,0,0,0,230,74,139,239,0,0,0,0,0,11,19,139,239,0,0,0,0,0,11,219,139,239,0,0,0,0,0,6,103,139,239,0,0,0,0,0,139,182,139,239,0,0,0,0,0,139,219,139,239,0,0,0,0,0,11,144,139,239,0,0,0,0,0,198,74,139,239,0,0,0,0,0,139,178,139,239,0,0,0,0,0,0,219,139,239,0,0,0,0,0,47,148,139,239,0,0,0,0,0,6,173,139,239,0,0,0,0,0,139,19,139,239,0,0,0,0,0,0,70,139,239,0,0,0,0,0,0,94,139,239,0,0,0,0,0,0,38,139,239,0,0,0,0,0,11,169,139,239,0,0,0,0,0,6,94,139,239,0,0,0,0,0,0,0,139,239,0,0,0,0,0,207,74,139,239,0,0,0,0,0,6,153,139,239,0,0,0,0,0,47,47,139,239,0,0,0,0,0,0,64,139,239,0,0,0,0,0,6,123,139,239,0,0,0,0,0,6,219,139,239,0,0,0,0,0,0,179,139,239,0,0,0,0,0,139,123,139,239,0,0,0,0,0,0,146,139,239,0,0,0,0,0,198,38,139,239,0,0,0,0,0,11,23,139,239,0,0,0,0,0,0,169,139,239,0,0,0,0,0,139,172,139,239,0,0,0,0,0,230,182,139,239,0,0,0,0,0,0,151,139,239,0,0,0,0,0,0,72,139,239,0,0,0,0,0,139,64,139,239,0,0,0,0,0,0,57,139,239,0,0,0,0,0,11,123,139,239,0,0,0,0,0,0,113,139,239,0,0,0,0,0,11,172,139,239,0,0,0,0,0,0,191,139,239,0,0,0,0,0,0,17,139,239,0,0,0,0,0,139,74,139,239,0,0,0,0,0,11,103,139,239,0,0,0,0,0,0,131,139,239,0,0,0,0,0,0,249,139,239,0,0,0,0,0,0,92,139,239,0,0,0,0,0,207,169,139,239,0,0,0,0,0,0,121,139,239,0,0,0,0,0,0,20,139,239,0,0,0,0,0,139,150,139,239,0,0,0,0,0,6,178,139,239,0,0,0,0,0,0,74,139,239,0,0,0,0,0,230,47,139,239,0,0,0,0,0,11,150,139,239,0,0,0,0,0,0,79,139,239,0,0,0,0,0,0,47,139,239,0,0,0,0,0,207,30,139,239,0,0,0,0,0,0,251,139,88,87,0,0,0,144,151,214,129,251,136,23,108,172,0,239,0,0,0,0,0,38,195,139,239,0,0,0,0,11,5,215,139,239,0,0,0,0,0,116,59,139,239,0,0,0,0,11,156,215,139,239,0,0,0,0,0,118,82,139,239,0,0,0,0,0,39,77,139,239,0,0,0,0,11,192,215,139,239,0,0,0,0,0,29,221,139,239,0,0,0,0,0,62,51,139,239,0,0,0,0,0,207,73,139,239,0,0,0,0,0,221,84,139,239,0,0,0,0,0,63,41,139,239,0,0,0,0,0,166,53,139,239,0,0,0,0,0,171,82,139,239,0,0,0,0,11,75,124,139,239,0,0,0,0,0,191,247,139,239,0,0,0,0,0,111,35,139,239,0,0,0,0,0,61,18,139,239,0,0,0,0,0,59,90,139,239,0,0,0,0,0,189,236,139,239,0,0,0,0,0,222,157,139,239,0,0,0,0,0,113,6,139,239,0,0,0,0,0,168,221,139,239,0,0,0,0,0,76,33,139,239,0,0,0,0,0,174,60,139,239,0,0,0,0,0,4,115,139,239,0,0,0,0,0,188,195,139,239,0,0,0,0,0,78,186,139,239,0,0,0,0,0,240,215,139,239,0,0,0,0,0,118,90,139,239,0,0,0,0,0,116,170,139,239,0,0,0,0,0,183,53,139,239,0,0,0,0,11,27,124,139,239,0,0,0,0,0,27,170,139,239,0,0,0,0,0,30,60,139,239,0,0,0,0,0,75,161,139,239,0,0,0,0,0,220,193,139,239,0,0,0,0,0,57,202,139,239,0,0,0,0,0,168,114,139,239,0,0,0,0,0,106,202,139,239,0,0,0,0,0,222,132,139,239,0,0,0,0,0,72,142,139,239,0,0,0,0,0,38,59,139,239,0,0,0,0,0,97,215,139,239,0,0,0,0,11,27,215,139,239,0,0,0,0,0,145,41,139,239,0,0,0,0,0,84,142,139,239,0,0,0,0,0,200,114,139,239,0,0,0,0,11,8,6,139,239,0,0,0,0,0,84,59,139,239,0,0,0,0,0,251,119,139,239,0,0,0,0,0,162,193,139,239,0,0,0,0,0,216,247,139,239,0,0,0,0,11,50,6,139,239,0,0,0,0,0,246,18,139,239,0,0,0,0,11,209,215,139,239,0,0,0,0,0,39,232,139,239,0,0,0,0,0,46,73,139,239,0,0,0,0,0,190,157,139,239,0,0,0,0,11,187,6,139,239,0,0,0,0,0,139,199,139,239,0,0,0,0,11,100,6,139,239,0,0,0,0,0,167,53,139,239,0,0,0,0,0,219,199,139,239,0,0,0,0,11,187,124,139,239,0,0,0,0,0,194,21,139,239,0,0,0,0,0,87,193,139,239,0,0,0,0,0,201,242,139,239,0,0,0,0,0,114,232,139,239,0,0,0,0,0,65,247,139,239,0,0,0,0,0,155,41,139,239,0,0,0,0,0,242,53,139,239,0,0,0,0,0,10,41,139,239,0,0,0,0,0,193,124,139,239,0,0,0,0,0,128,73,139,239,0,0,0,0,0,52,124,139,239,0,0,0,0,0,65,132,139,239,0,0,0,0,0,96,51,139,239,0,0,0,0,0,114,53,139,239,0,0,0,0,0,4,85,139,239,0,0,0,0,0,80,202,139,239,0,0,0,0,0,118,41,139,239,0,0,0,0,0,15,157,139,239,0,0,0,0,0,253,115,139,239,0,0,0,0,0,38,223,139,239,0,0,0,0,0,198,142,139,239,0,0,0,0,0,47,90,139,239,0,0,0,0,0,39,138,139,239,0,0,0,0,0,141,157,139,239,0,0,0,0,0,214,18,139,239,0,0,0,0,0,88,161,139,239,0,0,0,0,0,103,247,139,239,0,0,0,0,0,41,193,139,239,0,0,0,0,0,118,176,139,239,0,0,0,0,0,183,82,139,239,0,0,0,0,0,229,53,139,239,0,0,0,0,11,83,155,139,239,0,0,0,0,11,209,124,139,239,0,0,0,0,0,244,84,139,239,0,0,0,0,0,198,55,139,239,0,0,0,0,11,193,124,139,239,0,0,0,0,0,157,24,139,239,0,0,0,0,0,125,41,139,239,0,0,0,0,0,244,186,139,239,0,0,0,0,11,93,215,139,239,0,0,0,0,0,0,18,139,239,0,0,0,0,0,3,18,139,239,0,0,0,0,0,38,193,139,239,0,0,0,0,0,255,35,139,239,0,0,0,0,0,138,247,139,239,0,0,0,0,0,143,132,139,239,0,0,0,0,0,165,242,139,239,0,0,0,0,0,174,35,139,239,0,0,0,0,0,130,18,139,239,0,0,0,0,0,94,51,139,239,0,0,0,0,0,235,161,139,239,0,0,0,0,0,39,51,139,239,0,0,0,0,0,22,157,139,239,0,0,0,0,0,178,176,139,239,0,0,0,0,11,61,215,139,239,0,0,0,0,0,153,6,139,239,0,0,0,0,0,138,193,139,239,0,0,0,0,0,126,82,139,239,0,0,0,0,0,64,84,139,239,0,0,0,0,0,143,60,139,239,0,0,0,0,0,187,41,139,239,0,0,0,0,0,189,198,139,239,0,0,0,0,0,167,82,139,239,0,0,0,0,11,244,6,139,239,0,0,0,0,0,4,232,139,239,0,0,0,0,0,140,242,139,239,0,0,0,0,0,186,132,139,239,0,0,0,0,0,175,51,139,239,0,0,0,0,0,162,157,139,239,0,0,0,0,0,196,247,139,239,0,0,0,0,0,230,186,139,239,0,0,0,0,0,218,53,139,239,0,0,0,0,0,46,236,139,239,0,0,0,0,0,57,247,139,239,0,0,0,0,0,120,242,139,239,0,0,0,0,0,75,51,139,239,0,0,0,0,0,24,157,139,239,0,0,0,0,11,235,124,139,239,0,0,0,0,0,120,240,139,239,0,0,0,0,0,238,195,139,239,0,0,0,0,0,217,35,139,239,0,0,0,0,0,139,161,139,239,0,0,0,0,0,79,84,139,239,0,0,0,0,0,29,142,139,239,0,0,0,0,0,163,223,139,239,0,0,0,0,0,69,102,139,239,0,0,0,0,0,117,176,139,239,0,0,0,0,0,6,115,139,239,0,0,0,0,0,94,157,139,239,0,0,0,0,0,89,170,139,239,0,0,0,0,0,139,202,139,239,0,0,0,0,0,253,41,139,239,0,0,0,0,0,6,232,139,239,0,0,0,0,0,6,34,139,239,0,0,0,0,0,28,202,139,239,0,0,0,0,0,124,51,139,239,0,0,0,0,0,130,51,139,239,0,0,0,0,0,28,223,139,239,0,0,0,0,0,17,193,139,239,0,0,0,0,0,212,193,139,239,0,0,0,0,0,195,242,139,239,0,0,0,0,0,75,114,139,239,0,0,0,0,0,110,77,139,239,0,0,0,0,0,70,33,139,239,0,0,0,0,0,189,161,139,239,0,0,0,0,0,207,85,139,239,0,0,0,0,0,233,51,139,239,0,0,0,0,0,65,2,139,239,0,0,0,0,0,124,242,139,239,0,0,0,0,11,17,124,139,239,0,0,0,0,0,55,223,139,239,0,0,0,0,11,2,6,139,239,0,0,0,0,0,139,119,139,239,0,0,0,0,0,233,33,139,239,0,0,0,0,0,24,247,139,239,0,0,0,0,0,70,198,139,239,0,0,0,0,0,210,215,139,239,0,0,0,0,0,48,176,139,239,0,0,0,0,0,230,73,139,239,0,0,0,0,0,7,199,139,239,0,0,0,0,11,253,215,139,239,0,0,0,0,0,157,198,139,239,0,0,0,0,11,137,155,139,239,0,0,0,0,0,195,102,139,239,0,0,0,0,11,191,215,139,239,0,0,0,0,0,224,51,139,239,0,0,0,0,0,79,6,139,239,0,0,0,0,0,204,132,139,239,0,0,0,0,0,2,34,139,239,0,0,0,0,0,20,221,139,239,0,0,0,0,11,18,124,139,239,0,0,0,0,0,2,85,139,88,177,0,0,0,231,135,169,214,108,182,201,169,0,0,0,0,0,22,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,166,76,84,72,255,74,10,231,181,73,198,75,178,61,95,94,5,173,118,58,115,102,16,146,226,152,166,138,126,49,200,230,22,25,140,25,234,119,22,171,202,215,226,230,108,235,107,229,89,212,127,190,155,169,97,26,65,110,172,19,191,94,103,211,234,167,88,211,40,166,190,13,228,226,213,126,139,153,229,60,124,78,157,229,206,199,99,236,202,140,253,110,153,104,79,26,105,139,116,14,118,205,94,41,46,52,88,122,100,122,170,173,2,212,233,236,198,129,185,216,176,11,128,4,89,19,47,234,58,180,191,34,91,135,16,22,155,64,88,71,28,112,172,57,181,145,27,215,86,181,255,246,84,215,163,51,179,142,102,237,239,241,13,160,64,131,149,21,7,72,2,43,224,217,188,84,29,83,85,181,38,250,140,34,214,157,124,252,4,44,222,21,122,91,77,7,192,37,133,66,70,156,201,156,24,134,157,22,167,180,119,35,224,214,160,200,159,28,48,55,216,140,219,234,100,136,109,76,208,120,225,183,44,187,81,193,221,96,123,118,52,29,201,239,201,139,99,140,173,245,95,76,163,66,1,255})
    end
    _G.SimpleLibLoaded = true
end



