class Library
    require "yaml"

    def initialize(authors=[], books=[], readers=[], orders=[])
        @authors = []
        authors.each { |author| add_author(author) }
        @books = []
        books.each { |book| add_book(book) }
        @readers = []
        readers.each { |reader| add_reader(reader) }
        @orders = []
        orders.each { |order| add_order(order) }
    end

    def to_s
        def all_objects_in_str(objects)
            str = ""
            objects.each_with_index { |object, index| str << "#{index + 1}) #{object}\n" }
            str
        end
        all_authors = all_objects_in_str(@authors)
        all_books = all_objects_in_str(@books)
        all_readers = all_objects_in_str(@readers)
        all_orders = all_objects_in_str(@orders)
        "Library\nAuthors:\n#{all_authors}Books:\n#{all_books}Readers:\n#{all_readers}Orders:\n#{all_orders}"
    end

    def add_author(new_author)
        if new_author.is_a?(Author) && !@authors.include?(new_author)
            @authors.push(new_author)
        end
    end

    def add_book(new_book)
        if new_book.is_a?(Book) && !@books.include?(new_book)
            unless @authors.include?(new_book.author)
                @authors.push(new_book.author)
            end
            @books.push(new_book)
        end
    end

    def add_reader(new_reader)
        if new_reader.is_a?(Reader) && !@readers.include?(new_reader)
            @readers.push(new_reader)
        end
    end

    def add_order(new_order)
        if new_order.is_a?(Order) && !@orders.include?(new_order) && 
            @readers.include?(new_order.reader) && @books.include?(new_order.book)
            @orders.push(new_order)
        end
    end

    def add(new_object)
        if new_object.is_a?(Author)
            add_author(new_object)
        elsif new_object.is_a?(Book)
            add_book(new_object)
        elsif new_object.is_a?(Reader)
            add_reader(new_object)
        elsif new_object.is_a?(Order)
            add_order(new_object)
        end
    end

    alias + add

    def save(file)
        File.open(file, "w") do |f|
            f.write(@authors.to_yaml)
            f.write(@books.to_yaml)
            f.write(@readers.to_yaml)
            f.write(@orders.to_yaml)
        end
    end

    def load(file)
        return nil unless File.exist?(file)
        data = YAML::load_stream(File.open(file))
        @authors = data[0]
        @books = data[1]
        @readers = data[2]
        @orders = data[3]
        self
    end

    def the_most_popular_books(n=3)
        the_most_popular_objects(n, @books, :@book)
    end

    def the_most_popular_book
        best_books = the_most_popular_books(1)
        best_books[0] if best_books
    end

    def the_most_popular_readers(n=3)
        the_most_popular_objects(n, @readers, :@reader)
    end

    def count_of_readers_of_the_most_popular_books(n=3)
        best_books = the_most_popular_books(n)
        return 0 unless best_books
        readers_of_best_books = []
        @orders.each do |order|
            if best_books.include?(order.book) && !readers_of_best_books.include?(order.reader)
                readers_of_best_books.push(order.reader)
            end
        end
        readers_of_best_books.size
    end

    private

    def the_most_popular_objects(n=3, objects, variable)
        return nil if objects.size == 0
        ratings = Hash.new(0)
        @orders.each do |order|
            ratings[objects.find_index(order.instance_variable_get(variable))] += 1
        end
        ratings = ratings.to_a.sort_by { |item| [-item[1], objects[item[0]].name] }
        best_objects = []
        n = [n, objects.size].min
        n.times do |i|
            best_objects << objects[ratings.dig(i, 0)]
        end
        best_objects
    end
end