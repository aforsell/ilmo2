class CoursesController < ApplicationController
	before_filter :get_active_user
		
	def index
   	@courses = Course.find(:all)
	end

	def show
		@course = Course.find(params[:id])
	end

	def new
		@course = Course.new
	end

	def create
 		@course = Course.new(params[:course])
		if @course.save
 			flash[:notice] = 'Course added.'
 			redirect_to(courses_path)
		else
			render :action => "new"
		end
 	end

private

	def get_active_user
		if session[:user_id]
			@active_user = User.find(session[:user_id])
		end
	end
end
