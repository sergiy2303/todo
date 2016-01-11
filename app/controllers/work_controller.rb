class WorkController < ApplicationController

  before_action :work, only: [:create, :new]
  def index
  end

  def create
    work = Work.new(work_params)
    work.user_id = current_user.id
    if work.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    unless work.new_record?
      work.destroy!
    end
    redirect_to root_path
  end

  def edit
    work = Work.find(params[:id])
  end

  def update
    if work.update(work_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def work_params
    params.require(:work).permit(:description)
  end

  def works
    Work.where(user_id: current_user.id)
  end
  helper_method :works

  def work
    works.find_by(id: params[:id]) || Work.new
  end
  helper_method :work
end
