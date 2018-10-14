class Permission

  attr_accessor :action, :resource, :is_removed

  def initialize(action, resource)
    @action = action
    @resource = resource
    is_removed = false
  end

end