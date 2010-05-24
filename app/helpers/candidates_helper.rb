module CandidatesHelper
  def candidate_list(position, province, municipality, district)
    if province.empty? and municipality.empty? and district.empty?
      list = Candidate
    elsif municipality.empty? and district.empty?
      list = Candidate.by_province(province)
    elsif district.empty?
      list = Candidate.by_province_and_municipality(province, municipality)
    else
      list = Candidate.by_location(province, municipality, district)
    end
    
    return list.class_eval("for_#{position}")
  end

  def tally_bar(candidate)
    # FIXME
    tally_percentage = (candidate.num_votes / User.voted.count) rescue 1
    bar_width = tally_percentage*140
    %Q{
      <div class="tally_bar" style="width: #{bar_width}px">
        <em class="tally_count">#{tally_percentage}%</em>
      </div>
    }
  end
end
