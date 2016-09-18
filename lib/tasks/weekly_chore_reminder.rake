namespace :chores do
  desc 'Populates users and chores'
  task weekly_reminder: :environment do
    chore_ids = []
    print 'Sending emails: '
    residents = Resident.all
    residents.each do |resident|
      ChoreMailer.weekly_email(resident, resident.chores).deliver_now
      chore_ids << resident.chores.pluck(:id)
      print '.'
    end
    puts ' done'

    print 'Switching chores: '
    residents.each_with_index do |resident, i|
      Chore.where(id: chore_ids[(i+1)%chore_ids.size])
        .update_all(resident_id: resident.id)
      print '.'
    end
    puts ' done'
  end
end
