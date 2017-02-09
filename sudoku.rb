sudoku_string = '1-58-2----9--764-52--4--819-19--73-6762-83-9-----61-5---76---3-43--2-5-16--3-89--'
sudoku_string2 = '--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3'
sudoku_string3 = '29-5----77-----4----4738-129-2--3-648---5--7-5---672--3-9--4--5----8-7---87--51-9'
sudoku_string4 = '-8--2-----4-5--32--2-3-9-466---9---4---64-5-1134-5-7--36---4--24-723-6-----7--45-'
sudoku_string5 = '6-873----2-----46-----6482--8---57-19--618--4-31----8-86-2---39-5----1--1--4562--'
sudoku_string6 = '---6891--8------2915------84-3----5-2----5----9-24-8-1-847--91-5------6--6-41----'
sudoku_string7 = '-3-5--8-45-42---1---8--9---79-8-61-3-----54---5------78-----7-2---7-46--61-3--5--'
sudoku_string8 = '-96-4---11---6---45-481-39---795--43-3--8----4-5-23-18-1-63--59-59-7-83---359---7'
sudoku_string9 = '----754----------8-8-19----3----1-6--------34----6817-2-4---6-39------2-53-2-----'
sudoku_string10 = '3---------5-7-3--8----28-7-7------43-----------39-41-54--3--8--1---4----968---2--'
sudoku_string11 = '3-26-9--55--73----------9-----94----------1-9----57-6---85----6--------3-19-82-4-'
sudoku_string12 = '-2-5----48-5--------48-9-2------5-73-9-----6-25-9------3-6-18--------4-71----4-9-'
sudoku_string13 = '--7--8------2---6-65--79----7----3-5-83---67-2-1----8----71--38-2---5------4--2--'
sudoku_string14 = '----------2-65-------18--4--9----6-4-3---57-------------------73------9----------'
sudoku_string15 = '---------------------------------------------------------------------------------'

def sudoku_array(sudoku_string)
	sudoku_string.split("").map { |string_value| string_value.to_i }
end

def row_checker(sudoku_string)
	first_row_indexes = [0,1,2,3,4,5,6,7,8]
	current_row = 0
	until current_row >= 9
		indexes = first_row_indexes.map { |index| index + current_row * 9}
		hash_of_vals = {}
		indexes.each do |index|
			if hash_of_vals[sudoku_string[index]] && sudoku_string[index] != 0
				return false
			else 
				hash_of_vals[sudoku_string[index]] = 1
			end
		end
		current_row += 1
	end
	true
end

def column_checker(sudoku_string)
	first_column_indexes = [0,9,18,27,36,45,54,63,72]
	current_column = 0
	until current_column >= 9
		indexes = first_column_indexes.map { |index| index + current_column }
		hash_of_vals = { }
		indexes.each do |index|
			if hash_of_vals[sudoku_string[index]] && sudoku_string[index] != 0
				return false
			else 
				hash_of_vals[sudoku_string[index]] = 1
			end
		end
		current_column += 1
	end
	true
end

def square_checker(sudoku_string)
	first_square_indexes = [0,1,2,9,10,11,18,19,20]
	current_square = 0
	until current_square >= 3
		indexes = first_square_indexes.map { |index| index + (current_square * 3)}
		hash_of_vals = { }
		indexes.each do |index|
			if hash_of_vals[sudoku_string[index]] && sudoku_string[index] != 0
				return false
			else 
				hash_of_vals[sudoku_string[index]] = 1
			end
		end
		current_square += 1
	end
	first_square_indexes.map! { |index| index + 27 }
	current_square = 0
	until current_square >= 3
		indexes = first_square_indexes.map { |index| index + (current_square * 3)}
		hash_of_vals = { }
		indexes.each do |index|
			if hash_of_vals[sudoku_string[index]] && sudoku_string[index] != 0
				return false
			else 
				hash_of_vals[sudoku_string[index]] = 1
			end
		end
		current_square += 1
	end
	first_square_indexes.map! { |index| index + 27 }
	current_square = 0
	until current_square >= 3
		indexes = first_square_indexes.map { |index| index + (current_square * 3)}
		hash_of_vals = { }
		indexes.each do |index|
			if hash_of_vals[sudoku_string[index]] && sudoku_string[index] != 0
				return false
			else 
				hash_of_vals[sudoku_string[index]] = 1
			end
		end
		current_square += 1
	end
	true
end

def valid?(sudoku_array)
	return row_checker(sudoku_array) && column_checker(sudoku_array) && square_checker(sudoku_array)
end


def solver(sudoku_array)
	hash_object = {}
	indexes_blank = sudoku_array.each_index.select{|i| sudoku_array[i] == 0 }
	indexes_blank.map! do |val| 
		hash = {} 
		hash['index'] = val
		hash['not_values'] = [ ]
		hash
	end
	cursor_index = 0
	until cursor_index == indexes_blank.length
		guess = 1
		cursor = indexes_blank[cursor_index]
		until false
			used_up_values = cursor['not_values']
			if guess > 9 
				cursor['not_values'] = []
				sudoku_array[cursor['index']] = 0
				cursor_index -= 1
				cursor = indexes_blank[cursor_index]
				cursor['not_values'] << sudoku_array[cursor['index']]
				sudoku_array[cursor['index']] = 0
				break
			elsif !(used_up_values.include?(guess)) && guess_cell(guess, cursor['index'], sudoku_array)
				sudoku_array[cursor['index']] = guess
				cursor_index += 1
				break
			else
				guess += 1
			end
		end
	end
	print_it(sudoku_array)
end

def print_it(array)
	p "**************************************************"
	p "**************************************************"
	p valid?(array)
	p "**************************************************"
	p array[0..8]
	p array[9..17]
	p array[18..26]
	puts " "
	p array[27..35]
	p array[36..44]
	p array[45..53]
	puts " "
	p array[54..62]
	p array[63..71]
	p array[72..80]

end

def guess_cell(value, index, sudoku_array)
	sudoku_array[index] = value
	return true if row_checker(sudoku_array) && column_checker(sudoku_array) && square_checker(sudoku_array)
	sudoku_array[index] = 0
	false
end

def sudoku_array(sudoku_string)
	sudoku_string.split("").map { |string_value| string_value.to_i }
end

solver(sudoku_array(sudoku_string))
solver(sudoku_array(sudoku_string2))
solver(sudoku_array(sudoku_string3))
solver(sudoku_array(sudoku_string4))
solver(sudoku_array(sudoku_string5))
solver(sudoku_array(sudoku_string6))
solver(sudoku_array(sudoku_string7))
solver(sudoku_array(sudoku_string8))
solver(sudoku_array(sudoku_string9))
solver(sudoku_array(sudoku_string10))
solver(sudoku_array(sudoku_string11))
solver(sudoku_array(sudoku_string12))
solver(sudoku_array(sudoku_string13))
solver(sudoku_array(sudoku_string14))
solver(sudoku_array(sudoku_string15))

