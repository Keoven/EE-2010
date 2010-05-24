class UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open , :except => :election_closed
  before_filter :require_election_close, :only => :election_closed
  layout 'home', :only => [:home, :election_closed]

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
    raise 'InvalidValidationCall: Impossible to happen in normal usage.' unless params[:user].keys.sort.eql? ['birth_date(1i)', 'birth_date(2i)', 'birth_date(3i)', 'email', 'voter_id']
    @conditions = {:email      => params[:user][:email],
                   :voter_id   => params[:user][:voter_id],
                   :birth_date => Date.civil( params[:user][:"birth_date(1i)"].to_i,
                                              params[:user][:"birth_date(2i)"].to_i,
                                              params[:user][:"birth_date(3i)"].to_i )}
    if User.exists?(@conditions)
      flash[:notice] = 'Voter exists!'
      render :text => '<span id="match-found">Voter match found.</span>'
    else
      flash[:notice] = 'User not found!'
      render :text => 'No matching voters found.', :status => 444
    end
    rescue
      render :text => 'ConditionsNotSet: Impossible to happen in normal usage.'
  end

  ## TODO
  #  Ability of user to send the activation link to his or her email again
  #

  def activate
    session[:action_accessed?] = true
    @conditions = {:email      => params[:user][:email],
                   :voter_id   => params[:user][:voter_id],
                   :birth_date => Date.civil( params[:user][:"birth_date(1i)"].to_i,
                                              params[:user][:"birth_date(2i)"].to_i,
                                              params[:user][:"birth_date(3i)"].to_i )}
    @user = User.find(:first, :conditions => @conditions)
    if @user.activated?
      flash[:notice] = 'User account already activated!'
      render :text => %Q{ You have already activated your account, please check your email. }
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
    @user = User.find(:first, :conditions => { :voter_id => @ballot.voter_id })
    @user_province = PROVINCE_LIST.index(@user.provincial_code)
    @user_municipality = MUNICIPALITY_LIST[@user.provincial_code].index(@user.municipality_code)
    @user_district = @user.district_code.last.to_i
  end

  def cast_ballot
    session[:action_accessed?] = true
    @user = User.find(:first, :conditions => { :voter_id => params[:voter_id] })
    unless @user.activated?
      redirect_to root_path
    else
      if @user.voted?
        flash[:notice] = 'User already voted!'
        render :text => 'You have already casted your vote.'
      else
        @ballot ||= {}
        params.each do |position, value|
          next unless Candidate::POSITIONS.include?(position)
          @ballot[position] ||= []
          if value.is_a?(String)
            @ballot[position] << value
          else
            value.each do |id, value|
              @ballot[position] << id if value == '1'
            end
          end
          raise 'InvalidBallot: Impossible to happen in normal usage.' unless @ballot[position].size <= APP_CONFIG['positions'][position]
        end

        @ballot.each do |key, value|
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

