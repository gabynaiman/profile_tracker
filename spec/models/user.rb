class User

  attr_reader :first_name
  attr_reader :last_name

  def self.john_doe
    self.new 'John', 'Doe'
  end

  def full_name
    concatenate
  end

  private

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def concatenate
    "#{first_name} #{last_name}"
  end

end