class Patient
  # STATE
  # name => String
  # blood_type => String ['A', 'O', 'AB', etc.]
  # cured => Boolean [true, false]
  attr_accessor :id, :room # attr_reader + attr_writer
  attr_reader :name, :age, :blood_type, :cured

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @blood_type = attributes[:blood_type] || 'A'
    @cured = attributes[:status] || false
    @age = attributes[:age] || nil
  end
end
