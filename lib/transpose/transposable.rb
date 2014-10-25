module Transpose
  module Transposable
    extend ::ActiveSupport::Concern

    included do
      class_attribute :transposers

      self.transposers = {}
    end

    module ClassMethods
      def transposer(klass, attribute_map = {})
        self.transposers[klass] = attribute_map
      end
    end

    def transpose(klass)
      transposition_instance = klass.is_a?(String) ? klass.constantize.new : klass.new

      raise ::Transpose::Errors::TransposerNotFound unless self.class.transposers.has_key?(transposition_instance.class.name)

      result = self.class.transposers[klass.to_s].inject(transposition_instance) do |transposition, hash_pair|
        transposition.__send__("#{hash_pair[1]}=", self.__send__(hash_pair[0]))
        transposition
      end

      result
    end
    alias :transpose_to :transpose
    alias :transpose_into :transpose

    def transpose_instance(transposition_instance)
      raise ::Transpose::TransposerNotFound unless self.class.transposers.has_key?(transposition_instance.class.name)

      result = self.class.transposers[transposition_instance.class.name].inject(transposition_instance) do |transposition, hash_pair|
        transposition.__send__("#{hash_pair[1]}=", self.__send__(hash_pair[0]))
        transposition
      end

      result
    end
    alias :transpose_to_instance :transpose_instance
    alias :transpose_with_instance :transpose_instance
  end
end
