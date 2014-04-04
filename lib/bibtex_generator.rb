#encoding: utf-8

module BibtexGenerator
	extend ActiveSupport::Concern
	
	special_symbols = {'ä' => '\\"{a}', 'ö' => '\\"{o}'}
	
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
		bibtex = "@" + reference.ref_type + "{" + reference.name + ",\n"
		i = 0
		reference.reference_attributes.each do |ref_att|
			bibtex += "\t" + ref_att.name + " = " + "{" + ref_att.value + "}"+ (i<(reference.reference_attributes.count-1) ? "," : "") + "\n"
			i += 1
		end
		bibtex += "}"
		return bibtex
	end
	
	# Handle special symbols
	
	def handle_special_symbols(references)
		references.each do |reference|
			handle_skands_for_reference_attribute_values(reference)
		end
	end
	
	def handle_special_symbols_for_reference_attribute_values(reference)
		reference.reference_attributes.each do |ref_att|
			special_symbols_for_string(ref_att.value)
		end
	end
	
	def special_symbols_for_string(s)
		special_chars.each do |key, value|
			s.tr(key, value)
		end
	end
	
end