class CustomDeviseMailer < ApplicationMailer
    def confirmation_instructions(record, token, opts = {})
        @token = token
        @resource = record
    
        attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logos/favicon.png'))

        mail(
            to: record.email,
            subject: "メールアドレス認証メール"
        ) do |format|
            format.html { render template: 'devise/mailer/confirmation_instructions' }
        end
    end

    def unlock_instructions(record, token, opts = {})
        @token = token
        @resource = record
    
        attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logos/favicon.png'))

        mail(
            to: record.email,
            subject: "アカウントロック解除メール"
        ) do |format|
            format.html { render template: 'devise/mailer/unlock_instructions' }
        end
    end

    def reset_password_instructions(record, token, opts = {})
        @token = token
        @resource = record
    
        attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logos/favicon.png'))

        mail(
            to: record.email,
            subject: "パスワードリセットメール"
        ) do |format|
            format.html { render template: 'devise/mailer/reset_password_instructions' }
        end
    end

    def password_change(record, token, opts = {})
        @token = token
        @resource = record
    
        attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logos/favicon.png'))

        mail(
            to: record.email,
            subject: "パスワードリセット完了メール"
        ) do |format|
            format.html { render template: 'devise/mailer/password_change' }
        end
    end
end
