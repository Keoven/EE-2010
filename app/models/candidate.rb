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
  
  ##Named scopes
  #
  POSITIONS.each do |position|
    named_scope "for_#{position.gsub(' ','').underscore}".intern,
      :conditions => {:position => position}
  end
  named_scope :top, lambda { |limit|
    { :limit => limit } unless limit.zero?
  }
  named_scope :by_ranking, :order => 'num_votes DESC, last_name'
  named_scope :by_province, lambda { |province|
    province = PROVINCE_LIST.index(province) unless province !~ /^[A-Z]{3}$/
    { :conditions => {:province => province} }
  }
  named_scope :by_municipality, lambda { |municipality|
    { :conditions => {:municipality => municipality} }
  }
  named_scope :by_district, lambda { |district|
    { :conditions => {:district => district} }
  }

  ##Class Methods
  #
  def self.levels
    LEVELS
  end

  def self.positions
    POSITIONS
  end
  def self.get_candidates(position, province, municipality, district)
    Candidate.find_all_by_position("#{position}",  :conditions => {:province => province, :municipality => municipality, :district => district} ,:order => "last_name")
  end


  ##Instance Methods
  #
  
  def full_name
    "#{last_name}, #{first_name} #{middle_name}"
  end

  def middle_initial
    middle_name.nil? ? "" : middle_name[0].chr
  end

  def cast_vote(position_voted, user)
    if self.position.eql? position_voted
      @user_province = PROVINCE_LIST.index(user.provincial_code)
      @user_municipality = MUNICIPALITY_LIST[user.provincial_code].index(user.municipality_code)
      @user_district = user.district_code.last.to_i
      case position_voted
        when *POSITIONS[0..2]
        	increment!(:num_votes)
        when *POSITIONS[3..4]
          increment!(:num_votes) if province == @user_province
        when *POSITIONS[5..7]
          increment!(:num_votes) if province     == @user_province     and
                                    municipality == @user_municipality
        when POSITIONS[8]
          increment!(:num_votes) if province     == @user_province     and
                                    municipality == @user_municipality and
                                    district     == @user_district
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
