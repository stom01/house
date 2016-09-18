class ResidentsController < ApplicationController
  before_action :authenticate, except: [:index]
  
  expose :residents, -> { Resident.all.includes(:chores).order(:id) }
  expose :resident

  def create
    if resident.save
      redirect_to residents_path
    else
      render :new
    end
  end

  def update
    if resident.update(resident_params)
      redirect_to residents_path
    else
      render :edit
    end
  end

  def destroy
    resident.destroy
    redirect_to residents_path
  end

  private

  def resident_params
    params.require(:resident).permit(:name, :email)
  end
end
