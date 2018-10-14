require_relative 'role'
class User

  @@users = []

  attr_accessor :name, :roles

  def initialize name
    @name = name
    @roles = []    
  end

  def self.get_users
    return @@users
  end

  def self.find_user username
    @@users.each do |user|
      return user if user.name == username
    end
    return nil
  end

  def self.create_user name
    raise "User already exist" unless find_user(name).nil?
    user = User.new(name)
    @@users << user
    return user
  end

  def add_role role_name
    @roles.each do |role|
      raise "Role already added" if role.name == role_name
    end
    role = Role.find_role role_name
    raise "Invalid Role" if role.nil?
    roles << role
    return role
  end


  def can? action, resource
    roles.each do |role|
      return true if role.can? action, resource
    end
    return false
  end

end