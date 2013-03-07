module ProfileTracker
  class TextReport

    def initialize
      @lines = []
    end

    def text(text)
      @lines << text
    end

    def table(&block)
      table = Table.new
      block.call table
      text table.to_s
    end

    def to_s
      @lines.join "\n"
    end

    class Table

      def initialize()
        @columns = []
        @rows = []
      end

      def column(label, size)
        @columns << {label: label, size: size}
      end

      def row(*texts)
        @rows << texts
      end

      def to_s
        output = []

        line_size = @columns.inject(0) { |size, col| size + col[:size] + 2 }

        output << ('-' * line_size)

        output << @columns.inject(nil) do |out, col|
          text = col[:label][0..(col[:size] - 2)].ljust(col[:size])
          out ? "#{out}| #{text}" : " #{text} "
        end

        output << ('-' * line_size)

        @rows.each do |row|
          i = 0
          output << @columns.inject(nil) do |out, col|
            text = row[i][0..(col[:size] - 2)].ljust(col[:size])
            i += 1
            out ? "#{out}| #{text}" : " #{text} "
          end
        end

        output << ('-' * line_size)


        output.join "\n"
      end

    end

  end
end