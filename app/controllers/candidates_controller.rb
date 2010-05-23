class CandidatesController < ApplicationController
  ##GET /candidates
  #
  def index
    filtered = Candidate
    
    case params[:filter]
      when 'President'
        filtered = Candidate.for_president
      when 'Vice President'
        filtered = Candidate.for_vice_president
      when 'Senator'
        filtered = Candidate.for_senator
      when 'Governor'
        filtered = Candidate.for_governor
      when 'Vice Governor'
        filtered = Candidate.for_vice_governor
      when 'Mayor'
        filtered = Candidate.for_mayor
      when 'Vice Mayor'
        filtered = Candidate.for_vice_mayor
      when 'Councilor'
        filtered = Candidate.for_councilor
      when 'Representative'
        filtered = Candidate.for_representative
    end
    
    @candidates = filtered.paginate :page     => params[:page],
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
end
