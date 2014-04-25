class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :terms, :acceptance => {:accept => true}
  # Relationships
  has_one :location
  has_many :children
  
  accepts_nested_attributes_for :location, :children
         
         
end
