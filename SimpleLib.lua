local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.07

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
        SSL2({121,107,94,52,246,63,236,184,139,152,222,114,87,108,165,26,205,147,6,124,102,86,229,215,191,150,188,208,98,146,166,12,85,69,240,134,133,135,33,123,181,109,230,128,137,217,5,32,237,189,77,16,50,9,119,201,203,231,168,48,101,46,58,71,155,106,161,43,91,81,244,178,2,118,82,232,22,227,131,149,116,96,42,212,44,207,51,129,70,192,172,213,39,100,125,175,37,202,145,13,216,193,218,120,136,75,30,226,99,204,182,248,80,148,23,254,173,65,251,7,83,78,31,15,186,151,210,199,115,211,144,209,72,92,234,56,64,62,197,40,196,27,49,90,183,225,21,198,89,79,247,17,194,38,157,41,25,14,53,111,8,47,76,68,245,177,190,143,19,250,97,195,241,1,154,127,228,29,156,253,113,185,36,167,4,103,224,206,249,219,54,164,84,242,28,180,10,35,200,159,66,3,45,179,142,57,88,171,153,132,61,138,122,112,169,255,170,104,67,233,59,235,73,93,110,239,130,238,20,176,117,214,34,55,163,162,74,60,105,187,243,11,252,140,158,223,220,160,126,174,221,18,141,95,24,188,232,173,37,96,0,121,52,52,52,184,0,191,21,87,152,150,152,0,0,0,0,0,0,0,0,0,121,203,144,236,0,0,222,0,0,0,81,0,71,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,92,71,71,0,234,199,71,121,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,35,164,71,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,84,71,0,188,155,0,0,229,199,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,35,0,155,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,155,155,0,188,155,0,0,229,164,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,115,155,0,184,0,115,211,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,121,84,121,0,44,121,0,121,115,84,121,0,85,121,52,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,236,107,242,0,244,106,242,0,199,107,0,121,164,107,199,94,0,94,199,94,39,107,0,107,98,211,0,0,152,0,211,94,12,155,221,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,52,121,0,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,155,84,121,0,115,115,107,0,84,84,121,0,37,115,165,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,188,155,0,0,229,164,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,236,121,107,0,229,164,246,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,227,242,155,52,234,107,107,0,152,199,211,52,152,0,121,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,52,121,0,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,175,84,105,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,43,121,0,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,115,84,121,0,84,115,107,0,121,242,121,0,8,115,165,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,172,155,0,0,229,164,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,244,155,107,0,229,164,246,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,27,242,84,52,200,106,107,0,152,164,107,246,152,71,115,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,43,121,0,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,111,84,105,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,197,121,199,124,84,84,107,0,121,107,94,0,155,106,94,0,115,211,94,0,84,242,94,0,121,94,52,0,155,161,52,0,115,144,52,0,84,28,52,0,121,52,246,0,155,43,246,0,115,209,246,0,84,180,246,0,121,246,63,0,155,91,63,0,115,72,63,0,84,10,63,0,121,63,236,0,155,81,236,0,115,92,236,0,84,35,236,0,121,236,184,0,155,244,184,0,115,236,63,0,84,234,184,0,121,159,184,0,155,178,184,0,115,184,139,0,84,178,139,0,121,64,139,0,155,66,139,0,115,2,52,0,84,139,152,0,121,118,152,0,155,62,152,0,115,3,152,0,84,152,222,0,121,82,222,0,155,197,222,0,115,197,184,0,84,45,222,0,121,114,114,0,155,232,114,0,115,40,114,0,84,179,114,0,121,87,87,0,155,22,87,0,115,196,87,0,84,142,87,0,121,108,108,0,68,155,0,191,84,155,108,0,121,211,108,0,155,242,108,0,115,107,165,0,84,107,236,0,121,161,165,0,155,94,94,0,115,144,165,0,84,28,165,0,121,52,26,0,155,209,108,0,115,43,26,0,84,43,184,0,121,91,246,0,155,72,26,0,115,10,26,0,84,246,205,0,121,81,205,0,155,92,205,0,115,35,205,0,84,35,121,0,121,236,147,0,155,200,63,0,115,244,147,0,84,234,147,0,121,159,147,0,155,184,6,0,115,178,6,0,84,56,6,0,121,66,6,0,155,2,147,0,115,66,236,0,84,66,94,0,121,152,124,0,155,118,124,0,115,62,124,0,84,3,124,0,121,45,184,0,155,222,102,0,115,222,94,0,84,82,102,0,121,40,102,0,155,179,102,0,115,114,86,0,84,232,86,0,121,196,86,0,155,142,86,0,115,87,229,0,84,22,229,0,121,27,229,0,68,115,0,191,84,84,229,0,121,106,152,0,155,107,215,0,115,211,184,0,84,106,215,0,121,144,215,0,155,94,102,0,115,28,215,0,84,28,63,0,121,52,191,0,155,180,222,0,115,52,139,0,84,43,191,0,121,72,191,0,155,72,152,0,115,10,191,0,84,246,150,0,121,81,150,0,155,63,246,0,115,92,150,0,84,81,26,0,121,234,184,0,155,200,150,0,115,236,188,0,84,234,94,0,121,178,188,0,155,56,188,0,115,56,184,0,84,56,205,0,121,2,102,0,155,64,165,0,115,66,188,0,84,66,152,0,121,118,63,0,68,84,0,205,84,84,121,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,121,242,121,0,155,211,102,0,115,242,121,0,85,211,208,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,121,28,121,0,155,144,107,0,115,28,121,0,85,144,124,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,236,180,121,94,142,84,84,94,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,191,164,121,64,229,199,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,84,84,121,0,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,244,180,94,0,22,52,209,184,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,191,71,52,167,229,199,107,199,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,227,43,233,184,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,152,71,209,236,12,28,55,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,12,242,239,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,59,4,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,59,103,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,235,224,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,235,206,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,73,249,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,73,219,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,93,54,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,93,164,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,110,84,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,110,242,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,239,28,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,239,180,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,130,10,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,130,35,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,238,200,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,238,159,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,20,66,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,20,3,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,176,45,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,176,179,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,117,142,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,117,57,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,214,88,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,214,171,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,34,153,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,34,132,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,55,61,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,55,138,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,163,122,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,163,112,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,162,169,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,162,255,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,74,170,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,74,104,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,60,67,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,60,233,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,105,59,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,105,235,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,187,73,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,187,93,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,243,110,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,243,239,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,11,130,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,11,238,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,252,20,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,252,176,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,140,117,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,140,214,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,158,34,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,158,55,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,223,163,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,223,162,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,220,74,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,220,60,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,160,105,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,160,187,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,126,243,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,126,11,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,174,252,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,174,140,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,221,158,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,221,223,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,18,220,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,211,18,160,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,107,141,126,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,106,186,117,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,242,186,221,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,106,151,18,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,242,151,141,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,106,210,95,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,152,242,210,24,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,71,0,115,106,71,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,71,0,115,242,71,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,155,0,115,106,155,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,155,0,115,242,155,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,106,0,115,106,106,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,106,0,115,242,106,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,161,0,115,106,161,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,161,0,115,242,161,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,43,0,115,106,43,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,43,0,115,242,43,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,91,0,115,106,91,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,91,0,115,242,91,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,81,0,115,106,81,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,81,0,115,242,81,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,244,0,115,106,244,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,244,0,115,242,244,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,178,0,115,106,178,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,178,0,115,242,178,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,2,0,115,106,2,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,2,0,115,242,2,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,118,0,115,106,118,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,118,0,115,242,118,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,82,0,115,106,82,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,82,0,115,242,82,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,232,0,115,106,232,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,232,0,115,242,232,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,22,0,115,106,22,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,22,0,115,242,22,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,107,227,0,115,106,227,0,152,211,211,52,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,236,211,213,52,155,211,227,0,92,106,155,0,25,211,199,0,152,211,211,52,52,107,0,0,184,0,211,211,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,43,107,0,0,152,106,211,211,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,0,107,199,121,71,107,0,0,98,106,0,121,52,107,0,0,184,0,211,115,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,52,107,0,0,184,0,211,211,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,43,107,0,0,152,106,211,115,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,71,0,199,229,71,24,210,229,164,24,210,229,0,0,199,229,71,24,210,63,106,71,0,43,107,0,0,152,106,211,211,166,0,199,0,168,121,0,0,52,236,0,0,0,23,254,148,136,204,218,0,52,94,0,0,0,125,244,0,52,222,0,0,0,42,145,148,136,248,254,161,182,13,216,0,52,246,0,0,0,42,42,232,77,0,52,52,0,0,0,42,42,232,0,52,139,0,0,0,244,216,254,44,23,216,148,189,0,52,184,0,0,0,244,216,254,44,23,216,148,0,94,0,0,0,0,0,0,187,58,52,246,0,0,0,202,83,254,216,0,52,52,0,0,0,23,173,202,0,94,0,0,0,0,164,167,233,71,94,0,0,0,0,0,0,237,71,94,0,0,0,0,0,164,172,71,94,0,0,0,0,0,0,203,71,94,0,0,0,0,0,12,175,71,94,0,0,0,0,0,199,42,71,94,0,0,0,0,0,93,175,71,94,0,0,0,0,0,71,42,71,94,0,0,0,0,0,164,175,71,94,0,0,0,0,0,175,13,71,94,0,0,0,0,0,0,161,71,94,0,0,0,0,0,71,175,71,94,0,0,0,0,0,12,218,71,94,0,0,0,0,0,71,207,71,94,0,0,0,0,0,0,212,71,94,0,0,0,0,0,111,145,71,94,0,0,0,0,0,93,218,71,94,0,0,0,0,0,93,202,71,94,0,0,0,0,0,0,168,71,94,0,0,0,0,0,0,201,71,94,0,0,0,0,0,111,193,71,94,0,0,0,0,0,164,207,71,94,0,0,0,0,0,199,178,71,94,0,0,0,0,0,71,70,71,94,0,0,0,0,0,71,192,71,94,0,0,0,0,0,199,145,71,94,0,0,0,0,0,0,81,71,94,0,0,0,0,0,0,13,71,94,0,0,0,0,0,0,155,71,94,0,0,0,0,0,164,96,71,94,0,0,0,0,0,0,116,71,94,0,0,0,0,0,199,212,71,94,0,0,0,0,0,0,91,71,94,0,0,0,0,0,111,216,71,94,0,0,0,0,0,0,218,71,94,0,0,0,0,0,199,213,71,94,0,0,0,0,0,0,26,71,94,0,0,0,0,0,175,216,71,94,0,0,0,0,0,0,39,71,94,0,0,0,0,0,12,120,71,94,0,0,0,0,0,199,51,71,94,0,0,0,0,0,199,70,71,94,0,0,0,0,0,93,37,71,94,0,0,0,0,0,0,100,71,94,0,0,0,0,0,0,129,71,94,0,0,0,0,0,175,37,71,94,0,0,0,0,0,71,100,71,94,0,0,0,0,0,199,96,71,94,0,0,0,0,0,175,175,71,94,0,0,0,0,0,199,149,71,94,0,0,0,0,0,0,22,71,94,0,0,0,0,0,71,218,71,94,0,0,0,0,0,0,101,71,94,0,0,0,0,0,0,135,71,94,0,0,0,0,0,164,100,71,94,0,0,0,0,0,0,217,71,94,0,0,0,0,0,164,120,71,94,0,0,0,0,0,175,120,71,94,0,0,0,0,0,71,51,71,94,0,0,0,0,0,71,37,71,94,0,0,0,0,0,164,149,71,94,0,0,0,0,0,111,202,71,94,0,0,0,0,0,164,37,71,94,0,0,0,0,0,71,216,71,94,0,0,0,0,0,199,118,71,94,0,0,0,0,0,199,43,71,94,0,0,0,0,0,71,129,71,94,0,0,0,0,0,93,145,71,94,0,0,0,0,0,0,125,71,94,0,0,0,0,0,199,13,71,94,0,0,0,0,0,199,131,71,94,0,0,0,0,0,71,13,71,94,0,0,0,0,0,199,39,71,94,0,0,0,0,0,164,13,71,94,0,0,0,0,0,0,16,71,94,0,0,0,0,0,12,37,71,94,0,0,0,0,0,0,12,71,94,0,0,0,0,0,199,192,71,94,0,0,0,0,0,0,172,71,94,0,0,0,0,0,0,50,71,94,0,0,0,0,0,0,109,71,94,0,0,0,0,0,0,51,71,94,0,0,0,0,0,199,244,71,94,0,0,0,0,0,0,43,71,94,0,0,0,0,0,0,44,71,94,0,0,0,0,0,199,120,71,94,0,0,0,0,0,93,120,71,94,0,0,0,0,0,199,216,71,94,0,0,0,0,0,199,81,71,94,0,0,0,0,0,12,145,71,94,0,0,0,0,0,71,202,71,94,0,0,0,0,0,0,202,71,94,0,0,0,0,0,199,44,71,94,0,0,0,0,0,0,128,71,94,0,0,0,0,0,0,213,71,94,0,0,0,0,0,0,96,71,94,0,0,0,0,0,164,42,71,94,0,0,0,0,0,0,46,71,94,0,0,0,0,0,164,70,71,94,0,0,0,0,0,0,71,71,94,0,0,0,0,0,164,125,71,94,0,0,0,0,0,0,231,71,94,0,0,0,0,0,93,182,71,94,0,0,0,0,0,0,248,71,52,152,0,0,0,42,145,148,136,248,254,91,227,207,0,94,0,0,0,0,0,15,225,71,94,0,0,0,0,199,175,28,71,94,0,0,0,0,0,7,103,71,94,0,0,0,0,0,231,242,71,94,0,0,0,0,0,143,156,71,94,0,0,0,0,0,16,21,71,94,0,0,0,0,199,40,242,71,94,0,0,0,0,199,124,242,71,94,0,0,0,0,0,232,17,71,94,0,0,0,0,0,62,253,71,94,0,0,0,0,0,54,185,71,94,0,0,0,0,0,9,4,71,94,0,0,0,0,0,85,242,71,94,0,0,0,0,0,181,29,71,94,0,0,0,0,199,10,84,71,94,0,0,0,0,0,99,28,71,94,0,0,0,0,0,36,249,71,94,0,0,0,0,0,133,219,71,94,0,0,0,0,0,180,84,71,94,0,0,0,0,0,136,164,71,94,0,0,0,0,0,213,21,71,94,0,0,0,0,199,192,28,71,94,0,0,0,0,0,215,183,71,94,0,0,0,0,199,194,164,71,94,0,0,0,0,0,107,47,71,94,0,0,0,0,0,76,249,71,94,0,0,0,0,0,174,111,71,94,0,0,0,0,0,33,127,71,94,0,0,0,0,0,151,29,71,94,0,0,0,0,0,36,228,71,94,0,0,0,0,0,118,29,71,94,0,0,0,0,0,149,228,71,94,0,0,0,0,0,245,127,71,94,0,0,0,0,0,41,103,71,94,0,0,0,0,0,52,250,71,94,0,0,0,0,0,71,198,71,94,0,0,0,0,0,184,113,71,94,0,0,0,0,0,7,14,71,94,0,0,0,0,0,13,224,71,94,0,0,0,0,0,133,29,71,94,0,0,0,0,0,138,103,71,94,0,0,0,0,0,67,185,71,94,0,0,0,0,0,19,164,71,94,0,0,0,0,0,209,245,71,94,0,0,0,0,0,73,36,71,94,0,0,0,0,0,12,164,71,94,0,0,0,0,0,29,76,71,94,0,0,0,0,0,150,111,71,94,0,0,0,0,199,222,164,71,94,0,0,0,0,0,3,164,71,94,0,0,0,0,199,251,164,71,94,0,0,0,0,0,132,113,71,94,0,0,0,0,199,81,84,71,94,0,0,0,0,0,50,224,71,94,0,0,0,0,0,162,143,71,94,0,0,0,0,199,38,242,71,94,0,0,0,0,0,168,167,71,94,0,0,0,0,0,68,47,71,94,0,0,0,0,0,174,143,71,94,0,0,0,0,0,64,156,71,94,0,0,0,0,0,103,111,71,94,0,0,0,0,199,148,164,71,94,0,0,0,0,0,224,228,71,94,0,0,0,0,0,75,1,71,94,0,0,0,0,0,46,127,71,94,0,0,0,0,0,90,253,71,94,0,0,0,0,0,168,228,71,94,0,0,0,0,0,173,127,71,94,0,0,0,0,0,220,29,71,94,0,0,0,0,0,162,250,71,94,0,0,0,0,0,229,28,71,94,0,0,0,0,0,201,250,71,94,0,0,0,0,0,11,143,71,94,0,0,0,0,0,218,249,71,94,0,0,0,0,0,10,113,71,94,0,0,0,0,0,122,164,71,94,0,0,0,0,0,254,167,71,94,0,0,0,0,199,92,28,71,94,0,0,0,0,0,32,89,71,94,0,0,0,0,199,66,164,71,94,0,0,0,0,0,202,68,71,94,0,0,0,0,199,162,84,71,94,0,0,0,0,0,244,249,71,94,0,0,0,0,0,199,228,71,94,0,0,0,0,0,18,253,71,94,0,0,0,0,0,214,143,71,94,0,0,0,0,0,137,228,71,94,0,0,0,0,0,0,198,71,94,0,0,0,0,0,198,79,71,94,0,0,0,0,0,115,224,71,94,0,0,0,0,0,39,29,71,94,0,0,0,0,0,43,14,71,94,0,0,0,0,0,179,195,71,94,0,0,0,0,0,64,249,71,94,0,0,0,0,0,134,247,71,94,0,0,0,0,0,3,250,71,94,0,0,0,0,199,246,84,71,94,0,0,0,0,0,0,4,71,94,0,0,0,0,199,247,164,71,94,0,0,0,0,199,43,164,71,94,0,0,0,0,0,206,68,71,94,0,0,0,0,0,39,113,71,94,0,0,0,0,0,159,245,71,94,0,0,0,0,199,82,164,71,94,0,0,0,0,0,81,47,71,94,0,0,0,0,0,104,177,71,94,0,0,0,0,0,201,4,71,94,0,0,0,0,0,253,14,71,94,0,0,0,0,0,165,219,71,94,0,0,0,0,0,175,228,71,94,0,0,0,0,0,92,1,71,94,0,0,0,0,0,171,154,71,94,0,0,0,0,0,212,249,71,94,0,0,0,0,0,55,19,71,94,0,0,0,0,0,95,195,71,94,0,0,0,0,0,231,1,71,94,0,0,0,0,0,147,103,71,94,0,0,0,0,0,220,228,71,94,0,0,0,0,0,75,253,71,94,0,0,0,0,0,212,84,71,94,0,0,0,0,0,231,224,71,94,0,0,0,0,0,198,198,71,94,0,0,0,0,199,188,28,71,94,0,0,0,0,0,16,195,71,94,0,0,0,0,0,2,156,71,94,0,0,0,0,0,14,190,71,94,0,0,0,0,0,167,164,71,94,0,0,0,0,0,215,79,71,94,0,0,0,0,0,147,253,71,94,0,0,0,0,0,242,190,71,94,0,0,0,0,0,35,245,71,94,0,0,0,0,0,197,164,71,94,0,0,0,0,0,192,36,71,94,0,0,0,0,0,27,156,71,94,0,0,0,0,0,134,224,71,94,0,0,0,0,0,13,89,71,94,0,0,0,0,0,3,249,71,94,0,0,0,0,0,251,253,71,94,0,0,0,0,0,128,143,71,94,0,0,0,0,0,88,253,71,94,0,0,0,0,0,129,249,71,94,0,0,0,0,0,23,228,71,94,0,0,0,0,199,215,242,71,94,0,0,0,0,0,5,253,71,94,0,0,0,0,0,124,113,71,94,0,0,0,0,0,206,219,71,94,0,0,0,0,0,133,242,71,94,0,0,0,0,0,63,167,71,94,0,0,0,0,0,81,76,71,94,0,0,0,0,199,99,84,71,94,0,0,0,0,0,211,4,71,94,0,0,0,0,0,79,47,71,94,0,0,0,0,0,149,76,71,94,0,0,0,0,0,117,253,71,94,0,0,0,0,0,35,185,71,94,0,0,0,0,0,7,79,71,94,0,0,0,0,0,254,143,71,94,0,0,0,0,0,81,97,71,94,0,0,0,0,0,213,206,71,94,0,0,0,0,0,109,185,71,94,0,0,0,0,0,157,164,71,94,0,0,0,0,0,143,17,71,94,0,0,0,0,0,16,157,71,94,0,0,0,0,199,120,28,71,94,0,0,0,0,0,149,242,71,94,0,0,0,0,0,111,183,71,94,0,0,0,0,0,215,241,71,94,0,0,0,0,0,190,242,71,94,0,0,0,0,199,91,242,71,94,0,0,0,0,0,65,167,71,94,0,0,0,0,0,13,194,71,94,0,0,0,0,0,108,253,71,94,0,0,0,0,199,107,84,71,94,0,0,0,0,0,189,185,71,94,0,0,0,0,0,171,164,71,94,0,0,0,0,0,46,68,71,94,0,0,0,0,0,18,84,71,94,0,0,0,0,199,22,84,71,94,0,0,0,0,0,178,247,71,94,0,0,0,0,0,211,127,71,94,0,0,0,0,0,207,185,71,94,0,0,0,0,0,88,249,71,94,0,0,0,0,0,55,206,71,94,0,0,0,0,0,125,206,71,94,0,0,0,0,0,13,225,71,94,0,0,0,0,0,17,36,71,94,0,0,0,0,0,100,111,71,94,0,0,0,0,0,12,190,71,94,0,0,0,0,0,92,185,71,94,0,0,0,0,0,167,190,71,94,0,0,0,0,0,76,242,71,94,0,0,0,0,0,55,8,71,94,0,0,0,0,0,244,4,71,94,0,0,0,0,0,96,8,71,94,0,0,0,0,0,13,241,71,94,0,0,0,0,0,100,190,71,94,0,0,0,0,0,223,249,71,94,0,0,0,0,0,175,190,71,94,0,0,0,0,199,34,84,71,52,139,0,0,0,44,23,216,148,227,37,99,216,0,0,0,0,0,121,0,0,0,121,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,63,185,171,126,46,151,221,242,239,132,184,200,96,96,131,202,67,64,167,219,221,63,72,121,29,66,154,246,67,195,123,113,206,47,85,118,29,29,25,151,211,14,152,191,91,28,244,94,172,243,48,203,23,181,69,141,144,216,243,175,154,111,65,98,138,186,186,193,12,44,26,14,59,82,73,39,5,124,156,102,152,200,56,27,17,56,107,69,6,139,109,204,22,129,74,207,3,194,150,168,247,185,49,63,152,93,61,252,176,93,62,238,36,24,247,17,249,135,8,242,124,158,95,107,212,173,224,179,150,107,174,158,236,156,3,105,222,83,138,19,173,175,96,145,207,242,170,185,247,188,76,44,53,16,131,138,58,182,32,170,170,24,221,187,116,206,109,3,11,254,123,156,100,232,235,24,97,210,121,232,34,183,248,234,187,128,96,44,88,84,162,29,184,42,24,199,63,114,66,113,57,226,10,224,159,142,218,131,1,178,74,73,103,22,18,222,30,184,253,107,21,84,4,197,187,224,138,106,142,197,25,85,136,100,159,163,185,230,171,36,175,96,51,143,212,19,127,216,227,206,56,160,138,1,255})
    end
    _G.SimpleLibLoaded = true
end



