module BibtexParser

  def test1
    inproceedings = "@inproceedings{Singer:2003:SBN:1085714.1085771,
author = {Singer, Eric},
title = {Sonic Banana: A Novel Bend-sensor-based MIDI Controller},
booktitle = {Proceedings of the 2003 Conference on New Interfaces for Musical Expression},
series = {NIME '03},
year = {2003},
location = {Montreal, Quebec, Canada},
pages = {220--221},
numpages = {2},
url = {http://dl.acm.org/citation.cfm?id=1085714.1085771},
acmid = {1085771},
publisher = {National University of Singapore},
address = {Singapore, Singapore},
keywords = {MIDI, bend, controller, interactive, performance, sensors},
}"
    parse_bibtex_references inproceedings
  end

  def parse_bibtex_references(bibtex)
    bibtex = bibtex.gsub("\n", "") #poistetaan rivinvaihdot koska muuten hajoo
    #bibtex = bibtex.squish
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

  end

  private

    def current_char()
      return @bibtex_string[@current_index]
    end

    def next_char()
      if(@current_index >= @bibtex_string.length)
        return nil
      end
      @current_index += 1
      return current_char
    end

    #eats the string from bibtex_string and returns true if possible
    def accept(string)
      skip_white_space
      bibtex_index = @current_index
      string_index = 0
      while string_index < string.length do
        if((@bibtex_string[bibtex_index] != string[string_index]) || bibtex_index > @bibtex_string.length)
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

    #word seperated by white space
    def next_word
      skip_white_space
      return next_word_until([" ", "\n", "\t", "\r"])
    end

    def next_word_until(separators)
      word = ""
      while (not separators.include?(current_char)) && @current_index < @bibtex_string.length do
        word += current_char
        next_char
      end
      return word
    end

    def skip_white_space
      while(is_white_space(current_char) && @current_index < @bibtex_string.length)
        @current_index += 1
      end
    end

    def is_white_space(char)
      return char == " " || char == "\n" || char == "\r" || char == "\t"
    end

    def is_end_of_input
      skip_white_space
      return @current_index >= @bibtex_string.length - 1
    end

    def next_reference
      if is_end_of_input
        return nil
      end

      type = reference_type.downcase

      puts type



      expect('{')
      id = reference_id
      expect(',')
      reference = Reference.new(name: id, ref_type: type)
      attributes = []
      key = ""
      value = ""
      while key != nil do
        key, value = attribute
        if(reference.get_available_attributes.include? key)
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
      if current_char == '}'
        return nil
      end
      return next_word.downcase;
    end

    def attribute_value
      skip_white_space
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
end