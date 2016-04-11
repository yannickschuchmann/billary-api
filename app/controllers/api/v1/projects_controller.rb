class API::V1::ProjectsController < API::V1::ApiController
  before_action :set_project, only: [:show, :update, :destroy]

  def projects_url obj
    api_v1_projects_url obj
  end

  def project_url obj
    api_v1_project_url obj
  end

  # GET /projects
  def index
    if query_params[:top_level]
      @projects = current_user.projects.top_level
    else
      @projects = current_user.projects.all
    end

    render json: @projects, include: [("*." * 100)[0..-2]]
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :parent_id, :client_id)
    end

    def query_params
      params.permit(:top_level)
    end
end
