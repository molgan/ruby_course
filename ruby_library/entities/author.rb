class Author
    DEFAULT_NAME_RANGE = 3..15

    attr_reader :name, :year, :bio

    def initialize(name, year, bio='')
        valid?(name, year)
        @name = name
        @year = year
        @bio = bio
    end

    def to_s
        "Author { #{@name}, #{@year}. #{@bio} }"
    end

    def ==(other)
        if other.is_a?(Author)
            @name == other.name && @year == other.year && @bio == other.bio
        end
    end

    private

    def valid?(name, year)
        case
        when !DEFAULT_NAME_RANGE.include?(name.length)
            raise ArgumentError, "Unvalid name (#{name}). Its length must be in range #{DEFAULT_NAME_RANGE}"
        when !year.is_a?(Integer)
            raise TypeError, "Unvalid year class (#{year} is #{year.class}). It must be integer" 
        when year >= Time.new.year
            raise ArgumentError, "Unvalid year (#{year}). It must be less than #{Time.new.year}"
        end
    end
end