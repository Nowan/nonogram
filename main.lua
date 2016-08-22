--[[

]]--

-- input data 
local data =  { 0,1,1,1,0,
				0,0,1,0,0,
				1,1,1,1,1,
				1,0,0,0,1,
				1,0,0,0,1 };

-- convert data from one-dimensional array to two-dimensional matrix
local matrix = {};
matrix.size = math.sqrt(#data);
for i=1,#data do
	local row = math.ceil(i/matrix.size);
	matrix[row] = {};
	for column=1,matrix.size do
		matrix[row][column] = data[(row-1)*matrix.size+column];
	end
	i = i + matrix.size;
end

-- print matrix contents in console
for r=1,matrix.size do
	local stringLine = "";
	for c=1,matrix.size do
		stringLine = stringLine..matrix[r][c];
	end
	print(stringLine)
end

-- array of nonogram row hints
local rHints = {};


for r=1,matrix.size do
	local rowHints = {}; -- row hints only for current row
	-- loop through columns in search of shaded segments

	local c=1;
	-- WHILE loop allows to change iteration value inside of the loop (and FOR doesn't)
	while c<=matrix.size do
		local segment = matrix[r][c];
		if segment==1 then
			-- if segment is shaded - add new row hint with value 1
			rowHints[#rowHints+1] = 1;

			-- check neibhor segments
			c = c + 1;
			local nextSegment = matrix[r][c];
			while nextSegment==1 do
				-- if next segment is shaded - increase row hint value
				rowHints[#rowHints] = rowHints[#rowHints] + 1;

				-- set next segment
				c = c + 1;
				nextSegment = matrix[r][c];
			end
		else
			c = c+1;
		end

	end
	rHints[r] = rowHints;
end

