# Role based ACL

## Inroduction
In `Role based ACL` we have user defined access control list based on role. It has following entities:
- User: It is the user in the ecosystem with a name.
- Permission: It defines an `action` user can perform over a `resource`. It is combination of action and resource.
- Role: It defines ability of a user in ecossytem. It is `combination of multiple permissions` and roles.

## Installation
In order to run the application you need to install [ruby-2.4.1](https://www.ruby-lang.org/en/documentation/installation/).
After installing ruby, go to root directory of project and run command
```
  bundle install
``` 
it will install third party dependencies.

## How to run the application
To start the application go to root path of project and run command.
```
  ruby main.rb
```

## Testcases
For testing functionality of application we have written test cases in spec folder. To execute testcases run following command
```
  rspec spec
```

## Assumptions
- You can have only one user with one name. Creating second user with same name will raise error.
- Name is unique for role. Creating other role with same name will raise error.
- Resources and actions are just string objects. They can be created dynamically.
- Inherent roles permissions are not removed when you apply remove permission on its super role.
- For now we have only add inherent role. Inherent roles cannot be removed once attached.
- Code is written in a way so that code comments are not required. However if at some place if it is not understandable please let me know.

Let me know if any other changes are required.

Thanks :).