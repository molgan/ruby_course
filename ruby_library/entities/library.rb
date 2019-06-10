class Library
  include Storage

  def initialize(authors: [], books: [], readers: [], orders: [])
    @authors = []
    @books = []
    @readers = []
    @orders = []
    add(authors, books, readers, orders)
  end

  def to_s
    "Library\n" + 
    "Authors:\n\t#{@authors.join("\n\t")}\n" + 
    "Books:\n\t#{@books.join("\n\t")}\n" +
    "Readers:\n\t#{@readers.join("\n\t")}\n" + 
    "Orders:\n\t#{@orders.join("\n\t")}\n"
  end

  def to_h
    {
      authors: @authors,
      books: @books,
      readers: @readers,
      orders: @orders
    }
  end

  def add(*entities)
    entities.flatten.each do |entity|
      case entity
      when Author then @authors.push(entity) unless @authors.include?(entity)
      when Book
        @books.push(entity) unless @books.include?(entity)
        @authors.push(entity.author) unless @authors.include?(entity.author)
      when Reader then @readers.push(entity) unless @readers.include?(entity)
      when Order
        if !@orders.include?(entity) && @readers.include?(entity.reader) && @books.include?(entity.book)
          @orders.push(entity)
        end
      end
    end
  end

  alias + add

  def save(file)
    save_yml(to_h, file)
  end

  def load(file)
    data = load_yml(file)
    if data.is_a?(Hash) && data.keys == [:autors, :books, :readers, :orders]
      @authors = data[:authors]
      @books = data[:books]
      @readers = data[:readers]
      @orders = data[:orders]
    end
  end

  def top_book
    top_books(1).first
  end

  def top_books(number = 3)
    top_entities(number, :@book)
  end

  def top_readers(number = 3)
    top_entities(number, :@reader)
  end

  def count_of_top_books_readers(number = 3)
    books = top_books(number)
    (@orders.map { |order| order.reader if books.include?(order.book) }).compact.uniq.size
  end

  private

  def top_entities(number = 3, entity)
    grouped_entities = @orders.group_by { |order| order.instance_variable_get(entity) }
    (grouped_entities.keys.sort_by{ |key| -grouped_entities[key].length})[0, number]
  end
end