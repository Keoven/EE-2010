module Admin::UsersHelper
  def generate_id(length=12)
    codes = [*'a'..'z'] + [*0..9]
    id = ''
    length.times do
      id << codes.choice.to_s
    end
    return id
  end
  
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
