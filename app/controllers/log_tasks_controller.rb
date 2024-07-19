class LogTasksController < ApplicationController
  before_action :set_log_task, only: [:edit, :update, :update_timer]

  def index
  end

  def show
  end

  def new
    @log_task = current_user.log_tasks.new
  end

  def create
    @log_task = current_user.log_tasks.new(log_task_params)

    respond_to do |format|
      if @log_task.save
        format.html { redirect_to log_task_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @log_task }
      else
        format.html { redirect_to log_task_path, alert: @log_task.errors.full_messages.join(', ') }
        format.json { render json: @log_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.json { render json: { log_task: @log_task } }
    end
  end

  def update
    respond_to do |format|
      if @log_task.update(log_task_params)
        format.html { redirect_to log_task_path, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @log_task }
      else
        format.html { redirect_to log_task_path, alert: @log_task.errors.full_messages.join(', ') }
        format.json { render json: @log_task.errors, status: :unprocessable_entity }
      end
    end
  end

  def log_list
    date = params[:date]
    log_tasks = current_user.log_tasks.where(date: date)

    log_list = log_tasks.map do |log|
      {
        id: log.id,
        task: {
          name: log.task.name,
          project: {
            name: log.task.project.name,
            code: log.task.project.code
          }
        },
        user: {
          username: log.user.username
        },
        notes: log.notes,
        timer: log.timer
      }
    end

    render json: { logList: log_list }
  end

  def log_task_by_id
    log_task = LogTask.find_by(id: params[:id])
  end

  def update_timer
    if @log_task.update(timer: params[:timer])
      render json: { message: "Timer updated successfully" }, status: :ok
    else
      render json: { errors: @log_task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_log_task
    @log_task = LogTask.find(params[:id])
  end

  def log_task_params
    params.require(:log_task).permit(:task_id, :date, :notes, :timer)
  end
end
