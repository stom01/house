namespace :chores do
  desc 'Populates users and chores'
  task weekly_reminder: :environment do
    chore_ids = []
    print 'Sending emails: '
    Resident.all.each do |resident|
      ChoreMailer.weekly_email(resident, resident.chores).deliver_now
      chore_ids << resident.chores.pluck(:id)
      print '.'
    end
    puts ' done'

    print 'Switching chores: '
    Resident.all.pluck(:id).each_with_index do |resident_id, i|
      Chore.where(id: chore_ids[(i+1)%chore_ids.size])
        .update_all(resident_id: resident_id)
      print '.'
    end
    puts ' done'
  end
end
