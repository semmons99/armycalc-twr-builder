function countWargearCost(item)
  local x = 0;
  for i,bonus in item.bonuses() do
    x = x + countWargearCost(bonus);
  end
  x = x + item.baseCost; -- All of the necron wargear has only baseCost costs
  return x;
end

-- File local variables
catcount = {};
lpacount = {};
mxcount = {};

for i,unit in twArmy:units() do
  -- Main routine Local variables
  
  -- Check for too much wargear on Lord(s)
  if unit.name == "Necron Lord" then
    local a = countWargearCost(unit);  
    if a > 100 then
      twError("Necron lord may only have 100 points of wargear.");
    end
  end
  -- Count One-per-army restrictions on units
  if unit.extra.lpa then
    if lpacount[unit.name] then
      lpacount[unit.name]['count'] = lpacount[unit.name]['count'] + 1;
    else
      lpacount[unit.name] = {};
      lpacount[unit.name]['count'] = 1;
      lpacount[unit.name]['limit'] = unit.extra.lpa;
    end
  end
  -- Count mutually exclusive restricted units
  if unit.extra.mx then
    if mxcount[unit.extra.mx] then
      mxcount[unit.extra.mx][i] = unit.name;
    else
      mxcount[unit.extra.mx] = {};
      mxcount[unit.extra.mx][i] = unit.name;
    end
  end
  -- Count One-per-army restrictions on wargear
  -- Count Force Organisation compliance
  if catcount[unit.extra.cat] then
    catcount[unit.extra.cat] = catcount[unit.extra.cat] + 1;
  else
    catcount[unit.extra.cat] = 1;
  end
end

twNotice(lpacount);
twNotice(mxcount);

-- Display Force Organisation compliance errors
if not catcount['HQ'] then
  twNotice("Army must have 1 or more HQ choices");
elseif catcount['HQ'] > 2 then
  twError("Army must not have more than 2 HQ choices");
end
if not catcount['Troops'] then
  twNotice("Army must have 2 or more Troops choices");
elseif catcount['Troops'] < 2 then
  twNotice("Army must have 2 or more Troops choices");
elseif catcount['Troops'] > 6 then
  twError("Army may not have more than 6 Troops choices");
end
if catcount['Elite'] and catcount['Elite'] > 3 then
  twError("Army may not have more than 3 Elite choices");
end
if catcount['Fast'] and catcount['Fast']> 3 then
  twError("Army may not have more than 3 Fast Attack choices");
end
if catcount['Heavy'] and catcount['Heavy'] > 3 then
  twError("Army may not have more than 3 Heavy Support choices");
end

