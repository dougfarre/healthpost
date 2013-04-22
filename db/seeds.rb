# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# See http://railsapps.github.com/rails-environment-variables.html


puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

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


