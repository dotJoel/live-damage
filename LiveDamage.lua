LiveDamage_UpdateInterval = 1.0; -- how often to update the info
playerClass, englishClass = UnitClass("player");

if (iCurrent == nil) then
    iCurrent = 1;
end

if (iCurrent2 == nil) then
    iCurrent2 = 1;
end

t = {
    [1] = "Weapon Skill",
    [2] = "Defense",
    [3] = "Dodge",
    [4] = "Parry",
    [5] = "Block",
    [6] = "Melee Hit",
    [7] = "Ranged Hit",
    [8] = "Spell Hit",
    [9] = "Melee Crit",
    [10] = "Ranged Crit",
    [11] = "Spell Crit",
    [12] = "unused",
    [13] = "unused",
    [14] = "unused",
    [15] = "Melee Resilience",
    [16] = "Ranged Resilience",
    [17] = "Spell Resilience",
    [18] = "Melee Haste",
    [19] = "Ranged Haste",
    [20] = "Spell Haste",
    [21] = "Mainhand Skill",
    [22] = "Offhand Skill",
    [23] = "Ranged Skill",
    [24] = "Expertise",
    [25] = "Armor Penetration"
}

function LiveDamage_OnLoad()
    ChatFrame1:AddMessage("showing LiveDamage for " .. englishClass);
end

function LiveDamage_OnUpdate(self, elapsed)

    self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;

    base, posBuff, negBuff = UnitAttackPower("player");
    if (self.TimeSinceLastUpdate > LiveDamage_UpdateInterval) then
        if (iCurrent2 == 1) then
            strDamage = "Spell Bonus: " .. GetSpellBonusDamage(3);
        else
            base, posBuff, negBuff = UnitAttackPower("player");
            iAttackPower = base + posBuff;
            strDamage = "Attack Power: " .. iAttackPower;
        end
        if (iCurrent == 10) then
            strPercent = format("%.2f%%", GetRangedCritChance());
        elseif (iCurrent == 11) then
            strPercent = format("%.2f%%", GetSpellCritChance(3));
        elseif (iCurrent == 9) then
            strPercent = format("%.2f%%", GetCritChance());
        else
            strPercent = GetCombatRating(iCurrent);
        end
        LiveDamage_FrameText:SetText(strDamage .. "\n" .. t[iCurrent] .. ": " .. strPercent);
        self.TimeSinceLastUpdate = 0;
    end

end

function LiveDamage_flip1()
    if (iCurrent < 25) then
        if (iCurrent == 11) then
            iCurrent = 14;
        end
        iCurrent = iCurrent + 1;
    else
        iCurrent = 1;
    end
end

function LiveDamage_flip2()
    if (iCurrent2 == 2) then
        iCurrent2 = 1;
    else
        iCurrent2 = 2;
    end
end

function round(num, idp)
    local mult = 10 ^ (idp or 0);
    return math.floor(num * mult + 0.5) / mult;
end
