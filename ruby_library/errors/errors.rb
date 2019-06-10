class IncorrectClassError < TypeError
  def initialize(correct_class)
    super("Incorrect class: argument must have class #{correct_class}")
  end
end

class InvalidLengthError < ArgumentError
  def initialize(valid_length)
    super("Invalid name length: it must be #{valid_length}")
  end
end

class InvalidValueError < ArgumentError
  def initialize(arg, valid_value)
    super("Invalid #{arg}: it must be #{valid_value}")
  end
end