local GridSector = require("core.module.view.GridSector");

local function Grid(width, height)
  local grid = display.newGroup();
  
  grid.sector_width = 100;
  grid.sector_height = 100;
  grid.sectors = {};
  grid.hints = { row = {}, col = {} };
  
  function grid:init(nonogram)
    self.sector_width = width / nonogram.width;
    self.sector_height = height / nonogram.height;
    
    self:initGrid(nonogram);
    self:initHints(nonogram);
  end
  
  function grid:initGrid(nonogram)
    for r = 1, nonogram.rows do
      grid.sectors[r] = {};
      for c = 1, nonogram.cols do
        local sector = GridSector(r, c, self.sector_width, self.sector_height);
        sector.x = (c - 0.5) * self.sector_width - width * 0.5;
        sector.y = (r - 0.5) * self.sector_height - height * 0.5;
        grid.sectors[r][c] = sector;
        grid:insert(sector);
      end
    end
  end
  
  function grid:initHints(nonogram)
    self:initRowHints(nonogram);
    self:initColumnHints(nonogram);
  end
  
  function grid:initRowHints(nonogram)
    for r = 1, nonogram.rows do
      local lines = nonogram:getUnbrokenLinesInRow(r);
      local row_y = (r - 0.5) * self.sector_height - height * 0.5;
      local row_hint = display.newText(grid, table.concat(lines, " "), -width * 0.5 - 20, row_y, "Arial", 30);
      row_hint.anchorX = 1.0;
    end
  end
  
  function grid:initColumnHints(nonogram)
    for c = 1, nonogram.cols do
      local lines = nonogram:getUnbrokenLinesInColumn(c);
      local col_x = (c - 0.5) * self.sector_width - width * 0.5;
      local col_hint = display.newText(grid, table.concat(lines, "\n"), col_x, -height * 0.5 - 20, "Arial", 30);
      col_hint.anchorY = 1.0;
    end
  end

  function grid:markSectorAsFilled(row, col)
    self.sectors[row][col]:markAsFilled();
  end
  
  function grid:markSectorAsEmpty(row, col)
    self.sectors[row][col]:markAsEmpty();
  end
  
  return grid;
end

return Grid;