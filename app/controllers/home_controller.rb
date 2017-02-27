class HomeController < ApplicationController
  def index
      @students = Student.all
  end
end
