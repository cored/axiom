module Veritas
  class Relation
    module Operation
      module Binary
        include Veritas::Operation::Binary

        def self.included(descendant)
          descendant.extend ClassMethods
          self
        end

        def initialize(left, right)
          super
          @header     = left.header     | right.header
          @directions = left.directions | right.directions
        end

        module ClassMethods
          def new(left, right)
            assert_ordered_match(left, right)
            super
          end

        private

          def assert_ordered_match(left, right)
            if left.directions.empty? != right.directions.empty?
              raise RelationMismatchError, 'both relations must be ordered or neither may be ordered'
            end
          end

        end # module ClassMethods
      end # module Binary
    end # module Operation
  end # class Relation
end # module Veritas
