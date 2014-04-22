#encoding: utf-8

module BibtexGenerator
	
	extend ActiveSupport::Concern

	def generate_bibtex_string(references)
		bibtex_file = ""
		i = 0
		references.each do |reference|
			bibtex_file += generate_bibtex_for_reference(reference) + (i<(references.count-1) ? "\n\n" : "")
			i += 1
    	end
	return bibtex_file
	end
	
	private

	def generate_bibtex_for_reference(reference)
		bibtex_id = "@" + reference.ref_type + "{" + reference.name + ",\n"
		bibtex = ""
		i = 0
		reference.reference_attributes.each do |ref_att|
			bibtex += "\t" + ref_att.name + " = " + "{" + ref_att.value + "}"+ (i<(reference.reference_attributes.count-1) ? "," : "") + "\n"
			i += 1
		end
		bibtex += "}"
		bibtex = bibtex_id + replace_special_symbols_for_string(bibtex)
		return bibtex
	end
	
	# Handle special symbols
	
	def replace_special_symbols_for_string(s)
	    special_symbols = {'ä' => '\\"{a}', 'Ä' => '\\"{A}', 'ö'=> '\\"{o}', 'Ö' => '\\"{O}'}
	    special_symbols.each do |key, value|
				s = s.gsub(key, value)
	    end
	    return s
	end
	
end