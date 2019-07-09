require 'csv'
require_relative 'patient'
require 'pry-byebug'

patients = []

csv_options = { headers: true, header_converters: :symbol }

CSV.foreach('patients.csv', csv_options) do |row|
  row[:id]    = row[:id].to_i          # Convert column to Integer
  row[:cured] = row[:cured] == "true"  # Convert column to boolean
  row[:age]   = row[:age].to_i == 0 ? nil : row[:age].to_i
  patients << Patient.new(row)
end

binding.pry
p patients
