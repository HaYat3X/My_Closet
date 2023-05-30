class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: @contact.email, bcc: ENV["MAIL_USERNAME"], subject: "お問い合わせについて【自動送信】"
    end
end
