class Author
    attr_reader :name, :year, :bio

    def initialize(name, year, bio="")
        raise "Wrong name class. It must be String" unless name.is_a?(String)
        raise "Wrong year class. It must be Integer" unless year.is_a?(Integer)
        raise "Wrong bio class. It must be String" unless bio.is_a?(String)
        raise "Wrong author name #{name}. Its size must be from 3 to 15" if name.size < 3 || name.size > 15
        raise "Wrong author year #{year}. It must be less than #{Time.new.year}" if year >= Time.new.year
        @name = name
        @year = year
        @bio = bio
    end

    def to_s
        "author: #{@name}, year: #{@year}, bio: #{@bio}"
    end

    def ==(other)
        if other.is_a?(Author)
            @name == other.name && @year == other.year && @bio == other.bio
        else
            false
        end
    end
end