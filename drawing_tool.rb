load 'lib/canvas.rb'

# create canvas
begin
  puts "enter command: "
  command = gets.chomp
  canvas = Canvas.create_from_command(command)
rescue Exception => e
  puts e.message
  retry
end

loop do
  puts "enter command: "
  command = gets.chomp
  
  break if command == "Q"
  puts canvas.process_command(command)
end