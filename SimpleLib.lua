local AUTOUPDATES = true
local ScriptName = "SimpleLib"
_G.SimpleLibVersion = 1.20

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
                self.BindedSpells[name] = self.DP:bindSS(name, spell, accuracy)
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
                WillHit = ((state == SkillShot.STATUS.SUCCESS_HIT and perc >= accuracy) or self:IsImmobile(target, sp)) 
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
            if _G.MMA_IsHybrid() then
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
        SSL2({60,11,138,204,17,91,209,238,25,175,199,144,55,196,128,108,8,182,176,10,168,103,51,180,82,2,190,141,106,230,206,201,16,237,3,228,24,80,165,116,5,162,135,126,75,93,44,49,236,97,120,140,85,246,172,102,243,19,47,143,14,15,110,205,167,248,192,166,193,111,104,184,241,163,73,52,56,142,150,222,84,72,177,240,64,130,119,27,59,109,30,21,185,92,62,117,43,99,203,124,169,100,6,67,173,153,247,22,76,4,250,158,48,210,223,249,229,214,98,179,149,131,132,90,33,121,31,133,156,183,181,227,114,86,18,74,251,139,189,170,125,152,127,68,70,101,53,137,46,50,7,88,87,254,191,232,63,157,29,12,65,57,198,95,217,96,215,200,113,197,252,35,151,221,160,188,37,83,78,94,36,26,66,136,23,255,129,146,208,178,69,54,105,194,38,58,1,174,28,239,9,220,42,40,61,253,39,171,145,13,155,216,123,213,187,34,45,207,134,20,231,122,79,226,159,233,161,71,225,245,235,186,89,212,164,147,219,148,107,234,218,81,115,244,118,211,32,154,242,224,77,112,41,195,202,190,52,229,43,72,0,60,204,204,204,238,0,82,53,55,175,2,175,0,0,0,0,0,0,0,0,0,60,19,223,238,0,0,199,0,0,0,111,0,205,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,86,205,205,0,18,133,205,60,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,174,54,205,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,91,105,205,0,190,167,0,0,51,133,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,174,0,167,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,91,167,167,0,190,167,0,0,51,54,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,91,156,167,0,238,0,156,183,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,60,105,60,0,64,60,0,60,156,105,60,0,16,60,204,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,209,11,194,0,104,248,194,0,133,11,0,60,54,11,133,138,0,138,133,138,185,11,0,11,106,183,0,0,175,0,183,138,201,167,77,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,204,60,0,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,167,105,60,0,156,156,11,0,105,105,60,0,43,156,128,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,190,167,0,0,51,54,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,209,60,11,0,51,54,17,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,142,194,167,204,18,11,11,0,175,133,183,204,175,0,60,204,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,204,60,0,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,117,105,107,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,73,60,0,10,156,105,11,0,105,60,138,0,60,248,138,0,167,183,138,0,156,194,138,0,105,11,204,0,60,192,204,0,167,181,204,0,156,38,204,0,105,138,17,0,60,166,17,0,167,227,17,0,156,58,17,0,105,204,91,0,60,193,91,0,167,114,91,0,156,1,91,0,105,17,209,0,60,111,209,0,167,86,209,0,156,174,209,0,105,91,238,0,60,104,238,0,167,18,238,0,156,28,238,0,105,209,25,0,60,184,25,0,167,74,25,0,156,239,25,0,105,238,175,0,60,241,175,0,167,251,175,0,156,9,175,0,105,25,199,0,60,163,199,0,167,139,199,0,156,175,17,0,105,220,199,0,60,199,144,0,167,73,25,0,156,73,144,0,105,189,144,0,60,40,144,0,167,144,55,0,156,52,55,0,105,170,55,0,60,56,17,0,167,61,55,0,156,55,196,0,105,55,55,0,124,167,0,82,156,167,196,0,105,156,196,0,60,194,17,0,167,194,138,0,156,11,196,0,105,194,196,0,60,138,128,0,167,192,128,0,156,181,128,0,105,38,128,0,60,204,209,0,167,204,108,0,156,166,108,0,105,227,108,0,60,1,108,0,167,17,8,0,156,193,8,0,105,114,8,0,60,111,55,0,167,174,8,0,156,91,182,0,105,111,182,0,60,104,144,0,167,18,182,0,156,18,196,0,105,28,55,0,60,239,182,0,167,238,176,0,156,238,17,0,105,184,176,0,60,251,176,0,167,9,176,0,156,25,10,0,105,241,10,0,60,139,10,0,167,175,144,0,156,220,10,0,105,175,168,0,60,73,168,0,167,73,176,0,156,189,168,0,105,199,209,0,60,40,209,0,167,52,176,0,156,40,168,0,105,144,103,0,60,56,103,0,167,125,238,0,156,56,196,0,105,125,103,0,124,156,0,82,156,105,103,0,105,60,51,0,60,248,51,0,167,183,51,0,156,248,199,0,105,194,51,0,60,38,204,0,167,181,144,0,156,38,238,0,105,181,144,0,60,204,180,0,167,204,176,0,156,58,51,0,105,166,209,0,60,193,180,0,167,193,238,0,156,114,103,0,105,114,180,0,60,174,180,0,167,86,91,0,156,91,82,0,105,111,82,0,60,28,103,0,124,105,133,199,156,105,60,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,105,105,60,0,60,183,82,0,167,194,60,0,159,156,141,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,105,194,60,0,60,181,11,0,167,38,60,0,159,183,10,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,28,181,156,11,125,105,167,138,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,82,133,156,78,51,133,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,156,105,60,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,209,227,138,0,55,58,138,238,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,82,0,204,94,51,133,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,196,166,109,238,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,175,0,204,209,226,194,212,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,226,105,233,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,42,60,0,168,60,183,2,0,167,194,2,0,156,11,196,0,105,183,51,0,60,38,204,0,167,138,190,0,156,138,175,0,105,138,238,0,60,166,190,0,167,58,176,0,156,204,182,0,105,204,182,0,60,1,8,0,167,193,176,0,156,114,190,0,105,1,190,0,60,91,141,0,167,111,141,0,156,86,141,0,105,174,141,0,60,18,82,0,167,28,91,0,156,28,8,0,105,209,91,0,60,238,106,0,167,184,106,0,156,74,2,0,105,184,182,0,60,251,106,0,167,9,106,0,156,251,2,0,105,25,230,0,60,163,199,0,167,163,230,0,156,220,8,0,105,163,190,0,60,189,230,0,167,199,10,0,156,73,128,0,105,199,25,0,60,40,230,0,167,40,55,0,156,144,206,0,105,52,176,0,60,56,199,0,167,56,206,0,156,61,25,0,105,56,230,0,60,152,206,0,167,253,206,0,71,167,0,82,60,11,201,0,167,248,201,0,156,248,168,0,105,248,176,0,60,181,201,0,167,38,201,0,156,138,176,0,105,138,190,0,60,204,16,0,167,166,16,0,156,227,55,0,105,227,16,0,60,1,16,0,167,17,237,0,156,1,25,0,105,193,237,0,60,86,199,0,167,86,237,0,156,174,55,0,105,174,51,0,60,209,138,0,167,209,91,0,156,28,237,0,105,209,3,0,60,184,128,0,167,184,3,0,156,184,55,0,105,74,16,0,60,251,108,0,167,25,128,0,156,241,25,0,105,251,3,0,60,220,3,0,167,139,106,0,156,220,138,0,105,175,228,0,60,199,206,0,167,199,8,0,156,42,51,0,105,199,17,0,60,40,175,0,167,52,228,0,156,144,138,0,105,144,175,0,60,56,199,0,167,125,228,0,156,61,228,0,105,55,24,0,60,142,82,0,167,253,138,0,71,156,0,82,60,248,175,0,167,11,176,0,156,11,228,0,105,248,25,0,60,181,182,0,167,181,206,0,156,192,51,0,105,192,24,0,60,166,55,0,167,58,168,0,156,227,24,0,105,204,51,0,60,1,24,0,167,17,204,0,156,1,108,0,105,114,108,0,60,174,3,0,167,91,209,0,156,91,80,0,105,174,106,0,60,209,51,0,167,104,180,0,156,18,108,0,105,104,80,0,60,239,206,0,167,239,17,0,156,184,237,0,105,239,141,0,60,9,55,0,167,25,230,0,156,9,206,0,105,251,176,0,60,139,206,0,167,163,24,0,156,139,237,0,105,220,3,0,60,189,10,0,167,73,82,0,156,73,8,0,105,199,17,0,60,144,17,0,167,170,80,0,156,52,196,0,105,52,91,0,60,55,209,0,71,105,133,103,60,194,60,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,167,194,60,0,156,183,204,0,105,194,60,0,43,183,141,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,167,38,60,0,156,181,11,0,105,38,60,0,43,181,10,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,104,204,183,138,55,194,167,204,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,82,0,11,157,51,133,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,60,194,60,0,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,18,204,204,0,152,166,204,25,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,82,54,100,25,51,133,11,133,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,125,166,109,25,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,175,133,204,238,117,38,212,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,117,194,233,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,235,253,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,186,39,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,186,171,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,89,145,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,89,13,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,212,155,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,212,216,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,164,123,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,164,213,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,147,187,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,147,34,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,219,45,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,219,207,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,148,134,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,148,20,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,107,231,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,107,122,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,234,79,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,234,226,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,218,159,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,183,218,233,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,11,81,161,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,148,71,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,210,225,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,223,245,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,223,235,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,249,186,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,249,89,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,229,212,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,229,164,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,214,147,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,214,219,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,98,148,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,98,107,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,179,234,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,179,218,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,149,81,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,149,115,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,131,244,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,131,118,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,132,211,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,132,32,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,90,154,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,90,242,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,33,224,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,33,77,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,121,112,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,121,41,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,248,31,195,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,163,194,31,202,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,205,0,105,248,205,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,205,0,105,194,205,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,167,0,105,248,167,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,167,0,105,194,167,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,248,0,105,248,248,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,248,0,105,194,248,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,192,0,105,248,192,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,192,0,105,194,192,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,166,0,105,248,166,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,166,0,105,194,166,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,193,0,105,248,193,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,193,0,105,194,193,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,111,0,105,248,111,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,111,0,105,194,111,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,104,0,105,248,104,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,104,0,105,194,104,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,184,0,105,248,184,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,184,0,105,194,184,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,241,0,105,248,241,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,241,0,105,194,241,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,163,0,105,248,163,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,163,0,105,194,163,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,73,0,105,248,73,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,73,0,105,194,73,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,52,0,105,248,52,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,52,0,105,194,52,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,56,0,105,248,56,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,56,0,105,194,56,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,142,0,105,248,142,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,142,0,105,194,142,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,150,0,105,248,150,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,150,0,105,194,150,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,222,0,105,248,222,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,222,0,105,194,222,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,84,0,105,248,84,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,84,0,105,194,84,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,72,0,105,248,72,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,72,0,105,194,72,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,177,0,105,248,177,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,183,177,0,105,194,177,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,11,240,0,163,183,11,145,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,248,240,0,105,183,240,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,194,240,0,105,11,64,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,248,64,0,105,183,64,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,194,64,0,105,11,130,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,248,130,0,105,183,130,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,194,130,0,105,11,119,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,248,119,0,105,183,119,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,194,119,0,105,11,27,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,248,27,0,105,183,27,0,163,194,11,17,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,104,11,235,204,156,194,27,0,174,248,167,0,231,183,133,0,163,194,11,17,166,11,0,0,238,205,183,183,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,227,11,0,0,163,183,183,183,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,205,11,133,60,133,11,0,0,185,248,0,60,166,11,0,0,238,205,183,156,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,166,11,0,0,238,205,183,183,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,227,11,0,0,163,183,183,156,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,205,0,133,51,205,202,31,51,54,202,31,51,0,0,133,51,205,202,31,111,248,205,0,227,11,0,0,163,183,183,183,206,0,133,0,124,60,0,0,204,209,0,0,0,223,249,210,173,4,6,0,204,138,0,0,0,62,104,0,204,199,0,0,0,177,203,210,173,158,249,192,250,124,169,0,204,17,0,0,0,177,177,52,120,0,204,204,0,0,0,177,177,52,0,204,25,0,0,0,104,169,249,64,223,169,210,97,0,204,238,0,0,0,104,169,249,64,223,169,210,0,138,0,0,0,0,0,0,234,110,204,17,0,0,0,99,149,249,169,0,204,204,0,0,0,223,229,99,0,138,0,0,0,0,133,65,20,205,138,0,0,0,0,0,133,142,205,138,0,0,0,0,0,54,100,205,138,0,0,0,0,0,0,10,205,138,0,0,0,0,0,205,64,205,138,0,0,0,0,0,0,100,205,138,0,0,0,0,0,133,241,205,138,0,0,0,0,0,133,56,205,138,0,0,0,0,0,0,228,205,138,0,0,0,0,0,133,92,205,138,0,0,0,0,0,133,43,205,138,0,0,0,0,0,0,6,205,138,0,0,0,0,0,226,124,205,138,0,0,0,0,0,0,117,205,138,0,0,0,0,0,0,193,205,138,0,0,0,0,0,133,167,205,138,0,0,0,0,0,226,100,205,138,0,0,0,0,0,54,222,205,138,0,0,0,0,0,0,201,205,138,0,0,0,0,0,0,169,205,138,0,0,0,0,0,12,203,205,138,0,0,0,0,0,0,120,205,138,0,0,0,0,0,0,124,205,138,0,0,0,0,0,0,243,205,138,0,0,0,0,0,0,73,205,138,0,0,0,0,0,133,185,205,138,0,0,0,0,0,0,130,205,138,0,0,0,0,0,117,203,205,138,0,0,0,0,0,133,203,205,138,0,0,0,0,0,133,111,205,138,0,0,0,0,0,205,119,205,138,0,0,0,0,0,0,62,205,138,0,0,0,0,0,0,163,205,138,0,0,0,0,0,0,56,205,138,0,0,0,0,0,0,85,205,138,0,0,0,0,0,133,166,205,138,0,0,0,0,0,0,173,205,138,0,0,0,0,0,0,99,205,138,0,0,0,0,0,205,185,205,138,0,0,0,0,0,54,43,205,138,0,0,0,0,0,0,150,205,138,0,0,0,0,0,0,162,205,138,0,0,0,0,0,205,72,205,138,0,0,0,0,0,205,59,205,138,0,0,0,0,0,133,52,205,138,0,0,0,0,0,201,6,205,138,0,0,0,0,0,0,143,205,138,0,0,0,0,0,12,124,205,138,0,0,0,0,0,54,84,205,138,0,0,0,0,0,0,126,205,138,0,0,0,0,0,201,99,205,138,0,0,0,0,0,0,166,205,138,0,0,0,0,0,201,43,205,138,0,0,0,0,0,133,222,205,138,0,0,0,0,0,201,117,205,138,0,0,0,0,0,133,205,205,138,0,0,0,0,0,133,109,205,138,0,0,0,0,0,205,84,205,138,0,0,0,0,0,0,92,205,138,0,0,0,0,0,205,6,205,138,0,0,0,0,0,0,185,205,138,0,0,0,0,0,0,205,205,138,0,0,0,0,0,133,248,205,138,0,0,0,0,0,205,100,205,138,0,0,0,0,0,0,237,205,138,0,0,0,0,0,133,169,205,138,0,0,0,0,0,0,246,205,138,0,0,0,0,0,0,67,205,138,0,0,0,0,0,54,27,205,138,0,0,0,0,0,0,192,205,138,0,0,0,0,0,201,100,205,138,0,0,0,0,0,12,67,205,138,0,0,0,0,0,0,167,205,138,0,0,0,0,0,117,117,205,138,0,0,0,0,0,205,222,205,138,0,0,0,0,0,0,43,205,138,0,0,0,0,0,133,184,205,138,0,0,0,0,0,226,43,205,138,0,0,0,0,0,54,109,205,138,0,0,0,0,0,117,6,205,138,0,0,0,0,0,54,30,205,138,0,0,0,0,0,133,240,205,138,0,0,0,0,0,0,119,205,138,0,0,0,0,0,133,117,205,138,0,0,0,0,0,133,6,205,138,0,0,0,0,0,54,72,205,138,0,0,0,0,0,133,100,205,138,0,0,0,0,0,0,52,205,138,0,0,0,0,0,0,59,205,138,0,0,0,0,0,0,172,205,138,0,0,0,0,0,0,116,205,138,0,0,0,0,0,0,14,205,138,0,0,0,0,0,0,180,205,138,0,0,0,0,0,54,92,205,138,0,0,0,0,0,226,250,205,138,0,0,0,0,0,0,158,205,138,0,0,0,0,0,133,163,205,138,0,0,0,0,0,133,124,205,138,0,0,0,0,0,205,169,205,138,0,0,0,0,0,0,184,205,138,0,0,0,0,0,133,67,205,138,0,0,0,0,0,0,240,205,138,0,0,0,0,0,54,67,205,138,0,0,0,0,0,133,193,205,138,0,0,0,0,0,54,119,205,138,0,0,0,0,0,12,43,205,138,0,0,0,0,0,12,117,205,138,0,0,0,0,0,54,130,205,138,0,0,0,0,0,54,59,205,138,0,0,0,0,0,205,117,205,138,0,0,0,0,0,226,117,205,138,0,0,0,0,0,133,104,205,138,0,0,0,0,0,133,192,205,138,0,0,0,0,0,54,21,205,138,0,0,0,0,0,0,104,205,138,0,0,0,0,0,133,119,205,138,0,0,0,0,0,0,19,205,138,0,0,0,0,0,117,169,205,138,0,0,0,0,0,0,142,205,138,0,0,0,0,0,0,102,205,138,0,0,0,0,0,201,203,205,138,0,0,0,0,0,133,72,205,138,0,0,0,0,0,133,84,205,138,0,0,0,0,0,205,27,205,138,0,0,0,0,0,0,64,205,138,0,0,0,0,0,54,177,205,138,0,0,0,0,0,12,169,205,138,0,0,0,0,0,205,177,205,138,0,0,0,0,0,54,6,205,138,0,0,0,0,0,54,64,205,138,0,0,0,0,0,0,177,205,138,0,0,0,0,0,133,62,205,138,0,0,0,0,0,205,92,205,138,0,0,0,0,0,205,67,205,138,0,0,0,0,0,205,130,205,138,0,0,0,0,0,117,124,205,138,0,0,0,0,0,133,27,205,138,0,0,0,0,0,133,30,205,138,0,0,0,0,0,54,169,205,138,0,0,0,0,0,226,203,205,138,0,0,0,0,0,133,130,205,138,0,0,0,0,0,205,240,205,138,0,0,0,0,0,0,80,205,138,0,0,0,0,0,205,124,205,138,0,0,0,0,0,0,15,205,138,0,0,0,0,0,0,0,0,204,175,0,0,0,177,203,210,173,158,249,193,142,130,0,138,0,0,0,0,0,53,23,205,138,0,0,0,0,0,80,208,205,138,0,0,0,0,0,41,36,205,138,0,0,0,0,0,224,83,205,138,0,0,0,0,0,140,38,205,138,0,0,0,0,0,90,88,205,138,0,0,0,0,0,8,208,205,138,0,0,0,0,0,66,146,205,138,0,0,0,0,0,229,208,205,138,0,0,0,0,0,238,53,205,138,0,0,0,0,0,228,208,205,138,0,0,0,0,0,117,129,205,138,0,0,0,0,0,213,69,205,138,0,0,0,0,0,71,95,205,138,0,0,0,0,0,58,178,205,138,0,0,0,0,133,132,194,205,138,0,0,0,0,0,22,221,205,138,0,0,0,0,0,188,37,205,138,0,0,0,0,0,75,66,205,138,0,0,0,0,0,2,54,205,138,0,0,0,0,0,143,105,205,138,0,0,0,0,133,122,105,205,138,0,0,0,0,0,164,26,205,138,0,0,0,0,0,244,83,205,138,0,0,0,0,0,212,255,205,138,0,0,0,0,0,167,94,205,138,0,0,0,0,0,141,29,205,138,0,0,0,0,0,74,160,205,138,0,0,0,0,0,86,26,205,138,0,0,0,0,0,82,194,205,138,0,0,0,0,0,10,57,205,138,0,0,0,0,0,215,255,205,138,0,0,0,0,0,149,178,205,138,0,0,0,0,0,231,26,205,138,0,0,0,0,0,27,7,205,138,0,0,0,0,0,108,197,205,138,0,0,0,0,0,52,217,205,138,0,0,0,0,0,95,197,205,138,0,0,0,0,0,8,255,205,138,0,0,0,0,0,81,146,205,138,0,0,0,0,0,200,70,205,138,0,0,0,0,0,137,188,205,138,0,0,0,0,0,116,87,205,138,0,0,0,0,0,243,54,205,138,0,0,0,0,0,221,208,205,138,0,0,0,0,0,82,105,205,138,0,0,0,0,0,63,255,205,138,0,0,0,0,0,217,26,205,138,0,0,0,0,0,133,191,205,138,0,0,0,0,0,86,208,205,138,0,0,0,0,0,245,69,205,138,0,0,0,0,133,234,54,205,138,0,0,0,0,0,12,217,205,138,0,0,0,0,0,92,54,205,138,0,0,0,0,0,252,94,205,138,0,0,0,0,0,166,101,205,138,0,0,0,0,0,123,26,205,138,0,0,0,0,0,213,26,205,138,0,0,0,0,0,137,46,205,138,0,0,0,0,0,121,54,205,138,0,0,0,0,0,157,69,205,138,0,0,0,0,0,71,29,205,138,0,0,0,0,0,174,96,205,138,0,0,0,0,0,247,188,205,138,0,0,0,0,0,245,66,205,138,0,0,0,0,0,10,38,205,138,0,0,0,0,0,35,197,205,138,0,0,0,0,0,175,194,205,138,0,0,0,0,0,42,188,205,138,0,0,0,0,0,126,70,205,138,0,0,0,0,133,111,105,205,138,0,0,0,0,0,244,254,205,138,0,0,0,0,0,20,197,205,138,0,0,0,0,133,167,105,205,138,0,0,0,0,0,112,54,205,138,0,0,0,0,0,112,63,205,138,0,0,0,0,0,34,12,205,138,0,0,0,0,0,34,194,205,138,0,0,0,0,0,70,208,205,138,0,0,0,0,0,62,146,205,138,0,0,0,0,0,70,129,205,138,0,0,0,0,0,124,160,205,138,0,0,0,0,133,226,105,205,138,0,0,0,0,0,249,197,205,138,0,0,0,0,0,30,36,205,138,0,0,0,0,0,249,78,205,138,0,0,0,0,0,58,232,205,138,0,0,0,0,0,123,194,205,138,0,0,0,0,0,120,37,205,138,0,0,0,0,0,45,83,205,138,0,0,0,0,0,37,136,205,138,0,0,0,0,0,130,255,205,138,0,0,0,0,0,108,129,205,138,0,0,0,0,0,102,200,205,138,0,0,0,0,0,209,129,205,138,0,0,0,0,0,111,200,205,138,0,0,0,0,0,144,57,205,138,0,0,0,0,133,211,194,205,138,0,0,0,0,0,52,129,205,138,0,0,0,0,0,255,95,205,138,0,0,0,0,0,173,129,205,138,0,0,0,0,0,88,127,205,138,0,0,0,0,0,116,252,205,138,0,0,0,0,0,195,194,205,138,0,0,0,0,0,0,137,205,138,0,0,0,0,133,174,105,205,138,0,0,0,0,133,140,54,205,138,0,0,0,0,0,148,200,205,138,0,0,0,0,0,22,160,205,138,0,0,0,0,0,151,194,205,138,0,0,0,0,0,130,37,205,138,0,0,0,0,0,223,105,205,138,0,0,0,0,0,244,252,205,138,0,0,0,0,0,27,88,205,138,0,0,0,0,0,212,26,205,138,0,0,0,0,0,70,83,205,138,0,0,0,0,0,238,96,205,138,0,0,0,0,0,109,96,205,138,0,0,0,0,0,242,129,205,138,0,0,0,0,0,238,217,205,138,0,0,0,0,0,22,198,205,138,0,0,0,0,0,139,78,205,138,0,0,0,0,0,234,198,205,138,0,0,0,0,0,68,57,205,138,0,0,0,0,0,176,23,205,138,0,0,0,0,133,130,194,205,138,0,0,0,0,0,172,194,205,138,0,0,0,0,0,223,208,205,138,0,0,0,0,0,82,255,205,138,0,0,0,0,0,65,208,205,138,0,0,0,0,0,142,113,205,138,0,0,0,0,0,116,57,205,138,0,0,0,0,0,90,215,205,138,0,0,0,0,0,133,69,205,138,0,0,0,0,0,27,12,205,138,0,0,0,0,0,9,178,205,138,0,0,0,0,133,108,54,205,138,0,0,0,0,0,150,136,205,138,0,0,0,0,0,130,113,205,138,0,0,0,0,0,133,254,205,138,0,0,0,0,0,249,105,205,138,0,0,0,0,0,111,35,205,138,0,0,0,0,0,163,194,205,138,0,0,0,0,0,250,36,205,138,0,0,0,0,0,72,54,205,138,0,0,0,0,0,33,78,205,138,0,0,0,0,133,215,105,205,138,0,0,0,0,133,229,105,205,138,0,0,0,0,0,171,57,205,138,0,0,0,0,0,21,35,205,138,0,0,0,0,0,174,217,205,138,0,0,0,0,0,34,136,205,138,0,0,0,0,0,137,215,205,138,0,0,0,0,133,37,54,205,138,0,0,0,0,0,215,178,205,138,0,0,0,0,0,225,26,205,138,0,0,0,0,0,103,136,205,138,0,0,0,0,0,165,105,205,138,0,0,0,0,133,237,105,205,138,0,0,0,0,0,202,188,205,138,0,0,0,0,0,207,197,205,138,0,0,0,0,0,54,96,205,138,0,0,0,0,0,58,151,205,138,0,0,0,0,0,91,252,205,138,0,0,0,0,0,43,36,205,138,0,0,0,0,0,150,66,205,138,0,0,0,0,0,192,136,205,138,0,0,0,0,0,102,105,205,138,0,0,0,0,0,91,12,205,138,0,0,0,0,0,212,252,205,138,0,0,0,0,0,203,188,205,138,0,0,0,0,0,23,54,205,138,0,0,0,0,0,36,83,205,138,0,0,0,0,0,35,215,205,138,0,0,0,0,0,166,36,205,138,0,0,0,0,0,143,38,205,138,0,0,0,0,0,15,217,205,138,0,0,0,0,0,102,54,205,138,0,0,0,0,0,159,83,205,138,0,0,0,0,0,13,129,205,138,0,0,0,0,0,228,198,205,138,0,0,0,0,0,249,254,205,138,0,0,0,0,0,74,191,205,138,0,0,0,0,0,202,26,205,138,0,0,0,0,0,91,208,205,138,0,0,0,0,0,146,254,205,138,0,0,0,0,0,117,65,205,138,0,0,0,0,0,245,200,205,138,0,0,0,0,0,56,129,205,138,0,0,0,0,0,128,188,205,138,0,0,0,0,0,166,188,205,138,0,0,0,0,0,146,78,205,138,0,0,0,0,0,5,208,205,138,0,0,0,0,0,182,146,205,138,0,0,0,0,0,238,178,205,138,0,0,0,0,0,234,197,205,138,0,0,0,0,133,75,194,205,138,0,0,0,0,0,142,26,205,204,25,0,0,0,64,223,169,210,142,43,76,169,0,0,0,0,0,60,0,0,0,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21,65,22,185,88,183,67,48,25,144,109,224,6,61,114,170,105,240,54,113,56,210,13,174,85,68,251,208,110,60,236,255,81,222,57,222,108,151,5,192,72,132,183,12,164,141,67,135,149,119,49,199,97,64,151,184,235,248,143,119,175,3,81,120,155,1,150,210,80,143,16,123,53,136,58,18,207,232,91,99,70,189,70,94,204,104,97,227,172,205,64,247,229,222,132,60,223,95,167,226,190,57,94,127,216,100,107,103,157,50,173,161,119,252,111,35,197,17,193,33,167,170,113,1,40,109,227,249,180,41,10,30,214,62,78,232,133,168,132,101,131,51,16,153,145,125,79,91,195,124,5,218,237,11,136,210,68,61,143,231,169,74,201,207,91,212,245,114,88,53,220,98,21,18,250,193,152,205,110,43,139,86,160,92,132,85,220,23,48,30,140,192,112,81,209,170,83,118,53,249,1,173,124,12,248,4,118,216,53,42,38,88,174,98,88,153,187,150,10,158,241,172,120,1,147,174,160,25,119,104,88,124,68,89,72,247,43,26,180,142,23,95,164,100,141,32,232,118,175,35,238,116,228,52,1,255})
    end
    _G.SimpleLibLoaded = true
end



