class UsersController < ApplicationController
    def makeAdmin
        authorize User, :edit?
        @user = User.find(params[:id])
        if @user.role == 'chair'
            @user.chair.destroy
        end
        @user.role = 'admin'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " an admin"
        redirect_to request.referrer
    end
    
    def makeGuest
        authorize User, :edit?
        @user = User.find(params[:id])
        if @user.role == 'chair'
            @user.chair.destroy
        end
        @user.role = 'guest'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " a guest"
        redirect_to request.referrer
    end
    
    def makeChair
        authorize User, :edit?
        @user = User.find(params[:id])
        @user.role = 'chair'
        @user.save!
        flash[:notice] = "You have made " +  @user.name + " a chair"
        redirect_to admin_path
    end
    
end
