# All goals operations
class GoalsController < AuthorizedController
  authorize_resource except: [:sign_off, :approve]
  before_filter :load_user
  before_filter :load_goal, only: [:sign_off, :approve, :show, :update]

  def_param_group :auth_and_user_and_goal do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user who owns the goal', required: true
    param :goal_id, String, desc: 'The goal being referenced', required: true
  end

  def_param_group :auth_and_user do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user who owns the goal', required: true
  end

  api :GET, '/users/:user_id/goals', 'Lists all goals for a user'
  formats ['json']
  param_group :auth_and_user
  example <<-EOT
  Response:
  {
    "in_progress": [],
     "completed": []
  }
  EOT
  def index
    @goals_not_signed_off = @user.goals.where('state != \'completed\'')
    @goals_signed_off = @user.goals.where(state: 'completed')
    @user.goals.mark_as_read! :all, for: current_user
  end

  api :GET, '/users/:user_id/goals', 'Show a specific goal'
  formats ['json']
  param_group :auth_and_user
  example <<-EOT
  Response:
  {
      "id": "61acf683-c23d-4f4b-ac5d-bb5cdc51e6be",
      "user_id": "c756f7dc-632e-4ab5-904d-33f9f0a25b94",
      "description": "Do well",
      "created_at": "2015-12-17T00:29:41.756Z",
      "updated_at": "2015-12-17T00:29:41.756Z",
      "self_evaluation": null,
      "manager_evaluation": null,
      "state": "new",
      "creator_id": "327592a3-04a0-4907-a174-588aa64abbba",
      "manager_eval_progress": null,
      "manager_eval_rating": null,
      "manager_eval_icon": null,
      "date": "2015-12-03"
  }
  EOT
  def show
    if @goal.user == current_user
      @evaluation_field = :self_evaluation
    elsif current_user.has_any_role?(:manager, :admin)
      @evaluation_field = :manager_evaluation
    else
      @evaluation_field = false
    end
    @goal_state_human_readable = goal_state_to_human_readable(@goal.state, @goal.user.id == @goal.creator)
  end

  def new
    @goal = Goal.new
  end

  api :POST, '/users/:user_id/goals/:goal_id/sign_off', 'Sign off on the final manager evaluation for a goal.  Marks a goal as completed.'
  formats ['json']
  param_group :auth_and_user_and_goal
  def sign_off
    authorize! :update, @goal
    respond_to do |format|
      if @goal.user == current_user
        @goal.state = 'completed'
        if @goal.save
          format.html { redirect_to dashboard_path, flash: { notice: 'Goal signed off' } }
          format.json { render json: @goal }
        else
          respond_to_validation_error(format: format, model: @goal)
        end
      else
        format.html { redirect_to :back, flash: { error: 'Only the goal owner can do the final sign off' } }
        format.json { render json: { error: 'Only the goal owner can do the final sign off' }, status: :bad_request }
      end
    end
  end

  api :POST, '/users/:user_id/goals/:goal_id/approve', 'Approve a new goal'
  formats ['json']
  param_group :auth_and_user_and_goal
  def approve
    authorize! :update, @goal
    respond_to do |format|
      if @goal.creator_id != current_user.id
        @goal.state = 'approved'
        if @goal.save
          format.html { redirect_to user_goal_path(current_user, @goal), flash: { notice: 'Goal approved' } }
          format.json { render json: @goal }
        else
          respond_to_validation_error(format: format, model: @goal)
        end
      else
        format.html { redirect_to :back, flash: { error: 'The goal creator can\'t approve their own goal' } }
        format.json { render json: { error: 'The goal creator can\'t approve their own goal' }, status: :bad_request }
      end
    end
  end

  api :POST, '/users/:user_id/goals', 'Create a goal'
  formats ['json']
  param_group :auth_and_user
  param :goal, Hash do
    param :description, String, desc: 'The goal description', required: true
    param :date, String, desc: 'A date for the goal in YYYY-MM-DD format', required: true
  end
  def create
    @goal = Goal.new(new_goal_params)
    respond_to do |format|
      if @goal.save
        format.html { redirect_to user_goals_path(@user), notice: 'Goal was successfully created.' }
        format.json { render json: @goal, status: :created }
      else
        respond_to_validation_error(format: format, model: @goal)
      end
    end
  end

  api :PUT, '/users/:user_id/goals/:goal_id', 'Update a goal'
  formats ['json']
  param_group :auth_and_user_and_goal
  param :goal, Hash do
    param :self_evaluation, String, desc: 'The goal\'s self evaluation'
    param :manager_evaluation, String, desc: 'The goal\'s manager evaluation'
    param :manager_eval_progress, ['0', '25', '50', '75', '100'], desc: 'The percentage of progress that has been made on this goal'
    param :manager_eval_rating, Integer, desc: 'A rating of the goal from 1-5'
    param :manager_eval_icon, String, desc: 'A fontawesome icon that represents the manager\'s evaluation'
  end
  def update
    respond_to do |format|
      if @goal.update(goal_params_with_new_state)
        format.html { redirect_to user_goal_path(@user, @goal), notice: 'Goal was successfully updated.' }
        format.json { render json: @goal }
      else
        respond_to_validation_error(format: format, model: @goal)
      end
    end
  end

  private

  def load_goal
    if params[:id]
      @goal = Goal.find(params[:id])
    else
      @goal = Goal.find(params[:goal_id])
    end
  end

  def goal_params
    params.require(:goal).permit(:user_id, :description, :date, :self_evaluation, :manager_evaluation, :manager_eval_progress, :manager_eval_icon, :manager_eval_rating)
  end

  def new_goal_params
    goal_params.merge(user_id: @user.id, creator_id: current_user.id)
  end

  def goal_params_with_new_state
    gp = goal_params
    if @goal.state == 'approved' && gp[:self_evaluation]
      gp[:state] = 'self_eval_completed'
    elsif @goal.state == 'self_eval_completed' && gp[:manager_evaluation]
      gp[:state] = 'manager_eval'
    end
    gp
  end

  def goal_state_to_human_readable(goal_state, goal_creator_is_goal_owner)
    # puts "Goal state: #{goal_state}"
    # Goal states (in order):
    # new - the one created already approved it; so missing one approver
    # approved - both approved the goal, and the employee has to write the self_eval
    # self_eval_completed - user has completed the self_eval, and manager has to write the manager_eval
    # manager_eval - employee has to approve the manager_eval
    # completed - both signed off on final evals

    state_map = {
      new: 'Employee must approve the goal',
      approved: 'Employee must write self evaluation',
      self_eval_completed: 'Manager must write their evaluation',
      manager_eval: 'Employee must approve the manager evaluation',
      completed: 'Completed and Signed Off'
    }
    state_map[:new] = 'Manager must approve the goal' if goal_creator_is_goal_owner

    state_map[goal_state.to_sym]
  end
end
