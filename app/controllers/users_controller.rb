class UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open

  ## ACTIONS
  #
  def home; end

  ## TODO:
  #  Temporary renders. The email sent should have a special code
  #  with it that would be confirmed when the user is about to vote.
  #

<<<<<<< HEAD
    if @user.save
      session[:save] = @user.id
      redirect_to admin_user_path(@user) 
=======
  def validate_for_activation
    if User.exists?(params[:conditions])
      render :text => 'The information you inputted cannot be found in the registered voters list.'
>>>>>>> d2acdc4eb0f6da3fe0fa710d6d93c991455d0f11
    else
      render :text => 'Show a button to activate voter account'
    end
  end

<<<<<<< HEAD
  ##GET /users/:id
  #
  def show
    @user = User.find(params[:id])
  end
  
  ##PUT /users/:id
  #
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_user_path(@user)
=======
  def activate
    @user = User.find(:first, :conditions => params[:user])
    if @user.activated?
      render :text => 'You have already activated your account, please check your email. Click here to send the link to the ballot form to your email again.'
>>>>>>> d2acdc4eb0f6da3fe0fa710d6d93c991455d0f11
    else
      render :text => 'Thank you. An email had been sent to your account that contains the link to your ballot form.'
    end
  end

  def show_ballot
    redirect_to home_path unless PendingBallot.exists?(params[:code])
  end

  def cast_ballot
    @ballot = params[:ballot]
    @ballot.each do |key, value|
      raise 'InvalidBallot: Impossible to happen in normal usage.' unless value.count == APP_CONFIG['positions'][key]
      value.each do |id|
        Candidate.find(id).cast_vote
      end
    end
  end
end

