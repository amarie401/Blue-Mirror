class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  # GET /notes
  # GET /notes.json
  def index
    page = params.fetch 'page', 1
    per = params.fetch 'per_page', 10
    tag = encrypt_param(params.fetch('tag', ''))

    if tag.blank?
      @notes = Note.where('user_id = ?', current_user).order('created_at DESC')
                   .page(page).per(per)
    else
    @notes = Note.where('user_id = ? AND tags ILIKE ?',
                        current_user, "%#{tag}%").order('created_at DESC')
                 .page(page).per(per)
    end

    formatted_notes = @notes.map { |note| format_note note }
    render json: formatted_notes
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    render json: format_note(@note)
  end

  # POST /notes
  # POST /notes.json
  def create
    params['user_id'] = current_user.id if current_user
    @note = Note.new(note_params)

    if @note.save
      render json: { location: format_note(@note) }, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.update(note_params)
      render json: { location: format_note(@note) }
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
  end

  private

  def format_note(note)
    return {} if note.blank?

    {
      id: note.id,
      title: decrypt_property(note.title),
      text: decrypt_property(note.text),
      tags: decrypt_property(note.tags),
      day: get_day(note.created_at + Time.now.utc_offset),
      time: get_time(note.created_at + Time.now.utc_offset)
    }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find_by_id(params[:id])
    @note = {} if different_user?(@note)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params[:title] = encrypt_param params[:title]
    params[:text] = encrypt_param params[:text]
    params[:tags] = encrypt_param params[:tags]

    params.permit(:title, :text, :tags, :user_id)
  end
end
