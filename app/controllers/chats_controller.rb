class ChatsController < ApplicationController
    layout 'chat'
  
    def index
      @messages = Message.order(:created_at).includes(:user)
      @message = Message.new
    end 
  
    def create
      @message = Current.user.messages.create(content: params[:content], role: 'user')
  
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('messages', partial: 'chats/message', locals: { message: @message })
        end
      end
  
      GenerateAiResponseJob.perform_later(@message.id)
    end
  end
  