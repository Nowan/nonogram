local function GridSector(row, col, width, height)
  local sector = display.newRect(0, 0, width, height);
  
  sector.row = row;
  sector.col = col;
  
  sector.stroke = { 0, 0, 0 };
  sector.strokeWidth = 2;
  
  function sector:touch(event)
    if event.phase == "began" then
      Runtime:dispatchEvent({ name = "selectionStarted", row = row, col = col });
    elseif event.phase == "moved" then
      Runtime:dispatchEvent({ name = "selectionMoved", row = row, col = col });
    elseif event.phase == "ended" or event.phase == "cancelled" then
      Runtime:dispatchEvent({ name = "selectionEnded", row = row, col = col });
    end
  end
  
  sector:addEventListener("touch", sector);
  
  function sector:markAsFilled()
    self:setFillColor(0.2);
  end
  
  function sector:markAsEmpty()
    self:setFillColor(1.0);
  end
  
  return sector;
end

return GridSector;