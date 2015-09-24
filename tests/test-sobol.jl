using DataStructures

function madsmodelrun(parameters::Associative) # Sobol Test
	f = 1
	i = 1
	for d in sort(collect(keys(parameters))) # TODO fix parameter order; sort use here is funny
		a = ( i > 2 ) ? 3 : 0
		b = ( abs( 4.0 * ( parameters[d] + 0.5 ) - 2 ) + a ) / ( 1 + a );
		f = f * b
		i = i + 1
	end
	predictions = DataStructures.OrderedDict(zip(["of"], [f]))
	return predictions
end
