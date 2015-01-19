class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!
  
 

def update
  # Get all params for :account_update
  account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

  # Allow user to update without using password.
  if account_update_params[:password].blank?
    account_update_params.delete("password")
    account_update_params.delete("password_confirmation")
  end

  # Set current_user
  @user = User.find(current_user.id)
   if @user.update_attributes(account_update_params)
     set_flash_message :notice, :updated
     sign_in @user, :bypass => true
     redirect_to after_update_path_for(@user)
   else
     render "edit"
   end
end

private


 def configure_permitted_parameters()
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :start_date) }
  end


end