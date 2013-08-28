namespace :db do
	desc "Populate the database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end

	def make_users
		User.create!(name: "John Howlett",
			         email: "jhowlett4@example.com",
			         password: "password",
			         password_confirmation: "password",
			         admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			password_confirmation = "password"
			User.create!(name: name,
						 email: email,
						 password: password,
						 password_confirmation: password)
		end
	end

	def make_microposts
		@users = User.all
		50.times do
			content = Faker::Lorem.sentence(5)
			@users.each do |user|
				user.microposts.create!(content: content)
			end
		end
	end

	def make_relationships
		users = User.all
		user = users.first
		followed = users[2..50]
		followers = users[3..40]
		followed.each { |followed| user.follow!(followed) }
		followers.each { |follower| follower.follow!(user) }
	end

end