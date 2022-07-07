## Following [Naushad_TIP2017](https://in.mathworks.com/matlabcentral/fileexchange/62713-naushad_tip2017) from theis [paper](https://doi.org/10.1109/TIP.2017.2700719).


### Main Dependencies:
#### 1. [Sparco](https://github.com/MPF-Optimization-Laboratory/Sparco)

1. [Manuals: Sparco: A Testing Framework for Sparse Reconstruction](https://personal.math.ubc.ca/~oyilmaz/preprints/sparco.pdf)
2. [Blog: SPARCO
](https://friedlander.io/software/sparco/)

##### Sparco Dependencies:

1. [Rice Wavelet Toolbox](https://github.com/ricedsp/rwt)
2. [CurveLab](http://www.curvelet.org/)

##### Sparco Issues

1. Issues in `opWavelet2`
2. Not installed [fftw](https://www.fftw.org/) needed for calling `fdct_wrapping_mex` in `CurveLab`.


#### 2. [SPGL1](https://friedlander.io/spgl1/)

#### 3. [Spot – A Linear-Operator Toolbox](https://github.com/mpf/spot)

[A Quick Guide to Using Spot](https://www.cs.ubc.ca/labs/scl/spot/guide_quick2.html)_
