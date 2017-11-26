local Nonogram = require("core.module.model.Nonogram");

local function GameController(view, model)
  local controller = {};
  
  controller.view = view;
  controller.model = model;
  
  function controller:initGame(nonogram_data)
    self.model:init(nonogram_data);
    self.view:init(self.model:getBaseNonogram());
  end
  
  function controller:selectionStarted(event)
    local sector = self.model:getSector(event.row, event.col);
    if sector == Nonogram.Sector.Empty then
      sector = Nonogram.Sector.Filled;
    elseif sector == Nonogram.Sector.Filled then
      sector = Nonogram.Sector.Empty;
    end
    self.model:setSelectionSector(sector);
    self:applySelectionSector(event.row, event.col);
    self:tryToFinishGame();
  end
  
  function controller:selectionMoved(event)
    self:applySelectionSector(event.row, event.col);
    self:tryToFinishGame();
  end
  
  function controller:applySelectionSector(row, col)
    local sector = self.model:getSelectionSector();
    self.model:setSector(row, col, sector);
    self.view:updateSector(row, col, sector);
  end
  
  function controller:tryToFinishGame()
    if self:isNonogramResolved() then
      self:finishGame();
    end
  end
  
  function controller:isNonogramResolved()
    return self.model:getBaseNonogram() == self.model:getTraceNonogram();
  end
  
  function controller:finishGame()
    print("Congratulations! Nonogram solved!");
    Runtime:removeEventListener("selectionStarted", self);
    Runtime:removeEventListener("selectionMoved", self);
  end
  
  Runtime:addEventListener("selectionStarted", controller);
  Runtime:addEventListener("selectionMoved", controller);
  
  return controller;
end

return GameController;