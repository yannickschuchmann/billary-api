class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :update, :destroy]

  # GET /time_entries
  def index
    @time_entries = TimeEntry.all

    render json: @time_entries
  end

  # GET /time_entries/1
  def show
    render json: @time_entry
  end

  # GET /time_entries/current
  def current
    render json: TimeEntry.where(stopped_at: nil).first
  end

  # GET /time_entries/stop
  def stop
    @currentTimeEntry = TimeEntry.where(stopped_at: nil).first
    unless @currentTimeEntry.blank?
      @currentTimeEntry.stopped_at = Time.now
      @currentTimeEntry.save
      render json: @currentTimeEntry
    else
      render json: nil
    end
  end

  # POST /time_entries
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      render json: @time_entry, status: :created, location: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_entries/1
  def update
    if @time_entry.update(time_entry_params)
      render json: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_entries/1
  def destroy
    @time_entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      debugger
      @time_entry = TimeEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_entry_params
      params.require(:time_entry).permit(:project_id, :manual, :started_at, :stopped_at)
    end
end
