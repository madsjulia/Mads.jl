abstract type Cat end

subtypes(Cat)

struct Lion <: Cat # Lion is a subtype of Cat
	mane_color
	roar::AbstractString
  end

struct Panther <: Cat # Panther is also a subtype of Cat
	eye_color
	Panther() = new("green")
	# Panthers will only have this constructor, and no default constructor.
end

function meow(animal::Tiger)
	"rawwwr"
  end

function meow(animal::Lion)
	animal.roar # access type properties using dot notation
  end

  function meow(animal::Panther)
	"grrr"
  end

  function meow(animal::Tiger)
	"rawwwr"
  end