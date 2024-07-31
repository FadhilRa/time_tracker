class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def new
    @project = current_user.projects.new
    @project.tasks.build
  end

  def create
    @project = current_user.projects.new(project_params)
    @project.tasks.each do |task|
      task.user = current_user
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { redirect_to projects_path(@project), alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render 'new'
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        @project.tasks.each do |task|
          task.update(user: current_user)
        end
        format.html { redirect_to projects_path(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { redirect_to projects_path(@project), alert: @project.errors.full_messages }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path(@project), notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tasks
    project = Project.find(params[:id])
    tasks = project.tasks

    render json: { tasks: tasks }
  end

  private

  def project_params
    params.require(:project).permit(:name, :code, tasks_attributes: [:id, :name, :user_id, :_destroy])
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end
end
