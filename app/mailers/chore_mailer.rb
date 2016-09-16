class ChoreMailer < ApplicationMailer
  def weekly_email(resident, chores)
    @chores = chores
    mail(to: email(resident), subject: chore_subject)
  end

  private

  def email(resident)
    %("#{resident.name}" <#{resident.email}>)
  end

  def chore_subject
    "Your chores this week: #{concatenate_chores_text}"
  end

  def concatenate_chores_text
    str = ""
    @chores.each { |chore| str += chore.name }
    str
  end
end
