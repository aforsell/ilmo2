class UsersController < ApplicationController
	before_filter :check_logged_in_and_correct_user, :only => [:edit, :update, :destroy]
	before_filter :check_not_logged_in, :only => [:new, :create]

	def index
		@users = User.find :all, :order => :username
	end

	def new
		@user = User.new
  end

  def create
		@user = User.new params[:user]
		if @user.save
			flash[:notice] = "User #{@user.username} was successfully created."
			redirect_to :controller => 'courses', :action => 'index'
			session[:user_id] = @user.id
		else
			render :action => 'new'
		end
  end

  def show
		@user = User.find params[:id]
  end

  def edit
		@user = User.find params[:id]
  end

  def update
		@user = User.find params[:id]
		if @user.update_attributes params[:user]
			flash[:notice] = "User #{@user.username} was successfully updated."
			redirect_to :controller => 'courses', :action => 'index'
		else
			render :action => 'edit'

		end
  end

  def destroy
		@user = User.find params[:id]
		if @user.destroy
			flash[:notice] = "User #{@user.username} was successfully removed."
			redirect_to :controller => 'sessions', :action => 'logout'
		else
			render :action => 'edit'
		end
  end

private

	def check_logged_in_and_correct_user
		if session[:user_id] and session[:user_id].to_s == params[:id].to_s
			return true
		end
		redirect_to courses_path	
	end

	def check_not_logged_in
		if session[:user_id]
			redirect_to courses_path	
		end
	end
end
