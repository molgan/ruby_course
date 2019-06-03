class Book
    attr_reader :name, :author, :description

    def initialize(name, author, description="")
        raise "Wrong name class. It must be String" unless name.is_a?(String)
        raise "Wrong author class. It must be Author" unless author.is_a?(Author)
        raise "Wrong description class. It must be String" unless description.is_a?(String)
        raise "Wrong book name. Its size must be positive" unless name.length > 0
        @name = name
        @author = author
        @description = description
    end

    def to_s
        "book: #{@name}, author: #{@author.name}, description: #{@description}"
    end

    def ==(other)
        if other.is_a?(Book)
            @name == other.name && @author == other.author && @description == other.description
        else
            false
        end
    end
end