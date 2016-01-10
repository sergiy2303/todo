class WorkController < ApplicationController

  before_action :work, only: [:create, :new]
  def index
  end

  def create
    work = Work.new(params.require(:work).permit(:description))
    work.user_id = current_user.id
    if work.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    work = Work.find(params[:id])
    if work
      work.destroy!
    end
    redirect_to root_path
  end

  private

  def works
    Work.where(user_id: current_user.id)
  end
  helper_method :works

  def work
    Work.new
  end
  helper_method :work
end
