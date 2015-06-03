user = User.create! email: 'task@testing.me', password: 'password'

Project.create! name: 'Project 1', user_id: user.id
Project.create! name: 'Project 2', user_id: user.id
Project.create! name: 'Project 3', user_id: user.id
Project.create! name: 'Project 4', user_id: user.id
Project.create! name: 'Project 5', user_id: user.id
Project.create! name: 'Project 6', user_id: user.id
Project.create! name: 'Project 7', user_id: user.id
