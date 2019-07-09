require_relative 'patient'
require 'csv'
require 'pry-byebug'

class PatientRepository
  def initialize(file_path)
    @patients = []
    @csv_file_path = file_path
    @next_id = 1
    load_csv
  end

  def all
    @patients
  end

  def add_patient(patient) # patient => patient instance
    patient.id = @next_id
    @patients << patient
    store_csv
  end

  private

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]    = row[:id].to_i          # Convert column to Integer
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      row[:age]   = row[:age].to_i == 0 ? nil : row[:age].to_i
      @patients << Patient.new(row)
    end

    @next_id = @patients.last.id + 1
  end

  def store_csv
    csv_options = { col_sep: ',' }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id','name','blood_type','cured','age']
      @patients.each do |patient|
        # creating the row for my csv
        id = @next_id
        name = patient.name
        blood_type = patient.blood_type
        cured = patient.cured
        age = patient.age

        csv << [id, name, blood_type, cured, age]
      end
    end
  end
end

repo = PatientRepository.new('patients.csv')
goerge = Patient.new(name: 'George')

# repo.add_patient(goerge)

# p repo.all























