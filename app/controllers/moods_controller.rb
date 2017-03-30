class MoodsController < ApplicationController
  # GET /moods
  # GET /moods.json
  def index
    days = params.fetch(:days, 7).to_i
    @moods = Mood.where('user_id = ? AND created_at > ?',
                        current_user, (DateTime.now - days)).order('created_at')

    formatted_moods = @moods.map { |mood| format_mood mood }

    render json: formatted_moods
  end

  # POST /moods
  # POST /moods.json
  def create
    params['user_id'] = current_user.id if current_user
    @mood = Mood.new(mood_params)

    if @mood.save
      render json: { location: format_mood(@mood) }, status: :created
    else
      render json: @mood.errors, status: :unprocessable_entity
    end
  end

  private

  def format_mood(mood)
    {
      id: mood.id,
      mood: mood.mood,
      day: get_day(mood.created_at + Time.now.utc_offset),
      time: get_time(mood.created_at + Time.now.utc_offset)
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_mood
    @mood = Mood.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mood_params
    max_mood = mood_list(current_user).length
    params['mood'] = max_mood if params['mood'] > max_mood

    params.permit(:mood, :user_id)
  end
end
