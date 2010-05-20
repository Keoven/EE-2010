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

  def format_address(address, options={})
    {:with_html => true}.merge!(options)

    district = DISTRICT_LIST[address[:district_code]]
    province = PROVINCE_LIST[address[:provincial_code]]
    municipality = MUNICIPALITY_LIST[province][address[:municipality_code]]

    %Q{ #{address[:street_number]} #{address[:street_name]} St.,
    #{content_tag :span, municipality, :title => "#{address[:municipality_code]}", :class => "address_code"},
    #{content_tag :span, province, :title => "#{address[:provincial_code]}", :class => "address_code"}
    }
  end
end

