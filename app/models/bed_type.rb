class BedType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :bed_preferences
  has_many :hospital_bed_availabilities

  def self.all_with_indicator(request)
    bed_types = BedType.all
    preferences = request.bed_preferences.map {|x| x.bed_type_id} 
  
    bed_types.each do |bed_type|
      bed_type.name << ' <prefered>' if preferences.include?(bed_type.id)        
    end
    
    return bed_types 
  end
end
