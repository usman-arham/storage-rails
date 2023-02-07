class V1::BlobsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def upsert
      blob = Blob.find_or_initialize_by(id: params[:id])
      blob.update!(data: params[:data])
      render json: '{"success": "data saved"}'
  end

  def show
    # blob =  Blob.find(params[:id])
    render json: Blob.find(params[:id]).as_json(methods: :data)
  end

  
  private

  def not_found
    render json: '{"error": "not_found"}', status: :not_found
  end

end
