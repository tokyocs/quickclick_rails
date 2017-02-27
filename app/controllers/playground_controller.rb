class PlaygroundController < ApplicationController
  def index
      @student = Student.find(params[:student_id])
  end
end
