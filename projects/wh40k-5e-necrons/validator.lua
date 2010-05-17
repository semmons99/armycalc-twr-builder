function countWargearCost(item)
  local x = 0;
  for i,bonus in item.bonuses() do
    x = x + countWargearCost(bonus);
  end
  x = x + item.baseCost;
  return x;
end

for i,unit in twArmy:units() do
  -- Check for too much wargear on Lord(s)
  if unit.name == "Necron Lord" then
    local a = countWargearCost(unit);  
    if a > 100 then
      twError("Necron lord may only have 100 points of wargear.");
    end
  end
  -- Check One-per-army restrictions on wargear
  -- Check One-per-army restrictions on units
  -- Check Force Organisation compliance
end
