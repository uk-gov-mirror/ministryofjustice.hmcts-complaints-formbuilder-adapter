class ComplaintController < ActionController::API
  def create
    render json: { placeholder: true }, status: 201
  end
end
