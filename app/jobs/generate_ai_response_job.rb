class GenerateAiResponseJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    ai_response = generate_ai_response(message.content)
    
    ai_message = User.find_or_create_by(email_address: 'system@ai.com').messages.create!(content: ai_response, ai_generated: true, role: 'assistant')
    
    Turbo::StreamsChannel.broadcast_append_to(
      "chat",
      target: "messages",
      partial: "chats/message",
      locals: { message: ai_message }
    )
  end

  private

  def generate_ai_response(user_message)
    anthropic_service = AnthropicService.new
    anthropic_service.generate_response(user_message)
  rescue StandardError => e
    Rails.logger.error("Error generating AI response: #{e.message}")
    "I'm sorry, but I couldn't generate a response at this time. Please try again later."
  end
end
