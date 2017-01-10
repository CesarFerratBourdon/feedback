# All operations for Replies
class RepliesController < ApplicationController
  authorize_resource
  skip_before_action :verify_authenticity_token, only: [:feedback_reply]
  before_action :load_user, except: [:feedback_reply]
  before_action :load_feedback

  def_param_group :auth_and_user_and_feedback do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user who owns the feedback', required: true
    param :feedback_id, String, desc: 'The feedback being referenced', required: true
  end

  def new
    @reply = Reply.new(user_id: @user.id, feedback_id: @feedback.id)
  end

  api :POST, '/users/:user_id/feedbacks/:feedback_id/replies', 'Create a reply to feedback'
  formats ['json']
  param_group :auth_and_user_and_feedback
  param :reply, Hash, required: true do
    param :content, String, desc: 'The reply itself', required: true
  end
  def create
    reply = Reply.new(create_reply_params.merge(user_id: current_user.id, feedback_id: @feedback.id))
    respond_to do |format|
      if reply.save
        format.html { redirect_to user_feedbacks_path(@user), flash: { notice: 'Reply created' } }
        format.json { render json: reply }
      else
        respond_to_validation_error(format: format, model: reply)
      end
    end
  end

  def feedback_reply
    # create reply
    reply = Reply.new(content: clean_up_reply_content, user_id: @eedback.user.id, feedback_id: @feedback.id)
    if reply.save
      render json: { succcess: true }
    else
      head 500
    end
  end

  private

  def load_feedback
    @feedback = Feedback.find(params[:feedback_id])
  end

  def clean_up_reply_content
    reply_content = params['stripped-text']
    # strip trailing dashes from signature from stripped-text
    if reply_content[reply_content.length - 2..reply_content.length] == '--'
      reply_content = reply_content[0..reply_content.length - 3]
    end
    # trim whitespace
    reply_content.strip
  end

  def create_reply_params
    params.require(:reply).permit(:content)
  end
end
