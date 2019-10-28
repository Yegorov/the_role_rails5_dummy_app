# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

##############################
# Roles
##############################
Role.create!(
  name: :user,
  title: :role_for_users,
  description: :user_can_edit_his_pages,
  the_role: {
    pages: {
      index:   true,
      show:    true,
      new:     true,
      create:  true,
      edit:    true,
      update:  true,
      destroy: true,
      my:      true,
      secret:  false
    }
  }
)

Role.create!(
  name: :pages_moderator,
  title: :pages_moderator,
  description: :can_do_anything_with_pages,
  the_role: { moderator: { pages: true } }
)

TheRole.create_admin!

p "Roles created"

##############################
# Users
##############################
User.create!(
  email: 'admin@site.com',
  name:  Faker::Name.name,
  company: Faker::Company.name,
  address: Faker::Address.street_address,
  password: 'qwerty',
  password_confirmation: 'qwerty',
  role: Role.with_name(:admin)
)

User.create!(
  email: Faker::Internet.email,
  name:  Faker::Name.name,
  company: Faker::Company.name,
  address: Faker::Address.street_address,
  password: 'qwerty',
  password_confirmation: 'qwerty',
  role: Role.with_name(:pages_moderator)
)

5.times do
  User.create!(
    email: Faker::Internet.email,
    name:  Faker::Name.name,
    company: Faker::Company.name,
    address: Faker::Address.street_address,
    password: 'qwerty',
    password_confirmation: 'qwerty',
    role: Role.with_name(:user)
  )
end

p "Users created"

##############################
# Pages
##############################

User.all.each do |user|
  10.times do
    user.pages.create!(
      title:   Faker::Lorem.sentence,
      content: Faker::Lorem.paragraphs(number: 3).join,
      state: %w[draft published].sample
    )
  end
end

p "Pages created"
