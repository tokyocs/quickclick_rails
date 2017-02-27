class ReflectionsController < ApplicationController
  before_action :set_reflection, only: [:show, :edit, :update, :destroy]

  # GET /reflections
  # GET /reflections.json
  def index
    @reflections = Reflection.all
  end

  # GET /reflections/1
  # GET /reflections/1.json
  def show
  end

  # GET /reflections/new
  def new
    @reflection = Reflection.new
  end

  # GET /reflections/1/edit
  def edit
  end

  # POST /reflections
  # POST /reflections.json
  def create
    @reflection = Reflection.new(reflection_params)

    respond_to do |format|
      if @reflection.save
        format.html { redirect_to @reflection, notice: 'Reflection was successfully created.' }
        format.json { render :show, status: :created, location: @reflection }
      else
        format.html { render :new }
        format.json { render json: @reflection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reflections/1
  # PATCH/PUT /reflections/1.json
  def update
    respond_to do |format|
      if @reflection.update(reflection_params)
        format.html { redirect_to @reflection, notice: 'Reflection was successfully updated.' }
        format.json { render :show, status: :ok, location: @reflection }
      else
        format.html { render :edit }
        format.json { render json: @reflection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reflections/1
  # DELETE /reflections/1.json
  def destroy
    @reflection.destroy
    respond_to do |format|
      format.html { redirect_to reflections_url, notice: 'Reflection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reflection
      @reflection = Reflection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reflection_params
      params.require(:reflection).permit(:student_id, :problem_id, :session_id, :reflection, :response_timing)
    end
end
