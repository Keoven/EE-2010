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

  def format_address(user, options={})
    {:with_html => true}.merge!(options)
    district = DISTRICT_LIST[user.district_code]
    province = PROVINCE_LIST[user.provincial_code]
    municipality = MUNICIPALITY_LIST[province][user.municipality_code]

    address = %Q{ #{user.street_number} #{user.street_name} St.,
    <span title="#{user.municipality_code}">#{municipality}</span>,
    <span title="#{user.provincial_code}">#{province}</span>
    }
  end
end
