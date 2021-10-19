roles = Role.create([{ name: 'Admin' }, { name: 'User' }])
users = User.create(name: 'Admin', email: 'bbrizolara@cds.com', password: 'password', 
                    password_confirmation: 'password', active: true, role: roles.first)
