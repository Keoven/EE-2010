require 'test_helper'

class CandidatesControllerTest < ActionController::TestCase
  ##Setup and Teardown
  #
  def setup
    @valid_candidate = candidates(:candidate_1)
  end

  def teardown
    Candidate.delete_all
  end
  
  test "filter candidates" do
    get :index
  end
end
