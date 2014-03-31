module BibtexGenerator
	extend ActiveSupport::Concern

	def generate_bibtex_string(references)
		bibtex_file = ""
		references.each do |reference|
			bibtex_file += generate_bibtex_for_reference(reference) + "\n"
		end
		return bibtex_file
	end
	
	def generate_bibtex_for_reference(reference)
		bibtex = "@" + reference.ref_type + "{" + reference.name + ",\n"
		i = 0
		reference.reference_attributes.each do |ref_att|
			bibtex += ref_att.name + " = " + "{" + ref_att.value + "}"+ (i<(reference.reference_attributes.count-1) ? "," : "") + "\n"
			i += 1
		end
		bibtex += "}"
		return bibtex
	end

end