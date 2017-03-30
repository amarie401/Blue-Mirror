class MedsController < ApplicationController
  before_action :set_med, only: [:show, :update, :destroy]

  # GET /meds
  # GET /meds.json
  def index
    @meds = Med.where('user_id = ?', current_user)

    formatted_meds = @meds.map { |med| format_med med }

    render json: formatted_meds
  end

  # GET /meds/1
  # GET /meds/1.json
  def show
    render json: format_med(@med)
  end

  # POST /meds
  # POST /meds.json
  def create
    params['user_id'] = current_user.id if current_user
    @med = Med.new(med_params)

    if @med.save
      render json: { location: format_med(@med) }, status: :created
    else
      render json: @med.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meds/1
  # PATCH/PUT /meds/1.json
  def update
    if @med.update(med_params)
      render json: { status: :ok, location: format_med(@med) }
    else
      render json: @med.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meds/1
  # DELETE /meds/1.json
  def destroy
    @med.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_med
    @med = Med.find_by_id(params[:id])
    @med = {} if different_user?(@med)
  end

  def format_med(med)
    {
      id: med.id,
      name: decrypt_property(med.name),
      user_id: med.user_id
    }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def med_params
    params[:name] = encrypt_param params[:name]
    params.permit(:name, :user_id)
  end
end
