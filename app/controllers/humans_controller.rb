class HumansController < ApplicationController
  before_action :set_human, only: [ :show, :edit, :update, :destroy ]

  def index
    @humans = Human.all
  end

  def show
  end

  def new
    @human = Human.new
    @human.initialize_matrix
  end

  def create
    human_attributes = Human.from_human_params(human_params)
    @human = Human.new(human_attributes)
    if @human.save
      redirect_to humans_path, notice: "Human was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @human.initialize_matrix
  end

  def update
    human_attributes = Human.from_human_params(human_params)
    if @human.update(human_attributes)
      redirect_to humans_path, notice: "Human was successfully updated."
    else
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @human.destroy
    redirect_to humans_path, notice: "Human was successfully destroyed."
  end

  private

  def set_human
    @human = Human.find(params[:id])
  end

  def human_params
    params.require(:human).permit(:name, dna_matrix: {})
  end
end
