# create canvas
begin
  puts "enter command: "
  command = gets.chomp
  canvas = Canvas.create_from_command(command)
rescue Exception => e
  puts e.message
  retry
end

until command == "Q"
  puts "enter command: "
  command = gets.chomp
  canvas.proccess_command(command)
end