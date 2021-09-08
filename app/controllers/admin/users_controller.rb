class Admin::UsersController < ApplicationController
 before_action :authenticate_admin!
 
 def index
  @users=User.all
 end
  
 def show
  @user=User.find(params[:id])
 end
  
 def edit
  @user=User.find(params[:id])
 end
 
 def update
  @user=User.find(params[:id])
  if @user.update(user_params)
   redirect_to admin_user_path(@user)
  else
   render 'edit'
  end
 end
 
 private
 
 def user_params
  params.require(:user).permit(:is_deleted, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :encrypted_password)
 end 
end
