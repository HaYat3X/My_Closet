class Contact::ContactsController < ApplicationController
    # * お問い合わせフォーム
    def new
        @contact = UserContact.new
    end

    # * お問い合わせ処理
    def create
        
    end

    private

    # ! 投稿時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:user_contact).permit(:email, :name, :content)
    end
end
