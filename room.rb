require_relative 'patient'

class Room
  # STATE
  # vacancy => Boolean
  # capacity => Integer
  # room_no => String
  # patients => Array of Patient instance
  attr_accessor :id
  attr_reader :room_no, :capacity, :vacancy

  def initialize(attributes)
    @id = attributes[:id]
    @vacancy = attributes[:vacancy] || true
    @capacity = attributes[:capacity]
    @room_no = attributes[:room_no]
    @patients = []
  end

  def admit(patient)
    if @vacancy
      @patients << patient
      patient.room = self


      if @patients.length == @capacity
        @vacancy = false
      end
    else
      puts
      puts "We can't admit this patient anymore. We only have #{@capacity} beds"
    end
  end
end

# room_1 = Room.new({
#   room_no: 'Room #1',
#   capacity: 5
# })

# john = Patient.new(name: 'John')
# george = Patient.new(name: 'george')
# mary = Patient.new(name: 'mary')

# room_1.admit(john)
# room_1.admit(george)
# p room_1

# room_1.admit(mary)
















