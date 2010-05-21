class Candidate < ActiveRecord::Base
  ##Constants
  #
  LEVELS = %w(National Provincial City/Municipal District)
  POSITIONS = ['President'    , 'Vice President', 'Senator'   , 'Governor' ,
               'Vice Governor', 'Mayor'         , 'Vice Mayor', 'Councilor', 'Representative']

  ##Validations
  #
  validates_presence_of :first_name, :message => 'required'
  validates_presence_of :last_name, :message => 'required'
  validates_inclusion_of :level, :in => LEVELS, :message => 'not in list'
  validates_inclusion_of :position, :in => POSITIONS, :message => 'not in list'
  validate :votes_should_not_be_negative
  validate :level_and_position_should_match
  validate :location_should_match_level

  ##Class Methods
  #
  def self.levels
    LEVELS
  end

  def self.positions
    POSITIONS
  end

  ##Instance Methods
  #

  def cast_vote(position_voted, user)
    if self.position.eql? position_voted
      @user_province = PROVINCE_LIST.index(user.provincial_code)
      @user_municipality = MUNICIPALITY_LIST[user.provincial_code].index(user.municipality_code)
      @user_district = user.district_code.last.to_i
      case position_voted
        when *POSITIONS[0..2]
        	update_attribute(:num_votes, num_votes + 1)
        when *POSITIONS[3..4]
          update_attribute(:num_votes, num_votes + 1) if self.province     == @user_province
        when *POSITIONS[5..7]
          update_attribute(:num_votes, num_votes + 1) if self.province     == @user_province     and
                                                         self.municipality == @user_municipality
        when POSITIONS[8]
          update_attribute(:num_votes, num_votes + 1) if self.province     == @user_province     and
                                                         self.municipality == @user_municipality and
                                                         self.district     == @user_district
      end
    end
  end

  private
  def votes_should_not_be_negative
    errors.add(:num_votes, :message => 'should not be negative') if self.num_votes < 0
  end

  def level_and_position_should_match
    case self.level
      when LEVELS[0]
        errors.add_to_base("Position not on the #{LEVELS[0]} level") unless POSITIONS[0..2].include?(self.position)
      when LEVELS[1]
        errors.add_to_base("Position not on the #{LEVELS[1]} level") unless POSITIONS[3..4].include?(self.position)
      when LEVELS[2]
        errors.add_to_base("Position not on the #{LEVELS[2]} level") unless POSITIONS[5..7].include?(self.position)
      when LEVELS[3]
        errors.add_to_base("Position not on the #{LEVELS[3]} level") unless self.position.eql?(POSITIONS[8])
    end
  end

  def location_should_match_level
    case self.level
      when LEVELS[0]
        errors.add_to_base('Province, city/municipality and district must not be set') unless (self.province.nil? and self.municipality.nil? and self.district.nil?)
      when LEVELS[1]
        errors.add_to_base('Province must be set') if self.province.nil?
        errors.add_to_base('City/municipality and district must not be set') unless (self.municipality.nil? and self.district.nil?)
      when LEVELS[2]
        errors.add_to_base('City/municipality must be set') if self.municipality.nil?
        errors.add_to_base('District must not be set') unless self.district.nil?
      when LEVELS[3]
        errors.add_to_base('District must be set') if self.district.nil?
    end
  end
end

