module SAXMachine
  class SAXConfig
    
    class ElementConfig
      attr_reader :name, :setter
      
      def initialize(name, options)
        @name = name.to_s
        
        if options.has_key?(:with)
          # for faster comparisons later
          @with = options[:with].to_a.flatten.collect {|o| o.to_s}
        else
          @with = nil
        end
        
        if options.has_key?(:value)
          @value = options[:value].to_s
        else
          @value = nil
        end
        
        @as = options[:as]
        @collection = options[:collection]
        
        if @collection
          @setter = "add_#{options[:as]}"
        else
          @setter = "#{@as}="
        end
      end

      def value_from_attrs(attrs)
        attrs[attrs.index(@value) + 1] if attrs.index(@value)
      end
      
      def attrs_match?(attrs)
        if @with
          @with == (@with & attrs)
        else
          true
        end
      end
      
      def has_value_and_attrs_match?(attrs)
        !@value.nil? && attrs_match?(attrs)
      end
      
      def collection?
        @collection
      end
    end
    
  end
end