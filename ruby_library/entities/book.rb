class Book
  attr_reader :name, :author, :description

  def initialize(name:, author:, description: '')
    valid_name?(name)
    valid_author?(author)
    @name = name
    @author = author
    @description = description
  end

  def to_s
    "Book { #{@name} by #{@author.name}. #{@description} }"
  end

  def ==(other)
    return unless other.is_a?(Book)
    @name == other.name && @author == other.author && @description == other.description
  end

  private

  def valid_name?(name)
    raise InvalidLengthError, 'positive' unless name.length > 0
  end

  def valid_author?(author)
    raise IncorrectClassError, Author unless author.is_a?(Author)
  end
end