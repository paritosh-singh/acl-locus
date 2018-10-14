require_relative 'permission'
class Role 
  @@roles = []
  attr_accessor :name, :permissions, :inherit_roles, :is_active


  def initialize name
    @name = name
    @inherit_roles = []
    @is_active = true
    @permissions = []
  end

  def self.get_roles
    return @@roles
  end

  def self.find_role name
    @@roles.each do |role|
      return role if role.name == name
    end
    return nil
  end

  def self.create_role name
    @@roles.each do |role|
      raise "Role already exist" if role.name == name
    end
    role = Role.new(name)
    @@roles << role
    return role
  end

  def find_permission action, resource
    permissions.each do |permission|
      return permission if !permission.is_removed && 
        permission.action == action && permission.resource == resource
    end
    return nil
  end

  def add_permission action, resource
    raise "Permission already added to role" if find_permission(action, resource)
    permission = Permission.new(action, resource)
    permissions << permission
    return permission
  end

  def remove_permission action, resource
    permission = find_permission(action, resource)
    raise "No permission #{action} - #{resource} exists" if permission.nil?
    permission.is_removed = true    
  end

  def add_inherit_role role_name
    role = Role.find_role(role_name)
    raise "Role #{role_name} doesn't exist" if role.nil?
    inherit_roles << role
    return role
  end  

  def can? action, resource
    permission = find_permission(action, resource)
    return true unless permission.nil?
    inherit_roles.each do |role|
      return true if role.can? action, resource
    end
    return false
  end

end
