# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a sorted relation
      class Order < Relation
        include Unary
        include Equalizer.new(:operand, :directions)

        # The relation sort order
        #
        # @return [Operation::Order::DirectionSet]
        #
        # @api private
        attr_reader :directions

        # Instantiate a new Order
        #
        # @example
        #   order = Order.new(operand, directions)
        #
        # @param [Relation] operand
        #   the relation to sort
        # @param [DirectionSet, Header, Array<Direction, Attribute>] directions
        #   the directions to sort tuples in
        #
        # @return [Order]
        #
        # @api public
        def self.new(operand, directions)
          header     = operand.header
          directions = DirectionSet.coerce(directions) do |direction|
            header[direction] unless direction.kind_of?(Direction)
          end
          directions |= header - directions.attributes
          super
        end

        # Initialize an Order
        #
        # @param [Relation] operand
        #   the relation to sort
        # @param [DirectionSet, Array<Direction, Attribute>] directions
        #   the directions to sort tuples in
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, directions)
          super(operand)
          @directions = directions
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   order = Order.new(operand, directions)
        #   order.each { |tuple| ... }
        #
        # @yield [tuple]
        #
        # @yieldparam [Tuple] tuple
        #   each tuple in the set
        #
        # @return [self]
        #
        # @api public
        def each
          return to_enum unless block_given?
          directions.sort_tuples(operand).each { |tuple| yield tuple }
          self
        end

        # Insert a relation into the Order
        #
        # @example
        #   new_relation = order.insert(other)
        #
        # @param [Relation] other
        #
        # @return [Order]
        #
        # @api public
        def insert(other)
          assert_matching_directions(other, INSERTED)
          operand.insert(other.operand).sort_by(directions)
        end

        # Delete a relation from the Order
        #
        # @example
        #   new_relation = order.delete(other)
        #
        # @param [Relation] other
        #
        # @return [Order]
        #
        # @api public
        def delete(other)
          assert_matching_directions(other, DELETED)
          operand.delete(other.operand).sort_by(directions)
        end

      private

        # Assert that the other relation has matching directions
        #
        # @param [Relation] other
        #
        # @param [String] event
        #
        # @return [undefined]
        #
        # @raise [OrderMismatchError]
        #   raised when inserting a relation does not have matching directions
        #
        # @api private
        def assert_matching_directions(other, event)
          unless other.kind_of?(self.class) && directions.eql?(other.directions)
            fail OrderMismatchError, "other relation must have matching directions to be #{event}"
          end
        end

        module Methods

          # Return an ordered relation
          #
          # @example with a block
          #   order = relation.sort_by { |r| [r.a.desc, r.b] }
          #
          # @example with directions
          #   order = relation.sort_by(directions)
          #
          # @param [Array] args
          #   optional arguments
          #
          # @yield [relation]
          #   optional block to evaluate for directions
          #
          # @yieldparam [Relation] relation
          #
          # @yieldreturn [DirectionSet, Array<Direction>, Header]
          #
          # @return [Order]
          #
          # @api public
          def sort_by(*args, &block)
            Order.new(self, coerce_to_directions(*args, &block))
          end

          # Return an ordered relation
          #
          # @example
          #   order = relation.sort
          #
          # @return [Order]
          #
          # @api public
          def sort
            Order.new(self, EMPTY_ARRAY)
          end

        private

          # Coerce the arguments and block into directions
          #
          # @param [DirectionSet, Array<Direction>, Header] directions
          #   optional directions
          #
          # @yield [relation]
          #   optional block to evaluate for directions
          #
          # @yieldparam [Relation] relation
          #
          # @yieldreturn [DirectionSet, Array<Direction>, Header]
          #
          # @return [DirectionSet, Array<Direction>, Header]
          #
          # @api private
          def coerce_to_directions(directions = Undefined, &block)
            if directions.equal?(Undefined)
              header.context(&block).yield
            else
              directions
            end
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Axiom
