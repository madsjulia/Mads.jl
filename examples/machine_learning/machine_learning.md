## Machine Learning

Unsupervised Machine Learning methods are powerful data-analytics tools capable of extracting important features hidden (latent) in large datasets without any prior information.
The physical interpretation of the extracted features is done *a posteriori* by subject-matter experts.

In contrast, supervised ML methods are trained based on large labeled datasets; the labeling is performed *a priori* by subject-matter experts.
The process of deep ML commonly includes both unsupervised and supervised techniques [LeCun, Bengio, and Hinton 2015](https://www.nature.com/articles/nature14539) where unsupervised ML are applied to facilitate the process of data labeling.

The integration of large datasets, powerful computational capabilities, and affordable data storage has resulted in the widespread use of Machine Learning in science, technology, and industry.

Recently we have developed a novel unsupervised Machine Learning methods.
The methods are based on Matrix/Tensor Factorization coupled with sparsity and nonnegativity constraints.
The method reveals the temporal and spatial footprints of the extracted features.

### Examples

* [Blind Source Separation (i.e. Feature Extraction)](../../Examples/blind_source_separation/index.html)
* [Contaminant Source Identification](../Examples/contaminant_source_identification/index.html)

### Tensor Factorization

A novel unsupervised ML based on Tensor Factorization (TF) coupled with sparsity and nonnegativity constraints has been applied to extract the temporal and spatial footprints of the features in multi-dimensional datasets in the form of multi-way arrays or tensors.
The factorization of a given tensor $X$ is typically performed by minimization of the Frobenius norm:

$$ { \frac{1}{2} ||X-G \otimes_1 A_1 \otimes_2 A_2 \dots \otimes_n A_n ||_F^2 } $$

where:

* $N$ is the dimensionality of the tensor X, G is a mixing “core” tensor
* $A_1,A_2,\dots,A_N$ are “feature” factors (in the form of vectors or matrices)
* $\otimes$ is a tensor product applied to fold-in factors $A_1,A_2,\dots,A_N$  in each of the tensor dimensions

The product $G \otimes_1 A_1 \otimes_2 A_2 \dots \otimes_n A_n$ is an estimate of $X$ ($X_est$).


