class CandidatesController < ApplicationController
  ##GET /candidates
  #
  def index
    @candidates = Candidate.paginate :page     => params[:page],
                                     :per_page => 20,
                                     :order    => 'last_name'
  end
  
  def update_index
    render :update do |page|
      page.replace 'candidate_records', :partial => 'records', :locals => { :position => params[:position] }
    end
  end
  
  def tally
    @candidates = Candidate.all
  end
  
  def update_tally
    render :update do |page|
      Candidate.positions[0..2].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :divsion  => 'national',
                        :position => position }
      end
      
      Candidate.positions[3..8].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position }
      end
    end
  end
  
  def choose_province
    municipality_list = MUNICIPALITY_LIST[params[:province]].sort

    render :update do |page|
      page.replace_html :municipality_tally_filter, :partial => 'municipality_list', :locals => { :list => municipality_list }
      page.replace_html :district_tally_filter, :partial => 'district_list',
        :locals => { :list => generate_district_list(params[:province], municipality_list.first[1]) }
      Candidate.positions[3..4].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]) }
      end
      Candidate.positions[5..7].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]),
                        :municipality => MUNICIPALITY_LIST[params[:province]].sort.first[0] }
      end
      Candidate.positions[8].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]),
                        :municipality => MUNICIPALITY_LIST[params[:province]].sort.first[0],
                        :district => 1 }
      end
    end
  end

  def choose_municipality
    district_list = generate_district_list(params[:province], params[:municipality])

    render :update do |page|
      Candidate.positions[5..7].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]),
                        :municipality => MUNICIPALITY_LIST[params[:province]].index(params[:municipality]) }
      end
      
      page.replace_html :district_tally_filter, :partial => 'district_list', :locals => { :list => district_list }
      
      Candidate.positions[8].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]),
                        :municipality => MUNICIPALITY_LIST[params[:province]].index(params[:municipality]),
                        :district => 1 }
      end
    end
  end
  
  def choose_district
    render :update do |page|
      Candidate.positions[8].each do |position|
        position = position.gsub(' ','').underscore
        page.replace "#{position}_tally".intern,
          :partial => 'tally_position',
          :locals  => { :division => 'local',
                        :position => position,
                        :province => PROVINCE_LIST.index(params[:province]),
                        :municipality => MUNICIPALITY_LIST[params[:province]].index(params[:municipality]),
                        :district => params[:district].last.to_i }
      end
    end
  end

  private
  def generate_district_list(province, municipality)
    district_code = "#{province}#{municipality}"
    district_count = DISTRICT_LIST[district_code] || 0
    district_list = {}

    case district_count
      when 0
        district_list["Provincial District"] = "#{province}1"
      when 1
        district_list["Lone District"] = "#{district_code}1"
      else
        district_list = {}
        1.upto district_count do |i|
          district_list["#{i.ordinalize} District"] = "#{district_code}#{i}"
        end
    end
    
    return district_list.sort
  end
end
