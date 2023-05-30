class Admin::ContactsController < ApplicationController
    # * お問い合わせ一覧取得
    def list
        @contacts = UserContact.all()        
    end

    # * お問い合わせ対応完了処理
    def create_handle
        @handle = UserContact.find(params[:id])

        if @handle.update(status: 1)
            redirect_to "/"
        else
            render :new
        end
    end
    
    # * お問い合わせ対応完了解除処理
    def delete_handle
        @handle = UserContact.find(params[:id])

        if @handle.update(status: 0)
            redirect_to "/"
        else
            render :new
        end
    end
end
