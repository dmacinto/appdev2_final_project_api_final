desc "Fill the database tables with some sample data"
task sample_data: :environment do
  starting = Time.now

  Task.delete_all
  User.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  people << { first_name: "Alice", last_name: "Smith" }
  people << { first_name: "Bob", last_name: "Smith" }
  people << { first_name: "Carol", last_name: "Smith" }
  people << { first_name: "Doug", last_name: "Smith" }

  people.each do |person|
    username = person.fetch(:first_name).downcase

    user = User.create(
      email: "#{username}@example.com",
      password: "password",
      username: username.downcase,
    )

    p user.errors.full_messages
  end

  users = User.all



  create_table "tasks", force: :cascade do |t|
    t.text "body"
    t.integer "commenter_id"
    t.boolean "completed_id"
    t.boolean "in_progress_id"
    t.boolean "incomplete_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end




  users.each do |user|
    rand(15).times do
        if rand < 0.25
          task = user.comments.create(
            body: Faker::Quote.jack_handey,
            commenter_id: follower
          )
          p task.errors.full_messages
        end
      end
    end
  end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{Task.count} tasks."
end