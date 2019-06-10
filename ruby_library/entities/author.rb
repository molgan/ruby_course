class Author
  DEFAULT_NAME_RANGE = 3..15

  attr_reader :name, :year, :bio

  def initialize(name:, year:, bio: '')
    valid_name?(name)
    valid_year?(year)
    @name = name
		@year = year
		@bio = bio
  end

  def to_s
    "Author { #{@name}, #{@year}. #{@bio} }"
  end

  def ==(other)
    return unless other.is_a?(Author)
    @name == other.name && @year == other.year && @bio == other.bio
  end

  private

  def valid_name?(name)
    raise InvalidLengthError, DEFAULT_NAME_RANGE unless DEFAULT_NAME_RANGE.include?(name.length)
  end

  def valid_year?(year)
    raise IncorrectClassError, Integer unless year.is_a?(Integer)
    raise InvalidValueError.new('year', "less than #{Time.new.year}") unless year < Time.new.year
	end
end