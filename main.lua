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

