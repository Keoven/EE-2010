# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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

    #district = DISTRICT_LIST[address[:district_code]]
    #province = PROVINCE_LIST[address[:provincial_code]]
    #municipality = MUNICIPALITY_LIST[province][address[:municipality_code]]
=begin
    %Q{ #{address[:street_number]} #{address[:street_name]} St.,
    #{content_tag :span, municipality, :title => "#{address[:municipality_code]}", :class => "address_code"},
    #{content_tag :span, province, :title => "#{address[:provincial_code]}", :class => "address_code"}
    }
=end
    "ADDRESS"
  end
=begin
  def update_select_box(target_dom_id, collection, options={})
    # Set the default options
    options[:text] ||= 'name'
    options[:value] ||= 'id'
    options[:clear] ||= []
    out = "update_select_options( $('#{ target_dom_id.to_s }'),"
    out << "#{(collection.collect{ |c| [c.send(options[:text]), c.send(options[:value])]}).to_json}" << ","
    out << "#{options[:clear].to_json} )"
=end
end

