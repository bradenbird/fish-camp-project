class UsersController < ApplicationController
    def makeAdmin
        @user = User.find(params[:id])
        @user.role = 'admin'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " an admin"
        redirect_to request.referrer
    end
    
    def makeGuest
        @user = User.find(params[:id])
        @user.role = 'guest'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " a guest"
        redirect_to request.referrer
    end
    
    def makeChair
        @user = User.find(params[:id])
        @user.role = 'chair'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " a chair"
        redirect_to request.referrer
    end
    
end
