class User < ActiveRecord::Base
  #include UpdateWithoutPassword         

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_one :location
  has_many :children

  #Validations
  validates :email, presence: true
  validates :start_date, presence: true
  
  accepts_nested_attributes_for :location, :children


  def has_location
  	self.location.empty?
  end 
         
         
end
