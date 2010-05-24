class UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open, :except => :election_closed
  before_filter :require_election_close, :except => :home

  ## ACTIONS
  #
  def home;            session[:action_accessed?] = true ; end
  def election_closed; session[:action_accessed?] = true ; end

  ## TODO:
  #  Temporary renders. The email sent should have a special code
  #  with it that would be confirmed when the user is about to vote.
  #

  def validate_for_activation
    session[:action_accessed?] = true
    @conditions = params[:conditions]
    raise 'InvalidValidationCall: Impossible to happen in normal usage.' unless @conditions.keys.sort == ['birth_date', 'email', 'voter_id']
    if User.exists?(@conditions)
      flash[:notice] = 'Voter exists!'
      render :text => 'Show a button to activate voter account and lock in fields. Also show button to reset fields.'
    else
      flash[:notice] = 'User not found!'
      render :text => 'The information inputted cannot be found in the registered voters list.'
    end
    rescue
      render :text => 'ConditionsNotSet: Impossible to happen in normal usage.'
  end

  def activate
    session[:action_accessed?] = true
    @user = User.find(:first, :conditions => params[:user])
    if @user.activated?
      flash[:notice] = 'User account already activated!'
      render :text => 'You have already activated your account, please check your email. Click here to send the link to the ballot form to your email again.'
    else
      @user.toggle!(:activated)
      key = generate_code
      PendingBallot.create(:ballot_key => key, :voter_id => @user.voter_id)
      flash[:notice] = 'User account activated!'
      render :text => 'Thank you. An email had been sent to your account that contains the link to your ballot form.'
    end
    rescue
      raise 'RecordNotFound: Impossible to happen in normal usage.'
  end

  def ballot
    session[:action_accessed?] = true
    @ballot = PendingBallot.find(:first, :conditions => { :ballot_key => params[:code] })
    redirect_to root_path if @ballot.nil?
  end

  def cast_ballot
    session[:action_accessed?] = true
    @user = User.find(:first, :conditions => { :voter_id => params[:voter_id] })
    unless @user.activated?
      redirect_to root_path
    else
      @ballot = params[:ballot]
      if @user.voted?
        flash[:notice] = 'User already voted!'
        render :text => 'You have already casted your vote.'
      else
        @ballot.each do |key, value|
          raise 'InvalidBallot: Impossible to happen in normal usage.' unless value.size <= APP_CONFIG['positions'][key]
          value.each do |id|
            Candidate.find(id).cast_vote(key, @user)
          end
        end
        @user.toggle!(:voted)
        PendingBallot.find(:first, :conditions => { :voter_id   => params[:voter_id],
                                                    :ballot_key => params[:code]      }).destroy
        flash[:notice] = 'Casting of ballot successful'
        render :text => 'Congratulations, you have successfully cast your ballot'
      end
    end
    rescue
      render :text => 'An error had occurred. Sorry for the inconvenience.'
  end
end

