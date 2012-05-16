def read_file(file_path)
	output_str  = ''
	file = File.new(file_path,"r")
	STDOUT.puts file.gets.inspect
	while (line = file.gets)
		if line.include? ' --> '
			init_time,final_time = line.split(' --> ')
			output_str += shift(init_time) +' --> ' + shift(final_time) + "\n" 
			STDOUT.puts output_str
		else
			output_str += line	
		end
	end
	write_file(output_str)
end

def shift(input_time)
	parsed_init_time = ''
	case ARGV[1]
	when 'add'
		h,m,s = input_time.split(':')
		parsed_init_time = (Time.new(1969,12,31,h,m,s.gsub(",",".").to_f) + ARGV[3].gsub(",",".").to_f).strftime("%H:%M:%S,%L") 
	when 'sub'
		h,m,s = input_time.split(':')
		parsed_init_time = (Time.new(1969,12,31,h,m,s.gsub(",",".").to_f) - ARGV[3].gsub(",",".").to_f).strftime("%H:%M:%S,%L") 
	else
		STDOUT.puts "Operation does not exist!"
	end
	parsed_init_time
end

def write_file(output_str)
	File.open(ARGV[5],'w') do |file_path|
		file_path.puts output_str
	end
	
end

case ARGV[0]
when "--operation"
	read_file ARGV[4]
else
	STDOUT.puts "command does not exist!"		
end

