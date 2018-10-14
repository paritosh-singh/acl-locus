require_relative "../models/role"
require_relative "../models/user"
describe "ACL App" do 

  before :all do
    @user = "DummyName"
    @role = "admin"
    @inherit_role = "writer"
  end

  it "create a user with given name" do
    User.create_user @user
    user = User.find_user @user
    expect(user).to_not be_nil
  end

  it "cannot create 2 users with same name" do    
    expect { User.create_user(@user) }.to raise_error
  end

  it "create a role with given name" do
    Role.create_role "admin"
    role = Role.find_role "admin"
    expect(role).to_not be_nil
  end

  it "cannot create 2 roles with same name" do    
    expect { Role.create_role "admin" }.to raise_error
  end  

  it "add permission to role" do
    role = Role.find_role @role
    role.add_permission "read", "post"    
  end

  it "assigning same permission to role should raise error" do
    role = Role.find_role @role
    expect{role.add_permission "read", "post"}.to raise_error
  end

  it "assign role to user" do
    user = User.find_user @user
    user.add_role @role
  end

  it "assigning same role to user should raise error" do
    user = User.find_user @user
    expect{user.add_role @role}.to raise_error
  end

  it "test permission for read post on user" do
    user = User.find_user @user
    expect(user.can? "read", "post").to be true
  end

  it "test permission for write on post user" do
    user = User.find_user @user
    expect(user.can? "write", "post").to be false
  end

  it "add new inherit role" do
    inherit_role = Role.create_role @inherit_role
    role = Role.find_role @role
    inherit_role.add_permission "write", "post"
    role.add_inherit_role @inherit_role
    user = User.find_user @user
    expect(user.can? "write", "post").to be true
  end

  it "remove permission from role" do
    inherit_role = Role.find_role @inherit_role
    inherit_role.remove_permission "write", "post"
    user = User.find_user @user
    expect(user.can? "write", "post").to be false
  end

  it "raise error on removing permission which does not exist from role" do
    inherit_role = Role.find_role @inherit_role
    expect{inherit_role.remove_permission "write", "post"}.to raise_error    
  end

end