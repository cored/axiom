require 'veritas/relation/header'
require 'veritas/relation/materialized'
require 'veritas/relation/empty'

module Veritas
  class Relation
    include Enumerable, Optimizable

    attr_reader :header

    def self.new(*args)
      if args.size == 2 && args.last.respond_to?(:size) && self == Relation
        Materialized.new(*args)
      else
        super
      end
    end

    def initialize(header, tuples)
      @header, @tuples = Header.coerce(header), tuples
    end

    def [](name)
      header[name]
    end

    def each
      seen = {}
      tuples.each do |tuple|
        tuple = Tuple.coerce(header, tuple)
        yield(seen[tuple] = tuple) unless seen.key?(tuple)
      end
      self
    end

    def ==(other)
      other = coerce(other)
      header == other.header &&
      to_set == project_relation(other).to_set
    end

    def eql?(other)
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      to_set.eql?(project_relation(other).to_set)
    end

    def hash
      header.hash ^ to_set.hash
    end

    def empty?
      each { return false }
      true
    end

  private

    attr_reader :tuples

    def coerce(tuples)
      tuples.kind_of?(Relation) ? tuples : Relation.new(header, tuples)
    end

    def new_empty_relation
      Relation::Empty.new(header)
    end

  end # class Relation
end # module Veritas

require 'veritas/relation/operation'
