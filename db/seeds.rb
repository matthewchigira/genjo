if ENV['ADMIN_EMAIL'] && ENV['ADMIN_PASSWORD']

  User.create!(name: "Administrator",
               email: ENV['ADMIN_EMAIL'],
               password: ENV['ADMIN_PASSWORD'],
               password_confirmation: ENV['ADMIN_PASSWORD'],
               admin: true,
               activated: true,
               private: true)
else

  Rails.logger.debug "ADMIN_EMAIL and/or ADMIN_PASSWORD not specified for seeds data"

end
