# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def generate_code(length=12)
    character_map = [*'a'..'z'] + [*0..9]
    code = String.new
    length.times do
      code << character_map.choice.to_s
    end
    return code
  end

  def format_name(user, options={})
    {:initial_first => false, :last_name_first => false}.merge!(options)

    first_name =
      (options[:initial_first] ? "#{user.first_name[0].chr}." : user.first_name)
    middle_name = user.middle_name unless user.middle_name.nil?
    middle_initial = "#{middle_name[0].chr}." unless middle_name.nil?
    last_name = user.last_name

    if options[:last_name_first]
      "#{last_name}, #{first_name} #{middle_name}"
    else
      "#{first_name} #{middle_initial} #{last_name}"
    end
  end
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
  def format_address(address, options={})
    {:with_html => true}.merge!(options)
 
    province = PROVINCE_LIST.index(address[:provincial_code])
    municipality = MUNICIPALITY_LIST[address[:provincial_code]].index(address[:municipality_code])
    district = address[:district_code] !~ /^#{address[:provincial_code]}\d$/ ? "#{address[:district_code].last.to_i.ordinalize} District" : nil

    str = "#{address[:street_number]} #{address[:street_name]}, "
    str << content_tag(:span, municipality, :title => address[:municipality_code], :class => 'address_code') << ", "
    str << content_tag(:span, province, :title => address[:provincial_code], :class => 'address_code')
    str << content_tag(:span, '(#{district})', :title => address[:district_code], :class => 'address_code') unless district.nil?
    
    return str
  end
end

