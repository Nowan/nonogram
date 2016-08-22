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

-- array of nonogram row and column hints
local rHints = {};
local cHints = {};

-- get row hints
for r=1,matrix.size do
	local rowHints = {}; -- row hints only for current row
	-- loop through columns in search of shaded segments

	local c=1;
	while c<=matrix.size do -- WHILE loop allows to change iteration value inside of the loop (and FOR doesn't)
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

-- get column hints - the same way as row hints
for c=1,matrix.size do
	local columnHints = {}; 

	local r=1;
	while r<=matrix.size do 
		local segment = matrix[r][c];
		if segment==1 then
			columnHints[#columnHints+1] = 1;

			r = r + 1;
			local nextSegment = matrix[r][c];
			while nextSegment==1 do
				columnHints[#columnHints] = columnHints[#columnHints] + 1;

				r = r + 1;
				if( r>matrix.size ) then 
					nextSegment=nil
				else
					nextSegment = matrix[r][c];
				end
			end
		else
			r = r+1;
		end

	end
	cHints[c] = columnHints;
end

-- print result
local stringLine = "";
for r=1,#rHints do
	for h=1,#rHints[r] do
		stringLine = stringLine..rHints[r][h].." ";
	end
	stringLine = stringLine.."| ";
end
print("Row hints: "..stringLine)

stringLine = "";
for c=1,#cHints do
	for h=1,#cHints[c] do
		stringLine = stringLine..cHints[c][h].." ";
	end
	stringLine = stringLine.."| ";
end
print("Column hints: "..stringLine)