class Contact::ContactsController < ApplicationController
    before_action :require_create_action, only: :complete

    # * お問い合わせフォーム
    def new
        @contact = UserContact.new
    end

    # * お問い合わせ処理
    def create
        @contact = UserContact.new(posts_params)

        if @contact.save
            session[:create_action_called] = true
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

    def require_create_action
        # セッションからフラグを取得し、createアクションが呼び出されたかを確認する
        unless session[:create_action_called]
            redirect_to "/contact/new"
        end
    end
end
