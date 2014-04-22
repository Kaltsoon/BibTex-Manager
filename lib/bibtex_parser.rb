module BibtexParser

  def parse_bibtex_references(bibtex)
    bibtex = bibtex.gsub(/\s+/, " ")
    bibtex = replace_specal_symbols(bibtex)
    @bibtex_string = bibtex
    @current_index = 0
    references = []
    reference = next_reference
    while not(reference.nil?) do
      if reference.valid?
        references.push reference
      end
      reference = next_reference
    end
    return references
  end

  private

    def next_reference
      if is_end_of_input
        return nil
      end

      type = reference_type.downcase
      expect('{')
      id = reference_id
      expect(',')
      reference = Reference.new(name: id, ref_type: type)
      attributes = []
      key = ""
      value = ""
      while key != nil do
        key, value = attribute
        if reference.get_available_attributes.include? key
          reference.reference_attributes.push(ReferenceAttribute.new(name: key, value: value))
        end
      end
      expect('}')
      return reference
    end

    def reference_type
      expect('@')
      return next_word_until(['{'])
    end

    def reference_id()
      return next_word_until([','])
    end

    def attribute
      key = attribute_key
      if key.nil?
        return nil, nil;
      end
      expect('=')
      value = attribute_value
      expect(',')
      return key, value
    end

    def attribute_key
      skip_white_space
      if current_char == '}'
        return nil
      end
      return next_word_until(['=']).gsub(/\s+/, "")
    end

    def attribute_value
      braces = accept('{')
      value = "";
      if braces
        value = next_word_until(['}'])
        expect('}')
      else
        value = next_word_until([','])
      end
      return value;
    end

    def accept(string)
      skip_white_space
      bibtex_index = @current_index
      string_index = 0
      while string_index < string.length do
        if (@bibtex_string[bibtex_index] != string[string_index]) || bibtex_index > @bibtex_string.length
          return false
        end
        string_index += 1
        bibtex_index += 1
      end
      @current_index = bibtex_index
      return true
    end

    def expect(string)
      if accept(string)
        return true
      end
      raise("bibtex parser syntax error! Expected '" + string + "' at index: " + @current_index.to_s)
    end

    def current_char()
      return @bibtex_string[@current_index]
    end

    def next_char()
      if @current_index >= @bibtex_string.length
        return nil
      end
      @current_index += 1
      return current_char
    end

    def next_word_until(separators)
      skip_white_space
      word = ""
      while (not separators.include?(current_char)) && @current_index < @bibtex_string.length do
        word += current_char
        next_char
      end
      return word
    end

    def skip_white_space
      while current_char == " " && not(is_end_of_input)
        @current_index += 1
      end
    end

    def is_end_of_input
      return @current_index >= @bibtex_string.length - 1
    end

    def replace_specal_symbols(bibtex)
      special_symbols = {'\\"{a}' => 'ä', '\\"{A}' => 'Ä', '\\"{o}' => 'ö', '\\"{O}' => 'Ö'}
      special_symbols.each do |key, value|
        bibtex = bibtex.gsub(key, value)
      end
      return bibtex
    end
end