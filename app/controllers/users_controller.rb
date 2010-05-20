class UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open

  ## ACTIONS
  #
  def home
  end
end

