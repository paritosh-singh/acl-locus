require_relative "input"

input = nil
while(input != 'q')
  begin
    Input.display_options
    print "\nEnter your choice: "
    input = gets.chomp
    Input.analyze_input input
  rescue => e
    puts e.message
  end  
end