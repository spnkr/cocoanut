class Object
	def S(a,v)
		App::Persistence[a]=v
	end
	def G(a)
		App::Persistence[a]
	end
end