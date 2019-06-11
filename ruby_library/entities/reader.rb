# frozen_string_literal: true

# class Reader
class Reader
  DEFAULT_MIN_AGE = 18
  DEFAULT_PHONE = /^\+[\d]*$/.freeze

  attr_reader :name, :age, :address, :phone, :email

  def initialize(name:, age:, address: '', phone: '', email: '')
    valid_name?(name)
    valid_age?(age)
    valid_phone?(phone)
    @name = name
    @age = age
    @address = address
    @phone = phone
    @email = email
  end

  def to_s
    "Reader { #{@name}, age: #{@age}, address: #{@address}, phone: #{@phone}, email: #{@email} }"
  end

  def ==(other)
    return unless other.is_a?(Reader)

    @name == other.name && @age == other.age && @address == other.address &&
      @phone == other.phone && @email == other.email
  end

  private

  def valid_name?(name)
    raise InvalidLengthError, 'positive' unless name.length.positive?
  end

  def valid_age?(age)
    raise IncorrectClassError, Integer unless age.is_a?(Integer)
    raise InvalidValueError.new('age', "at least #{DEFAULT_MIN_AGE}") unless age >= DEFAULT_MIN_AGE
  end

  def valid_phone?(phone)
    raise InvalidValueError.new('phone', 'started with + followed by digits') unless phone[DEFAULT_PHONE]
  end
end
