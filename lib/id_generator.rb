#encoding: utf-8

module IdGenerator
extend ActiveSupport::Concern
	
	def generate_id(attributes)
		if !enough_data_to_generate(attributes)
			return ""
		end
		return generate_id_string(attributes)
	end

	private
	
	def alphabet
		return ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
		"t", "u", "v", "w", "x", "y", "z"]
	end
	
	def enough_data_to_generate(attributes)
		if((attributes[:author].nil? && attributes[:editor].nil?) || attributes[:year].nil?)
			return false
		end
		return true
	end
	
	def generate_id_string(attributes)
		year = attributes[:year]
		name = get_begin_part(attributes)
		abc = generate_abc_end(name, year)
		return name + year + abc
	end
	
	# Begin part generation
	
	def get_begin_part(attributes)
		s = ""
		if !attributes[:author].nil?
			s = s + generate_name_part(attributes[:author])
		end
		if !attributes[:editor].nil?
			s = s + generate_name_part(attributes[:editor])
		end
		return s
	end
	
	def generate_name_part(s)
		name = ""
		parts = s.split(",")
		parts.each do |part|
			part = part.gsub(/\s+/,"")
			if(part.length >= 3)
				name = name + part[0,3].capitalize
			else
				name = name + part[0].capitalize
			end
		end
		return name
	end
	
	# ABC extension part generation
	
	def generate_abc_end(name, year)
		same_like = get_same_like(name, year)
		if same_like.count == 0
			return ""
		end
		return get_next_fix(longest_endfix(same_like))
	end
	
	def get_same_like(name, year)
		same_like = []
		start = name + year
		references = Reference.all
		references.each do |ref|
			if (ref.name =~ /#{start}/) == 0
				same_like.push(ref)
			end
		end
		return same_like
	end
	
	def get_next_fix(l_fix)
		if(l_fix.empty? || l_fix.length == 0)
			return alphabet[0]
		end
		last = l_fix[l_fix.length - 1].downcase
		if last == alphabet[alphabet.count - 1]
			return l_fix + alphabet[0]
		end
		return l_fix[0, l_fix.length - 1] + alphabet[alphabet.index(last) + 1]
	end
	
	def longest_endfix(same_like)
		l_fix = ""
		same_like.each do |r|
			fix = get_fix(r.name)
			l_fix = fix if compare(fix, l_fix)
		end
		return l_fix
	end
	
	def get_fix(name)
		fix = ""
		a = name.reverse!
		a.each_char do |c|
			if(digit?(c))
				break
			end
			fix = fix + c
		end
		return fix.reverse!
	end
	
	def digit?(char)
		if (char =~ /[[:digit:]]/).nil?
			return false
		end
		return true
	end
	
	def compare(fix1, fix2)
		if fix1.length == 0
			return false
		end
		if fix2.length == 0 || fix1.length > fix2.length || (fix1.length == fix2.length && alphabet.index(fix1[fix1.length - 1].downcase) > alphabet.index(fix2[fix2.length - 1].downcase))
			return true
		end
		return false
	end
end