# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# See http://railsapps.github.com/rails-environment-variables.html
#user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
#puts 'user: ' << user.name
#user.add_role :admin

puts 'DEFAULT TRANSFER CENTER'
transfer_center = TransferCenter.find_or_create_by_name :name => "MH Transfer Center" 
puts 'transfer_center: ' << transfer_center.name

puts "HOSPTIALS"
["MH The Woodlands", "MH Memorial City", "MH Sugar Land", "MH Katy"].each do |name|
  Hospital.find_or_create_by_name_and_transfer_center_id :name => name, :transfer_center_id => transfer_center.id
  puts 'hospital: ' << name
end

puts "PRACTICES"
practice = Practice.find_or_create_by_name :name => "MHMG The Woodlands", :transfer_center_id => transfer_center.id
puts 'pratice: ' << practice.name

puts "PROVIDERS"
["Amilcar Avendano, MD", "Gustavo A. Grieco, MD", "Hajin Lim, MD"].each do |name|
  Provider.find_or_create_by_name_and_practice_id :name => name, :practice_id => practice.id
  puts 'provider: ' << name
end

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email name: "Provider User", email: "provider@healthpost.com", password: "healthpost", 
                                    password_confirmation: "healthpost", practice_id: practice.id
user.add_role :provider
puts 'user: ' << user.name

user2 = User.find_or_create_by_email name: "Transfer Center User", email: "transfer_center@healthpost.com", 
                                     password: "healthpost", password_confirmation: "healthpost", :transfer_center_id => transfer_center.id 
user2.add_role :transfer_center
puts 'user: ' << user2.name

puts "DIAGNOSIS"
diagnoses = Array.new
["Inpatient", "Observation"].each do |name|
  diagnoses << Diagnosis.find_or_create_by_name(name)
end

puts "DIAGNOSIS DETAILS: " << diagnoses.first.name
["Floor", "Telemetry", "IMU", "ICU"].each do |name|
  DiagnosisDetail.find_or_create_by_name_and_diagnosis_id :name => name, :diagnosis_id => diagnoses.first.id
end

puts "DIAGNOSIS DETAILS: " << diagnoses.second.name
["Telemetry", "No Telemtry"].each do |name|
  DiagnosisDetail.find_or_create_by_name_and_diagnosis_id :name => name, :diagnosis_id => diagnoses.second.id
end

puts "BED TYPES"
["Private Room", "Shared Room", "Any"].each do |name|
  BedType.find_or_create_by_name :name => name
end


