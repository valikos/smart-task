class AttachmentsController < ApplicationController
  def index
    attachments = current_user.tasks.find(params[:task_id]).attachments
    render json: attachments, status: :ok
  end

  def upload
    attachment = Attachment.new(task_id: params[:task_id])
    attachment.file = params[:file]
    attachment.name = params[:file].original_filename
    if attachment.save
      render json: attachment, status: :created
    else
      render json: attachment.errors, status: :unprocessable_entity
    end
  end
end
