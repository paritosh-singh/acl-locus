require_relative 'models/role'
require_relative 'models/user'

class Input
  def self.display_options
    puts "\n\n1. Create User"
    puts "2. Create Role"
    puts "3. Add role to user"
    puts "4. Add permission to role"
    puts "5. Remove permission from role"
    puts "6. Add inherit role to a role"
    puts "7. Check user's permission over a resource"    
    puts "q Quit (You will lose complete data)"    
  end


  def self.analyze_input input
    case input
      when "1"
        create_user
      when "2"
        create_role
      when "3" 
        add_role_to_user
      when "4"
        add_permission_to_role
      when "5"
        remove_permission_from_role
      when "6"
        add_inherit_role_to_role
      when "7"
        check_user_permission_over_resource
      else
        puts "\n\nINVALID INPUT\n\n"
    end
  end


  def self.create_user
    print "\nEnter user name: "
    name = gets.chomp
    user = User.create_user name
    puts "User with name #{user.name} created"
  end


  def self.create_role
    print "\nEnter role name: "
    name = gets.chomp
    role = Role.create_role name
    puts "Role with name #{role.name} created"
  end

  def self.add_role_to_user
    print "\nEnter role user's name:"
    username = gets.chomp
    user = User.find_user username
    raise "Invalid username" if user.nil?
    print "\nEnter role name:"
    role_name = gets.chomp    
    user.add_role role_name
    puts "Role with name #{role_name} created"
  end

  def self.add_permission_to_role
    print "\nEnter role name: "
    role_name = gets.chomp
    role = Role.find_role role_name
    raise "Invalid Role" if role.nil?
    print "\nEnter action: "
    action = gets.chomp
    print "\nEnter resource: "
    resource = gets.chomp

    role.add_permission action, resource
    puts "Role with action #{action} and resource #{resource} added"
  end

  def self.check_user_permission_over_resource
    print "\nEnter user's name:"
    username = gets.chomp
    user = User.find_user username
    print "\nEnter action: "
    action = gets.chomp
    print "\nEnter resource: "
    resource = gets.chomp  
    puts "\n\n #{username} => #{action} => #{resource} : #{user.can?(action,resource)}" 
  end

  def add_inherit_role_to_role
    print "\nEnter role name: "
    role_name = gets.chomp
    role = Role.find_role role_name
    raise "Invalid Role" if role.nil?
    print "\n Enter role name to inherit"
    inherit_role_name = gets.chomp
    role.add_inherit_role inherit_role_name
    puts "Inherit role #{inherit_role_name} added to #{role_name}"
  end    

  def remove_permission_from_role
    print "\nEnter role name: "
    role_name = gets.chomp
    role = Role.find_role role_name
    raise "Invalid Role" if role.nil?
    print "\nEnter action: "
    action = gets.chomp
    print "\nEnter resource: "
    resource = gets.chomp
    role.remove_permission action, resource
    puts "Inherit role #{inherit_role_name} added to #{role_name}"
  end

end