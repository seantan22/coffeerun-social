# Create a main sample user
User.create!( name: "Sean Tan",
              email: "seankltan@gmail.com",
              password: "password",
              password_confirmation: "password",
              admin: true)

# Generate a bunch of additional sample users
99.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@example.com"
  password = "password"
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password)
end
