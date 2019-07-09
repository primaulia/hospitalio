require_relative 'room'
require 'csv'
require 'pry-byebug'
require_relative 'patient_repository'

class RoomRepository
  def initialize(file_path)
    @rooms = []
    @csv_file_path = file_path
    @next_id = 1
    load_csv
  end

  def all
    @rooms
  end

  def create_room(room)
    room.id = @next_id
    @rooms << room
    store_csv
  end

  private

  def load_csv
    csv_options = { headers: true, header_converters: :symbol }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]       = row[:id].to_i           # Convert column to Integer
      row[:capacity] = row[:capacity].to_i     # Convert column to Integer
      row[:vacancy]  = row[:vacancy] == 'true' # Convert column to Boolean
      @rooms << Room.new(row)
    end

    @next_id = @rooms.last.id + 1
  end

  def store_csv
    csv_options = { col_sep: ',' }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id','room_no','capacity','vacancy']
      @rooms.each do |room|
        # creating the row for my csv
        id = @next_id
        room_no = room.room_no
        capacity = room.capacity
        vacancy = room.vacancy

        csv << [id, room_no, capacity, vacancy]
      end
    end
  end
end

# creating the room for patient
room_repo = RoomRepository.new('rooms.csv')
new_room = Room.new(
  room_no: 'First Room',
  capacity: 2
)
# room_repo.create_room(new_room)

# creating the patient for the room
patient_repo = PatientRepository.new('patients.csv')
goerge = Patient.new(name: 'George')

# patient_repo.add_patient(goerge)

binding.pry

p room_repo.all
puts
p patient_repo.all






















