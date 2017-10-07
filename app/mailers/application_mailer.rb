class ApplicationMailer < ActionMailer::Base

  # => Address
  # => http://stackoverflow.com/a/8106387/1143732
  @@address = Mail::Address.new Rails.application.secrets.app[:email]
  @@address.display_name = Rails.application.secrets.app[:domain]

  # => Default
  # => http://stackoverflow.com/a/18579046/1143732
  default from:	@@address.format, template_path: "mailers"

  # Layout (app/views/layouts)
  layout "mailers/layouts/mailer"

  ##########################################################
  ##########################################################

    # For Admin "seeds" notification
    def new_user user
      @user = user
      mail to: @@address
      puts "User details sent to → #{@@address}"
    end

  ##########################################################
  ##########################################################

end
