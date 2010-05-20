require 'test_helper'

class CandidateTest < ActiveSupport::TestCase
  ##Setup and Teardown
  #
  def setup
    @valid_candidate = candidates(:candidate_1)
  end
  
  def teardown
    Candidate.delete_all
  end

  ## Columns
  #
  test "check columns" do
    assert @valid_candidate.first_name.is_a?(String)
    assert @valid_candidate.middle_name.is_a?(String)
    assert @valid_candidate.last_name.is_a?(String)
    assert @valid_candidate.position.is_a?(String)
    assert @valid_candidate.level.is_a?(String)
    assert @valid_candidate.province.is_a?(String)
    assert @valid_candidate.municipality.is_a?(String)
    assert @valid_candidate.district.is_a?(String)
    assert @valid_candidate.num_votes.is_a?(Integer)
  end

  ##Validations
  #
  test "should validate presence of first name" do
    @valid_candidate.first_name = nil
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors.on(:first_name)
  end

  test "should validate presence of last name" do
    @valid_candidate.last_name = nil
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors.on(:last_name)
  end

  test "should validate inclusion of position" do
    @valid_candidate.position = "Standing"
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors.on(:position)
  end

  test "should validate inclusion of level" do
    @valid_candidate.level = "Maximum"
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors.on(:level)
  end

  test "should validate non-negative votes" do
    @valid_candidate.num_votes = -88
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors.on(:num_votes)
  end

  test "level and position should match" do
    @valid_candidate.level = 'National'
    @valid_candidate.position = 'Representative'
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors
  end

  test "location should match level" do
    @valid_candidate.level = 'National'
    @valid_candidate.province = 'Provincia'
    @valid_candidate.municipality = 'Ciudad'
    @valid_candidate.district = 'Distrito'
    @valid_candidate.save

    assert_not_nil @valid_candidate.errors
  end

  test 'should cast vote on a candidate' do
  	## Valid Votes
  	#
  	
  	
  	## Invalid Votes
  	#
  	
    assert_difference('@valid_candidate.num_votes') do
      @valid_candidate.cast_vote('President', users(:one))
    end
  end

end

