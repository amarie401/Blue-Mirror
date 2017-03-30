class MoodListsController < ApplicationController
  # PATCH/PUT /mood_lists/1
  # PATCH/PUT /mood_lists/1.json
  def update
    set_mood_list

    if @mood_list.update(mood_list_params)
      render json: { location: @mood_list }
    else
      render json: @mood_list.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mood_list
    @mood_list = MoodList.find_by(user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mood_list_params
    params[:moods] = encrypt_param params[:moods]
    params.permit(:moods)
  end
end
