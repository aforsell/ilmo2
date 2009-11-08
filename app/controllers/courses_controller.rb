class CoursesController < ApplicationController
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
end
