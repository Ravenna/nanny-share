class ChildrenController < ApplicationController
  
  before_action :set_user
  
  def index
    @children = @user.children
  end 
  
  def new
    @child = @user.children.build
  end

  def edit
  end
  
  def show
  end 

  def create
    @child = @user.children.build(child_params)

    respond_to do |format|
      if @child.save
        format.html { redirect_to root_path, notice: 'Child was successfully added.' }
        format.json { render action: 'show', status: :created, location: @child }
        format.js 
      else
        format.html { render action: 'new' }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
  
  private
  
   def child_params
      params.require(:child).permit(:age, :gender, :user_id)
    end
    
    def set_user
        @user = User.find(params[:user_id])
    end
end
