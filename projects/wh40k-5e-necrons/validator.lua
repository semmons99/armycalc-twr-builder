function countWargearCost(item)
  local x = 0;
  for i,bonus in item.bonuses() do
    x = x + countWargearCost(bonus);
  end
  x = x + item.baseCost;
  return x;
end

for i,unit in twArmy:units() do
  if unit.name == "Necron Lord" then
    local a = countWargearCost(unit);  
    if a > 100 then
      twError("Necron lord may only have 100 points of wargear.");
    end
  twNotice(a);
  end
end

