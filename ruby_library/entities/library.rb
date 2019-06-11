# frozen_string_literal: true

# class Library
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
    "Library\n" \
      "Authors:\n\t#{@authors.join("\n\t")}\n" \
      "Books:\n\t#{@books.join("\n\t")}\n" \
      "Readers:\n\t#{@readers.join("\n\t")}\n" \
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
      when Book then @books.push(entity) unless @books.include?(entity)
      when Reader then @readers.push(entity) unless @readers.include?(entity)
      when Order then @orders.push(entity) if !@orders.include?(entity) && correct_order?(entity)
      end
    end
  end

  alias << add

  def save(file)
    save_yml(to_h, file)
  end

  def load(file)
    data = load_yml(file)
    return if !data.is_a?(Hash) || data.keys != %i[autors books readers orders]

    @authors = data[:authors]
    @books = data[:books]
    @readers = data[:readers]
    @orders = data[:orders]
  end

  def top_book
    top_books(1).first
  end

  def top_books(number = 3)
    grouped_orders = @orders.group_by(&:book)
    (grouped_orders.keys.sort_by { |key| -grouped_orders[key].length })[0, number]
  end

  def top_readers(number = 3)
    grouped_orders = @orders.group_by(&:reader)
    (grouped_orders.keys.sort_by { |key| -grouped_orders[key].length })[0, number]
  end

  def count_of_top_books_readers(number = 3)
    books = top_books(number)
    (@orders.map { |order| order.reader if books.include?(order.book) }).compact.uniq.size
  end

  private

  def correct_order?(order)
    @readers.include?(order.reader) && @books.include?(order.book)
  end
end
