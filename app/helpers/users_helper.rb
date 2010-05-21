module UsersHelper
  def show_candidates(candidate, i)
      if i.%(3) == 1 then
        "<tr><td>#{radio_button_tag 'candid', @candidate}#{i}. #{candidate.full_name}</td>"
      elsif i.%(3) == 2 then
        "<td>#{radio_button_tag 'candid', @candidate}#{i}. #{candidate.full_name}</td>"
      elsif i.%(3) == 0 then
        "<td>#{radio_button_tag 'candid', @candidate}#{i}. #{candidate.full_name}</td></tr>"
      end
  end
end
