class InsposController < ApplicationController
  # GET /inspos
  # GET /inspos.json
  def index
    render json: get_featured('db/data/inspos.seed')
  end
end
