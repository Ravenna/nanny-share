class WelcomeController < ApplicationController
   
   before_action :set_user
   
  def home
  end 
  
  def privacy
  end 
  
  def terms
  end 
  
  def manage_users
    @users = User.all
  end 
  
  def destroy_users
    @user = User.find(params[:id])
    #Destroy User
    @user.destroy
    #Destroy Users Children
    @user.children.each do |c|
      c.destroy
    end 
    #Destroy Users Location
    @user.locations.each do |l|
      l.destroy
    end 
    respond_to do |format|
      format.html { redirect_to manage_users_path }
      format.json { head :no_content }
    end
  end 
  
  def find_a_family
     @users = User.all 
     
      if user_signed_in? && params[:distance].present? #Current User and Distance Params
        @close = Location.where("user_id is NOT NULL").near([current_user.location.latitude, current_user.location.longitude], params[:distance])
        @close = @close.joins(user: :children).where('users.children_count <= ?', params[:number_of_children]) if params[:number_of_children].present?

        @hash = Gmaps4rails.build_markers(@close) do |location, marker|
            marker.lat location.latitude
            marker.lng location.longitude
            if location.user.email
              marker.infowindow location.user.email
            end
          end
        
      elsif user_signed_in?  && !current_user.location.nil? # Current User with a location but no distance params
        @close = Location.where("user_id is NOT NULL").near([current_user.location.latitude, current_user.location.longitude], 25)

        @hash = Gmaps4rails.build_markers(@close) do |location, marker|
            marker.lat location.latitude
            marker.lng location.longitude
            if location.user.email
              marker.infowindow location.user.email
            end
          end


      elsif user_signed_in?  && current_user.location.nil? # Current User with no location
        redirect_to root_path, alert: 'You must add your address before searching for families' 

      else # OK DO THIS
          redirect_to root_path, alert: 'You must login or create an account before searching for families' 
      end  
      
  end 
  
  # Never trust parameters from the scary internet, only allow the white list through.    
  def user_params
    params.require(:user).permit(:name,
           :user => [:id, :start_date,
            children_attributes => [:id, :age, :gender, :user_id],
            location_attributes => [:address_one, :address_two, :city, :state, :zip, :latitude, :longitude, :user_id]
          ])
  end
  
  
    def set_user
      if user_signed_in?
          @user = User.find(current_user.id)
      end 
    end
  
  
end
