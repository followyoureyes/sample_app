# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                   "Hans Peter"
  user.email                  "petermail@web.de"
  user.password               "geheim"
  user.password_confirmation  "geheim"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end