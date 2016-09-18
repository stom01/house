class ChoresController < ApplicationController
  expose :chores, -> { Chore.all.includes(:resident).order(:id) }
  expose :chore

  def create
    if chore.save
      respond_to do |format|
        format.html { redirect_to chores_path }
        format.js { }
      end
    else
      render :new
    end
  end

  def update
    if chore.update(chore_params)
      redirect_to chores_path
    else
      render :edit
    end
  end

  def destroy
    chore.destroy
    redirect_to chores_path
  end

  private

  def chore_params
    params.require(:chore).permit(:name, :description, :resident_id)
  end
end
