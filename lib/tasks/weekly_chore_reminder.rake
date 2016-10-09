namespace :chores do
  desc 'Populates users and chores'
  task weekly_reminder: :environment do
    Time.zone = 'Eastern Time (US & Canada)'
    if Time.current.sunday?
      residents = Resident.all.order(:id)
      chore_ids = []
      residents.each do |resident|
        chore_ids << resident.chores.pluck(:id)
      end
      print 'Switching chores: '
      residents.each_with_index do |resident, i|
        chores = Chore.where(id: chore_ids[(i+1)%chore_ids.size])
        chores.each { |chore| chore.update(resident_id: resident.id) }
        print '.'
      end
      puts ' done'

      print 'Sending emails: '
      residents.each do |resident|
        ChoreMailer.weekly_email(resident, resident.chores).deliver_now
        print '.'
      end
      puts ' done'
    end
  end
end
