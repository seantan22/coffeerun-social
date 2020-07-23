# Create a main sample user
User.create!( name: "Sean Tan",
              email: "seankltan@gmail.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              activated: true,
              activated_at: Time.zone.now)

# Generate a bunch of additional sample users
99.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@example.com"
  password = "password"
  User.create!( name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

# Generate orders for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  item = "Coffee" 
  details = "Almond Milk"
  vendor = "Tim Hortons"
  size = "Large"
  zone = "McLennan 6B"
  users.each { |user| user.orders.create!(item: item, 
                                          details: details,
                                          vendor: vendor,
                                          size: size,
                                          zone: zone) }
end
