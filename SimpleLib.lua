local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.09

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
        SSL2({237,234,26,36,143,44,51,214,236,38,4,103,93,162,200,112,151,173,85,35,120,158,126,18,148,119,146,144,63,50,61,177,59,229,21,135,233,210,198,76,130,62,102,123,67,172,5,136,32,75,184,121,204,167,82,189,13,211,107,31,45,255,235,105,195,23,127,113,246,225,60,66,232,8,14,166,57,81,27,219,132,95,114,29,15,33,71,183,49,138,17,64,155,134,159,242,129,6,178,77,164,110,55,239,161,201,215,74,98,194,88,137,54,52,22,244,30,196,206,91,125,170,115,180,213,243,122,207,152,224,1,202,212,254,12,116,208,181,104,100,86,89,68,43,106,227,252,190,247,253,197,80,185,28,37,118,203,150,9,149,78,79,53,84,156,128,131,99,223,231,230,209,47,250,109,145,175,216,111,205,251,101,142,124,20,2,179,10,191,228,171,186,218,147,133,168,222,176,96,58,160,221,39,169,165,11,249,187,46,117,182,94,87,42,199,65,157,70,24,248,19,141,90,140,240,108,73,41,83,217,241,56,245,25,139,97,40,7,163,153,48,3,72,226,154,69,220,238,92,174,193,192,16,34,188,146,166,30,129,95,0,237,36,36,36,214,0,148,252,93,38,119,38,0,0,0,0,0,0,0,0,0,237,82,206,51,0,0,4,0,0,0,225,0,105,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,254,105,105,0,12,207,105,237,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,176,186,105,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,218,105,0,146,195,0,0,126,207,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,176,0,195,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,195,195,0,146,195,0,0,126,186,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,152,195,0,214,0,152,224,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,237,218,237,0,15,237,0,237,152,218,237,0,59,237,36,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,51,234,147,0,60,23,147,0,207,234,0,237,186,234,207,26,0,26,207,26,155,234,0,234,63,224,0,0,38,0,224,26,177,195,193,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,4,237,207,35,195,152,234,0,152,218,234,0,218,237,26,0,237,23,26,0,195,224,26,0,152,147,26,0,218,234,36,0,237,127,36,0,195,1,36,0,152,133,36,0,218,26,143,0,237,113,143,0,195,202,143,0,152,168,143,0,218,36,44,0,237,246,44,0,195,212,44,0,152,222,44,0,218,143,51,0,237,225,51,0,195,254,51,0,152,176,51,0,218,44,214,0,237,60,214,0,195,12,214,0,152,96,214,0,218,51,236,0,237,66,236,0,195,116,236,0,152,58,236,0,218,214,38,0,237,232,38,0,195,208,38,0,152,160,38,0,218,236,4,0,237,8,4,0,195,181,4,0,152,221,4,0,218,38,38,0,237,4,103,0,195,14,103,0,152,104,236,0,218,104,103,0,237,169,143,0,195,103,26,0,152,169,103,0,218,166,214,0,237,93,93,0,195,57,93,0,152,86,93,0,135,195,0,148,195,218,93,0,152,218,236,0,218,152,4,0,237,234,162,0,195,23,162,0,152,224,51,0,218,224,162,0,237,133,162,0,195,26,200,0,152,133,234,0,218,127,200,0,237,202,200,0,195,202,162,0,152,168,200,0,218,36,112,0,237,246,112,0,195,143,26,0,152,212,112,0,218,222,38,0,237,225,112,0,195,176,112,0,152,44,151,0,218,176,112,0,237,60,151,0,195,12,151,0,152,51,143,0,218,96,151,0,237,214,173,0,195,66,173,0,152,116,173,0,218,66,4,0,237,160,173,0,195,236,85,0,152,232,85,0,218,208,85,0,237,181,4,0,195,221,85,0,152,38,35,0,218,8,35,0,237,39,38,0,195,104,35,0,152,39,200,0,218,39,35,0,237,103,120,0,195,166,120,0,152,103,162,0,218,100,120,0,237,165,120,0,195,165,120,0,152,93,158,0,135,152,0,148,195,195,158,0,152,152,103,0,218,195,200,0,237,234,93,0,195,224,158,0,152,147,158,0,218,147,38,0,237,26,126,0,195,127,126,0,152,1,126,0,218,133,126,0,237,36,18,0,195,113,18,0,152,202,93,0,218,113,112,0,237,212,18,0,195,222,36,0,152,222,18,0,218,143,148,0,237,225,148,0,195,254,148,0,152,44,103,0,218,254,120,0,237,96,148,0,195,51,119,0,152,60,119,0,218,51,35,0,237,116,119,0,195,58,119,0,152,58,200,0,218,214,146,0,237,208,36,0,195,232,146,0,152,208,146,0,218,208,234,0,237,221,146,0,195,38,144,0,152,38,146,0,135,218,0,85,195,218,237,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,152,218,237,0,218,152,51,0,237,147,237,0,78,152,144,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,152,147,237,0,218,23,144,0,237,133,237,0,78,224,35,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,12,127,237,234,57,218,218,234,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,148,105,237,190,126,207,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,195,218,237,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,96,127,26,0,165,1,1,51,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,148,186,26,20,126,207,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,11,133,248,51,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,38,186,1,44,149,147,25,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,149,218,108,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,104,237,0,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,218,218,237,0,120,234,0,0,195,147,237,0,240,152,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,96,224,234,0,181,218,234,143,140,218,192,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,218,218,237,0,237,23,144,0,195,147,237,0,240,237,26,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,11,147,195,143,11,147,224,124,96,147,234,26,38,186,234,143,140,195,192,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,168,237,0,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,237,147,237,0,195,23,144,0,152,147,237,0,59,224,200,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,24,195,0,0,126,186,234,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,96,218,234,0,126,186,143,207,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,162,133,218,143,60,133,234,0,38,105,26,44,38,186,152,143,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,168,237,0,0,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,177,147,163,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,19,2,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,141,179,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,141,10,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,90,191,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,90,228,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,140,171,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,140,186,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,240,218,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,240,147,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,108,133,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,108,168,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,73,222,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,73,176,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,41,96,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,41,58,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,83,160,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,83,221,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,217,39,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,217,169,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,241,165,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,241,11,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,56,249,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,56,187,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,245,46,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,245,117,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,25,182,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,25,94,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,139,87,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,139,42,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,97,199,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,97,65,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,40,157,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,40,70,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,7,24,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,7,248,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,163,19,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,163,141,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,153,90,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,153,140,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,48,240,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,240,108,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,54,73,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,52,41,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,52,83,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,22,217,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,22,241,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,244,56,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,244,245,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,30,25,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,30,139,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,196,97,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,196,40,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,206,7,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,206,163,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,91,153,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,91,48,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,23,125,3,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,147,125,72,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,174,65,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,174,226,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,193,154,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,193,69,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,192,220,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,192,238,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,16,92,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,16,174,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,34,193,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,34,192,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,234,188,16,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,38,224,188,34,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,105,0,38,23,224,188,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,105,0,152,224,105,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,105,0,152,234,195,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,195,0,152,224,195,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,195,0,152,234,23,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,23,0,152,224,23,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,23,0,152,234,127,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,127,0,152,224,127,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,127,0,152,234,113,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,113,0,152,224,113,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,113,0,152,234,246,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,246,0,152,224,246,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,246,0,152,234,225,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,225,0,152,224,225,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,225,0,152,234,60,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,60,0,152,224,60,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,147,60,0,152,234,66,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,23,66,0,38,147,241,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,66,0,152,147,66,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,232,0,152,23,232,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,232,0,152,147,232,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,8,0,152,23,8,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,8,0,152,147,8,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,14,0,152,23,14,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,14,0,152,147,14,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,166,0,152,23,166,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,166,0,152,147,166,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,57,0,152,23,57,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,57,0,152,147,57,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,234,81,0,152,23,81,0,38,224,224,36,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,51,234,155,36,195,224,81,0,254,23,195,0,203,224,207,0,38,224,224,36,36,234,0,0,214,0,224,224,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,113,234,0,0,38,23,224,224,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,0,234,207,237,105,234,0,0,63,23,0,237,36,234,0,0,214,0,224,152,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,36,234,0,0,214,0,224,224,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,113,234,0,0,38,23,224,152,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,105,0,207,126,105,188,122,126,186,188,122,126,0,0,207,126,105,188,122,44,23,105,0,113,234,0,0,38,23,224,224,61,0,207,0,107,237,0,0,36,51,0,0,0,22,244,52,161,194,55,0,36,26,0,0,0,159,60,0,36,4,0,0,0,114,178,52,161,137,244,127,88,77,164,0,36,143,0,0,0,114,114,166,184,0,36,36,0,0,0,114,114,166,0,36,236,0,0,0,60,164,244,15,22,164,52,75,0,36,214,0,0,0,60,164,244,15,22,164,52,0,26,0,0,0,0,0,0,153,235,36,143,0,0,0,6,125,244,164,0,36,36,0,0,0,22,30,6,0,26,0,0,0,0,0,0,204,105,26,0,0,0,0,0,0,235,105,26,0,0,0,0,0,207,138,105,26,0,0,0,0,0,207,225,105,26,0,0,0,0,0,0,144,105,26,0,0,0,0,0,186,219,105,26,0,0,0,0,0,105,183,105,26,0,0,0,0,0,177,129,105,26,0,0,0,0,0,0,127,105,26,0,0,0,0,0,0,242,105,26,0,0,0,0,0,0,210,105,26,0,0,0,0,0,0,31,105,26,0,0,0,0,0,0,17,105,26,0,0,0,0,0,105,110,105,26,0,0,0,0,0,0,136,105,26,0,0,0,0,0,207,155,105,26,0,0,0,0,0,177,55,105,26,0,0,0,0,0,105,71,105,26,0,0,0,0,0,207,8,105,26,0,0,0,0,0,177,239,105,26,0,0,0,0,0,0,18,105,26,0,0,0,0,0,0,49,105,26,0,0,0,0,0,0,105,105,26,0,0,0,0,0,0,225,105,26,0,0,0,0,0,105,155,105,26,0,0,0,0,0,207,95,105,26,0,0,0,0,0,105,95,105,26,0,0,0,0,0,0,55,105,26,0,0,0,0,0,207,114,105,26,0,0,0,0,0,186,77,105,26,0,0,0,0,0,105,129,105,26,0,0,0,0,0,105,77,105,26,0,0,0,0,0,0,172,105,26,0,0,0,0,0,105,178,105,26,0,0,0,0,0,105,134,105,26,0,0,0,0,0,0,129,105,26,0,0,0,0,0,207,14,105,26,0,0,0,0,0,207,110,105,26,0,0,0,0,0,0,177,105,26,0,0,0,0,0,0,75,105,26,0,0,0,0,0,0,71,105,26,0,0,0,0,0,0,178,105,26,0,0,0,0,0,0,211,105,26,0,0,0,0,0,140,77,105,26,0,0,0,0,0,0,161,105,26,0,0,0,0,0,0,29,105,26,0,0,0,0,0,0,57,105,26,0,0,0,0,0,0,239,105,26,0,0,0,0,0,0,33,105,26,0,0,0,0,0,0,8,105,26,0,0,0,0,0,0,27,105,26,0,0,0,0,0,186,64,105,26,0,0,0,0,0,0,107,105,26,0,0,0,0,0,242,178,105,26,0,0,0,0,0,242,55,105,26,0,0,0,0,0,149,6,105,26,0,0,0,0,0,242,77,105,26,0,0,0,0,0,242,110,105,26,0,0,0,0,0,140,110,105,26,0,0,0,0,0,0,214,105,26,0,0,0,0,0,207,183,105,26,0,0,0,0,0,0,15,105,26,0,0,0,0,0,186,17,105,26,0,0,0,0,0,242,6,105,26,0,0,0,0,0,0,82,105,26,0,0,0,0,0,0,110,105,26,0,0,0,0,0,0,35,105,26,0,0,0,0,0,207,64,105,26,0,0,0,0,0,105,164,105,26,0,0,0,0,0,105,159,105,26,0,0,0,0,0,149,164,105,26,0,0,0,0,0,207,219,105,26,0,0,0,0,0,0,14,105,26,0,0,0,0,0,186,95,105,26,0,0,0,0,0,207,132,105,26,0,0,0,0,0,207,60,105,26,0,0,0,0,0,0,62,105,26,0,0,0,0,0,207,127,105,26,0,0,0,0,0,207,113,105,26,0,0,0,0,0,0,32,105,26,0,0,0,0,0,186,114,105,26,0,0,0,0,0,0,114,105,26,0,0,0,0,0,0,0,105,26,0,0,0,0,0,0,81,105,26,0,0,0,0,0,0,66,105,26,0,0,0,0,0,186,55,105,26,0,0,0,0,0,207,77,105,26,0,0,0,0,0,186,110,105,26,0,0,0,0,0,207,159,105,26,0,0,0,0,0,0,76,105,26,0,0,0,0,0,186,155,105,26,0,0,0,0,0,140,242,105,26,0,0,0,0,0,0,159,105,26,0,0,0,0,0,207,17,105,26,0,0,0,0,0,186,129,105,26,0,0,0,0,0,140,55,105,26,0,0,0,0,0,207,232,105,26,0,0,0,0,0,186,239,105,26,0,0,0,0,0,149,110,105,26,0,0,0,0,0,186,29,105,26,0,0,0,0,0,149,242,105,26,0,0,0,0,0,186,178,105,26,0,0,0,0,0,105,17,105,26,0,0,0,0,207,254,248,105,26,0,0,0,0,0,140,88,105,26,0,0,0,0,0,0,137,105,36,38,0,0,0,114,178,52,161,137,244,246,81,33,0,26,0,0,0,0,0,247,101,105,26,0,0,0,0,0,177,231,105,26,0,0,0,0,0,224,228,105,26,0,0,0,0,0,49,228,105,26,0,0,0,0,207,24,218,105,26,0,0,0,0,0,76,247,105,26,0,0,0,0,0,114,142,105,26,0,0,0,0,0,41,230,105,26,0,0,0,0,0,81,128,105,26,0,0,0,0,0,239,251,105,26,0,0,0,0,0,209,230,105,26,0,0,0,0,0,18,133,105,26,0,0,0,0,0,180,10,105,26,0,0,0,0,0,177,218,105,26,0,0,0,0,0,207,197,105,26,0,0,0,0,207,32,133,105,26,0,0,0,0,0,239,231,105,26,0,0,0,0,0,66,231,105,26,0,0,0,0,0,162,191,105,26,0,0,0,0,0,231,47,105,26,0,0,0,0,207,22,186,105,26,0,0,0,0,0,158,47,105,26,0,0,0,0,0,182,145,105,26,0,0,0,0,0,140,9,105,26,0,0,0,0,0,167,205,105,26,0,0,0,0,0,138,124,105,26,0,0,0,0,0,242,9,105,26,0,0,0,0,0,70,218,105,26,0,0,0,0,0,214,179,105,26,0,0,0,0,0,128,111,105,26,0,0,0,0,0,242,47,105,26,0,0,0,0,0,140,223,105,26,0,0,0,0,0,238,128,105,26,0,0,0,0,0,244,2,105,26,0,0,0,0,0,68,124,105,26,0,0,0,0,0,216,53,105,26,0,0,0,0,0,124,47,105,26,0,0,0,0,0,210,142,105,26,0,0,0,0,0,119,131,105,26,0,0,0,0,0,140,111,105,26,0,0,0,0,0,35,230,105,26,0,0,0,0,207,6,186,105,26,0,0,0,0,0,141,20,105,26,0,0,0,0,0,203,2,105,26,0,0,0,0,0,167,147,105,26,0,0,0,0,0,188,111,105,26,0,0,0,0,207,44,186,105,26,0,0,0,0,0,70,79,105,26,0,0,0,0,0,122,251,105,26,0,0,0,0,0,121,186,105,26,0,0,0,0,0,117,2,105,26,0,0,0,0,0,27,133,105,26,0,0,0,0,0,185,10,105,26,0,0,0,0,207,243,218,105,26,0,0,0,0,0,3,53,105,26,0,0,0,0,0,130,2,105,26,0,0,0,0,0,104,186,105,26,0,0,0,0,0,8,111,105,26,0,0,0,0,0,161,133,105,26,0,0,0,0,0,165,216,105,26,0,0,0,0,0,142,191,105,26,0,0,0,0,207,35,218,105,26,0,0,0,0,0,61,145,105,26,0,0,0,0,0,116,84,105,26,0,0,0,0,0,168,247,105,26,0,0,0,0,207,37,186,105,26,0,0,0,0,0,37,101,105,26,0,0,0,0,0,69,209,105,26,0,0,0,0,207,34,218,105,26,0,0,0,0,0,72,186,105,26,0,0,0,0,207,208,186,105,26,0,0,0,0,0,55,133,105,26,0,0,0,0,0,136,20,105,26,0,0,0,0,0,76,43,105,26,0,0,0,0,0,237,216,105,26,0,0,0,0,0,119,251,105,26,0,0,0,0,0,136,216,105,26,0,0,0,0,0,214,227,105,26,0,0,0,0,0,8,223,105,26,0,0,0,0,0,35,185,105,26,0,0,0,0,0,103,231,105,26,0,0,0,0,0,12,218,105,26,0,0,0,0,0,24,147,105,26,0,0,0,0,0,144,133,105,26,0,0,0,0,0,66,20,105,26,0,0,0,0,207,225,133,105,26,0,0,0,0,0,138,128,105,26,0,0,0,0,0,54,179,105,26,0,0,0,0,0,103,197,105,26,0,0,0,0,0,204,205,105,26,0,0,0,0,0,192,131,105,26,0,0,0,0,0,144,28,105,26,0,0,0,0,0,34,179,105,26,0,0,0,0,0,248,179,105,26,0,0,0,0,0,36,186,105,26,0,0,0,0,0,2,79,105,26,0,0,0,0,0,66,197,105,26,0,0,0,0,0,77,203,105,26,0,0,0,0,0,40,216,105,26,0,0,0,0,0,47,147,105,26,0,0,0,0,0,118,251,105,26,0,0,0,0,0,23,10,105,26,0,0,0,0,0,97,175,105,26,0,0,0,0,0,113,79,105,26,0,0,0,0,0,136,10,105,26,0,0,0,0,0,98,101,105,26,0,0,0,0,0,172,109,105,26,0,0,0,0,0,166,53,105,26,0,0,0,0,0,164,171,105,26,0,0,0,0,0,199,145,105,26,0,0,0,0,0,244,230,105,26,0,0,0,0,0,174,186,105,26,0,0,0,0,0,145,223,105,26,0,0,0,0,0,153,223,105,26,0,0,0,0,0,234,171,105,26,0,0,0,0,0,66,150,105,26,0,0,0,0,0,206,228,105,26,0,0,0,0,0,83,124,105,26,0,0,0,0,0,244,190,105,26,0,0,0,0,0,144,20,105,26,0,0,0,0,0,168,197,105,26,0,0,0,0,0,100,175,105,26,0,0,0,0,207,87,147,105,26,0,0,0,0,0,153,37,105,26,0,0,0,0,0,201,84,105,26,0,0,0,0,207,167,218,105,26,0,0,0,0,0,94,251,105,26,0,0,0,0,0,131,179,105,26,0,0,0,0,0,206,251,105,26,0,0,0,0,0,222,145,105,26,0,0,0,0,0,181,251,105,26,0,0,0,0,0,74,147,105,26,0,0,0,0,0,234,111,105,26,0,0,0,0,0,184,218,105,26,0,0,0,0,207,250,186,105,26,0,0,0,0,0,121,99,105,26,0,0,0,0,0,34,191,105,26,0,0,0,0,0,76,84,105,26,0,0,0,0,0,180,247,105,26,0,0,0,0,0,75,2,105,26,0,0,0,0,0,119,133,105,26,0,0,0,0,0,223,124,105,26,0,0,0,0,0,55,228,105,26,0,0,0,0,0,103,101,105,26,0,0,0,0,0,125,145,105,26,0,0,0,0,0,46,205,105,26,0,0,0,0,0,248,109,105,26,0,0,0,0,0,118,190,105,26,0,0,0,0,0,177,47,105,26,0,0,0,0,0,115,20,105,26,0,0,0,0,0,236,20,105,26,0,0,0,0,0,140,142,105,26,0,0,0,0,0,142,205,105,26,0,0,0,0,0,112,179,105,26,0,0,0,0,0,170,99,105,26,0,0,0,0,0,242,43,105,26,0,0,0,0,0,105,53,105,26,0,0,0,0,0,244,101,105,26,0,0,0,0,0,77,218,105,26,0,0,0,0,0,221,145,105,26,0,0,0,0,0,95,2,105,26,0,0,0,0,0,255,156,105,26,0,0,0,0,0,186,79,105,26,0,0,0,0,0,4,218,105,26,0,0,0,0,0,3,145,105,26,0,0,0,0,0,138,78,105,26,0,0,0,0,0,145,80,105,26,0,0,0,0,0,108,250,105,26,0,0,0,0,0,74,128,105,26,0,0,0,0,207,0,133,105,26,0,0,0,0,207,6,218,105,26,0,0,0,0,0,77,145,105,26,0,0,0,0,0,244,197,105,26,0,0,0,0,0,144,84,105,26,0,0,0,0,0,116,171,105,26,0,0,0,0,0,136,99,105,26,0,0,0,0,0,181,216,105,26,0,0,0,0,0,219,205,105,26,0,0,0,0,0,89,109,105,26,0,0,0,0,0,112,124,105,26,0,0,0,0,0,27,171,105,26,0,0,0,0,0,171,2,105,26,0,0,0,0,0,95,109,105,26,0,0,0,0,0,33,145,105,26,0,0,0,0,0,18,111,105,26,0,0,0,0,0,1,20,105,26,0,0,0,0,0,35,252,105,26,0,0,0,0,0,153,190,105,26,0,0,0,0,0,150,124,105,26,0,0,0,0,0,238,253,105,26,0,0,0,0,0,98,171,105,26,0,0,0,0,0,237,191,105,26,0,0,0,0,0,131,175,105,26,0,0,0,0,0,138,47,105,26,0,0,0,0,0,91,231,105,26,0,0,0,0,207,214,218,105,26,0,0,0,0,0,228,2,105,36,236,0,0,0,15,22,164,52,81,129,98,164,0,0,0,0,0,237,0,0,0,237,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,51,39,27,4,242,127,77,161,141,139,177,184,172,61,230,84,89,219,64,22,197,26,210,97,157,232,154,56,224,44,146,4,106,180,166,112,35,101,177,58,232,252,88,205,26,88,204,253,20,66,51,106,54,120,51,107,182,238,225,160,36,104,166,100,254,143,126,13,175,107,125,124,64,188,89,128,82,8,149,215,130,161,190,79,183,25,109,105,92,202,23,106,179,162,20,106,21,81,24,105,202,84,195,14,174,231,125,91,190,87,154,143,157,184,71,63,15,120,193,151,156,192,50,33,203,88,119,102,6,137,14,102,146,215,244,112,153,102,230,71,209,207,223,252,8,193,138,206,139,80,117,212,110,155,147,9,74,191,178,131,166,60,217,229,117,7,118,3,1,132,180,62,194,44,254,204,170,162,174,129,67,116,171,56,71,163,230,193,111,129,66,127,182,68,178,240,99,240,153,55,23,31,201,114,158,28,234,137,218,110,163,235,234,187,39,242,206,240,195,16,212,176,164,104,88,205,68,176,40,71,238,126,170,175,165,225,213,92,194,132,69,4,230,168,219,121,10,188,181,73,66,197,199,212,1,255})
    end
    _G.SimpleLibLoaded = true
end



