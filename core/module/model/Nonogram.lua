local Nonogram = {};

Nonogram.Sector = { Empty = 0, Filled = 1, Locked = 2 };

local generateRowColGrid, compareNonograms;

Nonogram._constructor = function(data)
  local nonogram = generateRowColGrid(data);
  nonogram.cols = data.cols;
  nonogram.rows = data.rows;
  nonogram.width = data.cols;
  nonogram.height = data.rows;
  
  function nonogram:getUnbrokenLinesInRow(row_index)
    local lines = {};
    local r, c = row_index, 1;
    while c <= self.cols do
      local sector = self[r][c];
      if sector == Nonogram.Sector.Filled then
        local length = self:getUnbrokenLineLength(r, c, 0, 1);
        table.insert(lines, length);
        c = c + length;
      end
      c = c + 1;
    end
    return lines;
  end
  
  function nonogram:getUnbrokenLinesInColumn(col_index)
    local lines = {};
    local r, c = 1, col_index;
    while r <= self.rows do
      local sector = self[r][c];
      if sector == Nonogram.Sector.Filled then
        local length = self:getUnbrokenLineLength(r, c, 1, 0);
        table.insert(lines, length);
        r = r + length;
      end
      r = r + 1;
    end
    return lines;
  end
  
  function nonogram:getUnbrokenLineLength(r, c, r_step, c_step)
    local length = 1;
    while self[r + r_step] and self[r + r_step][c + c_step] == Nonogram.Sector.Filled do
      length = length + 1;
      r = r + r_step;
      c = c + c_step;
    end
    return length;
  end
  
  function nonogram:toString()
    local output = "";
    for r = 1, self.rows do
      for c = 1, self.cols do
        output = output.." "..tostring(self[r][c]);
      end
      output = output.."\n";
    end
    return output;
  end
  
  function nonogram:equals(nonogram)
    for r = 1, self.rows do
      for c = 1, self.cols do
        if self[r][c] ~= nonogram[r][c] then
          return false;
        end
      end
    end
    return true;
  end
  
  function nonogram:forEach(callback)
    for r = 1, self.rows do
      for c = 1, self.cols do
        callback(self[r][c], r, c);
      end
    end
  end
  
  nonogram._mt = {
    __tostring = function(self)
      return self:toString();
    end,
    
    __eq = compareNonograms
  };
  
  setmetatable(nonogram, nonogram._mt);
  
  return nonogram;
end

generateRowColGrid = function(data)
  local grid = {};
  for r = 1, data.rows do
    grid[r] = {};
    for c = 1, data.cols do
      local i = (r - 1) * data.cols + c;
      grid[r][c] = data.griddler[i];
    end
  end
  return grid;
end

compareNonograms = function(nonogramA, nonogramB)
  return nonogramA:equals(nonogramB);
end

Nonogram._mt = { 
  __call = function(Nonogram, data)
    return Nonogram._constructor(data);
  end 
};
setmetatable(Nonogram, Nonogram._mt);

return Nonogram;