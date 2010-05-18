class Candidate < ActiveRecord::Base
  LEVELS = %w(National Provincial City/Municipal District)
  POSITIONS = ['President', 'Vice President', 'Senator', 'Governor',
               'Vice Governor', 'Mayor', 'Vice Mayor', 'Councilor', 'Representative']

  validates_presence_of :first_name, :message => 'required'
  validates_presence_of :last_name, :message => 'required'
  validates_inclusion_of :level, :in => LEVELS, :message => 'not in list'
  validates_inclusion_of :position, :in => POSITIONS, :message => 'not in list'
  validate :votes_should_not_be_negative
  validate :level_and_position_should_match

  def self.levels
    LEVELS
  end

  def self.positions
    POSITIONS
  end

  private
  def votes_should_not_be_negative
    errors.add(:num_votes, :message => 'should not be negative') if self.num_votes < 0
  end

  def level_and_position_should_match
    case self.level
      when LEVELS[0]
        errors.add_to_base('Level and position do not match') unless POSITIONS[0..2].include?(self.position)
      when LEVELS[1]
        errors.add_to_base('Level and position do not match') unless POSITIONS[3..4].include?(self.position)
      when LEVELS[2]
        errors.add_to_base('Level and position do not match') unless POSITIONS[5..7].include?(self.position)
      when LEVELS[3]
        errors.add_to_base('Level and position do not match') unless self.position.eql?(POSITIONS[8])
    end
  end
end
