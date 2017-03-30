class SMSMessages
  include Delayed::RecurringJob
  include ApplicationHelper
  run_every 1.day
  run_at '10:00am'
  timezone 'US/Eastern'
  queue 'slow-jobs'

  def perform
    easy = SMSEasy::Client.new
    inspos = get_featured('db/data/inspos.seed')

    # SMS limit of 105 chars per chunk?

    daily = 'Hello from Blue Mirror! ' \
    'We hope you have a terrific day! Visit ' \
    'https://blue-mirror.herokuapp.com to reflect, or to change SMS settings.'

    weekly = daily.gsub 'day', 'week'

    reminder = "Hello from Blue Mirror team! We haven't seen you for " \
    + "a few days and we hope you're okay! We'd love for you to come see " \
    + "us again! Remember: We are stronger together." \
    + "\n\nVisit https://blue-mirror.herokuapp.com to change your SMS settings."

    User.all.each do |user|
      next unless user.phone and user.phone_provider and user.sms_frequency
      mia = user.updated_at.beginning_of_day == 3.days.ago.beginning_of_day

      if user.sms_frequency == 'Daily'
        easy.deliver(decrypt(user.phone), user.phone_provider, daily)
      elsif user.sms_frequency == 'Weekly' and Date.today.monday?
        easy.deliver(decrypt(user.phone), user.phone_provider, weekly)
      elsif user.sms_frequency == 'Reminder' and mia
        easy.deliver(decrypt(user.phone), user.phone_provider, reminder)
      end
    end
  end
end
