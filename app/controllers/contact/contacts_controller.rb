class Contact::ContactsController < ApplicationController
    # * お問い合わせフォーム
    def new
        @contact = UserContact.new
    end

    # * お問い合わせ処理
    def create
        @contact = UserContact.new(posts_params)

        if @contact.save
            ContactMailer.contact_mail(@contact).deliver
            redirect_to "/contact/complete"
        else
            render :new
        end
    end

    # * お問い合わせ完了画面
    def complete        
    end    

    private

    # ! 投稿時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:user_contact).permit(:email, :name, :content)
    end
end
