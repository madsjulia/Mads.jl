#include <math.h>
#include <stdio.h>

double my_c_sqrt(double x)
{
    return sqrt(x);
}

double my_c_func1(long int n, double x)
{
	long int i;
	double r = 0;
	for(i = 0; i < n; i++)
		r += (i + 1) / x;
	return r;
}

int my_c_model1(long int n_x, double *x, long int n_o, double *o)
{
	long int i, j;
	for(j = 0; j < n_o; j++)
		o[j] = 0;
	for(i = 0; i < n_x; i++)
		for(j = 0; j < n_o; j++)
			o[j] += x[i] * (i + 1) / (j + 1);
	return 1;
}

int my_c_model2(long int n_x, double *x, double *M, long int n_o, double *o)
{
	long int i, j;
	/*
	for(j = 0; j < n_o; j++)
	{
		for(i = 0; i < n_x; i++)
			printf("%g ", M[j + i * n_o]);
		printf("\n");
	}
	*/
	for(j = 0; j < n_o; j++)
	{
		o[j] = 0;
		for(i = 0; i < n_x; i++)
			o[j] += M[j + i * n_o] * x[i];
	}
	/*
	for(j = 0; j < n_o; j++)
		printf("%g\n", o[j] );
	*/
	return 1;
}
