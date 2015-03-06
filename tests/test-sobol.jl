function madsmodelrun(parameters::Dict) # Sobol Test
	f = 1
	i = 1
	for d in sort(collect(keys(parameters)))
		if( i > 2 )
			a = 3
		else
			a = 0
		end
		b = ( abs( 4.0 * ( parameters[d] + 0.5 ) - 2 ) + a ) / ( 1 + a );
		f = f * b
		i = i + 1
	end
	predictions = {"o1"=>f}
	return predictions
end
