local Grid = require("core.module.view.Grid");
local Nonogram = require("core.module.model.Nonogram");

local function GameView()
  local view = display.newGroup();
  
  view.grid = nil;
  
  function view:init(nonogram)
    self.grid = Grid(500, 500);
    self.grid.x = display.contentCenterX;
    self.grid.y = display.contentCenterY;
    self:insert(self.grid);
    
    self.grid:init(nonogram);
  end
  
  function view:updateSector(row, col, state)
    if state == Nonogram.Sector.Empty then
      self.grid:markSectorAsEmpty(row, col);
    elseif state == Nonogram.Sector.Filled then
      self.grid:markSectorAsFilled(row, col);
    end
  end
  
  return view;
end

return GameView;