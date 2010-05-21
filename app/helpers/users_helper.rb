module UsersHelper
  def show_candidates(candidate, i, position)
    case i.%(3)
    when 1
        "<tr><td>#{radio_button_tag position, candidate}#{i}. #{candidate.full_name}</td>"
    when 2
        "<td>#{radio_button_tag position, candidate}#{i}. #{candidate.full_name}</td>"
    when 0
        "<td>#{radio_button_tag position, candidate}#{i}. #{candidate.full_name}</td></tr>"
    end
  end
  def show_multiple_candidates(candidate, i, position)
    case i.%(3)
    when 1
        "<tr><td>#{check_box position, candidate}#{i}. #{candidate.full_name}</td>"
    when 2
        "<td>#{check_box position, candidate}#{i}. #{candidate.full_name}</td>"
    when 0
        "<td>#{check_box position, candidate}#{i}. #{candidate.full_name}</td></tr>"
    end
  end
end
