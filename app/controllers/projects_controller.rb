class ProjectsController < ApplicationController
  def show
  end

  def new
    @project = current_user.projects.new
    @project.tasks.build
  end

  def create
    @project = current_user.projects.create(project_params)
    @project.tasks.each do |task|
      task.user = current_user
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to new_project_path, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to new_project_path, alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def tasks
    project = Project.find(params[:id])
    tasks = project.tasks

    render json: { tasks: tasks }
  end

  private

  def project_params
    params.require(:project).permit(:name, :code, tasks_attributes: [:name, :user_id, :_destroy])
  end
end
