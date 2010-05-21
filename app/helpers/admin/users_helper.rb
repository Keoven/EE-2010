module Admin::UsersHelper
  def generate_district_list(province, municipality)
    district_code = "#{province}#{municipality}"
    district_count = DISTRICT_LIST[district_code] || 1
    district_list = {}

    case district_count
      when 1
        district_list["Lone District"] = 1
      else
        district_list = {}
        1.upto district_count do |i|
          district_list["#{i.ordinalize} District"] = "#{district_code}#{i}"
        end
    end

    district_list.sort
  end
end

