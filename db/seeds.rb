# frozen_string_literal: true

ActiveRecord::Base.transaction do
  STATUS_EXAMPLES = ['created',
                     'QA',
                     'in_progress',
                     'ready for review',
                     'blocked',
                     'done'].freeze

  # Creating your user
  if ENV['TEST_USER_EMAIL']
    email = ENV['TEST_USER_EMAIL']
  else
    print 'Enter an email address for your user: '.green
    email = $stdin.gets
    email = email.chomp
  end

  if ENV['TEST_USER_PASSWORD']
    password = ENV['TEST_USER_PASSWORD']
  else
    print 'Enter a password for your user: '.green
    password = $stdin.gets
    password = password.chomp
  end

  if User.exists?(email:)
    puts 'Database already seeded'.red
    return
  end

  puts 'Creating user'.yellow
  User.create(email:, password:)

  # Creating dummy users
  puts 'Creating dummy users'.yellow
  5.times do
    User.create(email: Faker::Internet.email,
                password: Faker::Internet.password)
  end

  # Creating projects
  if ENV['PROJECT_COUNT']
    project_count = ENV['PROJECT_COUNT'].to_i
  else
    print 'Enter how many projects do you want: '.green
    project_count = $stdin.gets
    project_count = project_count.chomp.to_i
  end

  puts 'Creating projects'.yellow
  project_count.times do
    project = Project.create(name: Faker::Lorem.sentence(word_count: Random.rand(1..8)),
                             description: Faker::Lorem.paragraph(sentence_count: Random.rand(1..25)))
    StatusChange.create(next_status: 'created', project:, user_id: 1)

    # Creating comments and status changes for created project (except for the first one)
    next if project.id == 1

    Random.rand(1..3).times do
      Random.rand(1..3).times do
        Comment.create(content: Faker::Lorem.paragraph(sentence_count: Random.rand(1..3)),
                       user_id: Random.rand(2..User.count),
                       project:)
      end

      Random.rand(1..3).times do
        StatusChange.create(previous_status: STATUS_EXAMPLES[Random.rand(0..5)],
                            next_status: STATUS_EXAMPLES[Random.rand(0..5)],
                            user_id: Random.rand(2..User.count),
                            project:)
      end
    end
  end
end
