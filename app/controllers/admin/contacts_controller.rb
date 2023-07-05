class Admin::ContactsController < ApplicationController

        # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
        before_action :move_to_signed_in, except: []

    # * お問い合わせ一覧取得
    def list
        @contacts = UserContact.all()
    end

    # * お問い合わせ詳細取得
    def show
        @show = UserContact.find(params[:id])
    end

    # * お問い合わせ対応完了処理
    def create_handle
        @handle = UserContact.find(params[:id])

        if @handle.update(status: 1)
            redirect_to "/admin/contact/list/"
        else
            render :new
        end
    end

    # * お問い合わせ対応完了解除処理
    def delete_handle
        @handle = UserContact.find(params[:id])

        if @handle.update(status: 0)
            redirect_to "/admin/contact/list/"
        else
            render :new
        end
    end

     # ! (privateは外部クラスから参照できない)
     private
     # ! ログインがしているのか判定する
     def move_to_signed_in
         unless admin_signed_in?
             redirect_to new_admin_session_path, alert: "この操作は、サインインが必要です。"
         end
     end
end
