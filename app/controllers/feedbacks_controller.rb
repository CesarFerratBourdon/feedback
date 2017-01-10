# All feedback operations
class FeedbacksController < AuthorizedController
  authorize_resource
  before_filter :load_user

  def_param_group :auth_and_user_and_feedback do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user who owns the feedback', required: true
    param :feedback_id, String, desc: 'The feedback being referenced', required: true
  end

  def_param_group :auth_and_user do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user who owns the feedback', required: true
  end

  api :GET, '/users/:user_id/feedbacks', 'Lists all feedback for a user'
  formats ['json']
  param_group :auth_and_user
  example <<-EOT
  Response:
  [
    {
      "id": "c50f809b-1bda-447e-b216-ea246f44dc75",
      "user_id": "c756f7dc-632e-4ab5-904d-33f9f0a25b94",
      "rating": 5,
      "comment": "You did well",
      "created_at": "2015-12-11T01:14:32.816Z",
      "updated_at": "2015-12-11T01:14:32.816Z",
      "goal_id": null,
      "icon": "thumbs-up",
      "sender_id": "327592a3-04a0-4907-a174-588aa64abbba"
    },
    {
      "id": "6071355f-2940-44c5-9490-5f146da93014",
      "user_id": "c756f7dc-632e-4ab5-904d-33f9f0a25b94",
      "rating": 3,
      "comment": "Try harder",
      "created_at": "2015-12-11T01:17:43.378Z",
      "updated_at": "2015-12-11T01:17:43.378Z",
      "goal_id": null,
      "icon": "thumbs-up",
      "sender_id": "327592a3-04a0-4907-a174-588aa64abbba"
    }
  ]
  EOT
  def index
    @feedbacks = @user.feedbacks
    @feedbacks.mark_as_read! :all, for: current_user
  end

  def new
    @feedback = Feedback.new
  end

  api :POST, '/users/:user_id/feedbacks', 'Create a feedback'
  formats ['json']
  param_group :auth_and_user
  param :feedback, Hash do
    param :comment, String, desc: 'The feedback itself', required: true
    param :rating, Integer, desc: 'A rating of the user from 1-5'
    param :goal_id, String, desc: 'A goal id that this feedback references'
    param :icon, String, desc: 'A fontawesome icon to represent the feedback'
  end
  def create
    respond_to do |format|
      return false unless current_user_is_not_owner(format)

      @feedback = Feedback.new(feedback_params.merge(user_id: params[:user_id], sender_id: current_user.id))
      if @feedback.save
        format.html { redirect_to user_feedbacks_path(@user), notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created }
      else
        respond_to_validation_error(format: format, model: @feedback)
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @feedback.update(feedback_params)
  #       format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
  #       format.json { render json: @feedback }
  #     else
  #       respond_to_validation_error(format: format, model: @feedback)
  #     end
  #   end
  # end

  private

  def current_user_is_not_owner(format)
    if @user.id == current_user.id
      format.html { redirect_to :back, flash: { error: 'You can\'t write feedback for yourself' } }
      format.json { render json: { error: 'You can\'t write feedback for yourself' }, status: :bad_request }
      return false
    end
    true
  end

  def feedback_params
    params.require(:feedback).permit(:user_id, :rating, :comment, :goal_id, :icon)
  end
end
