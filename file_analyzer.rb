# Check if a directory is provided as an argument
if ARGV.empty?
  puts "Usage: ruby file_analyzer.rb <directory>"
  exit 1
end

directory = ARGV[0]

# Check if the provided directory exists
unless Dir.exist?(directory)
  puts "Directory does not exist."
  exit 1
end

# Analyze files in the directory
file_count = Dir.glob(File.join(directory, '*')).count { |file| File.file?(file) }
largest_file = Dir.glob(File.join(directory, '*')).max_by { |file| File.size(file) }
total_size = Dir.glob(File.join(directory, '**', '*')).select { |file| File.file?(file) }.sum { |file| File.size(file) }

# Output the analysis
puts "File Analysis for Directory: #{directory}"
puts "-----------------------------"
puts "Total Files: #{file_count}"
puts "Largest File: #{largest_file}"
puts "Total Size: #{total_size} bytes"
