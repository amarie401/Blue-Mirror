class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.where('user_id = ?', current_user)
    formatted_events = @events.map do |event|
      format_event event
    end

    render json: formatted_events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render json: format_event(@event)
  end

  # POST /events
  # POST /events.json
  def create
    params['user_id'] = current_user.id if current_user
    @event = Event.new(event_params)

    if @event.save
      render json: { location: format_event(@event) }, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.update(event_params)
      render json: { location: format_event(@event) }
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
  end

  private

  def format_event(event)
    {
      id: event.id,
      title: decrypt(event.title),
      start: (event.from + Time.now.utc_offset),
      frequency: event.frequency,
      completed: event.completed,
      user_id: event.user_id,
      allDay: false
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find_by_id(params[:id])
    @event = {} if different_user?(@event)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params[:title] = encrypt_param params[:title]
    params.permit(:title, :from, :frequency, :completed, :user_id)
  end
end
