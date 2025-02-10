# Clear existing data
Item.delete_all
Category.delete_all
Menu.delete_all
User.delete_all

# Create Users
10.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: 'password' # Assuming Devise or similar for authentication
  )

  # Create Menus for each User
  rand(1..3).times do
    menu = user.menus.create!(name: Faker::Restaurant.name)

    # Create Categories for each Menu
    rand(2..4).times do
      category = menu.categories.create!(name: Faker::Restaurant.type)

      # Create Items for each Category
      rand(3..6).times do
        category.items.create!(
          name: Faker::Food.dish,
          price: Faker::Commerce.price(range: 5.0..50.0),
          description: Faker::Food.description
        )
      end
    end
  end
end

puts "Seeded #{User.count} users, #{Menu.count} menus, #{Category.count} categories, and #{Item.count} items."
