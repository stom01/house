namespace :db do
  desc 'Populates users and chores'
  task sample: :environment do
    ids = []
    print "Adding Users "
    4.times do
      r = Resident.create(name: Faker::Name.name, email: ENV['EMAIL'])
      ids << r.id
      print '.'
    end
    print "\nAdding Chores "
    4.times do |i|
      if i % 2 == 0
        Chore.create(name: Faker::Hacker.noun, resident_id: ids[i])
      else
        Chore.create(name: Faker::Hacker.noun, resident_id: ids[i],
          description: Faker::Hacker.say_something_smart)
      end
      print '.'
    end
    puts "\ndone adding sample data"
  end
end
