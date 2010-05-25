module CandidatesHelper
  def candidate_list(list, position, province, municipality, district, for_tally=false)
    limit = 5
    case position
      when /president$/
        limit = 0
      when /senator/
        limit = 15
    end
    
    list = position.nil? ? Candidate.all : Candidate.class_eval("for_#{position}")
    case position
      when /governor$/
        list = list.by_province(province)
      when /mayor$/, /councilor/
        list = list.by_province(province).by_municipality(municipality)
      when /representative/
        list = list.by_province(province).by_municipality(municipality).by_district(district)
    end
    
    if for_tally
      return list.top(limit).by_ranking
    else
      return list
    end
  end
  
  def candidate_list_heading(position, province, municipality, district)
    heading = position.titleize << " "
    
    case position
      when /^governor$/
        heading << content_tag(:span, province.titleize) unless province.nil?
      when /^mayor$/
        heading << content_tag(:span, municipality.titleize) unless municipality.nil?
      when /representative/
        heading << content_tag(:span, "#{district.ordinalize.titleize} District") unless district.nil?
      else
        heading.chop!
    end
    
    return heading
  end

  def tally_bar(candidate)
    group = Candidate.class_eval("for_#{position.gsub(' ','').underscore}")
    group = group.by_province(candidate.province) if Candidate.positions[3..8].include? position
    group = group.by_municipality(candidate.municipality) if Candidate.positions[5..8].include? position
    group = group.by_district(candidate.district) if Candidate.positions[8].eql? position
    total_votes = group.sum(:num_votes)
    tally_percentage = total_votes.zero? ? 0 : (candidate.num_votes.to_f / total_votes.to_f)*100
    bar_width = "#{tally_percentage.to_i}%"
    %Q{
      <div class="tally_bar" style="width: #{bar_width}">
        <em class="tally_count">#{number_to_percentage tally_percentage, :precision => 2}</em>
      </div>
    }
  end
end
