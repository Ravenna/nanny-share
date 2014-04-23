class WelcomeController < ApplicationController
   
   before_action :set_user
   
  def home
  end 
  
  def find_a_family
     @users = User.all 
     
      if user_signed_in? && params[:distance].present?
        @close = Location.near([current_user.location.latitude, current_user.location.longitude], params[:distance])
        @close = @close.joins(users: :children).where('user.children.count <= ?', params[:number_of_children]) if params[:number_of_children].present?
        
        
        
        # DON'T SHOW CURRENT USER
        #@close = @close.where('user_id != ?', current_user)
      else user_signed_in? 
        @close = Location.near([current_user.location.latitude, current_user.location.longitude], 5)
      end  
      
      @hash = Gmaps4rails.build_markers(@close) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
        marker.infowindow location.user.email
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
