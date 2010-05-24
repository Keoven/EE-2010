class CandidatesController < ApplicationController
  ##GET /candidates
  #
  def index
    filters = params.dup
    filters.delete("action")
    filters.delete("controller")
    
    @items = Candidate.filtered(filters) rescue Candidate.all
=begin
    if params[:position] && @filters.collect{|f| f[:scope]}.include?(params[:position])
      @items = Candidate.send(params[:position])
    else
      @items = Candidate.for_president
    end  
=end
    @candidates = @items.paginate :page     => params[:page],
                                    :per_page => 25,
                                    :order    => 'last_name'
    
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace 'candidate_records', :partial => 'records'
        end
      }
    end
  end
  
  def tally
    @candidates = Candidate.for_president.paginate :page     => params[:page],
                                    :per_page => 25,
                                    :order    => 'num_votes DESC'
  end
  
  def list_municipalities
    municipality_list = MUNICIPALITY_LIST[params[:province]].sort

    render :update do |page|
      page.replace_html :municipality_tally_filter, :partial => 'municipality_list', :locals => { :list => municipality_list }
      page.replace_html :district_tally_filter, :partial => 'district_list',
        :locals => { :list => generate_district_list(params[:province], municipality_list.first[1]) }
      page.replace_html :local_candidate_records, :partial => 'tally_position',
        :locals => { :prefix => 'local',
                     :list => [Candidate.for_governor.find_by_province( PROVINCE_LIST.index(params[:province]) )] }
    end
  end

  def list_districts
    district_list = generate_district_list(params[:province], params[:municipality])

    render :update do |page|
      page.replace_html :district_tally_filter, :partial => 'district_list', :locals => { :list => district_list }
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
