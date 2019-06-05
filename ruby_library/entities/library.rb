require_relative '../storage/storage'

class Library
    include Storage

    def initialize(authors=[], books=[], readers=[], orders=[])
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
        entities.flatten!
        entities.each do |entity|
            case entity
            when Author
                @authors.push(entity) unless @authors.include?(entity)
            when Book
                @books.push(entity) unless @books.include?(entity)
                @authors.push(entity.author) unless @authors.include?(entity.author)
            when Reader
                @readers.push(entity) unless @readers.include?(entity)
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
        h = load_yml(file)
        if h.is_a?(Hash) && h.keys == [:autors, :books, :readers, :orders]
            @authors = h[:authors]
            @books = h[:books]
            @readers = h[:readers]
            @orders = h[:orders]
        end
    end

    def top_book
        top_books(1).first
    end

    def top_books(n=3)
        top_entities(n, @books, :@book)
    end

    def top_readers(n=3)
        top_entities(n, @readers, :@reader)
    end

    def count_of_top_books_readers(n=3)
        books = top_books(n)
        readers = []
        @orders.each do |order|
            if books.include?(order.book) && !readers.include?(order.reader)
                readers.push(order.reader)
            end
        end
        readers.size
    end

    private

    def top_entities(n=3, entities, variable)
        return [] if entities.size == 0
        ratings = Hash.new(0)
        @orders.each { |order| ratings[entities.find_index(order.instance_variable_get(variable))] += 1 }
        ratings = ratings.to_a.sort_by { |item| [-item[1], entities[item[0]].name] }
        best_entities = []
        ([n, entities.size].min).times { |i| best_entities.push(entities[ratings.dig(i, 0)]) }
        best_entities
    end
end