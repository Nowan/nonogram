local Nonogram = require("core.module.model.Nonogram");

local function GameModel()
  local model = {};
  
  model.selection_sector = nil;
  model.base_nonogram = nil;
  model.trace_nonogram = nil;
  
  function model:init(nonogram_data)
    self.base_nonogram = Nonogram(nonogram_data);
    self.trace_nonogram = Nonogram(nonogram_data);
    self.trace_nonogram:forEach(function(sector, row, col) 
      self.trace_nonogram[row][col] = Nonogram.Sector.Empty;
    end);
  end
  
  function model:getSelectionSector()
    return self.selection_sector or Nonogram.Sector.Filled;
  end
  
  function model:setSelectionSector(sector)
    self.selection_sector = sector;
  end
  
  function model:getBaseNonogram()
    return self.base_nonogram;
  end
  
  function model:getTraceNonogram()
    return self.trace_nonogram;
  end
  
  function model:getSector(row, col)
    return self.trace_nonogram[row][col];
  end
  
  function model:setSector(row, col, sector)
    self.trace_nonogram[row][col] = sector;
  end
  
  return model;
end

return GameModel;