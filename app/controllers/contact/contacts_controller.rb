class Contact::ContactsController < ApplicationController
    def new
        @contact = UserContact.new
    end
end
