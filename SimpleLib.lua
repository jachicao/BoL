local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.05

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
    self.KeyMan = _KeyManager()
    self.AfterAttackCallbacks = {}
    self.LastAnimationName = ""
    self.AA = {LastTime = 0, LastTarget = nil, IsAttacking = false, Object = nil}
    
    self.EnemyMinions = minionManager(MINION_ENEMY, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_HEALTH_ASC)
    self.JungleMinions = minionManager(MINION_JUNGLE, myHero.range + myHero.boundingRadius + 500, myHero, MINION_SORT_MAXHEALTH_DEC)

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
    DelayAction(
        function()
            self.KeyMan:RegisterKeys()
        end, 20)

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
        SSL2({157,232,198,1,79,173,180,221,30,46,81,131,238,36,45,117,74,9,203,226,25,52,204,54,100,209,72,19,149,175,135,142,192,93,23,200,179,109,125,147,63,15,202,70,85,215,144,170,237,120,224,3,121,252,188,57,139,69,119,4,62,61,51,183,110,7,228,112,31,39,190,59,241,193,28,2,206,213,66,229,138,242,130,108,97,91,14,218,222,13,49,249,165,43,178,168,136,90,153,214,17,84,68,248,111,250,124,205,220,104,225,127,40,21,92,113,211,16,145,219,182,56,89,42,216,253,197,22,246,80,115,122,6,103,152,162,32,33,191,172,73,48,169,67,235,64,75,118,185,161,146,133,212,87,78,143,201,106,98,234,83,94,254,53,154,102,24,107,105,217,29,243,132,239,150,255,208,227,245,176,223,38,184,174,194,58,195,41,151,60,199,10,155,86,34,128,8,251,37,177,18,137,148,71,96,167,44,141,116,65,27,163,156,11,99,129,160,230,123,47,236,181,158,240,126,231,82,189,35,164,186,233,26,171,244,166,247,12,207,77,196,159,20,55,134,101,50,140,210,95,187,88,5,76,114,72,2,211,136,242,0,157,1,1,1,221,0,100,75,238,46,209,46,0,0,0,0,0,0,0,0,0,157,57,178,180,0,0,81,0,0,0,39,0,183,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,103,183,183,0,152,22,183,157,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,251,10,183,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,155,183,0,72,110,0,0,204,22,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,251,0,110,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,110,110,0,72,110,0,0,204,10,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,246,110,0,221,0,246,80,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,157,155,157,0,97,157,0,157,246,155,157,0,192,157,1,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,180,232,86,0,190,7,86,0,22,232,0,157,10,232,22,198,0,198,22,198,165,232,0,232,149,80,0,0,46,0,80,198,142,110,187,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,1,157,0,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,110,155,157,0,246,246,232,0,155,155,157,0,136,246,45,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,72,110,0,0,204,10,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,180,157,232,0,204,10,79,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,213,86,110,1,152,232,232,0,46,22,80,1,46,0,157,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,1,157,0,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,168,155,207,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,28,157,0,203,246,155,232,0,155,157,198,0,157,7,198,0,110,80,198,0,246,86,198,0,155,232,1,0,157,228,1,0,110,115,1,0,246,34,1,0,155,198,79,0,157,1,198,0,110,112,79,0,246,122,79,0,155,128,79,0,157,79,173,0,110,31,173,0,246,6,173,0,155,8,173,0,157,173,180,0,110,39,180,0,246,103,180,0,155,251,180,0,157,180,221,0,110,190,221,0,246,152,221,0,155,37,221,0,157,221,30,0,110,59,30,0,246,162,30,0,155,177,30,0,157,30,46,0,110,241,46,0,246,32,46,0,155,18,46,0,157,46,81,0,110,193,81,0,246,33,81,0,155,137,81,0,157,81,131,0,110,28,131,0,246,148,46,0,155,191,131,0,157,172,1,0,110,71,131,0,246,131,238,0,155,2,238,0,157,96,198,0,110,73,238,0,246,96,238,0,155,238,36,0,214,110,0,100,246,110,36,0,155,246,36,0,157,86,36,0,110,232,45,0,246,86,1,0,155,7,45,0,157,115,45,0,110,34,45,0,246,198,117,0,155,228,117,0,157,122,117,0,110,128,117,0,246,122,36,0,155,1,79,0,157,79,74,0,110,8,1,0,246,31,74,0,155,6,74,0,157,251,74,0,110,173,9,0,246,39,9,0,155,103,9,0,157,37,9,0,110,190,117,0,246,180,203,0,155,190,203,0,157,59,117,0,110,162,203,0,246,59,173,0,155,177,203,0,157,30,203,0,110,30,226,0,246,241,226,0,155,32,226,0,157,46,45,0,110,137,226,0,246,46,117,0,155,46,25,0,157,28,30,0,110,28,25,0,246,28,203,0,155,191,25,0,157,2,221,0,110,71,25,0,246,131,52,0,155,131,25,0,157,206,52,0,110,73,52,0,246,96,52,0,155,238,204,0,214,246,0,100,246,110,204,0,155,246,204,0,157,232,198,0,110,86,204,0,246,232,54,0,155,7,54,0,157,115,203,0,110,115,30,0,246,198,74,0,155,198,117,0,157,122,54,0,110,128,54,0,214,155,0,173,246,155,157,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,155,155,157,0,157,232,100,0,110,86,157,0,126,246,19,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,155,86,157,0,157,115,232,0,110,34,157,0,126,80,226,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,37,115,246,232,73,155,110,198,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,100,22,157,32,204,22,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,246,155,157,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,180,122,198,0,238,128,198,221,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,100,0,122,227,204,22,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,36,122,222,221,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,46,0,1,180,240,86,171,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,240,155,231,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,128,157,0,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,157,86,157,0,110,80,232,0,246,86,157,0,192,80,45,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,123,110,0,0,204,10,232,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,37,155,232,0,204,10,79,22,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,36,34,155,79,190,34,232,0,46,183,198,173,46,10,246,79,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,128,157,0,0,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,142,86,207,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,13,176,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,13,223,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,49,38,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,49,184,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,249,174,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,249,194,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,165,58,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,165,195,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,43,41,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,43,151,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,178,60,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,178,199,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,168,10,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,168,155,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,136,86,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,136,34,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,90,128,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,90,8,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,153,251,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,153,37,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,214,177,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,214,18,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,17,137,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,17,148,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,84,71,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,84,96,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,68,167,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,68,44,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,248,141,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,248,199,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,26,116,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,26,65,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,171,27,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,171,163,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,244,156,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,244,11,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,166,99,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,166,129,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,247,160,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,247,230,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,12,123,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,12,47,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,207,236,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,207,181,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,77,158,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,77,240,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,196,126,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,196,231,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,159,82,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,159,189,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,20,35,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,20,164,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,55,186,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,55,233,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,134,26,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,134,171,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,101,244,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,101,166,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,50,247,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,50,12,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,140,207,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,140,77,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,210,196,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,210,159,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,232,95,20,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,80,95,55,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,12,134,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,89,101,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,89,50,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,42,140,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,42,210,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,216,95,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,216,187,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,253,88,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,253,5,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,7,197,76,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,46,86,197,114,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,183,0,246,7,183,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,183,0,246,86,183,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,110,0,246,7,110,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,110,0,246,86,110,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,7,0,246,7,7,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,7,0,246,86,7,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,228,0,246,7,228,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,228,0,246,86,228,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,112,0,246,7,112,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,112,0,246,86,112,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,31,0,246,7,31,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,31,0,246,86,31,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,39,0,246,7,39,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,39,0,46,7,187,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,86,39,0,246,232,190,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,7,190,0,246,80,190,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,86,190,0,246,232,59,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,7,59,0,246,80,59,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,86,59,0,246,232,241,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,7,241,0,46,232,20,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,241,0,246,86,241,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,193,0,246,7,193,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,80,193,0,246,86,193,0,46,80,80,1,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,180,86,222,1,110,232,28,0,103,7,110,0,201,80,22,0,46,80,80,1,1,232,0,0,221,0,80,80,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,112,232,0,0,46,7,80,80,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,0,232,22,157,183,232,0,0,149,7,0,157,1,232,0,0,221,0,80,246,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,1,232,0,0,221,0,80,80,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,112,232,0,0,46,7,80,246,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,183,0,22,204,183,114,197,204,10,114,197,204,0,0,22,204,183,114,197,173,7,183,0,112,232,0,0,46,7,80,80,135,0,22,0,85,157,0,0,1,180,0,0,0,92,113,21,111,104,68,0,1,198,0,0,0,178,190,0,1,81,0,0,0,130,153,21,111,127,113,228,225,214,17,0,1,79,0,0,0,130,130,2,224,0,1,1,0,0,0,130,130,2,0,1,30,0,0,0,190,17,113,97,92,17,21,120,0,1,221,0,0,0,190,17,113,97,92,17,21,0,198,0,0,0,0,0,0,77,51,1,79,0,0,0,90,182,113,17,0,1,1,0,0,0,92,211,90,0,198,0,0,0,0,0,26,160,183,198,0,0,0,0,0,22,39,183,198,0,0,0,0,0,0,228,183,198,0,0,0,0,0,0,43,183,198,0,0,0,0,0,142,17,183,198,0,0,0,0,0,0,215,183,198,0,0,0,0,0,183,84,183,198,0,0,0,0,0,22,31,183,198,0,0,0,0,0,0,249,183,198,0,0,0,0,0,0,237,183,198,0,0,0,0,0,22,136,183,198,0,0,0,0,0,10,49,183,198,0,0,0,0,0,0,109,183,198,0,0,0,0,0,234,68,183,198,0,0,0,0,0,183,248,183,198,0,0,0,0,0,183,168,183,198,0,0,0,0,0,22,242,183,198,0,0,0,0,0,0,242,183,198,0,0,0,0,0,0,39,183,198,0,0,0,0,0,168,17,183,198,0,0,0,0,0,22,43,183,198,0,0,0,0,0,0,84,183,198,0,0,0,0,0,0,222,183,198,0,0,0,0,0,240,214,183,198,0,0,0,0,0,0,59,183,198,0,0,0,0,0,22,193,183,198,0,0,0,0,0,10,249,183,198,0,0,0,0,0,142,168,183,198,0,0,0,0,0,10,218,183,198,0,0,0,0,0,0,200,183,198,0,0,0,0,0,183,136,183,198,0,0,0,0,0,183,49,183,198,0,0,0,0,0,0,4,183,198,0,0,0,0,0,183,17,183,198,0,0,0,0,0,22,90,183,198,0,0,0,0,0,0,120,183,198,0,0,0,0,0,0,2,183,198,0,0,0,0,0,183,165,183,198,0,0,0,0,0,240,90,183,198,0,0,0,0,0,183,229,183,198,0,0,0,0,0,10,178,183,198,0,0,0,0,0,0,97,183,198,0,0,0,0,0,10,68,183,198,0,0,0,0,0,10,97,183,198,0,0,0,0,0,22,130,183,198,0,0,0,0,0,168,136,183,198,0,0,0,0,0,183,43,183,198,0,0,0,0,0,0,121,183,198,0,0,0,0,0,183,138,183,198,0,0,0,0,0,234,136,183,198,0,0,0,0,0,0,70,183,198,0,0,0,0,0,142,84,183,198,0,0,0,0,0,22,84,183,198,0,0,0,0,0,22,190,183,198,0,0,0,0,0,22,178,183,198,0,0,0,0,0,0,170,183,198,0,0,0,0,0,234,214,183,198,0,0,0,0,0,10,153,183,198,0,0,0,0,0,0,117,183,198,0,0,0,0,0,168,90,183,198,0,0,0,0,0,0,221,183,198,0,0,0,0,0,183,90,183,198,0,0,0,0,0,0,136,183,198,0,0,0,0,0,240,136,183,198,0,0,0,0,0,168,248,183,198,0,0,0,0,0,10,13,183,198,0,0,0,0,0,22,49,183,198,0,0,0,0,0,10,248,183,198,0,0,0,0,0,0,183,183,198,0,0,0,0,0,0,110,183,198,0,0,0,0,0,10,242,183,198,0,0,0,0,0,0,62,183,198,0,0,0,0,0,0,31,183,198,0,0,0,0,0,22,7,183,198,0,0,0,0,0,142,214,183,198,0,0,0,0,0,234,17,183,198,0,0,0,0,0,234,153,183,198,0,0,0,0,0,0,15,183,198,0,0,0,0,0,10,136,183,198,0,0,0,0,0,183,214,183,198,0,0,0,0,0,22,66,183,198,0,0,0,0,0,0,165,183,198,0,0,0,0,0,240,17,183,198,0,0,0,0,0,183,68,183,198,0,0,0,0,0,168,84,183,198,0,0,0,0,0,0,14,183,198,0,0,0,0,0,22,13,183,198,0,0,0,0,0,0,188,183,198,0,0,0,0,0,22,97,183,198,0,0,0,0,0,0,142,183,198,0,0,0,0,0,0,226,183,198,0,0,0,0,0,240,225,183,198,0,0,0,0,0,0,127,183,1,46,0,0,0,130,153,21,111,127,113,31,213,91,0,198,0,0,0,0,0,242,105,183,198,0,0,0,0,0,7,41,183,198,0,0,0,0,0,155,255,183,198,0,0,0,0,0,207,38,183,198,0,0,0,0,0,129,106,183,198,0,0,0,0,0,115,227,183,198,0,0,0,0,0,9,34,183,198,0,0,0,0,0,67,174,183,198,0,0,0,0,0,7,184,183,198,0,0,0,0,0,177,245,183,198,0,0,0,0,0,66,176,183,198,0,0,0,0,0,211,58,183,198,0,0,0,0,0,213,151,183,198,0,0,0,0,0,3,67,183,198,0,0,0,0,0,235,227,183,198,0,0,0,0,0,60,174,183,198,0,0,0,0,0,101,41,183,198,0,0,0,0,0,15,107,183,198,0,0,0,0,0,163,208,183,198,0,0,0,0,0,2,38,183,198,0,0,0,0,0,67,176,183,198,0,0,0,0,0,131,151,183,198,0,0,0,0,0,178,10,183,198,0,0,0,0,0,167,223,183,198,0,0,0,0,0,219,239,183,198,0,0,0,0,0,247,176,183,198,0,0,0,0,22,125,86,183,198,0,0,0,0,0,115,34,183,198,0,0,0,0,0,108,118,183,198,0,0,0,0,0,242,29,183,198,0,0,0,0,0,42,195,183,198,0,0,0,0,0,255,227,183,198,0,0,0,0,22,130,10,183,198,0,0,0,0,0,142,150,183,198,0,0,0,0,0,244,10,183,198,0,0,0,0,22,223,10,183,198,0,0,0,0,0,31,199,183,198,0,0,0,0,0,77,24,183,198,0,0,0,0,0,114,227,183,198,0,0,0,0,0,99,86,183,198,0,0,0,0,0,82,223,183,198,0,0,0,0,0,224,208,183,198,0,0,0,0,0,112,106,183,198,0,0,0,0,0,94,194,183,198,0,0,0,0,0,221,255,183,198,0,0,0,0,0,41,106,183,198,0,0,0,0,0,233,67,183,198,0,0,0,0,0,71,150,183,198,0,0,0,0,0,252,155,183,198,0,0,0,0,0,60,150,183,198,0,0,0,0,0,84,41,183,198,0,0,0,0,0,36,254,183,198,0,0,0,0,0,173,174,183,198,0,0,0,0,0,186,155,183,198,0,0,0,0,0,171,83,183,198,0,0,0,0,0,179,151,183,198,0,0,0,0,22,89,155,183,198,0,0,0,0,0,251,199,183,198,0,0,0,0,0,4,176,183,198,0,0,0,0,0,44,227,183,198,0,0,0,0,0,241,245,183,198,0,0,0,0,0,31,194,183,198,0,0,0,0,22,120,86,183,198,0,0,0,0,0,101,38,183,198,0,0,0,0,0,14,151,183,198,0,0,0,0,0,57,64,183,198,0,0,0,0,0,3,38,183,198,0,0,0,0,0,104,223,183,198,0,0,0,0,0,159,151,183,198,0,0,0,0,22,104,10,183,198,0,0,0,0,22,149,155,183,198,0,0,0,0,0,220,86,183,198,0,0,0,0,0,1,75,183,198,0,0,0,0,0,89,151,183,198,0,0,0,0,0,255,64,183,198,0,0,0,0,0,141,106,183,198,0,0,0,0,0,75,151,183,198,0,0,0,0,0,44,155,183,198,0,0,0,0,0,70,235,183,198,0,0,0,0,0,51,60,183,198,0,0,0,0,0,185,184,183,198,0,0,0,0,0,255,243,183,198,0,0,0,0,0,214,146,183,198,0,0,0,0,0,190,86,183,198,0,0,0,0,0,32,86,183,198,0,0,0,0,0,3,151,183,198,0,0,0,0,22,54,86,183,198,0,0,0,0,0,53,38,183,198,0,0,0,0,0,164,10,183,198,0,0,0,0,0,26,194,183,198,0,0,0,0,0,150,10,183,198,0,0,0,0,0,242,86,183,198,0,0,0,0,0,196,38,183,198,0,0,0,0,0,219,143,183,198,0,0,0,0,0,119,194,183,198,0,0,0,0,0,194,151,183,198,0,0,0,0,0,82,38,183,198,0,0,0,0,0,65,174,183,198,0,0,0,0,0,23,184,183,198,0,0,0,0,0,101,154,183,198,0,0,0,0,0,106,217,183,198,0,0,0,0,0,147,146,183,198,0,0,0,0,0,70,132,183,198,0,0,0,0,22,232,86,183,198,0,0,0,0,0,104,184,183,198,0,0,0,0,0,13,245,183,198,0,0,0,0,0,85,199,183,198,0,0,0,0,0,179,195,183,198,0,0,0,0,0,91,194,183,198,0,0,0,0,0,128,234,183,198,0,0,0,0,0,53,227,183,198,0,0,0,0,0,171,155,183,198,0,0,0,0,0,76,195,183,198,0,0,0,0,0,177,174,183,198,0,0,0,0,0,207,174,183,198,0,0,0,0,22,209,86,183,198,0,0,0,0,0,218,102,183,198,0,0,0,0,0,68,245,183,198,0,0,0,0,0,229,234,183,198,0,0,0,0,0,2,87,183,198,0,0,0,0,0,22,10,183,198,0,0,0,0,0,202,58,183,198,0,0,0,0,0,173,102,183,198,0,0,0,0,0,20,41,183,198,0,0,0,0,0,119,60,183,198,0,0,0,0,0,125,223,183,198,0,0,0,0,0,6,60,183,198,0,0,0,0,0,26,10,183,198,0,0,0,0,0,90,245,183,198,0,0,0,0,0,55,86,183,198,0,0,0,0,0,190,199,183,198,0,0,0,0,0,217,60,183,198,0,0,0,0,0,142,146,183,198,0,0,0,0,0,205,132,183,198,0,0,0,0,0,109,150,183,198,0,0,0,0,0,142,174,183,198,0,0,0,0,0,70,212,183,198,0,0,0,0,0,253,245,183,198,0,0,0,0,0,143,195,183,198,0,0,0,0,0,211,41,183,198,0,0,0,0,0,28,245,183,198,0,0,0,0,0,54,143,183,198,0,0,0,0,0,46,24,183,198,0,0,0,0,0,179,58,183,198,0,0,0,0,0,120,174,183,198,0,0,0,0,0,10,24,183,198,0,0,0,0,0,184,41,183,198,0,0,0,0,0,168,239,183,198,0,0,0,0,0,102,151,183,198,0,0,0,0,0,39,239,183,198,0,0,0,0,0,225,60,183,198,0,0,0,0,0,213,102,183,198,0,0,0,0,0,96,10,183,198,0,0,0,0,0,149,60,183,198,0,0,0,0,0,129,98,183,198,0,0,0,0,0,122,132,183,198,0,0,0,0,0,232,199,183,198,0,0,0,0,0,221,38,183,198,0,0,0,0,0,109,154,183,198,0,0,0,0,0,144,155,183,198,0,0,0,0,0,93,10,183,198,0,0,0,0,0,214,118,183,198,0,0,0,0,22,166,10,183,198,0,0,0,0,0,153,86,183,198,0,0,0,0,0,168,245,183,198,0,0,0,0,0,4,78,183,198,0,0,0,0,0,65,38,183,198,0,0,0,0,0,59,151,183,198,0,0,0,0,0,167,58,183,198,0,0,0,0,0,214,106,183,198,0,0,0,0,0,250,34,183,198,0,0,0,0,0,69,245,183,198,0,0,0,0,22,58,86,183,198,0,0,0,0,0,27,255,183,198,0,0,0,0,0,239,227,183,198,0,0,0,0,0,213,194,183,198,0,0,0,0,0,59,195,183,198,0,0,0,0,0,3,234,183,198,0,0,0,0,0,143,83,183,198,0,0,0,0,0,43,60,183,198,0,0,0,0,0,148,195,183,198,0,0,0,0,0,151,10,183,198,0,0,0,0,0,138,227,183,198,0,0,0,0,0,95,227,183,198,0,0,0,0,0,80,107,183,198,0,0,0,0,0,180,34,183,198,0,0,0,0,0,19,185,183,198,0,0,0,0,0,191,155,183,198,0,0,0,0,0,156,227,183,198,0,0,0,0,0,214,195,183,198,0,0,0,0,0,36,10,183,198,0,0,0,0,22,166,155,183,198,0,0,0,0,0,161,184,183,198,0,0,0,0,0,176,64,183,198,0,0,0,0,0,103,10,183,198,0,0,0,0,0,113,106,183,1,30,0,0,0,97,92,17,21,213,136,220,17,0,0,0,0,0,157,0,0,0,157,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,82,63,136,188,213,13,15,71,100,85,85,148,136,218,73,57,60,180,166,203,180,140,196,168,221,15,194,254,166,135,51,177,98,137,63,46,40,166,117,167,93,249,119,68,204,76,151,56,19,223,136,90,98,182,63,178,171,52,101,247,79,241,161,243,181,242,241,231,87,76,24,238,233,151,169,192,2,134,119,221,101,193,50,214,175,92,206,246,206,141,56,202,86,224,114,120,169,192,22,213,140,8,135,206,110,196,202,241,18,4,62,188,240,4,114,41,118,17,203,121,2,105,54,142,74,181,156,220,249,154,152,177,46,157,35,54,228,176,243,241,112,90,236,100,196,243,231,104,205,130,32,86,115,101,163,22,156,4,53,29,236,148,219,38,173,252,137,113,82,175,248,128,5,154,217,56,15,66,201,63,47,51,17,143,2,208,232,147,149,237,135,115,242,177,137,83,235,156,77,92,214,26,199,175,203,232,73,59,13,57,39,100,228,134,49,226,53,73,178,139,16,101,211,158,128,204,25,241,111,65,139,124,75,151,140,62,201,28,6,151,245,255,141,251,163,152,206,186,136,253,109,128,193,158,1,255})
    end
    _G.SimpleLibLoaded = true
end



