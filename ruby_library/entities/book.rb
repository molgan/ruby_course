class Book
    attr_reader :name, :author, :description

    def initialize(name, author, description='')
        valid?(name, author)
        @name = name
        @author = author
        @description = description
    end

    def to_s
        "Book { #{@name} by #{@author.name}. #{@description} }"
    end

    def ==(other)
        if other.is_a?(Book)
            @name == other.name && @author == other.author && @description == other.description
        end
    end

    private

    def valid?(name, author)
        case
        when name.length == 0
            raise ArgumentError, 'Unvalid name. Its length must be positive'
        when !author.is_a?(Author)
            raise TypeError, 'Unvalid author class. It must be Author'
        end
    end
end