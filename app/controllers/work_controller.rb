class WorkController < ApplicationController

  before_action :find_work, except: [:destroy, :create]
  def index
    @works = works.order(created_at: 'desc').page(params[:page]).per(5)
  end

  def create
    @work = Work.new(work_params)
    @work.user_id = current_user.id
    if @work.save
      redirect_via_turbolinks_to root_path
    else
      render :new
    end
  end

  def destroy
    if params[:id] == "42"
      works.where(complete: true).destroy_all
    end
    redirect_via_turbolinks_to root_path
  end

  def update
    if @work.update(work_params)
      redirect_via_turbolinks_to root_path
    else
      render :edit
    end
  end

  def toggle_complete
    @work.complete ? @work.update(complete: false) : @work.update(complete: true)
    render json: { 'completed_works' => completed_works? }
  end

  private

  def work_params
    params.require(:work).permit(:description)
  end

  def works
    current_user.works
  end

  def find_work
    @work = works.find_by(id: params[:id]) || Work.new()
  end

  def completed_works?
    return true unless current_user.works.where(complete: true).count.zero?
    false
  end
  helper_method :completed_works?
end
