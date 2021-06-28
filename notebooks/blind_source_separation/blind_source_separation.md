# Blind Source Separation


```julia
import Mads
```

    ┌ Info: Precompiling Mads [d6bdc55b-bd94-5012-933c-1f73fc2ee992]
    └ @ Base loading.jl:1317


    [1mMads: Model Analysis & Decision Support[0m
    ====
    
    [1m[34m    ___      ____    [1m[31m        ____   [1m[32m ____         [1m[35m     ______[0m
    [1m[34m   /   \    /    \  [1m[31m        /    | [1m[32m |    \     [1m[35m       /  __  \[0m
    [1m[34m  |     \  /     |   [1m[31m      /     |  [1m[32m|     \     [1m[35m     /  /  \__\[0m
    [1m[34m  |  |\  \/  /|  | [1m[31m       /      | [1m[32m |      \   [1m[35m     |  |[0m
    [1m[34m  |  | \    / |  |  [1m[31m     /  /|   | [1m[32m |   |\  \   [1m[35m     \  \______.[0m
    [1m[34m  |  |  \__/  |  |  [1m[31m    /  / |   | [1m[32m |   | \  \  [1m[35m      \_______  \[0m
    [1m[34m  |  |        |  | [1m[31m    /  /  |   | [1m[32m |   |  \  \  [1m[35m             \  \[0m
    [1m[34m  |  |        |  |  [1m[31m  /  /===|   | [1m[32m |   |___\  \ [1m[35m   __.        |  |[0m
    [1m[34m  |  |        |  | [1m[31m  /  /    |   | [1m[32m |           \  [1m[35m \  \______/  /[0m
    [1m[34m  |__|        |__| [1m[31m /__/     |___| [1m[32m |____________\ [1m[35m  \__________/[0m
    
    [1mMADS[0m is an integrated high-performance computational framework for data- and model-based analyses.
    [1mMADS[0m can perform: Sensitivity Analysis, Parameter Estimation, Model Inversion and Calibration, Uncertainty Quantification, Model Selection and Model Averaging, Model Reduction and Surrogate Modeling, Machine Learning, Decision Analysis and Support.


    [32m[1m    Updating[22m[39m registry at `~/.julia/registries/General`
    [33m[1m┌ [22m[39m[33m[1mWarning: [22m[39mcould not download https://pkg.julialang.org/registries
    [33m[1m└ [22m[39m[90m@ Pkg.Types /Users/julia/buildbot/worker/package_macos64/build/usr/share/julia/stdlib/v1.6/Pkg/src/Types.jl:980[39m
    [32m[1m   Resolving[22m[39m package versions...
    [36m[1m[ [22m[39m[36m[1mInfo: [22m[39mModule BIGUQ is not available!
    ┌ Info: Installing pyqt package to avoid buggy tkagg backend.
    └ @ PyPlot /Users/vvv/.julia/packages/PyPlot/XHEG0/src/init.jl:118



```julia
import NMF
```


```julia
import Random
Random.seed!(2015)
nk = 3
s1 = (sin.(0.05:0.05:5) .+1) ./ 2
s2 = (sin.(0.3:0.3:30) .+ 1) ./ 2
s3 = rand(100);
```

## Source matrix (assumed unknown)


```julia
S = [s1 s2 s3]
```




    100×3 Matrix{Float64}:
     0.52499      0.64776     0.518466
     0.549917     0.782321    0.249446
     0.574719     0.891663    0.244758
     0.599335     0.96602     0.304535
     0.623702     0.998747    0.0407869
     0.64776      0.986924    0.258012
     0.671449     0.931605    0.0868265
     0.694709     0.837732    0.882364
     0.717483     0.71369     0.850562
     0.739713     0.57056     0.216851
     0.761344     0.421127    0.333606
     0.782321     0.27874     0.285782
     0.802593     0.156117    0.889261
     ⋮                        
     0.0171135    0.999997    0.577248
     0.0112349    0.978188    0.956294
     0.00657807   0.913664    0.62366
     0.0031545    0.812189    0.914383
     0.000972781  0.682826    0.578899
     3.83712e-5   0.537133    0.515968
     0.000353606  0.388122    0.415338
     0.0019177    0.249105    0.961519
     0.00472673   0.1325      0.795982
     0.00877369   0.0487227   0.73677
     0.0140485    0.00525646  0.653462
     0.0205379    0.00598419  0.607898




```julia
Mads.plotseries(S; title="Original sources", name="Source", quiet=true)
```




<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="141.42mm" height="100mm" viewBox="0 0 141.42 100"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="img-e062a7da">
<defs>
  <marker id="arrow" markerWidth="15" markerHeight="7" refX="5" refY="3.5" orient="auto" markerUnits="strokeWidth">
    <path d="M0,0 L15,3.5 L0,7 z" stroke="context-stroke" fill="context-stroke"/>
  </marker>
</defs>
<g class="plotroot xscalable yscalable" id="img-e062a7da-1">
  <g class="guide xlabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-e062a7da-2">
    <g transform="translate(-144.38,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-150</text>
      </g>
    </g>
    <g transform="translate(-91.36,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-38.34,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(14.67,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(67.69,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(173.73,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(226.74,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(279.76,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">250</text>
      </g>
    </g>
    <g transform="translate(-91.36,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-80.76,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-70.15,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-59.55,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-48.95,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-38.34,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-27.74,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-17.14,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-6.53,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(4.07,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(14.67,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(25.28,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(35.88,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(46.48,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(57.09,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(67.69,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(78.29,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(88.9,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(99.5,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(110.11,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(131.31,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(141.92,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(152.52,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(163.12,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(173.73,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(184.33,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(194.93,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(205.54,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(216.14,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(226.74,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-91.36,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(14.67,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(226.74,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-91.36,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-86.06,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-95</text>
      </g>
    </g>
    <g transform="translate(-80.76,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-75.46,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-85</text>
      </g>
    </g>
    <g transform="translate(-70.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-64.85,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-75</text>
      </g>
    </g>
    <g transform="translate(-59.55,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-54.25,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-65</text>
      </g>
    </g>
    <g transform="translate(-48.95,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-43.64,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-55</text>
      </g>
    </g>
    <g transform="translate(-38.34,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-33.04,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-45</text>
      </g>
    </g>
    <g transform="translate(-27.74,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-22.44,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-35</text>
      </g>
    </g>
    <g transform="translate(-17.14,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-11.83,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-25</text>
      </g>
    </g>
    <g transform="translate(-6.53,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(-1.23,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-15</text>
      </g>
    </g>
    <g transform="translate(4.07,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(9.37,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-5</text>
      </g>
    </g>
    <g transform="translate(14.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(19.98,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">5</text>
      </g>
    </g>
    <g transform="translate(25.28,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(30.58,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">15</text>
      </g>
    </g>
    <g transform="translate(35.88,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(41.18,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">25</text>
      </g>
    </g>
    <g transform="translate(46.48,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(51.79,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">35</text>
      </g>
    </g>
    <g transform="translate(57.09,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(62.39,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">45</text>
      </g>
    </g>
    <g transform="translate(67.69,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(72.99,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">55</text>
      </g>
    </g>
    <g transform="translate(78.29,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(83.6,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">65</text>
      </g>
    </g>
    <g transform="translate(88.9,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(94.2,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">75</text>
      </g>
    </g>
    <g transform="translate(99.5,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(104.8,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">85</text>
      </g>
    </g>
    <g transform="translate(110.11,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(115.41,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">95</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(126.01,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">105</text>
      </g>
    </g>
    <g transform="translate(131.31,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(136.61,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">115</text>
      </g>
    </g>
    <g transform="translate(141.92,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(147.22,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">125</text>
      </g>
    </g>
    <g transform="translate(152.52,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(157.82,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">135</text>
      </g>
    </g>
    <g transform="translate(163.12,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(168.42,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">145</text>
      </g>
    </g>
    <g transform="translate(173.73,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(179.03,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">155</text>
      </g>
    </g>
    <g transform="translate(184.33,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(189.63,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">165</text>
      </g>
    </g>
    <g transform="translate(194.93,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(200.23,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">175</text>
      </g>
    </g>
    <g transform="translate(205.54,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(210.84,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">185</text>
      </g>
    </g>
    <g transform="translate(216.14,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(221.44,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">195</text>
      </g>
    </g>
    <g transform="translate(226.74,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
  </g>
  <g class="guide colorkey" id="img-e062a7da-3">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-e062a7da-4">
      <g transform="translate(126.75,48.45)" id="img-e062a7da-5">
        <g class="primitive">
          <text dy="0.35em">Source 1</text>
        </g>
      </g>
      <g transform="translate(126.75,51.5)" id="img-e062a7da-6">
        <g class="primitive">
          <text dy="0.35em">Source 2</text>
        </g>
      </g>
      <g transform="translate(126.75,54.54)" id="img-e062a7da-7">
        <g class="primitive">
          <text dy="0.35em">Source 3</text>
        </g>
      </g>
    </g>
    <g stroke-width="0" id="img-e062a7da-8">
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#008000" id="img-e062a7da-9">
        <g transform="translate(124.23,54.54)" id="img-e062a7da-10">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#0000FF" id="img-e062a7da-11">
        <g transform="translate(124.23,51.5)" id="img-e062a7da-12">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FF0000" id="img-e062a7da-13">
        <g transform="translate(124.23,48.45)" id="img-e062a7da-14">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-e062a7da-15">
      <g transform="translate(123.71,45.43)" id="img-e062a7da-16">
        <g class="primitive">
          <text dy="-0em"></text>
        </g>
      </g>
    </g>
  </g>
  <g clip-path="url(#img-e062a7da-17)">
    <g id="img-e062a7da-18">
      <g pointer-events="visible" stroke-width="0.3" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-e062a7da-19">
        <g transform="translate(67.69,50.75)" id="img-e062a7da-20">
          <path d="M-55.02,-39.18 L55.02,-39.18 55.02,39.18 -55.02,39.18  z" class="primitive"/>
        </g>
      </g>
      <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-e062a7da-21">
        <g transform="translate(67.69,199.47)" id="img-e062a7da-22" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,162.29)" id="img-e062a7da-23" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,125.11)" id="img-e062a7da-24" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,87.93)" id="img-e062a7da-25" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-26" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,13.56)" id="img-e062a7da-27" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-23.62)" id="img-e062a7da-28" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-60.8)" id="img-e062a7da-29" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-97.98)" id="img-e062a7da-30" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,162.29)" id="img-e062a7da-31" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,154.85)" id="img-e062a7da-32" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,147.42)" id="img-e062a7da-33" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,139.98)" id="img-e062a7da-34" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,132.54)" id="img-e062a7da-35" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,125.11)" id="img-e062a7da-36" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,117.67)" id="img-e062a7da-37" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,110.24)" id="img-e062a7da-38" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,102.8)" id="img-e062a7da-39" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,95.36)" id="img-e062a7da-40" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,87.93)" id="img-e062a7da-41" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,80.49)" id="img-e062a7da-42" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,73.05)" id="img-e062a7da-43" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,65.62)" id="img-e062a7da-44" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,58.18)" id="img-e062a7da-45" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-46" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,43.31)" id="img-e062a7da-47" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,35.87)" id="img-e062a7da-48" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,28.44)" id="img-e062a7da-49" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,21)" id="img-e062a7da-50" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,13.56)" id="img-e062a7da-51" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,6.13)" id="img-e062a7da-52" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-1.31)" id="img-e062a7da-53" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-8.75)" id="img-e062a7da-54" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-16.18)" id="img-e062a7da-55" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-23.62)" id="img-e062a7da-56" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-31.05)" id="img-e062a7da-57" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-38.49)" id="img-e062a7da-58" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-45.93)" id="img-e062a7da-59" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-53.36)" id="img-e062a7da-60" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-60.8)" id="img-e062a7da-61" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,162.29)" id="img-e062a7da-62" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,87.93)" id="img-e062a7da-63" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,13.56)" id="img-e062a7da-64" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-60.8)" id="img-e062a7da-65" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,162.29)" id="img-e062a7da-66" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,158.57)" id="img-e062a7da-67" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,154.85)" id="img-e062a7da-68" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,151.14)" id="img-e062a7da-69" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,147.42)" id="img-e062a7da-70" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,143.7)" id="img-e062a7da-71" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,139.98)" id="img-e062a7da-72" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,136.26)" id="img-e062a7da-73" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,132.54)" id="img-e062a7da-74" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,128.83)" id="img-e062a7da-75" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,125.11)" id="img-e062a7da-76" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,121.39)" id="img-e062a7da-77" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,117.67)" id="img-e062a7da-78" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,113.95)" id="img-e062a7da-79" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,110.24)" id="img-e062a7da-80" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,106.52)" id="img-e062a7da-81" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,102.8)" id="img-e062a7da-82" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,99.08)" id="img-e062a7da-83" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,95.36)" id="img-e062a7da-84" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,91.64)" id="img-e062a7da-85" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,87.93)" id="img-e062a7da-86" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,84.21)" id="img-e062a7da-87" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,80.49)" id="img-e062a7da-88" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,76.77)" id="img-e062a7da-89" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,73.05)" id="img-e062a7da-90" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,69.34)" id="img-e062a7da-91" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,65.62)" id="img-e062a7da-92" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,61.9)" id="img-e062a7da-93" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,58.18)" id="img-e062a7da-94" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,54.46)" id="img-e062a7da-95" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-96" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,47.03)" id="img-e062a7da-97" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,43.31)" id="img-e062a7da-98" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,39.59)" id="img-e062a7da-99" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,35.87)" id="img-e062a7da-100" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,32.15)" id="img-e062a7da-101" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,28.44)" id="img-e062a7da-102" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,24.72)" id="img-e062a7da-103" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,21)" id="img-e062a7da-104" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,17.28)" id="img-e062a7da-105" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,13.56)" id="img-e062a7da-106" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,9.85)" id="img-e062a7da-107" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,6.13)" id="img-e062a7da-108" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,2.41)" id="img-e062a7da-109" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-1.31)" id="img-e062a7da-110" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-5.03)" id="img-e062a7da-111" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-8.75)" id="img-e062a7da-112" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-12.46)" id="img-e062a7da-113" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-16.18)" id="img-e062a7da-114" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-19.9)" id="img-e062a7da-115" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-23.62)" id="img-e062a7da-116" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-27.34)" id="img-e062a7da-117" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-31.05)" id="img-e062a7da-118" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-34.77)" id="img-e062a7da-119" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-38.49)" id="img-e062a7da-120" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-42.21)" id="img-e062a7da-121" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-45.93)" id="img-e062a7da-122" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-49.65)" id="img-e062a7da-123" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-53.36)" id="img-e062a7da-124" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-57.08)" id="img-e062a7da-125" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
        <g transform="translate(67.69,-60.8)" id="img-e062a7da-126" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-55.02,0 L55.02,0 " class="primitive"/>
        </g>
      </g>
      <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-e062a7da-127">
        <g transform="translate(-144.38,50.75)" id="img-e062a7da-128" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-91.36,50.75)" id="img-e062a7da-129" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-38.34,50.75)" id="img-e062a7da-130" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(14.67,50.75)" id="img-e062a7da-131" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-132" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.75)" id="img-e062a7da-133" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(173.73,50.75)" id="img-e062a7da-134" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(226.74,50.75)" id="img-e062a7da-135" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(279.76,50.75)" id="img-e062a7da-136" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-91.36,50.75)" id="img-e062a7da-137" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-80.76,50.75)" id="img-e062a7da-138" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-70.15,50.75)" id="img-e062a7da-139" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-59.55,50.75)" id="img-e062a7da-140" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-48.95,50.75)" id="img-e062a7da-141" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-38.34,50.75)" id="img-e062a7da-142" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-27.74,50.75)" id="img-e062a7da-143" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-17.14,50.75)" id="img-e062a7da-144" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-6.53,50.75)" id="img-e062a7da-145" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(4.07,50.75)" id="img-e062a7da-146" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(14.67,50.75)" id="img-e062a7da-147" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(25.28,50.75)" id="img-e062a7da-148" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(35.88,50.75)" id="img-e062a7da-149" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(46.48,50.75)" id="img-e062a7da-150" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(57.09,50.75)" id="img-e062a7da-151" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-152" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(78.29,50.75)" id="img-e062a7da-153" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(88.9,50.75)" id="img-e062a7da-154" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(99.5,50.75)" id="img-e062a7da-155" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(110.11,50.75)" id="img-e062a7da-156" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.75)" id="img-e062a7da-157" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(131.31,50.75)" id="img-e062a7da-158" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(141.92,50.75)" id="img-e062a7da-159" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(152.52,50.75)" id="img-e062a7da-160" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(163.12,50.75)" id="img-e062a7da-161" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(173.73,50.75)" id="img-e062a7da-162" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(184.33,50.75)" id="img-e062a7da-163" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(194.93,50.75)" id="img-e062a7da-164" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(205.54,50.75)" id="img-e062a7da-165" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(216.14,50.75)" id="img-e062a7da-166" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(226.74,50.75)" id="img-e062a7da-167" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-91.36,50.75)" id="img-e062a7da-168" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(14.67,50.75)" id="img-e062a7da-169" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.75)" id="img-e062a7da-170" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(226.74,50.75)" id="img-e062a7da-171" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-91.36,50.75)" id="img-e062a7da-172" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-86.06,50.75)" id="img-e062a7da-173" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-80.76,50.75)" id="img-e062a7da-174" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-75.46,50.75)" id="img-e062a7da-175" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-70.15,50.75)" id="img-e062a7da-176" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-64.85,50.75)" id="img-e062a7da-177" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-59.55,50.75)" id="img-e062a7da-178" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-54.25,50.75)" id="img-e062a7da-179" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-48.95,50.75)" id="img-e062a7da-180" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-43.64,50.75)" id="img-e062a7da-181" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-38.34,50.75)" id="img-e062a7da-182" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-33.04,50.75)" id="img-e062a7da-183" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-27.74,50.75)" id="img-e062a7da-184" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-22.44,50.75)" id="img-e062a7da-185" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-17.14,50.75)" id="img-e062a7da-186" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-11.83,50.75)" id="img-e062a7da-187" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-6.53,50.75)" id="img-e062a7da-188" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(-1.23,50.75)" id="img-e062a7da-189" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(4.07,50.75)" id="img-e062a7da-190" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(9.37,50.75)" id="img-e062a7da-191" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(14.67,50.75)" id="img-e062a7da-192" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(19.98,50.75)" id="img-e062a7da-193" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(25.28,50.75)" id="img-e062a7da-194" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(30.58,50.75)" id="img-e062a7da-195" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(35.88,50.75)" id="img-e062a7da-196" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(41.18,50.75)" id="img-e062a7da-197" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(46.48,50.75)" id="img-e062a7da-198" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(51.79,50.75)" id="img-e062a7da-199" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(57.09,50.75)" id="img-e062a7da-200" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(62.39,50.75)" id="img-e062a7da-201" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(67.69,50.75)" id="img-e062a7da-202" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(72.99,50.75)" id="img-e062a7da-203" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(78.29,50.75)" id="img-e062a7da-204" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(83.6,50.75)" id="img-e062a7da-205" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(88.9,50.75)" id="img-e062a7da-206" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(94.2,50.75)" id="img-e062a7da-207" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(99.5,50.75)" id="img-e062a7da-208" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(104.8,50.75)" id="img-e062a7da-209" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(110.11,50.75)" id="img-e062a7da-210" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(115.41,50.75)" id="img-e062a7da-211" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.75)" id="img-e062a7da-212" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(126.01,50.75)" id="img-e062a7da-213" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(131.31,50.75)" id="img-e062a7da-214" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(136.61,50.75)" id="img-e062a7da-215" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(141.92,50.75)" id="img-e062a7da-216" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(147.22,50.75)" id="img-e062a7da-217" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(152.52,50.75)" id="img-e062a7da-218" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(157.82,50.75)" id="img-e062a7da-219" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(163.12,50.75)" id="img-e062a7da-220" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(168.42,50.75)" id="img-e062a7da-221" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(173.73,50.75)" id="img-e062a7da-222" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(179.03,50.75)" id="img-e062a7da-223" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(184.33,50.75)" id="img-e062a7da-224" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(189.63,50.75)" id="img-e062a7da-225" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(194.93,50.75)" id="img-e062a7da-226" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(200.23,50.75)" id="img-e062a7da-227" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(205.54,50.75)" id="img-e062a7da-228" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(210.84,50.75)" id="img-e062a7da-229" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(216.14,50.75)" id="img-e062a7da-230" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(221.44,50.75)" id="img-e062a7da-231" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
        <g transform="translate(226.74,50.75)" id="img-e062a7da-232" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.18 L0,39.18 " class="primitive"/>
        </g>
      </g>
      <g class="plotpanel" id="img-e062a7da-233">
        <metadata>
          <boundingbox value="12.674072265625mm 11.563373480902783mm 110.03464833800396mm 78.3632568359375mm"/>
          <unitbox value="-1.8861759164086167 1.0268950027889776 103.77235183281724 -1.0537900055779552"/>
        </metadata>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-e062a7da-234">
          <g class="color_RGBA{N0f8}(0.0,0.502,0.0,1.0)" stroke-dasharray="none" stroke="#008000" id="img-e062a7da-235">
            <g transform="translate(68.22,50.5)" id="img-e062a7da-236">
              <path fill="none" d="M-52.49,-1.13 L-51.43,18.88 -50.37,19.23 -49.31,14.78 -48.25,34.4 -47.19,18.24 -46.13,30.97 -45.06,-28.19 -44,-25.82 -42.94,21.3 -41.88,12.62 -40.82,16.18 -39.76,-28.7 -38.7,11.48 -37.64,30.49 -36.58,-24.06 -35.52,25.24 -34.46,15.19 -33.4,35.45 -32.34,10.28 -31.28,-21.59 -30.22,-24.12 -29.16,3.88 -28.1,19.8 -27.04,34.09 -25.98,21.57 -24.92,29.42 -23.86,-28.21 -22.8,-4.49 -21.74,-6.69 -20.68,20.4 -19.62,20.63 -18.56,13.63 -17.5,-7.75 -16.44,-12.86 -15.38,20.91 -14.31,-0.01 -13.25,32.51 -12.19,35.01 -11.13,11.07 -10.07,6.52 -9.01,8.23 -7.95,-23.81 -6.89,14.68 -5.83,30.56 -4.77,-36.11 -3.71,5.9 -2.65,18.73 -1.59,-19.26 -0.53,7.27 0.53,-6.62 1.59,-21.2 2.65,21.8 3.71,-12.2 4.77,-25.02 5.83,11.98 6.89,-31.63 7.95,-14.61 9.01,9.55 10.07,-13.63 11.13,2.03 12.19,24.7 13.25,5.13 14.31,-23.96 15.38,-21.66 16.44,6.51 17.5,28.53 18.56,-36.24 19.62,-26.67 20.68,-15.43 21.74,-6.81 22.8,-28.01 23.86,-9.86 24.92,-25.59 25.98,-4.53 27.04,-28.5 28.1,-13.51 29.16,-17.33 30.22,27.82 31.28,-36.31 32.34,17.78 33.4,-12.71 34.46,32.59 35.52,21.22 36.58,-34.1 37.64,35.21 38.7,36.68 39.76,-21.33 40.82,-5.5 41.88,-33.68 42.94,-8.95 44,-30.57 45.06,-5.62 46.13,-0.94 47.19,6.54 48.25,-34.07 49.31,-21.76 50.37,-17.36 51.43,-11.16 52.49,-7.78 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-e062a7da-237">
          <g class="color_RGBA{N0f8}(0.0,0.0,1.0,1.0)" stroke-dasharray="none" stroke="#0000FF" id="img-e062a7da-238">
            <g transform="translate(68.22,49.89)" id="img-e062a7da-239">
              <path fill="none" d="M-52.49,-10.13 L-51.43,-20.14 -50.37,-28.27 -49.31,-33.8 -48.25,-36.23 -47.19,-35.35 -46.13,-31.24 -45.06,-24.26 -44,-15.03 -42.94,-4.39 -41.88,6.72 -40.82,17.31 -39.76,26.43 -38.7,33.26 -37.64,37.2 -36.58,37.9 -35.52,35.28 -34.46,29.59 -33.4,21.33 -32.34,11.25 -31.28,0.23 -30.22,-10.73 -29.16,-20.65 -28.1,-28.65 -27.04,-34.02 -25.98,-36.27 -24.92,-35.21 -23.86,-30.92 -22.8,-23.79 -21.74,-14.47 -20.68,-3.77 -19.62,7.34 -18.56,17.87 -17.5,26.88 -16.44,33.57 -15.38,37.33 -14.31,37.84 -13.25,35.04 -12.19,29.19 -11.13,20.81 -10.07,10.64 -9.01,-0.39 -7.95,-11.32 -6.89,-21.16 -5.83,-29.03 -4.77,-34.23 -3.71,-36.3 -2.65,-35.05 -1.59,-30.59 -0.53,-23.32 0.53,-13.89 1.59,-3.15 2.65,7.95 3.71,18.42 4.77,27.32 5.83,33.86 6.89,37.45 7.95,37.77 9.01,34.79 10.07,28.78 11.13,20.28 12.19,10.04 13.25,-1.02 14.31,-11.91 15.38,-21.66 16.44,-29.4 17.5,-34.43 18.56,-36.32 19.62,-34.88 20.68,-30.25 21.74,-22.84 22.8,-13.32 23.86,-2.53 24.92,8.57 25.98,18.97 27.04,27.76 28.1,34.14 29.16,37.55 30.22,37.68 31.28,34.53 32.34,28.36 33.4,19.74 34.46,9.43 35.52,-1.64 36.58,-12.49 37.64,-22.15 38.7,-29.76 39.76,-34.63 40.82,-36.32 41.88,-34.7 42.94,-29.9 44,-22.36 45.06,-12.74 46.13,-1.9 47.19,9.18 48.25,19.51 49.31,28.19 50.37,34.42 51.43,37.65 52.49,37.59 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-e062a7da-240">
          <g class="color_RGBA{N0f8}(1.0,0.0,0.0,1.0)" stroke-dasharray="none" stroke="#FF0000" id="img-e062a7da-241">
            <g transform="translate(68.22,45.6)" id="img-e062a7da-242">
              <path fill="none" d="M-52.49,3.29 L-51.43,1.44 -50.37,-0.41 -49.31,-2.24 -48.25,-4.05 -47.19,-5.84 -46.13,-7.6 -45.06,-9.33 -44,-11.03 -42.94,-12.68 -41.88,-14.29 -40.82,-15.85 -39.76,-17.35 -38.7,-18.81 -37.64,-20.2 -36.58,-21.52 -35.52,-22.79 -34.46,-23.98 -33.4,-25.1 -32.34,-26.14 -31.28,-27.1 -30.22,-27.99 -29.16,-28.79 -28.1,-29.51 -27.04,-30.14 -25.98,-30.68 -24.92,-31.13 -23.86,-31.49 -22.8,-31.76 -21.74,-31.94 -20.68,-32.03 -19.62,-32.02 -18.56,-31.92 -17.5,-31.72 -16.44,-31.44 -15.38,-31.06 -14.31,-30.59 -13.25,-30.04 -12.19,-29.39 -11.13,-28.66 -10.07,-27.85 -9.01,-26.95 -7.95,-25.97 -6.89,-24.91 -5.83,-23.78 -4.77,-22.58 -3.71,-21.31 -2.65,-19.97 -1.59,-18.57 -0.53,-17.1 0.53,-15.59 1.59,-14.02 2.65,-12.4 3.71,-10.74 4.77,-9.04 5.83,-7.31 6.89,-5.54 7.95,-3.75 9.01,-1.93 10.07,-0.1 11.13,1.75 12.19,3.6 13.25,5.46 14.31,7.32 15.38,9.17 16.44,11.01 17.5,12.84 18.56,14.65 19.62,16.43 20.68,18.19 21.74,19.91 22.8,21.6 23.86,23.25 24.92,24.85 25.98,26.4 27.04,27.9 28.1,29.34 29.16,30.72 30.22,32.04 31.28,33.29 32.34,34.47 33.4,35.57 34.46,36.6 35.52,37.55 36.58,38.42 37.64,39.21 38.7,39.91 39.76,40.53 40.82,41.06 41.88,41.49 42.94,41.84 44,42.09 45.06,42.26 46.13,42.33 47.19,42.3 48.25,42.19 49.31,41.98 50.37,41.68 51.43,41.28 52.49,40.8 " class="primitive"/>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide crosshair" id="img-e062a7da-243">
        <g class="text_box" fill="#000000" id="img-e062a7da-244">
          <g transform="translate(115.65,12.09)" id="img-e062a7da-245">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em"></text>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide helpscreen" id="img-e062a7da-246">
        <g class="text_box" id="img-e062a7da-247">
          <g fill="#000000" id="img-e062a7da-248">
            <g transform="translate(67.69,50.75)" id="img-e062a7da-249">
              <path d="M-34.41,-12.5 L34.41,-12.5 34.41,12.5 -34.41,12.5  z" class="primitive"/>
            </g>
          </g>
          <g fill="#FFFF74" font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-e062a7da-250">
            <g transform="translate(67.69,41.66)" id="img-e062a7da-251">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">h,j,k,l,arrows,drag to pan</text>
              </g>
            </g>
            <g transform="translate(67.69,46.2)" id="img-e062a7da-252">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">i,o,+,-,scroll,shift-drag to zoom</text>
              </g>
            </g>
            <g transform="translate(67.69,50.75)" id="img-e062a7da-253">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">r,dbl-click to reset</text>
              </g>
            </g>
            <g transform="translate(67.69,55.29)" id="img-e062a7da-254">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">c for coordinates</text>
              </g>
            </g>
            <g transform="translate(67.69,59.83)" id="img-e062a7da-255">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">? for help</text>
              </g>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide questionmark" id="img-e062a7da-256">
        <g class="text_box" fill="#000000" id="img-e062a7da-257">
          <g transform="translate(122.71,12.09)" id="img-e062a7da-258">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em">?</text>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g class="guide ylabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-e062a7da-259">
    <g transform="translate(11.67,199.47)" id="img-e062a7da-260" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.5</text>
      </g>
    </g>
    <g transform="translate(11.67,162.29)" id="img-e062a7da-261" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(11.67,125.11)" id="img-e062a7da-262" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.5</text>
      </g>
    </g>
    <g transform="translate(11.67,87.93)" id="img-e062a7da-263" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(11.67,50.75)" id="img-e062a7da-264" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.5</text>
      </g>
    </g>
    <g transform="translate(11.67,13.56)" id="img-e062a7da-265" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(11.67,-23.62)" id="img-e062a7da-266" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.5</text>
      </g>
    </g>
    <g transform="translate(11.67,-60.8)" id="img-e062a7da-267" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(11.67,-97.98)" id="img-e062a7da-268" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.5</text>
      </g>
    </g>
    <g transform="translate(11.67,162.29)" id="img-e062a7da-269" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(11.67,154.85)" id="img-e062a7da-270" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.9</text>
      </g>
    </g>
    <g transform="translate(11.67,147.42)" id="img-e062a7da-271" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(11.67,139.98)" id="img-e062a7da-272" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.7</text>
      </g>
    </g>
    <g transform="translate(11.67,132.54)" id="img-e062a7da-273" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(11.67,125.11)" id="img-e062a7da-274" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.5</text>
      </g>
    </g>
    <g transform="translate(11.67,117.67)" id="img-e062a7da-275" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(11.67,110.24)" id="img-e062a7da-276" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.3</text>
      </g>
    </g>
    <g transform="translate(11.67,102.8)" id="img-e062a7da-277" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(11.67,95.36)" id="img-e062a7da-278" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.1</text>
      </g>
    </g>
    <g transform="translate(11.67,87.93)" id="img-e062a7da-279" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(11.67,80.49)" id="img-e062a7da-280" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.1</text>
      </g>
    </g>
    <g transform="translate(11.67,73.05)" id="img-e062a7da-281" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(11.67,65.62)" id="img-e062a7da-282" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.3</text>
      </g>
    </g>
    <g transform="translate(11.67,58.18)" id="img-e062a7da-283" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(11.67,50.75)" id="img-e062a7da-284" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.5</text>
      </g>
    </g>
    <g transform="translate(11.67,43.31)" id="img-e062a7da-285" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(11.67,35.87)" id="img-e062a7da-286" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.7</text>
      </g>
    </g>
    <g transform="translate(11.67,28.44)" id="img-e062a7da-287" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(11.67,21)" id="img-e062a7da-288" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.9</text>
      </g>
    </g>
    <g transform="translate(11.67,13.56)" id="img-e062a7da-289" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(11.67,6.13)" id="img-e062a7da-290" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.1</text>
      </g>
    </g>
    <g transform="translate(11.67,-1.31)" id="img-e062a7da-291" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(11.67,-8.75)" id="img-e062a7da-292" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.3</text>
      </g>
    </g>
    <g transform="translate(11.67,-16.18)" id="img-e062a7da-293" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(11.67,-23.62)" id="img-e062a7da-294" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.5</text>
      </g>
    </g>
    <g transform="translate(11.67,-31.05)" id="img-e062a7da-295" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(11.67,-38.49)" id="img-e062a7da-296" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.7</text>
      </g>
    </g>
    <g transform="translate(11.67,-45.93)" id="img-e062a7da-297" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(11.67,-53.36)" id="img-e062a7da-298" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.9</text>
      </g>
    </g>
    <g transform="translate(11.67,-60.8)" id="img-e062a7da-299" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(11.67,162.29)" id="img-e062a7da-300" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1</text>
      </g>
    </g>
    <g transform="translate(11.67,87.93)" id="img-e062a7da-301" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(11.67,13.56)" id="img-e062a7da-302" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1</text>
      </g>
    </g>
    <g transform="translate(11.67,-60.8)" id="img-e062a7da-303" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2</text>
      </g>
    </g>
    <g transform="translate(11.67,162.29)" id="img-e062a7da-304" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.00</text>
      </g>
    </g>
    <g transform="translate(11.67,158.57)" id="img-e062a7da-305" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.95</text>
      </g>
    </g>
    <g transform="translate(11.67,154.85)" id="img-e062a7da-306" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.90</text>
      </g>
    </g>
    <g transform="translate(11.67,151.14)" id="img-e062a7da-307" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.85</text>
      </g>
    </g>
    <g transform="translate(11.67,147.42)" id="img-e062a7da-308" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.80</text>
      </g>
    </g>
    <g transform="translate(11.67,143.7)" id="img-e062a7da-309" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.75</text>
      </g>
    </g>
    <g transform="translate(11.67,139.98)" id="img-e062a7da-310" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.70</text>
      </g>
    </g>
    <g transform="translate(11.67,136.26)" id="img-e062a7da-311" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.65</text>
      </g>
    </g>
    <g transform="translate(11.67,132.54)" id="img-e062a7da-312" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.60</text>
      </g>
    </g>
    <g transform="translate(11.67,128.83)" id="img-e062a7da-313" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.55</text>
      </g>
    </g>
    <g transform="translate(11.67,125.11)" id="img-e062a7da-314" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.50</text>
      </g>
    </g>
    <g transform="translate(11.67,121.39)" id="img-e062a7da-315" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.45</text>
      </g>
    </g>
    <g transform="translate(11.67,117.67)" id="img-e062a7da-316" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.40</text>
      </g>
    </g>
    <g transform="translate(11.67,113.95)" id="img-e062a7da-317" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.35</text>
      </g>
    </g>
    <g transform="translate(11.67,110.24)" id="img-e062a7da-318" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.30</text>
      </g>
    </g>
    <g transform="translate(11.67,106.52)" id="img-e062a7da-319" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.25</text>
      </g>
    </g>
    <g transform="translate(11.67,102.8)" id="img-e062a7da-320" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.20</text>
      </g>
    </g>
    <g transform="translate(11.67,99.08)" id="img-e062a7da-321" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.15</text>
      </g>
    </g>
    <g transform="translate(11.67,95.36)" id="img-e062a7da-322" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.10</text>
      </g>
    </g>
    <g transform="translate(11.67,91.64)" id="img-e062a7da-323" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.05</text>
      </g>
    </g>
    <g transform="translate(11.67,87.93)" id="img-e062a7da-324" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.00</text>
      </g>
    </g>
    <g transform="translate(11.67,84.21)" id="img-e062a7da-325" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.05</text>
      </g>
    </g>
    <g transform="translate(11.67,80.49)" id="img-e062a7da-326" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.10</text>
      </g>
    </g>
    <g transform="translate(11.67,76.77)" id="img-e062a7da-327" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.15</text>
      </g>
    </g>
    <g transform="translate(11.67,73.05)" id="img-e062a7da-328" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.20</text>
      </g>
    </g>
    <g transform="translate(11.67,69.34)" id="img-e062a7da-329" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.25</text>
      </g>
    </g>
    <g transform="translate(11.67,65.62)" id="img-e062a7da-330" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.30</text>
      </g>
    </g>
    <g transform="translate(11.67,61.9)" id="img-e062a7da-331" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.35</text>
      </g>
    </g>
    <g transform="translate(11.67,58.18)" id="img-e062a7da-332" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.40</text>
      </g>
    </g>
    <g transform="translate(11.67,54.46)" id="img-e062a7da-333" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.45</text>
      </g>
    </g>
    <g transform="translate(11.67,50.75)" id="img-e062a7da-334" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.50</text>
      </g>
    </g>
    <g transform="translate(11.67,47.03)" id="img-e062a7da-335" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.55</text>
      </g>
    </g>
    <g transform="translate(11.67,43.31)" id="img-e062a7da-336" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.60</text>
      </g>
    </g>
    <g transform="translate(11.67,39.59)" id="img-e062a7da-337" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.65</text>
      </g>
    </g>
    <g transform="translate(11.67,35.87)" id="img-e062a7da-338" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.70</text>
      </g>
    </g>
    <g transform="translate(11.67,32.15)" id="img-e062a7da-339" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.75</text>
      </g>
    </g>
    <g transform="translate(11.67,28.44)" id="img-e062a7da-340" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.80</text>
      </g>
    </g>
    <g transform="translate(11.67,24.72)" id="img-e062a7da-341" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.85</text>
      </g>
    </g>
    <g transform="translate(11.67,21)" id="img-e062a7da-342" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.90</text>
      </g>
    </g>
    <g transform="translate(11.67,17.28)" id="img-e062a7da-343" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.95</text>
      </g>
    </g>
    <g transform="translate(11.67,13.56)" id="img-e062a7da-344" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.00</text>
      </g>
    </g>
    <g transform="translate(11.67,9.85)" id="img-e062a7da-345" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.05</text>
      </g>
    </g>
    <g transform="translate(11.67,6.13)" id="img-e062a7da-346" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.10</text>
      </g>
    </g>
    <g transform="translate(11.67,2.41)" id="img-e062a7da-347" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.15</text>
      </g>
    </g>
    <g transform="translate(11.67,-1.31)" id="img-e062a7da-348" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.20</text>
      </g>
    </g>
    <g transform="translate(11.67,-5.03)" id="img-e062a7da-349" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.25</text>
      </g>
    </g>
    <g transform="translate(11.67,-8.75)" id="img-e062a7da-350" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.30</text>
      </g>
    </g>
    <g transform="translate(11.67,-12.46)" id="img-e062a7da-351" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.35</text>
      </g>
    </g>
    <g transform="translate(11.67,-16.18)" id="img-e062a7da-352" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.40</text>
      </g>
    </g>
    <g transform="translate(11.67,-19.9)" id="img-e062a7da-353" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.45</text>
      </g>
    </g>
    <g transform="translate(11.67,-23.62)" id="img-e062a7da-354" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.50</text>
      </g>
    </g>
    <g transform="translate(11.67,-27.34)" id="img-e062a7da-355" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.55</text>
      </g>
    </g>
    <g transform="translate(11.67,-31.05)" id="img-e062a7da-356" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.60</text>
      </g>
    </g>
    <g transform="translate(11.67,-34.77)" id="img-e062a7da-357" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.65</text>
      </g>
    </g>
    <g transform="translate(11.67,-38.49)" id="img-e062a7da-358" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.70</text>
      </g>
    </g>
    <g transform="translate(11.67,-42.21)" id="img-e062a7da-359" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.75</text>
      </g>
    </g>
    <g transform="translate(11.67,-45.93)" id="img-e062a7da-360" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.80</text>
      </g>
    </g>
    <g transform="translate(11.67,-49.65)" id="img-e062a7da-361" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.85</text>
      </g>
    </g>
    <g transform="translate(11.67,-53.36)" id="img-e062a7da-362" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.90</text>
      </g>
    </g>
    <g transform="translate(11.67,-57.08)" id="img-e062a7da-363" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.95</text>
      </g>
    </g>
    <g transform="translate(11.67,-60.8)" id="img-e062a7da-364" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.00</text>
      </g>
    </g>
  </g>
  <g font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-e062a7da-365">
    <g transform="translate(67.69,5)" id="img-e062a7da-366">
      <g class="primitive">
        <text text-anchor="middle" dy="0.6em">Original sources</text>
      </g>
    </g>
  </g>
</g>
<defs>
  <clipPath id="img-e062a7da-17">
    <path d="M12.67,11.56 L122.71,11.56 122.71,89.93 12.67,89.93 " />
  </clipPath>
</defs>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
<script> <![CDATA[

(function (glob, factory) {
    // AMD support
    if (typeof define === "function" && define.amd) {
        // Define as an anonymous module
        define("Gadfly", ["Snap.svg"], function (Snap) {
            return factory(Snap);
        });
    } else {
        // Browser globals (glob is window)
        // Snap adds itself to window
        glob.Gadfly = factory(glob.Snap);
    }
}(this, function (Snap) {

var Gadfly = {};

// Get an x/y coordinate value in pixels
var xPX = function(fig, x) {
    var client_box = fig.node.getBoundingClientRect();
    return x * fig.node.viewBox.baseVal.width / client_box.width;
};

var yPX = function(fig, y) {
    var client_box = fig.node.getBoundingClientRect();
    return y * fig.node.viewBox.baseVal.height / client_box.height;
};


Snap.plugin(function (Snap, Element, Paper, global) {
    // Traverse upwards from a snap element to find and return the first
    // note with the "plotroot" class.
    Element.prototype.plotroot = function () {
        var element = this;
        while (!element.hasClass("plotroot") && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.svgroot = function () {
        var element = this;
        while (element.node.nodeName != "svg" && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.plotbounds = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.viewportplotbounds = function () {
        var root = this.svgroot();
        var bbox = root.node.getBoundingClientRect();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.plotcenter = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x: bbox.x + bbox.width / 2,
            y: bbox.y + bbox.height / 2
        };
    };

    // Emulate IE style mouseenter/mouseleave events, since Microsoft always
    // does everything right.
    // See: http://www.dynamic-tools.net/toolbox/isMouseLeaveOrEnter/
    var events = ["mouseenter", "mouseleave"];

    for (i in events) {
        (function (event_name) {
            var event_name = events[i];
            Element.prototype[event_name] = function (fn, scope) {
                if (Snap.is(fn, "function")) {
                    var fn2 = function (event) {
                        if (event.type != "mouseover" && event.type != "mouseout") {
                            return;
                        }

                        var reltg = event.relatedTarget ? event.relatedTarget :
                            event.type == "mouseout" ? event.toElement : event.fromElement;
                        while (reltg && reltg != this.node) reltg = reltg.parentNode;

                        if (reltg != this.node) {
                            return fn.apply(this, event);
                        }
                    };

                    if (event_name == "mouseenter") {
                        this.mouseover(fn2, scope);
                    } else {
                        this.mouseout(fn2, scope);
                    }
                }
                return this;
            };
        })(events[i]);
    }


    Element.prototype.mousewheel = function (fn, scope) {
        if (Snap.is(fn, "function")) {
            var el = this;
            var fn2 = function (event) {
                fn.apply(el, [event]);
            };
        }

        this.node.addEventListener("wheel", fn2);

        return this;
    };


    // Snap's attr function can be too slow for things like panning/zooming.
    // This is a function to directly update element attributes without going
    // through eve.
    Element.prototype.attribute = function(key, val) {
        if (val === undefined) {
            return this.node.getAttribute(key);
        } else {
            this.node.setAttribute(key, val);
            return this;
        }
    };

    Element.prototype.init_gadfly = function() {
        this.mouseenter(Gadfly.plot_mouseover)
            .mousemove(Gadfly.plot_mousemove)
            .mouseleave(Gadfly.plot_mouseout)
            .dblclick(Gadfly.plot_dblclick)
            .mousewheel(Gadfly.guide_background_scroll)
            .drag(Gadfly.guide_background_drag_onmove,
                  Gadfly.guide_background_drag_onstart,
                  Gadfly.guide_background_drag_onend);
        this.mouseenter(function (event) {
            init_pan_zoom(this.plotroot());
        });
        return this;
    };
});


Gadfly.plot_mousemove = function(event, _x_px, _y_px) {
    var root = this.plotroot();
    var viewbounds = root.viewportplotbounds();

    // (_x_px, _y_px) are offsets relative to page (event.layerX, event.layerY) rather than viewport
    var x_px = event.clientX - viewbounds.x0;
    var y_px = event.clientY - viewbounds.y0;
    if (root.data("crosshair")) {
        px_per_mm = root.data("px_per_mm");
        bB = root.select('boundingbox').node.getAttribute('value').split(' ');
        uB = root.select('unitbox').node.getAttribute('value').split(' ');
        xscale = root.data("xscale");
        yscale = root.data("yscale");
        xtranslate = root.data("tx");
        ytranslate = root.data("ty");

        xoff_mm = bB[0].substr(0,bB[0].length-2)/1;
        yoff_mm = bB[1].substr(0,bB[1].length-2)/1;
        xoff_unit = uB[0]/1;
        yoff_unit = uB[1]/1;
        mm_per_xunit = bB[2].substr(0,bB[2].length-2) / uB[2];
        mm_per_yunit = bB[3].substr(0,bB[3].length-2) / uB[3];

        x_unit = ((x_px / px_per_mm - xtranslate) / xscale - xoff_mm) / mm_per_xunit + xoff_unit;
        y_unit = ((y_px / px_per_mm - ytranslate) / yscale - yoff_mm) / mm_per_yunit + yoff_unit;

        root.select('.crosshair').select('.primitive').select('text')
                .node.innerHTML = x_unit.toPrecision(3)+","+y_unit.toPrecision(3);
    };
};

Gadfly.helpscreen_visible = function(event) {
    helpscreen_visible(this.plotroot());
};
var helpscreen_visible = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 1.0}, 250);
};

Gadfly.helpscreen_hidden = function(event) {
    helpscreen_hidden(this.plotroot());
};
var helpscreen_hidden = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 0.0}, 250);
};

// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_help = function(event) {
        if (event.which == 191) { // ?
            helpscreen_visible(root);
        }
    };
    root.data("keyboard_help", keyboard_help);
    window.addEventListener("keydown", keyboard_help);

    var keyboard_pan_zoom = function(event) {
        var bounds = root.plotbounds(),
            width = bounds.x1 - bounds.x0;
            height = bounds.y1 - bounds.y0;
        if (event.which == 187 || event.which == 73) { // plus or i
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189 || event.which == 79) { // minus or o
            increase_zoom_by_position(root, -0.1, true);
        } else if (event.which == 39 || event.which == 76) { // right-arrow or l
            set_plot_pan_zoom(root, root.data("tx")-width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 40 || event.which == 74) { // down-arrow or j
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")-height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 37 || event.which == 72) { // left-arrow or h
            set_plot_pan_zoom(root, root.data("tx")+width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 38 || event.which == 75) { // up-arrow or k
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")+height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 82) { // r
            set_plot_pan_zoom(root, 0.0, 0.0, 1.0, 1.0);
        } else if (event.which == 191) { // ?
            helpscreen_hidden(root);
        } else if (event.which == 67) { // c
            root.data("crosshair",!root.data("crosshair"));
            root.select(".crosshair")
                .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
        }
    };
    root.data("keyboard_pan_zoom", keyboard_pan_zoom);
    window.addEventListener("keyup", keyboard_pan_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        xgridlines.data("unfocused_strokedash",
                        xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        ygridlines.data("unfocused_strokedash",
                        ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair")
        .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_pan_zoom"));
    root.data("keyboard_pan_zoom", undefined);
    window.removeEventListener("keydown", root.data("keyboard_help"));
    root.data("keyboard_help", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        var destcolor = root.data("unfocused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        var destcolor = root.data("unfocused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair").animate({"fill-opacity": 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 0.0}, 250);
    helpscreen_hidden(root);
};


var set_geometry_transform = function(root, tx, ty, xscale, yscale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");

    var xscale = xscalable ? xscale : 1.0,
        yscale = yscalable ? yscale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);
    root.selectAll(".geometry, image").forEach(function (element, i) {
            element.transform(t);
        });

    var t = new Snap.Matrix().scale(1.0/xscale, 1.0/yscale);
    root.selectAll('.marker').forEach(function (element, i) {
        element.selectAll('.primitive').forEach(function (element, i) {
            element.transform(t);
        }) });

    bounds = root.plotbounds();
    px_per_mm = root.data("px_per_mm");

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        ylabels = root.select(".ylabels");
        if (ylabels) {
            ylabels.transform(xfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1, 1/yscale);
                           element.select("text").transform(unscale_t);

                           var y = element.attr("transform").globalMatrix.f / px_per_mm;
                           element.attr("visibility",
                               bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                       }
                   });
        }
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        xlabels = root.select(".xlabels");
        if (xlabels) {
            xlabels.transform(yfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1/xscale, 1);
                           element.select("text").transform(unscale_t);

                           var x = element.attr("transform").globalMatrix.e / px_per_mm;
                           element.attr("visibility",
                               bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                           }
                   });
        }
    }
};


// Find the most appropriate tick scale and update label visibility.
var update_tickscale = function(root, scale, axis) {
    if (!root.hasClass(axis + "scalable")) return;

    var tickscales = root.data(axis + "tickscales");
    var best_tickscale = 1.0;
    var best_tickscale_dist = Infinity;
    for (tickscale in tickscales) {
        var dist = Math.abs(Math.log(tickscale) - Math.log(scale));
        if (dist < best_tickscale_dist) {
            best_tickscale_dist = dist;
            best_tickscale = tickscale;
        }
    }

    if (best_tickscale != root.data(axis + "tickscale")) {
        root.data(axis + "tickscale", best_tickscale);
        var mark_inscale_gridlines = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("g").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("g").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, xscale, yscale) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, xscale, and yscale
    var x_min = -width * xscale - (xscale * width - width),
        x_max = width * xscale,
        y_min = -height * yscale - (yscale * height - height),
        y_max = height * yscale;

    var x0 = bounds.x0 - xscale * bounds.x0,
        y0 = bounds.y0 - yscale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale changes, we may need to alter which set of
    // ticks are being displayed
    if (xscale != old_xscale) {
        update_tickscale(root, xscale, "x");
    }
    if (yscale != old_yscale) {
        update_tickscale(root, yscale, "y");
    }

    set_geometry_transform(root, tx, ty, xscale, yscale);

    root.data("xscale", xscale);
    root.data("yscale", yscale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, xscale, yscale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var xscale0 = root.data("xscale"),
        yscale0 = root.data("yscale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - xscale0) + (width * (1 - xscale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - yscale0) + (height * (1 - yscale0)) / 2);

    // rescale offsets
    xoff = xoff * xscale / xscale0;
    yoff = yoff * yscale / yscale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - xscale),
        y_edge_adjust = bounds.y0 * (1 - yscale);

    return {
        x: xoff + x_edge_adjust + (width - width * xscale) / 2,
        y: yoff + y_edge_adjust + (height - height * yscale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

    root.data("crosshair",false);

    // The non-scaling-stroke trick. Rather than try to correct for the
    // stroke-width when zooming, we force it to a fixed value.
    var px_per_mm = root.node.getCTM().a;

    // Drag events report deltas in pixels, which we'd like to convert to
    // millimeters.
    root.data("px_per_mm", px_per_mm);

    root.selectAll("path")
        .forEach(function (element, i) {
        sw = element.asPX("stroke-width") * px_per_mm;
        if (sw > 0) {
            element.attribute("stroke-width", sw);
            element.attribute("vector-effect", "non-scaling-stroke");
        }
    });

    // Store ticks labels original tranformation
    root.selectAll(".xlabels > g, .ylabels > g")
        .forEach(function (element, i) {
            var lm = element.transform().localMatrix;
            element.data("static_transform",
                new Snap.Matrix(lm.a, lm.b, lm.c, lm.d, lm.e, lm.f));
        });

    var xgridlines = root.select(".xgridlines");
    var ygridlines = root.select(".ygridlines");
    var xlabels = root.select(".xlabels");
    var ylabels = root.select(".ylabels");

    if (root.data("tx") === undefined) root.data("tx", 0);
    if (root.data("ty") === undefined) root.data("ty", 0);
    if (root.data("xscale") === undefined) root.data("xscale", 1.0);
    if (root.data("yscale") === undefined) root.data("yscale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("g").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("g").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("g").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("g").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
        root.data("ytickscale", 1.0);  // ???
    }

    var min_scale = 1.0, max_scale = 1.0;
    for (scale in xtickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    for (scale in ytickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    root.data("min_scale", min_scale);
    root.data("max_scale", max_scale);

    // store the original positions of labels
    if (xlabels) {
        xlabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        if (element.attribute("gadfly:scale") == null) { return; }
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("g").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("g").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("g").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("g").forEach(mark_inscale);

    // figure out the upper ond lower bounds on panning using the maximum
    // and minum grid lines
    var bounds = root.plotbounds();
    var pan_bounds = {
        x0: 0.0,
        y0: 0.0,
        x1: 0.0,
        y1: 0.0
    };

    if (xgridlines) {
        xgridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.x1 - bbox.x < pan_bounds.x0) {
                        pan_bounds.x0 = bounds.x1 - bbox.x;
                    }
                    if (bounds.x0 - bbox.x > pan_bounds.x1) {
                        pan_bounds.x1 = bounds.x0 - bbox.x;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    if (ygridlines) {
        ygridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.y1 - bbox.y < pan_bounds.y0) {
                        pan_bounds.y0 = bounds.y1 - bbox.y;
                    }
                    if (bounds.y0 - bbox.y > pan_bounds.y1) {
                        pan_bounds.y1 = bounds.y0 - bbox.y;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    // nudge these values a little
    pan_bounds.x0 -= 5;
    pan_bounds.x1 += 5;
    pan_bounds.y0 -= 5;
    pan_bounds.y1 += 5;
    root.data("pan_bounds", pan_bounds);

    root.data("zoompan-ready", true)
};


// drag actions, i.e. zooming and panning
var pan_action = {
    start: function(root, x, y, event) {
        root.data("dx", 0);
        root.data("dy", 0);
        root.data("tx0", root.data("tx"));
        root.data("ty0", root.data("ty"));
    },
    update: function(root, dx, dy, x, y, event) {
        var px_per_mm = root.data("px_per_mm");
        dx /= px_per_mm;
        dy /= px_per_mm;

        var tx0 = root.data("tx"),
            ty0 = root.data("ty");

        var dx0 = root.data("dx"),
            dy0 = root.data("dy");

        root.data("dx", dx);
        root.data("dy", dy);

        dx = dx - dx0;
        dy = dy - dy0;

        var tx = tx0 + dx,
            ty = ty0 + dy;

        set_plot_pan_zoom(root, tx, ty, root.data("xscale"), root.data("yscale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"),
                root.data("xscale"), root.data("yscale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, _x, _y, event) {
        var bounds = root.plotbounds();
        // _x and _y are co-ordinates relative to page, which caused problems
        // unless the SVG is precisely at the top-left of the page
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;

        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "fill-opacity": 0.25
        });
    },
    update: function(root, dx, dy, _x, _y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;
        if (yscalable) {
            y /= px_per_mm;
            y = Math.max(bounds.y0, y);
            y = Math.min(bounds.y1, y);
        } else {
            y = bounds.y1;
        }
        if (xscalable) {
            x /= px_per_mm;
            x = Math.max(bounds.x0, x);
            x = Math.min(bounds.x1, x);
        } else {
            x = bounds.x1;
        }

        dx = x - zoom_box.attr("x");
        dy = y - zoom_box.attr("y");
        var xoffset = 0,
            yoffset = 0;
        if (dx < 0) {
            xoffset = dx;
            dx = -1 * dx;
        }
        if (dy < 0) {
            yoffset = dy;
            dy = -1 * dy;
        }
        if (isNaN(dy)) {
            dy = 0.0;
        }
        if (isNaN(dx)) {
            dx = 0.0;
        }
        zoom_box.transform("T" + xoffset + "," + yoffset);
        zoom_box.attr("width", dx);
        zoom_box.attr("height", dy);
    },
    end: function(root, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var zoom_bounds = zoom_box.getBBox();
        if (zoom_bounds.width * zoom_bounds.height <= 0) {
            return;
        }
        var plot_bounds = root.plotbounds();
        var xzoom_factor = 1.0,
            yzoom_factor = 1.0;
        if (xscalable) {
            xzoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        if (yscalable) {
            yzoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * xzoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * yzoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty,
                root.data("xscale") * xzoom_factor, root.data("yscale") * yzoom_factor);
        zoom_box.remove();
    },
    cancel: function(root) {
        zoom_box.remove();
    }
};


Gadfly.guide_background_drag_onstart = function(x, y, event) {
    var root = this.plotroot();
    var scalable = root.hasClass("xscalable") || root.hasClass("yscalable");
    var zoomable = !event.altKey && !event.ctrlKey && event.shiftKey && scalable;
    var panable = !event.altKey && !event.ctrlKey && !event.shiftKey && scalable;
    var drag_action = zoomable ? zoom_action :
                      panable  ? pan_action :
                                 undefined;
    root.data("drag_action", drag_action);
    if (drag_action) {
        var cancel_drag_action = function(event) {
            if (event.which == 27) { // esc key
                drag_action.cancel(root);
                root.data("drag_action", undefined);
            }
        };
        window.addEventListener("keyup", cancel_drag_action);
        root.data("cancel_drag_action", cancel_drag_action);
        drag_action.start(root, x, y, event);
    }
};


Gadfly.guide_background_drag_onmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.update(root, dx, dy, x, y, event);
    }
};


Gadfly.guide_background_drag_onend = function(event) {
    var root = this.plotroot();
    window.removeEventListener("keyup", root.data("cancel_drag_action"));
    root.data("cancel_drag_action", undefined);
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.end(root, event);
    }
    root.data("drag_action", undefined);
};


Gadfly.guide_background_scroll = function(event) {
    if (event.shiftKey) {
        // event.deltaY is either the number of pixels, lines, or pages scrolled past.
        var actual_delta;
        switch (event.deltaMode) {
            case 0: // Chromium-based
                actual_delta = -event.deltaY / 1000.0;
                break;
            case 1: // Firefox
                actual_delta = -event.deltaY / 50.0;
                break;
            default:
                actual_delta = -event.deltaY;
        }
        // Assumes 20 pixels/line to get reasonably consistent cross-browser behaviour.
        increase_zoom_by_position(this.plotroot(), actual_delta);
        event.preventDefault();
    }
};

// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    if (min_scale==max_scale) { return 1; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    if (min_scale==max_scale) { return min_scale; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var xposition = slider_position_from_scale(old_xscale, min_scale, max_scale),
        yposition = slider_position_from_scale(old_yscale, min_scale, max_scale);
    xposition += (root.hasClass("xscalable") ? delta_position : 0.0);
    yposition += (root.hasClass("yscalable") ? delta_position : 0.0);
    old_xscale = scale_from_slider_position(xposition, min_scale, max_scale);
    old_yscale = scale_from_slider_position(yposition, min_scale, max_scale);
    var new_xscale = Math.max(min_scale, Math.min(old_xscale, max_scale)),
        new_yscale = Math.max(min_scale, Math.min(old_yscale, max_scale));
    if (animate) {
        Snap.animate(
            [old_xscale, old_yscale],
            [new_xscale, new_yscale],
            function (new_scale) {
                update_plot_scale(root, new_scale[0], new_scale[1]);
            },
            200);
    } else {
        update_plot_scale(root, new_xscale, new_yscale);
    }
}


var update_plot_scale = function(root, new_xscale, new_yscale) {
    var trans = scale_centered_translation(root, new_xscale, new_yscale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_xscale, new_yscale);
};


var toggle_color_class = function(root, color_class, ison) {
    var escaped_color_class = color_class.replace(/([^0-9a-zA-z])/g,"\\$1");
    var guides = root.selectAll(".guide." + escaped_color_class + ",.guide ." + escaped_color_class);
    var geoms = root.selectAll(".geometry." + escaped_color_class + ",.geometry ." + escaped_color_class);
    if (ison) {
        guides.animate({opacity: 0.5}, 250);
        geoms.animate({opacity: 0.0}, 250);
    } else {
        guides.animate({opacity: 1.0}, 250);
        geoms.animate({opacity: 1.0}, 250);
    }
};


Gadfly.colorkey_swatch_click = function(event) {
    var root = this.plotroot();
    var color_class = this.data("color_class");

    if (event.shiftKey) {
        root.selectAll(".colorkey g")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (typeof other_color_class !== 'undefined' && other_color_class != color_class) {
                    toggle_color_class(root, other_color_class,
                                       element.attr("opacity") == 1.0);
                }
            });
    } else {
        toggle_color_class(root, color_class, this.attr("opacity") == 1.0);
    }
};


return Gadfly;

}));


//@ sourceURL=gadfly.js

(function (glob, factory) {
    // AMD support
      if (typeof require === "function" && typeof define === "function" && define.amd) {
        require(["Snap.svg", "Gadfly"], function (Snap, Gadfly) {
            factory(Snap, Gadfly);
        });
      } else {
          factory(glob.Snap, glob.Gadfly);
      }
})(window, function (Snap, Gadfly) {
    var fig = Snap("#img-e062a7da");
fig.select("#img-e062a7da-3")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-e062a7da-18")
   .init_gadfly();
fig.select("#img-e062a7da-21")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-e062a7da-21")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-e062a7da-127")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-e062a7da-127")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-e062a7da-257")
   .mouseenter(Gadfly.helpscreen_visible)
.mouseleave(Gadfly.helpscreen_hidden)
;
    });
]]> </script>
</svg>




## Mixing matrix (assumed unknown)


```julia
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
```




    3×4 Matrix{Int64}:
     1  0  1  1
     1  2  0  2
     1  1  2  0



## Data matix (known)


```julia
X = S * H
```




    100×4 Matrix{Float64}:
     1.69122   1.81399   1.56192   1.82051
     1.58168   1.81409   1.04881   2.11456
     1.71114   2.02808   1.06423   2.35805
     1.86989   2.23657   1.2084    2.53137
     1.66324   2.03828   0.705276  2.6212
     1.8927    2.23186   1.16378   2.62161
     1.68988   1.95004   0.845102  2.53466
     2.4148    2.55783   2.45944   2.37017
     2.28173   2.27794   2.41861   2.14486
     1.52712   1.35797   1.17341   1.88083
     1.51608   1.17586   1.42856   1.6036
     1.34684   0.843262  1.35389   1.3398
     1.84797   1.20149   2.58111   1.11483
     ⋮                             
     1.59436   2.57724   1.17161   2.01711
     1.94572   2.91267   1.92382   1.96761
     1.5439    2.45099   1.2539    1.83391
     1.72973   2.53876   1.83192   1.62753
     1.2627    1.94455   1.15877   1.36663
     1.05314   1.59023   1.03198   1.0743
     0.803814  1.19158   0.83103   0.776598
     1.21254   1.45973   1.92496   0.500128
     0.933209  1.06098   1.59669   0.269727
     0.794267  0.834216  1.48231   0.106219
     0.672767  0.663975  1.32097   0.0245614
     0.63442   0.619866  1.23633   0.0325062




```julia
Mads.plotseries(X, title="Mixed signals", name="Signal", quiet=true)
```




<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="141.42mm" height="100mm" viewBox="0 0 141.42 100"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="img-583797c1">
<defs>
  <marker id="arrow" markerWidth="15" markerHeight="7" refX="5" refY="3.5" orient="auto" markerUnits="strokeWidth">
    <path d="M0,0 L15,3.5 L0,7 z" stroke="context-stroke" fill="context-stroke"/>
  </marker>
</defs>
<g class="plotroot xscalable yscalable" id="img-583797c1-1">
  <g class="guide xlabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-583797c1-2">
    <g transform="translate(-153.19,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-150</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(285.04,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">250</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-87.46,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-76.5,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-65.54,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-54.59,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-32.68,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-21.72,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-10.77,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(0.19,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(22.1,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(33.06,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(44.01,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(54.97,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(76.88,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(87.84,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(98.79,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(109.75,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(131.66,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(142.62,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(153.57,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(164.53,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(186.44,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(197.39,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(208.35,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(219.31,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-92.93,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-95</text>
      </g>
    </g>
    <g transform="translate(-87.46,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-81.98,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-85</text>
      </g>
    </g>
    <g transform="translate(-76.5,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-71.02,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-75</text>
      </g>
    </g>
    <g transform="translate(-65.54,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-60.07,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-65</text>
      </g>
    </g>
    <g transform="translate(-54.59,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-49.11,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-55</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-38.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-45</text>
      </g>
    </g>
    <g transform="translate(-32.68,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-27.2,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-35</text>
      </g>
    </g>
    <g transform="translate(-21.72,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-16.24,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-25</text>
      </g>
    </g>
    <g transform="translate(-10.77,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(-5.29,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-15</text>
      </g>
    </g>
    <g transform="translate(0.19,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(5.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-5</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(16.62,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">5</text>
      </g>
    </g>
    <g transform="translate(22.1,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(27.58,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">15</text>
      </g>
    </g>
    <g transform="translate(33.06,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(38.54,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">25</text>
      </g>
    </g>
    <g transform="translate(44.01,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(49.49,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">35</text>
      </g>
    </g>
    <g transform="translate(54.97,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(60.45,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">45</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(71.4,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">55</text>
      </g>
    </g>
    <g transform="translate(76.88,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(82.36,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">65</text>
      </g>
    </g>
    <g transform="translate(87.84,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(93.31,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">75</text>
      </g>
    </g>
    <g transform="translate(98.79,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(104.27,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">85</text>
      </g>
    </g>
    <g transform="translate(109.75,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(115.23,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">95</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(126.18,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">105</text>
      </g>
    </g>
    <g transform="translate(131.66,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(137.14,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">115</text>
      </g>
    </g>
    <g transform="translate(142.62,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(148.09,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">125</text>
      </g>
    </g>
    <g transform="translate(153.57,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(159.05,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">135</text>
      </g>
    </g>
    <g transform="translate(164.53,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(170,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">145</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(180.96,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">155</text>
      </g>
    </g>
    <g transform="translate(186.44,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(191.92,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">165</text>
      </g>
    </g>
    <g transform="translate(197.39,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(202.87,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">175</text>
      </g>
    </g>
    <g transform="translate(208.35,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(213.83,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">185</text>
      </g>
    </g>
    <g transform="translate(219.31,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(224.78,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">195</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
  </g>
  <g class="guide colorkey" id="img-583797c1-3">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-583797c1-4">
      <g transform="translate(127.31,46.07)" id="img-583797c1-5">
        <g class="primitive">
          <text dy="0.35em">Signal 1</text>
        </g>
      </g>
      <g transform="translate(127.31,49.68)" id="img-583797c1-6">
        <g class="primitive">
          <text dy="0.35em">Signal 2</text>
        </g>
      </g>
      <g transform="translate(127.31,53.29)" id="img-583797c1-7">
        <g class="primitive">
          <text dy="0.35em">Signal 3</text>
        </g>
      </g>
      <g transform="translate(127.31,56.9)" id="img-583797c1-8">
        <g class="primitive">
          <text dy="0.35em">Signal 4</text>
        </g>
      </g>
    </g>
    <g stroke-width="0" id="img-583797c1-9">
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FFA500" id="img-583797c1-10">
        <g transform="translate(124.51,56.9)" id="img-583797c1-11">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#008000" id="img-583797c1-12">
        <g transform="translate(124.51,53.29)" id="img-583797c1-13">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#0000FF" id="img-583797c1-14">
        <g transform="translate(124.51,49.68)" id="img-583797c1-15">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FF0000" id="img-583797c1-16">
        <g transform="translate(124.51,46.07)" id="img-583797c1-17">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-583797c1-18">
      <g transform="translate(123.7,42.77)" id="img-583797c1-19">
        <g class="primitive">
          <text dy="-0em"></text>
        </g>
      </g>
    </g>
  </g>
  <g clip-path="url(#img-583797c1-20)">
    <g id="img-583797c1-21">
      <g pointer-events="visible" stroke-width="0.3" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-583797c1-22">
        <g transform="translate(65.92,50.74)" id="img-583797c1-23">
          <path d="M-56.78,-39.19 L56.78,-39.19 56.78,39.19 -56.78,39.19  z" class="primitive"/>
        </g>
      </g>
      <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-583797c1-24">
        <g transform="translate(65.92,187.1)" id="img-583797c1-25" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-583797c1-26" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-583797c1-27" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-583797c1-28" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-583797c1-29" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-583797c1-30" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-583797c1-31" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-583797c1-32" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-583797c1-33" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-583797c1-34" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-583797c1-35" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-85.63)" id="img-583797c1-36" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-583797c1-37" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,157.35)" id="img-583797c1-38" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,152.39)" id="img-583797c1-39" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,147.43)" id="img-583797c1-40" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,142.47)" id="img-583797c1-41" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-583797c1-42" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,132.56)" id="img-583797c1-43" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,127.6)" id="img-583797c1-44" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,122.64)" id="img-583797c1-45" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,117.68)" id="img-583797c1-46" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-583797c1-47" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,107.76)" id="img-583797c1-48" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,102.8)" id="img-583797c1-49" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,97.84)" id="img-583797c1-50" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,92.89)" id="img-583797c1-51" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-583797c1-52" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,82.97)" id="img-583797c1-53" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,78.01)" id="img-583797c1-54" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,73.05)" id="img-583797c1-55" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,68.09)" id="img-583797c1-56" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-583797c1-57" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,58.17)" id="img-583797c1-58" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,53.21)" id="img-583797c1-59" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,48.26)" id="img-583797c1-60" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,43.3)" id="img-583797c1-61" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-583797c1-62" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,33.38)" id="img-583797c1-63" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,28.42)" id="img-583797c1-64" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,23.46)" id="img-583797c1-65" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,18.5)" id="img-583797c1-66" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-583797c1-67" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,8.58)" id="img-583797c1-68" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,3.63)" id="img-583797c1-69" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-1.33)" id="img-583797c1-70" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-6.29)" id="img-583797c1-71" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-583797c1-72" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-16.21)" id="img-583797c1-73" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-21.17)" id="img-583797c1-74" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-26.13)" id="img-583797c1-75" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-31.09)" id="img-583797c1-76" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-583797c1-77" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-41)" id="img-583797c1-78" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-45.96)" id="img-583797c1-79" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-50.92)" id="img-583797c1-80" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-55.88)" id="img-583797c1-81" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-583797c1-82" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-583797c1-83" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-583797c1-84" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-583797c1-85" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-583797c1-86" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-583797c1-87" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,159.83)" id="img-583797c1-88" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,157.35)" id="img-583797c1-89" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,154.87)" id="img-583797c1-90" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,152.39)" id="img-583797c1-91" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,149.91)" id="img-583797c1-92" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,147.43)" id="img-583797c1-93" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,144.95)" id="img-583797c1-94" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,142.47)" id="img-583797c1-95" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,139.99)" id="img-583797c1-96" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-583797c1-97" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,135.04)" id="img-583797c1-98" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,132.56)" id="img-583797c1-99" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,130.08)" id="img-583797c1-100" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,127.6)" id="img-583797c1-101" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,125.12)" id="img-583797c1-102" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,122.64)" id="img-583797c1-103" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,120.16)" id="img-583797c1-104" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,117.68)" id="img-583797c1-105" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,115.2)" id="img-583797c1-106" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-583797c1-107" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,110.24)" id="img-583797c1-108" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,107.76)" id="img-583797c1-109" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,105.28)" id="img-583797c1-110" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,102.8)" id="img-583797c1-111" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,100.32)" id="img-583797c1-112" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,97.84)" id="img-583797c1-113" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,95.36)" id="img-583797c1-114" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,92.89)" id="img-583797c1-115" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,90.41)" id="img-583797c1-116" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-583797c1-117" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,85.45)" id="img-583797c1-118" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,82.97)" id="img-583797c1-119" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,80.49)" id="img-583797c1-120" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,78.01)" id="img-583797c1-121" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,75.53)" id="img-583797c1-122" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,73.05)" id="img-583797c1-123" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,70.57)" id="img-583797c1-124" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,68.09)" id="img-583797c1-125" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,65.61)" id="img-583797c1-126" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-583797c1-127" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,60.65)" id="img-583797c1-128" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,58.17)" id="img-583797c1-129" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,55.69)" id="img-583797c1-130" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,53.21)" id="img-583797c1-131" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-583797c1-132" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,48.26)" id="img-583797c1-133" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,45.78)" id="img-583797c1-134" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,43.3)" id="img-583797c1-135" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,40.82)" id="img-583797c1-136" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-583797c1-137" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,35.86)" id="img-583797c1-138" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,33.38)" id="img-583797c1-139" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,30.9)" id="img-583797c1-140" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,28.42)" id="img-583797c1-141" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,25.94)" id="img-583797c1-142" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,23.46)" id="img-583797c1-143" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,20.98)" id="img-583797c1-144" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,18.5)" id="img-583797c1-145" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,16.02)" id="img-583797c1-146" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-583797c1-147" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,11.06)" id="img-583797c1-148" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,8.58)" id="img-583797c1-149" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,6.11)" id="img-583797c1-150" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,3.63)" id="img-583797c1-151" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,1.15)" id="img-583797c1-152" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-1.33)" id="img-583797c1-153" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-3.81)" id="img-583797c1-154" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-6.29)" id="img-583797c1-155" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-8.77)" id="img-583797c1-156" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-583797c1-157" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-13.73)" id="img-583797c1-158" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-16.21)" id="img-583797c1-159" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-18.69)" id="img-583797c1-160" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-21.17)" id="img-583797c1-161" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-23.65)" id="img-583797c1-162" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-26.13)" id="img-583797c1-163" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-28.61)" id="img-583797c1-164" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-31.09)" id="img-583797c1-165" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-33.57)" id="img-583797c1-166" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-583797c1-167" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-38.52)" id="img-583797c1-168" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-41)" id="img-583797c1-169" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-43.48)" id="img-583797c1-170" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-45.96)" id="img-583797c1-171" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-48.44)" id="img-583797c1-172" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-50.92)" id="img-583797c1-173" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-53.4)" id="img-583797c1-174" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-55.88)" id="img-583797c1-175" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-58.36)" id="img-583797c1-176" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-583797c1-177" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
      </g>
      <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-583797c1-178">
        <g transform="translate(-153.19,50.74)" id="img-583797c1-179" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-583797c1-180" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-583797c1-181" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-583797c1-182" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-583797c1-183" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-583797c1-184" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-583797c1-185" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-583797c1-186" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(285.04,50.74)" id="img-583797c1-187" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-583797c1-188" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-87.46,50.74)" id="img-583797c1-189" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-76.5,50.74)" id="img-583797c1-190" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-65.54,50.74)" id="img-583797c1-191" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-54.59,50.74)" id="img-583797c1-192" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-583797c1-193" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-32.68,50.74)" id="img-583797c1-194" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-21.72,50.74)" id="img-583797c1-195" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-10.77,50.74)" id="img-583797c1-196" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(0.19,50.74)" id="img-583797c1-197" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-583797c1-198" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(22.1,50.74)" id="img-583797c1-199" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(33.06,50.74)" id="img-583797c1-200" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(44.01,50.74)" id="img-583797c1-201" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(54.97,50.74)" id="img-583797c1-202" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-583797c1-203" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(76.88,50.74)" id="img-583797c1-204" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(87.84,50.74)" id="img-583797c1-205" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(98.79,50.74)" id="img-583797c1-206" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(109.75,50.74)" id="img-583797c1-207" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-583797c1-208" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(131.66,50.74)" id="img-583797c1-209" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(142.62,50.74)" id="img-583797c1-210" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(153.57,50.74)" id="img-583797c1-211" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(164.53,50.74)" id="img-583797c1-212" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-583797c1-213" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(186.44,50.74)" id="img-583797c1-214" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(197.39,50.74)" id="img-583797c1-215" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(208.35,50.74)" id="img-583797c1-216" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(219.31,50.74)" id="img-583797c1-217" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-583797c1-218" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-583797c1-219" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-583797c1-220" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-583797c1-221" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-583797c1-222" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-583797c1-223" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-92.93,50.74)" id="img-583797c1-224" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-87.46,50.74)" id="img-583797c1-225" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-81.98,50.74)" id="img-583797c1-226" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-76.5,50.74)" id="img-583797c1-227" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-71.02,50.74)" id="img-583797c1-228" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-65.54,50.74)" id="img-583797c1-229" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-60.07,50.74)" id="img-583797c1-230" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-54.59,50.74)" id="img-583797c1-231" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-49.11,50.74)" id="img-583797c1-232" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-583797c1-233" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-38.15,50.74)" id="img-583797c1-234" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-32.68,50.74)" id="img-583797c1-235" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-27.2,50.74)" id="img-583797c1-236" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-21.72,50.74)" id="img-583797c1-237" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-16.24,50.74)" id="img-583797c1-238" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-10.77,50.74)" id="img-583797c1-239" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-5.29,50.74)" id="img-583797c1-240" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(0.19,50.74)" id="img-583797c1-241" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(5.67,50.74)" id="img-583797c1-242" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-583797c1-243" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(16.62,50.74)" id="img-583797c1-244" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(22.1,50.74)" id="img-583797c1-245" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(27.58,50.74)" id="img-583797c1-246" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(33.06,50.74)" id="img-583797c1-247" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(38.54,50.74)" id="img-583797c1-248" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(44.01,50.74)" id="img-583797c1-249" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(49.49,50.74)" id="img-583797c1-250" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(54.97,50.74)" id="img-583797c1-251" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(60.45,50.74)" id="img-583797c1-252" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-583797c1-253" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(71.4,50.74)" id="img-583797c1-254" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(76.88,50.74)" id="img-583797c1-255" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(82.36,50.74)" id="img-583797c1-256" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(87.84,50.74)" id="img-583797c1-257" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(93.31,50.74)" id="img-583797c1-258" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(98.79,50.74)" id="img-583797c1-259" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(104.27,50.74)" id="img-583797c1-260" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(109.75,50.74)" id="img-583797c1-261" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(115.23,50.74)" id="img-583797c1-262" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-583797c1-263" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(126.18,50.74)" id="img-583797c1-264" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(131.66,50.74)" id="img-583797c1-265" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(137.14,50.74)" id="img-583797c1-266" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(142.62,50.74)" id="img-583797c1-267" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(148.09,50.74)" id="img-583797c1-268" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(153.57,50.74)" id="img-583797c1-269" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(159.05,50.74)" id="img-583797c1-270" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(164.53,50.74)" id="img-583797c1-271" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(170,50.74)" id="img-583797c1-272" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-583797c1-273" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(180.96,50.74)" id="img-583797c1-274" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(186.44,50.74)" id="img-583797c1-275" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(191.92,50.74)" id="img-583797c1-276" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(197.39,50.74)" id="img-583797c1-277" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(202.87,50.74)" id="img-583797c1-278" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(208.35,50.74)" id="img-583797c1-279" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(213.83,50.74)" id="img-583797c1-280" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(219.31,50.74)" id="img-583797c1-281" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(224.78,50.74)" id="img-583797c1-282" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-583797c1-283" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
      </g>
      <g class="plotpanel" id="img-583797c1-284">
        <metadata>
          <boundingbox value="9.146294487847229mm 11.543736436631946mm 113.55725847255258mm 78.38289388020833mm"/>
          <unitbox value="-1.8255294335437036 3.0806637075678025 103.65105886708741 -3.1613274151356046"/>
        </metadata>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-583797c1-285">
          <g class="color_RGBA{N0f8}(1.0,0.647,0.0,1.0)" stroke-dasharray="none" stroke="#FFA500" id="img-583797c1-286">
            <g transform="translate(66.47,48.45)" id="img-583797c1-287">
              <path fill="none" d="M-54.23,-5.66 L-53.14,-12.95 -52.04,-18.99 -50.94,-23.28 -49.85,-25.51 -48.75,-25.52 -47.66,-23.37 -46.56,-19.29 -45.47,-13.7 -44.37,-7.15 -43.28,-0.28 -42.18,6.26 -41.08,11.84 -39.99,15.91 -38.89,18.07 -37.8,18.09 -36.7,15.93 -35.61,11.74 -34.51,5.86 -33.41,-1.22 -32.32,-8.88 -31.22,-16.49 -30.13,-23.37 -29.03,-28.95 -27.94,-32.73 -26.84,-34.42 -25.75,-33.86 -24.65,-31.12 -23.55,-26.46 -22.46,-20.3 -21.36,-13.19 -20.27,-5.78 -19.17,1.27 -18.08,7.35 -16.98,11.9 -15.89,14.54 -14.79,15.03 -13.69,13.35 -12.6,9.66 -11.5,4.32 -10.41,-2.19 -9.31,-9.25 -8.22,-16.21 -7.12,-22.42 -6.03,-27.29 -4.93,-30.36 -3.83,-31.31 -2.74,-30.03 -1.64,-26.59 -0.55,-21.26 0.55,-14.46 1.64,-6.77 2.74,1.17 3.83,8.7 4.93,15.2 6.03,20.14 7.12,23.12 8.22,23.93 9.31,22.55 10.41,19.16 11.5,14.1 12.6,7.9 13.69,1.14 14.79,-5.5 15.89,-11.39 16.98,-15.93 18.08,-18.68 19.17,-19.33 20.27,-17.78 21.36,-14.11 22.46,-8.59 23.55,-1.68 24.65,6.07 25.75,14 26.84,21.45 27.94,27.81 29.03,32.55 30.13,35.28 31.22,35.81 32.32,34.12 33.41,30.41 34.51,25.02 35.61,18.49 36.7,11.43 37.8,4.48 38.89,-1.7 39.99,-6.53 41.08,-9.58 42.18,-10.53 43.28,-9.31 44.37,-5.99 45.47,-0.87 46.56,5.59 47.66,12.84 48.75,20.22 49.85,27.08 50.94,32.79 52.04,36.85 53.14,38.87 54.23,38.67 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-583797c1-288">
          <g class="color_RGBA{N0f8}(0.0,0.502,0.0,1.0)" stroke-dasharray="none" stroke="#008000" id="img-583797c1-289">
            <g transform="translate(66.47,48.85)" id="img-583797c1-290">
              <path fill="none" d="M-54.23,0.35 L-53.14,13.07 -52.04,12.69 -50.94,9.11 -49.85,21.59 -48.75,10.22 -47.66,18.12 -46.56,-21.91 -45.47,-20.9 -44.37,9.98 -43.28,3.65 -42.18,5.5 -41.08,-24.92 -39.99,1.39 -38.89,13.6 -37.8,-23.22 -36.7,9.24 -35.61,2.14 -34.51,15.27 -33.41,-1.86 -32.32,-23.43 -31.22,-25.41 -30.13,-7.01 -29.03,3.37 -27.94,12.68 -26.84,4.16 -25.75,9.24 -24.65,-29.32 -23.55,-13.59 -22.46,-15.11 -21.36,2.92 -20.27,3.08 -19.17,-1.55 -18.08,-15.75 -16.98,-19.06 -15.89,3.58 -14.79,-10.21 -13.69,11.66 -12.6,13.55 -11.5,-2.17 -10.41,-4.94 -9.31,-3.49 -8.22,-24.53 -7.12,1.48 -6.03,12.45 -4.93,-31.61 -3.83,-3.17 -2.74,5.83 -1.64,-19.03 -0.55,-0.85 0.55,-9.61 1.64,-18.81 2.74,10.4 3.83,-11.72 4.93,-19.7 6.03,5.55 7.12,-22.94 8.22,-10.99 9.31,5.72 10.41,-9.13 11.5,1.94 12.6,17.67 13.69,5.24 14.79,-13.54 15.89,-11.39 16.98,8.01 18.08,23.31 19.17,-19.28 20.27,-12.31 21.36,-4.22 22.46,2.1 23.55,-11.48 24.65,1.18 25.75,-8.78 26.84,5.78 27.94,-9.7 29.03,0.77 30.13,-1.31 31.22,29.23 32.32,-13.12 33.41,23.35 34.51,3.38 35.61,33.94 36.7,26.67 37.8,-9.93 38.89,36.56 39.99,37.77 41.08,-0.71 42.18,10.02 43.28,-8.63 44.37,7.98 45.47,-6.35 46.56,10.34 47.66,13.49 48.75,18.47 49.85,-8.66 50.94,-0.52 52.04,2.32 53.14,6.32 54.23,8.42 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-583797c1-291">
          <g class="color_RGBA{N0f8}(0.0,0.0,1.0,1.0)" stroke-dasharray="none" stroke="#0000FF" id="img-583797c1-292">
            <g transform="translate(66.47,50.08)" id="img-583797c1-293">
              <path fill="none" d="M-54.23,-7.13 L-53.14,-7.13 -52.04,-12.44 -50.94,-17.61 -49.85,-12.69 -48.75,-17.49 -47.66,-10.5 -46.56,-25.57 -45.47,-18.63 -44.37,4.18 -43.28,8.69 -42.18,16.94 -41.08,8.05 -39.99,26.01 -38.89,34.97 -37.8,17.25 -36.7,31.94 -35.61,24.8 -34.51,26.04 -33.41,10.93 -32.32,-7.04 -31.22,-15.19 -30.13,-12.48 -29.03,-12.5 -27.94,-11.32 -26.84,-16.99 -25.75,-13.67 -24.65,-30.03 -23.55,-17.36 -22.46,-11.88 -21.36,4.29 -20.27,11.77 -19.17,16.46 -18.08,15.34 -16.98,18.09 -15.89,31.86 -14.79,25.23 -13.69,34.2 -12.6,31.14 -11.5,17.57 -10.41,9.27 -9.31,2.48 -8.22,-15.49 -7.12,-9.21 -6.03,-9.17 -4.93,-34.87 -3.83,-22.24 -2.74,-17.13 -1.64,-26.82 -0.55,-13.13 0.55,-11.47 1.64,-9.17 2.74,12.57 3.83,8.22 4.93,9.88 6.03,26.57 7.12,14.42 8.22,20.31 9.31,26.38 10.41,14.65 11.5,14.2 12.6,14.93 13.69,1.03 14.79,-15.93 15.89,-21.67 16.98,-17.43 18.08,-13.45 19.17,-36.3 20.27,-32.15 21.36,-25.32 22.46,-17.5 23.55,-18.22 24.65,-4.97 25.75,-2.82 26.84,11.14 27.94,9.01 29.03,18.26 30.13,19.26 31.22,34.4 32.32,10.92 33.41,24.84 34.51,8.93 35.61,17.16 36.7,5.98 37.8,-19.7 38.89,-3.03 39.99,-7.61 41.08,-30.2 42.18,-26.06 43.28,-34.37 44.37,-22.93 45.47,-25.1 46.56,-10.37 47.66,-1.58 48.75,8.3 49.85,1.65 50.94,11.54 52.04,17.16 53.14,21.38 54.23,22.48 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-583797c1-294">
          <g class="color_RGBA{N0f8}(1.0,0.0,0.0,1.0)" stroke-dasharray="none" stroke="#FF0000" id="img-583797c1-295">
            <g transform="translate(66.47,48.65)" id="img-583797c1-296">
              <path fill="none" d="M-54.23,-2.66 L-53.14,0.06 -52.04,-3.15 -50.94,-7.09 -49.85,-1.96 -48.75,-7.65 -47.66,-2.62 -46.56,-20.6 -45.47,-17.3 -44.37,1.41 -43.28,1.69 -42.18,5.88 -41.08,-6.54 -39.99,8.65 -38.89,15.84 -37.8,-2.56 -36.7,12.58 -35.61,6.94 -34.51,10.56 -33.41,-1.54 -32.32,-16.16 -31.22,-20.95 -30.13,-15.19 -29.03,-12.79 -27.94,-10.03 -26.84,-15.13 -25.75,-12.31 -24.65,-30.22 -23.55,-20.02 -22.46,-17.7 -21.36,-5.14 -20.27,-1.35 -19.17,-0.14 -18.08,-4.2 -16.98,-3.58 -15.89,9.06 -14.79,2.41 -13.69,12.51 -12.6,11.61 -11.5,1.07 -10.41,-3.56 -9.31,-6.37 -8.22,-20.37 -7.12,-10.47 -6.03,-7.42 -4.93,-30.98 -3.83,-17.24 -2.74,-12.1 -1.64,-22.81 -0.55,-11.05 0.55,-12.04 1.64,-12.79 2.74,5.78 3.83,-1.51 4.93,-2.25 6.03,12.85 7.12,0.09 8.22,6.47 9.31,14.14 10.41,5.02 11.5,8.02 12.6,12.78 13.69,3.19 14.79,-9.52 15.89,-11.39 16.98,-3.96 18.08,2.31 19.17,-19.31 20.27,-15.04 21.36,-9.17 22.46,-3.25 23.55,-6.58 24.65,3.62 25.75,2.61 26.84,13.62 27.94,9.05 29.03,16.66 30.13,16.98 31.22,32.52 32.32,10.5 33.41,26.88 34.51,14.2 35.61,26.22 36.7,19.05 37.8,-2.72 38.89,17.43 39.99,15.62 41.08,-5.14 42.18,-0.26 43.28,-8.97 44.37,1 45.47,-3.61 46.56,7.97 47.66,13.16 48.75,19.35 49.85,9.21 50.94,16.14 52.04,19.58 53.14,22.59 54.23,23.55 " class="primitive"/>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide crosshair" id="img-583797c1-297">
        <g class="text_box" fill="#000000" id="img-583797c1-298">
          <g transform="translate(115.65,12.07)" id="img-583797c1-299">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em"></text>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide helpscreen" id="img-583797c1-300">
        <g class="text_box" id="img-583797c1-301">
          <g fill="#000000" id="img-583797c1-302">
            <g transform="translate(65.92,50.74)" id="img-583797c1-303">
              <path d="M-34.41,-12.5 L34.41,-12.5 34.41,12.5 -34.41,12.5  z" class="primitive"/>
            </g>
          </g>
          <g fill="#FFFF74" font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-583797c1-304">
            <g transform="translate(65.92,41.65)" id="img-583797c1-305">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">h,j,k,l,arrows,drag to pan</text>
              </g>
            </g>
            <g transform="translate(65.92,46.19)" id="img-583797c1-306">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">i,o,+,-,scroll,shift-drag to zoom</text>
              </g>
            </g>
            <g transform="translate(65.92,50.74)" id="img-583797c1-307">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">r,dbl-click to reset</text>
              </g>
            </g>
            <g transform="translate(65.92,55.28)" id="img-583797c1-308">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">c for coordinates</text>
              </g>
            </g>
            <g transform="translate(65.92,59.82)" id="img-583797c1-309">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">? for help</text>
              </g>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide questionmark" id="img-583797c1-310">
        <g class="text_box" fill="#000000" id="img-583797c1-311">
          <g transform="translate(122.7,12.07)" id="img-583797c1-312">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em">?</text>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g class="guide ylabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-583797c1-313">
    <g transform="translate(8.15,187.1)" id="img-583797c1-314" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-4</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-583797c1-315" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-583797c1-316" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-583797c1-317" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-583797c1-318" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-583797c1-319" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-583797c1-320" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-583797c1-321" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-583797c1-322" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-583797c1-323" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-583797c1-324" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6</text>
      </g>
    </g>
    <g transform="translate(8.15,-85.63)" id="img-583797c1-325" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">7</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-583797c1-326" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,157.35)" id="img-583797c1-327" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,152.39)" id="img-583797c1-328" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,147.43)" id="img-583797c1-329" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,142.47)" id="img-583797c1-330" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-583797c1-331" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,132.56)" id="img-583797c1-332" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,127.6)" id="img-583797c1-333" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,122.64)" id="img-583797c1-334" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,117.68)" id="img-583797c1-335" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-583797c1-336" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,107.76)" id="img-583797c1-337" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,102.8)" id="img-583797c1-338" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,97.84)" id="img-583797c1-339" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,92.89)" id="img-583797c1-340" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-583797c1-341" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(8.15,82.97)" id="img-583797c1-342" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,78.01)" id="img-583797c1-343" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,73.05)" id="img-583797c1-344" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,68.09)" id="img-583797c1-345" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-583797c1-346" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,58.17)" id="img-583797c1-347" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,53.21)" id="img-583797c1-348" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,48.26)" id="img-583797c1-349" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,43.3)" id="img-583797c1-350" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-583797c1-351" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,33.38)" id="img-583797c1-352" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,28.42)" id="img-583797c1-353" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,23.46)" id="img-583797c1-354" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,18.5)" id="img-583797c1-355" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-583797c1-356" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,8.58)" id="img-583797c1-357" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.2</text>
      </g>
    </g>
    <g transform="translate(8.15,3.63)" id="img-583797c1-358" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-1.33)" id="img-583797c1-359" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-6.29)" id="img-583797c1-360" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-583797c1-361" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-16.21)" id="img-583797c1-362" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-21.17)" id="img-583797c1-363" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-26.13)" id="img-583797c1-364" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-31.09)" id="img-583797c1-365" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-583797c1-366" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-41)" id="img-583797c1-367" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-45.96)" id="img-583797c1-368" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-50.92)" id="img-583797c1-369" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-55.88)" id="img-583797c1-370" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-583797c1-371" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6.0</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-583797c1-372" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-583797c1-373" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-583797c1-374" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-583797c1-375" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-583797c1-376" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,159.83)" id="img-583797c1-377" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.9</text>
      </g>
    </g>
    <g transform="translate(8.15,157.35)" id="img-583797c1-378" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,154.87)" id="img-583797c1-379" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.7</text>
      </g>
    </g>
    <g transform="translate(8.15,152.39)" id="img-583797c1-380" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,149.91)" id="img-583797c1-381" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.5</text>
      </g>
    </g>
    <g transform="translate(8.15,147.43)" id="img-583797c1-382" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,144.95)" id="img-583797c1-383" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.3</text>
      </g>
    </g>
    <g transform="translate(8.15,142.47)" id="img-583797c1-384" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,139.99)" id="img-583797c1-385" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.1</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-583797c1-386" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,135.04)" id="img-583797c1-387" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.9</text>
      </g>
    </g>
    <g transform="translate(8.15,132.56)" id="img-583797c1-388" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,130.08)" id="img-583797c1-389" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.7</text>
      </g>
    </g>
    <g transform="translate(8.15,127.6)" id="img-583797c1-390" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,125.12)" id="img-583797c1-391" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.5</text>
      </g>
    </g>
    <g transform="translate(8.15,122.64)" id="img-583797c1-392" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,120.16)" id="img-583797c1-393" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.3</text>
      </g>
    </g>
    <g transform="translate(8.15,117.68)" id="img-583797c1-394" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,115.2)" id="img-583797c1-395" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.1</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-583797c1-396" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,110.24)" id="img-583797c1-397" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.9</text>
      </g>
    </g>
    <g transform="translate(8.15,107.76)" id="img-583797c1-398" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,105.28)" id="img-583797c1-399" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.7</text>
      </g>
    </g>
    <g transform="translate(8.15,102.8)" id="img-583797c1-400" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,100.32)" id="img-583797c1-401" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.5</text>
      </g>
    </g>
    <g transform="translate(8.15,97.84)" id="img-583797c1-402" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,95.36)" id="img-583797c1-403" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.3</text>
      </g>
    </g>
    <g transform="translate(8.15,92.89)" id="img-583797c1-404" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,90.41)" id="img-583797c1-405" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.1</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-583797c1-406" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(8.15,85.45)" id="img-583797c1-407" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.1</text>
      </g>
    </g>
    <g transform="translate(8.15,82.97)" id="img-583797c1-408" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,80.49)" id="img-583797c1-409" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.3</text>
      </g>
    </g>
    <g transform="translate(8.15,78.01)" id="img-583797c1-410" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,75.53)" id="img-583797c1-411" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.5</text>
      </g>
    </g>
    <g transform="translate(8.15,73.05)" id="img-583797c1-412" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,70.57)" id="img-583797c1-413" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.7</text>
      </g>
    </g>
    <g transform="translate(8.15,68.09)" id="img-583797c1-414" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,65.61)" id="img-583797c1-415" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.9</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-583797c1-416" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,60.65)" id="img-583797c1-417" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.1</text>
      </g>
    </g>
    <g transform="translate(8.15,58.17)" id="img-583797c1-418" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,55.69)" id="img-583797c1-419" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.3</text>
      </g>
    </g>
    <g transform="translate(8.15,53.21)" id="img-583797c1-420" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,50.74)" id="img-583797c1-421" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.5</text>
      </g>
    </g>
    <g transform="translate(8.15,48.26)" id="img-583797c1-422" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,45.78)" id="img-583797c1-423" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.7</text>
      </g>
    </g>
    <g transform="translate(8.15,43.3)" id="img-583797c1-424" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,40.82)" id="img-583797c1-425" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.9</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-583797c1-426" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,35.86)" id="img-583797c1-427" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.1</text>
      </g>
    </g>
    <g transform="translate(8.15,33.38)" id="img-583797c1-428" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,30.9)" id="img-583797c1-429" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.3</text>
      </g>
    </g>
    <g transform="translate(8.15,28.42)" id="img-583797c1-430" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,25.94)" id="img-583797c1-431" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.5</text>
      </g>
    </g>
    <g transform="translate(8.15,23.46)" id="img-583797c1-432" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,20.98)" id="img-583797c1-433" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.7</text>
      </g>
    </g>
    <g transform="translate(8.15,18.5)" id="img-583797c1-434" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,16.02)" id="img-583797c1-435" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.9</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-583797c1-436" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,11.06)" id="img-583797c1-437" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.1</text>
      </g>
    </g>
    <g transform="translate(8.15,8.58)" id="img-583797c1-438" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.2</text>
      </g>
    </g>
    <g transform="translate(8.15,6.11)" id="img-583797c1-439" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.3</text>
      </g>
    </g>
    <g transform="translate(8.15,3.63)" id="img-583797c1-440" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.4</text>
      </g>
    </g>
    <g transform="translate(8.15,1.15)" id="img-583797c1-441" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-1.33)" id="img-583797c1-442" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-3.81)" id="img-583797c1-443" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-6.29)" id="img-583797c1-444" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-8.77)" id="img-583797c1-445" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-583797c1-446" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-13.73)" id="img-583797c1-447" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.1</text>
      </g>
    </g>
    <g transform="translate(8.15,-16.21)" id="img-583797c1-448" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-18.69)" id="img-583797c1-449" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.3</text>
      </g>
    </g>
    <g transform="translate(8.15,-21.17)" id="img-583797c1-450" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-23.65)" id="img-583797c1-451" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-26.13)" id="img-583797c1-452" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-28.61)" id="img-583797c1-453" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-31.09)" id="img-583797c1-454" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-33.57)" id="img-583797c1-455" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-583797c1-456" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-38.52)" id="img-583797c1-457" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.1</text>
      </g>
    </g>
    <g transform="translate(8.15,-41)" id="img-583797c1-458" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-43.48)" id="img-583797c1-459" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.3</text>
      </g>
    </g>
    <g transform="translate(8.15,-45.96)" id="img-583797c1-460" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-48.44)" id="img-583797c1-461" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-50.92)" id="img-583797c1-462" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-53.4)" id="img-583797c1-463" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-55.88)" id="img-583797c1-464" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-58.36)" id="img-583797c1-465" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-583797c1-466" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6.0</text>
      </g>
    </g>
  </g>
  <g font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-583797c1-467">
    <g transform="translate(65.92,5)" id="img-583797c1-468">
      <g class="primitive">
        <text text-anchor="middle" dy="0.6em">Mixed signals</text>
      </g>
    </g>
  </g>
</g>
<defs>
  <clipPath id="img-583797c1-20">
    <path d="M9.15,11.54 L122.7,11.54 122.7,89.93 9.15,89.93 " />
  </clipPath>
</defs>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
<script> <![CDATA[

(function (glob, factory) {
    // AMD support
    if (typeof define === "function" && define.amd) {
        // Define as an anonymous module
        define("Gadfly", ["Snap.svg"], function (Snap) {
            return factory(Snap);
        });
    } else {
        // Browser globals (glob is window)
        // Snap adds itself to window
        glob.Gadfly = factory(glob.Snap);
    }
}(this, function (Snap) {

var Gadfly = {};

// Get an x/y coordinate value in pixels
var xPX = function(fig, x) {
    var client_box = fig.node.getBoundingClientRect();
    return x * fig.node.viewBox.baseVal.width / client_box.width;
};

var yPX = function(fig, y) {
    var client_box = fig.node.getBoundingClientRect();
    return y * fig.node.viewBox.baseVal.height / client_box.height;
};


Snap.plugin(function (Snap, Element, Paper, global) {
    // Traverse upwards from a snap element to find and return the first
    // note with the "plotroot" class.
    Element.prototype.plotroot = function () {
        var element = this;
        while (!element.hasClass("plotroot") && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.svgroot = function () {
        var element = this;
        while (element.node.nodeName != "svg" && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.plotbounds = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.viewportplotbounds = function () {
        var root = this.svgroot();
        var bbox = root.node.getBoundingClientRect();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.plotcenter = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x: bbox.x + bbox.width / 2,
            y: bbox.y + bbox.height / 2
        };
    };

    // Emulate IE style mouseenter/mouseleave events, since Microsoft always
    // does everything right.
    // See: http://www.dynamic-tools.net/toolbox/isMouseLeaveOrEnter/
    var events = ["mouseenter", "mouseleave"];

    for (i in events) {
        (function (event_name) {
            var event_name = events[i];
            Element.prototype[event_name] = function (fn, scope) {
                if (Snap.is(fn, "function")) {
                    var fn2 = function (event) {
                        if (event.type != "mouseover" && event.type != "mouseout") {
                            return;
                        }

                        var reltg = event.relatedTarget ? event.relatedTarget :
                            event.type == "mouseout" ? event.toElement : event.fromElement;
                        while (reltg && reltg != this.node) reltg = reltg.parentNode;

                        if (reltg != this.node) {
                            return fn.apply(this, event);
                        }
                    };

                    if (event_name == "mouseenter") {
                        this.mouseover(fn2, scope);
                    } else {
                        this.mouseout(fn2, scope);
                    }
                }
                return this;
            };
        })(events[i]);
    }


    Element.prototype.mousewheel = function (fn, scope) {
        if (Snap.is(fn, "function")) {
            var el = this;
            var fn2 = function (event) {
                fn.apply(el, [event]);
            };
        }

        this.node.addEventListener("wheel", fn2);

        return this;
    };


    // Snap's attr function can be too slow for things like panning/zooming.
    // This is a function to directly update element attributes without going
    // through eve.
    Element.prototype.attribute = function(key, val) {
        if (val === undefined) {
            return this.node.getAttribute(key);
        } else {
            this.node.setAttribute(key, val);
            return this;
        }
    };

    Element.prototype.init_gadfly = function() {
        this.mouseenter(Gadfly.plot_mouseover)
            .mousemove(Gadfly.plot_mousemove)
            .mouseleave(Gadfly.plot_mouseout)
            .dblclick(Gadfly.plot_dblclick)
            .mousewheel(Gadfly.guide_background_scroll)
            .drag(Gadfly.guide_background_drag_onmove,
                  Gadfly.guide_background_drag_onstart,
                  Gadfly.guide_background_drag_onend);
        this.mouseenter(function (event) {
            init_pan_zoom(this.plotroot());
        });
        return this;
    };
});


Gadfly.plot_mousemove = function(event, _x_px, _y_px) {
    var root = this.plotroot();
    var viewbounds = root.viewportplotbounds();

    // (_x_px, _y_px) are offsets relative to page (event.layerX, event.layerY) rather than viewport
    var x_px = event.clientX - viewbounds.x0;
    var y_px = event.clientY - viewbounds.y0;
    if (root.data("crosshair")) {
        px_per_mm = root.data("px_per_mm");
        bB = root.select('boundingbox').node.getAttribute('value').split(' ');
        uB = root.select('unitbox').node.getAttribute('value').split(' ');
        xscale = root.data("xscale");
        yscale = root.data("yscale");
        xtranslate = root.data("tx");
        ytranslate = root.data("ty");

        xoff_mm = bB[0].substr(0,bB[0].length-2)/1;
        yoff_mm = bB[1].substr(0,bB[1].length-2)/1;
        xoff_unit = uB[0]/1;
        yoff_unit = uB[1]/1;
        mm_per_xunit = bB[2].substr(0,bB[2].length-2) / uB[2];
        mm_per_yunit = bB[3].substr(0,bB[3].length-2) / uB[3];

        x_unit = ((x_px / px_per_mm - xtranslate) / xscale - xoff_mm) / mm_per_xunit + xoff_unit;
        y_unit = ((y_px / px_per_mm - ytranslate) / yscale - yoff_mm) / mm_per_yunit + yoff_unit;

        root.select('.crosshair').select('.primitive').select('text')
                .node.innerHTML = x_unit.toPrecision(3)+","+y_unit.toPrecision(3);
    };
};

Gadfly.helpscreen_visible = function(event) {
    helpscreen_visible(this.plotroot());
};
var helpscreen_visible = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 1.0}, 250);
};

Gadfly.helpscreen_hidden = function(event) {
    helpscreen_hidden(this.plotroot());
};
var helpscreen_hidden = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 0.0}, 250);
};

// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_help = function(event) {
        if (event.which == 191) { // ?
            helpscreen_visible(root);
        }
    };
    root.data("keyboard_help", keyboard_help);
    window.addEventListener("keydown", keyboard_help);

    var keyboard_pan_zoom = function(event) {
        var bounds = root.plotbounds(),
            width = bounds.x1 - bounds.x0;
            height = bounds.y1 - bounds.y0;
        if (event.which == 187 || event.which == 73) { // plus or i
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189 || event.which == 79) { // minus or o
            increase_zoom_by_position(root, -0.1, true);
        } else if (event.which == 39 || event.which == 76) { // right-arrow or l
            set_plot_pan_zoom(root, root.data("tx")-width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 40 || event.which == 74) { // down-arrow or j
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")-height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 37 || event.which == 72) { // left-arrow or h
            set_plot_pan_zoom(root, root.data("tx")+width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 38 || event.which == 75) { // up-arrow or k
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")+height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 82) { // r
            set_plot_pan_zoom(root, 0.0, 0.0, 1.0, 1.0);
        } else if (event.which == 191) { // ?
            helpscreen_hidden(root);
        } else if (event.which == 67) { // c
            root.data("crosshair",!root.data("crosshair"));
            root.select(".crosshair")
                .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
        }
    };
    root.data("keyboard_pan_zoom", keyboard_pan_zoom);
    window.addEventListener("keyup", keyboard_pan_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        xgridlines.data("unfocused_strokedash",
                        xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        ygridlines.data("unfocused_strokedash",
                        ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair")
        .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_pan_zoom"));
    root.data("keyboard_pan_zoom", undefined);
    window.removeEventListener("keydown", root.data("keyboard_help"));
    root.data("keyboard_help", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        var destcolor = root.data("unfocused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        var destcolor = root.data("unfocused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair").animate({"fill-opacity": 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 0.0}, 250);
    helpscreen_hidden(root);
};


var set_geometry_transform = function(root, tx, ty, xscale, yscale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");

    var xscale = xscalable ? xscale : 1.0,
        yscale = yscalable ? yscale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);
    root.selectAll(".geometry, image").forEach(function (element, i) {
            element.transform(t);
        });

    var t = new Snap.Matrix().scale(1.0/xscale, 1.0/yscale);
    root.selectAll('.marker').forEach(function (element, i) {
        element.selectAll('.primitive').forEach(function (element, i) {
            element.transform(t);
        }) });

    bounds = root.plotbounds();
    px_per_mm = root.data("px_per_mm");

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        ylabels = root.select(".ylabels");
        if (ylabels) {
            ylabels.transform(xfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1, 1/yscale);
                           element.select("text").transform(unscale_t);

                           var y = element.attr("transform").globalMatrix.f / px_per_mm;
                           element.attr("visibility",
                               bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                       }
                   });
        }
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        xlabels = root.select(".xlabels");
        if (xlabels) {
            xlabels.transform(yfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1/xscale, 1);
                           element.select("text").transform(unscale_t);

                           var x = element.attr("transform").globalMatrix.e / px_per_mm;
                           element.attr("visibility",
                               bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                           }
                   });
        }
    }
};


// Find the most appropriate tick scale and update label visibility.
var update_tickscale = function(root, scale, axis) {
    if (!root.hasClass(axis + "scalable")) return;

    var tickscales = root.data(axis + "tickscales");
    var best_tickscale = 1.0;
    var best_tickscale_dist = Infinity;
    for (tickscale in tickscales) {
        var dist = Math.abs(Math.log(tickscale) - Math.log(scale));
        if (dist < best_tickscale_dist) {
            best_tickscale_dist = dist;
            best_tickscale = tickscale;
        }
    }

    if (best_tickscale != root.data(axis + "tickscale")) {
        root.data(axis + "tickscale", best_tickscale);
        var mark_inscale_gridlines = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("g").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("g").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, xscale, yscale) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, xscale, and yscale
    var x_min = -width * xscale - (xscale * width - width),
        x_max = width * xscale,
        y_min = -height * yscale - (yscale * height - height),
        y_max = height * yscale;

    var x0 = bounds.x0 - xscale * bounds.x0,
        y0 = bounds.y0 - yscale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale changes, we may need to alter which set of
    // ticks are being displayed
    if (xscale != old_xscale) {
        update_tickscale(root, xscale, "x");
    }
    if (yscale != old_yscale) {
        update_tickscale(root, yscale, "y");
    }

    set_geometry_transform(root, tx, ty, xscale, yscale);

    root.data("xscale", xscale);
    root.data("yscale", yscale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, xscale, yscale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var xscale0 = root.data("xscale"),
        yscale0 = root.data("yscale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - xscale0) + (width * (1 - xscale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - yscale0) + (height * (1 - yscale0)) / 2);

    // rescale offsets
    xoff = xoff * xscale / xscale0;
    yoff = yoff * yscale / yscale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - xscale),
        y_edge_adjust = bounds.y0 * (1 - yscale);

    return {
        x: xoff + x_edge_adjust + (width - width * xscale) / 2,
        y: yoff + y_edge_adjust + (height - height * yscale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

    root.data("crosshair",false);

    // The non-scaling-stroke trick. Rather than try to correct for the
    // stroke-width when zooming, we force it to a fixed value.
    var px_per_mm = root.node.getCTM().a;

    // Drag events report deltas in pixels, which we'd like to convert to
    // millimeters.
    root.data("px_per_mm", px_per_mm);

    root.selectAll("path")
        .forEach(function (element, i) {
        sw = element.asPX("stroke-width") * px_per_mm;
        if (sw > 0) {
            element.attribute("stroke-width", sw);
            element.attribute("vector-effect", "non-scaling-stroke");
        }
    });

    // Store ticks labels original tranformation
    root.selectAll(".xlabels > g, .ylabels > g")
        .forEach(function (element, i) {
            var lm = element.transform().localMatrix;
            element.data("static_transform",
                new Snap.Matrix(lm.a, lm.b, lm.c, lm.d, lm.e, lm.f));
        });

    var xgridlines = root.select(".xgridlines");
    var ygridlines = root.select(".ygridlines");
    var xlabels = root.select(".xlabels");
    var ylabels = root.select(".ylabels");

    if (root.data("tx") === undefined) root.data("tx", 0);
    if (root.data("ty") === undefined) root.data("ty", 0);
    if (root.data("xscale") === undefined) root.data("xscale", 1.0);
    if (root.data("yscale") === undefined) root.data("yscale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("g").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("g").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("g").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("g").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
        root.data("ytickscale", 1.0);  // ???
    }

    var min_scale = 1.0, max_scale = 1.0;
    for (scale in xtickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    for (scale in ytickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    root.data("min_scale", min_scale);
    root.data("max_scale", max_scale);

    // store the original positions of labels
    if (xlabels) {
        xlabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        if (element.attribute("gadfly:scale") == null) { return; }
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("g").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("g").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("g").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("g").forEach(mark_inscale);

    // figure out the upper ond lower bounds on panning using the maximum
    // and minum grid lines
    var bounds = root.plotbounds();
    var pan_bounds = {
        x0: 0.0,
        y0: 0.0,
        x1: 0.0,
        y1: 0.0
    };

    if (xgridlines) {
        xgridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.x1 - bbox.x < pan_bounds.x0) {
                        pan_bounds.x0 = bounds.x1 - bbox.x;
                    }
                    if (bounds.x0 - bbox.x > pan_bounds.x1) {
                        pan_bounds.x1 = bounds.x0 - bbox.x;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    if (ygridlines) {
        ygridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.y1 - bbox.y < pan_bounds.y0) {
                        pan_bounds.y0 = bounds.y1 - bbox.y;
                    }
                    if (bounds.y0 - bbox.y > pan_bounds.y1) {
                        pan_bounds.y1 = bounds.y0 - bbox.y;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    // nudge these values a little
    pan_bounds.x0 -= 5;
    pan_bounds.x1 += 5;
    pan_bounds.y0 -= 5;
    pan_bounds.y1 += 5;
    root.data("pan_bounds", pan_bounds);

    root.data("zoompan-ready", true)
};


// drag actions, i.e. zooming and panning
var pan_action = {
    start: function(root, x, y, event) {
        root.data("dx", 0);
        root.data("dy", 0);
        root.data("tx0", root.data("tx"));
        root.data("ty0", root.data("ty"));
    },
    update: function(root, dx, dy, x, y, event) {
        var px_per_mm = root.data("px_per_mm");
        dx /= px_per_mm;
        dy /= px_per_mm;

        var tx0 = root.data("tx"),
            ty0 = root.data("ty");

        var dx0 = root.data("dx"),
            dy0 = root.data("dy");

        root.data("dx", dx);
        root.data("dy", dy);

        dx = dx - dx0;
        dy = dy - dy0;

        var tx = tx0 + dx,
            ty = ty0 + dy;

        set_plot_pan_zoom(root, tx, ty, root.data("xscale"), root.data("yscale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"),
                root.data("xscale"), root.data("yscale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, _x, _y, event) {
        var bounds = root.plotbounds();
        // _x and _y are co-ordinates relative to page, which caused problems
        // unless the SVG is precisely at the top-left of the page
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;

        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "fill-opacity": 0.25
        });
    },
    update: function(root, dx, dy, _x, _y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;
        if (yscalable) {
            y /= px_per_mm;
            y = Math.max(bounds.y0, y);
            y = Math.min(bounds.y1, y);
        } else {
            y = bounds.y1;
        }
        if (xscalable) {
            x /= px_per_mm;
            x = Math.max(bounds.x0, x);
            x = Math.min(bounds.x1, x);
        } else {
            x = bounds.x1;
        }

        dx = x - zoom_box.attr("x");
        dy = y - zoom_box.attr("y");
        var xoffset = 0,
            yoffset = 0;
        if (dx < 0) {
            xoffset = dx;
            dx = -1 * dx;
        }
        if (dy < 0) {
            yoffset = dy;
            dy = -1 * dy;
        }
        if (isNaN(dy)) {
            dy = 0.0;
        }
        if (isNaN(dx)) {
            dx = 0.0;
        }
        zoom_box.transform("T" + xoffset + "," + yoffset);
        zoom_box.attr("width", dx);
        zoom_box.attr("height", dy);
    },
    end: function(root, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var zoom_bounds = zoom_box.getBBox();
        if (zoom_bounds.width * zoom_bounds.height <= 0) {
            return;
        }
        var plot_bounds = root.plotbounds();
        var xzoom_factor = 1.0,
            yzoom_factor = 1.0;
        if (xscalable) {
            xzoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        if (yscalable) {
            yzoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * xzoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * yzoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty,
                root.data("xscale") * xzoom_factor, root.data("yscale") * yzoom_factor);
        zoom_box.remove();
    },
    cancel: function(root) {
        zoom_box.remove();
    }
};


Gadfly.guide_background_drag_onstart = function(x, y, event) {
    var root = this.plotroot();
    var scalable = root.hasClass("xscalable") || root.hasClass("yscalable");
    var zoomable = !event.altKey && !event.ctrlKey && event.shiftKey && scalable;
    var panable = !event.altKey && !event.ctrlKey && !event.shiftKey && scalable;
    var drag_action = zoomable ? zoom_action :
                      panable  ? pan_action :
                                 undefined;
    root.data("drag_action", drag_action);
    if (drag_action) {
        var cancel_drag_action = function(event) {
            if (event.which == 27) { // esc key
                drag_action.cancel(root);
                root.data("drag_action", undefined);
            }
        };
        window.addEventListener("keyup", cancel_drag_action);
        root.data("cancel_drag_action", cancel_drag_action);
        drag_action.start(root, x, y, event);
    }
};


Gadfly.guide_background_drag_onmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.update(root, dx, dy, x, y, event);
    }
};


Gadfly.guide_background_drag_onend = function(event) {
    var root = this.plotroot();
    window.removeEventListener("keyup", root.data("cancel_drag_action"));
    root.data("cancel_drag_action", undefined);
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.end(root, event);
    }
    root.data("drag_action", undefined);
};


Gadfly.guide_background_scroll = function(event) {
    if (event.shiftKey) {
        // event.deltaY is either the number of pixels, lines, or pages scrolled past.
        var actual_delta;
        switch (event.deltaMode) {
            case 0: // Chromium-based
                actual_delta = -event.deltaY / 1000.0;
                break;
            case 1: // Firefox
                actual_delta = -event.deltaY / 50.0;
                break;
            default:
                actual_delta = -event.deltaY;
        }
        // Assumes 20 pixels/line to get reasonably consistent cross-browser behaviour.
        increase_zoom_by_position(this.plotroot(), actual_delta);
        event.preventDefault();
    }
};

// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    if (min_scale==max_scale) { return 1; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    if (min_scale==max_scale) { return min_scale; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var xposition = slider_position_from_scale(old_xscale, min_scale, max_scale),
        yposition = slider_position_from_scale(old_yscale, min_scale, max_scale);
    xposition += (root.hasClass("xscalable") ? delta_position : 0.0);
    yposition += (root.hasClass("yscalable") ? delta_position : 0.0);
    old_xscale = scale_from_slider_position(xposition, min_scale, max_scale);
    old_yscale = scale_from_slider_position(yposition, min_scale, max_scale);
    var new_xscale = Math.max(min_scale, Math.min(old_xscale, max_scale)),
        new_yscale = Math.max(min_scale, Math.min(old_yscale, max_scale));
    if (animate) {
        Snap.animate(
            [old_xscale, old_yscale],
            [new_xscale, new_yscale],
            function (new_scale) {
                update_plot_scale(root, new_scale[0], new_scale[1]);
            },
            200);
    } else {
        update_plot_scale(root, new_xscale, new_yscale);
    }
}


var update_plot_scale = function(root, new_xscale, new_yscale) {
    var trans = scale_centered_translation(root, new_xscale, new_yscale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_xscale, new_yscale);
};


var toggle_color_class = function(root, color_class, ison) {
    var escaped_color_class = color_class.replace(/([^0-9a-zA-z])/g,"\\$1");
    var guides = root.selectAll(".guide." + escaped_color_class + ",.guide ." + escaped_color_class);
    var geoms = root.selectAll(".geometry." + escaped_color_class + ",.geometry ." + escaped_color_class);
    if (ison) {
        guides.animate({opacity: 0.5}, 250);
        geoms.animate({opacity: 0.0}, 250);
    } else {
        guides.animate({opacity: 1.0}, 250);
        geoms.animate({opacity: 1.0}, 250);
    }
};


Gadfly.colorkey_swatch_click = function(event) {
    var root = this.plotroot();
    var color_class = this.data("color_class");

    if (event.shiftKey) {
        root.selectAll(".colorkey g")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (typeof other_color_class !== 'undefined' && other_color_class != color_class) {
                    toggle_color_class(root, other_color_class,
                                       element.attr("opacity") == 1.0);
                }
            });
    } else {
        toggle_color_class(root, color_class, this.attr("opacity") == 1.0);
    }
};


return Gadfly;

}));


//@ sourceURL=gadfly.js

(function (glob, factory) {
    // AMD support
      if (typeof require === "function" && typeof define === "function" && define.amd) {
        require(["Snap.svg", "Gadfly"], function (Snap, Gadfly) {
            factory(Snap, Gadfly);
        });
      } else {
          factory(glob.Snap, glob.Gadfly);
      }
})(window, function (Snap, Gadfly) {
    var fig = Snap("#img-583797c1");
fig.select("#img-583797c1-3")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-583797c1-21")
   .init_gadfly();
fig.select("#img-583797c1-24")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-583797c1-24")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-583797c1-178")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-583797c1-178")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-583797c1-311")
   .mouseenter(Gadfly.helpscreen_visible)
.mouseleave(Gadfly.helpscreen_hidden)
;
    });
]]> </script>
</svg>




## Blind signal reconstruction


```julia
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk);
```

    OF = 3.5187622911849673e-13


## Reconstructed sources


```julia
Mads.plotseries(Wipopt, title="Reconstructed sources", name="Source", quiet=true)
```




<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="141.42mm" height="100mm" viewBox="0 0 141.42 100"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="img-3b7fec4c">
<defs>
  <marker id="arrow" markerWidth="15" markerHeight="7" refX="5" refY="3.5" orient="auto" markerUnits="strokeWidth">
    <path d="M0,0 L15,3.5 L0,7 z" stroke="context-stroke" fill="context-stroke"/>
  </marker>
</defs>
<g class="plotroot xscalable yscalable" id="img-3b7fec4c-1">
  <g class="guide xlabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-3b7fec4c-2">
    <g transform="translate(-144.11,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-150</text>
      </g>
    </g>
    <g transform="translate(-91.15,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-38.19,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(14.78,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(67.74,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(173.67,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(226.64,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(279.6,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">250</text>
      </g>
    </g>
    <g transform="translate(-91.15,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-80.56,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-69.96,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-59.37,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-48.78,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-38.19,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-27.59,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-17,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-6.41,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(4.19,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(14.78,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(25.37,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(35.97,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(46.56,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(57.15,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(67.74,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(78.34,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(88.93,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(99.52,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(110.12,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(131.3,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(141.89,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(152.49,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(163.08,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(173.67,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(184.27,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(194.86,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(205.45,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(216.05,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(226.64,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-91.15,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(14.78,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(226.64,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-91.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-85.85,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-95</text>
      </g>
    </g>
    <g transform="translate(-80.56,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-75.26,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-85</text>
      </g>
    </g>
    <g transform="translate(-69.96,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-64.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-75</text>
      </g>
    </g>
    <g transform="translate(-59.37,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-54.07,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-65</text>
      </g>
    </g>
    <g transform="translate(-48.78,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-43.48,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-55</text>
      </g>
    </g>
    <g transform="translate(-38.19,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-32.89,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-45</text>
      </g>
    </g>
    <g transform="translate(-27.59,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-22.3,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-35</text>
      </g>
    </g>
    <g transform="translate(-17,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-11.7,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-25</text>
      </g>
    </g>
    <g transform="translate(-6.41,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(-1.11,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-15</text>
      </g>
    </g>
    <g transform="translate(4.19,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(9.48,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-5</text>
      </g>
    </g>
    <g transform="translate(14.78,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(20.08,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">5</text>
      </g>
    </g>
    <g transform="translate(25.37,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(30.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">15</text>
      </g>
    </g>
    <g transform="translate(35.97,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(41.26,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">25</text>
      </g>
    </g>
    <g transform="translate(46.56,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(51.85,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">35</text>
      </g>
    </g>
    <g transform="translate(57.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(62.45,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">45</text>
      </g>
    </g>
    <g transform="translate(67.74,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(73.04,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">55</text>
      </g>
    </g>
    <g transform="translate(78.34,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(83.63,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">65</text>
      </g>
    </g>
    <g transform="translate(88.93,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(94.23,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">75</text>
      </g>
    </g>
    <g transform="translate(99.52,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(104.82,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">85</text>
      </g>
    </g>
    <g transform="translate(110.12,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(115.41,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">95</text>
      </g>
    </g>
    <g transform="translate(120.71,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(126.01,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">105</text>
      </g>
    </g>
    <g transform="translate(131.3,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(136.6,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">115</text>
      </g>
    </g>
    <g transform="translate(141.89,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(147.19,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">125</text>
      </g>
    </g>
    <g transform="translate(152.49,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(157.78,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">135</text>
      </g>
    </g>
    <g transform="translate(163.08,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(168.38,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">145</text>
      </g>
    </g>
    <g transform="translate(173.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(178.97,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">155</text>
      </g>
    </g>
    <g transform="translate(184.27,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(189.56,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">165</text>
      </g>
    </g>
    <g transform="translate(194.86,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(200.16,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">175</text>
      </g>
    </g>
    <g transform="translate(205.45,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(210.75,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">185</text>
      </g>
    </g>
    <g transform="translate(216.05,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(221.34,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">195</text>
      </g>
    </g>
    <g transform="translate(226.64,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
  </g>
  <g class="guide colorkey" id="img-3b7fec4c-3">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-3b7fec4c-4">
      <g transform="translate(126.75,47.95)" id="img-3b7fec4c-5">
        <g class="primitive">
          <text dy="0.35em">Source 1</text>
        </g>
      </g>
      <g transform="translate(126.75,50.99)" id="img-3b7fec4c-6">
        <g class="primitive">
          <text dy="0.35em">Source 2</text>
        </g>
      </g>
      <g transform="translate(126.75,54.03)" id="img-3b7fec4c-7">
        <g class="primitive">
          <text dy="0.35em">Source 3</text>
        </g>
      </g>
    </g>
    <g stroke-width="0" id="img-3b7fec4c-8">
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#008000" id="img-3b7fec4c-9">
        <g transform="translate(124.23,54.03)" id="img-3b7fec4c-10">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#0000FF" id="img-3b7fec4c-11">
        <g transform="translate(124.23,50.99)" id="img-3b7fec4c-12">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FF0000" id="img-3b7fec4c-13">
        <g transform="translate(124.23,47.95)" id="img-3b7fec4c-14">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-3b7fec4c-15">
      <g transform="translate(123.71,44.93)" id="img-3b7fec4c-16">
        <g class="primitive">
          <text dy="-0em"></text>
        </g>
      </g>
    </g>
  </g>
  <g clip-path="url(#img-3b7fec4c-17)">
    <g id="img-3b7fec4c-18">
      <g pointer-events="visible" stroke-width="0.3" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-3b7fec4c-19">
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-20">
          <path d="M-54.96,-39.69 L54.96,-39.69 54.96,39.69 -54.96,39.69  z" class="primitive"/>
        </g>
      </g>
      <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-3b7fec4c-21">
        <g transform="translate(67.74,182.14)" id="img-3b7fec4c-22" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,163.3)" id="img-3b7fec4c-23" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,144.45)" id="img-3b7fec4c-24" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,125.61)" id="img-3b7fec4c-25" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,106.77)" id="img-3b7fec4c-26" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,87.93)" id="img-3b7fec4c-27" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,69.08)" id="img-3b7fec4c-28" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-29" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,31.4)" id="img-3b7fec4c-30" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,12.56)" id="img-3b7fec4c-31" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-6.29)" id="img-3b7fec4c-32" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-25.13)" id="img-3b7fec4c-33" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-43.97)" id="img-3b7fec4c-34" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-62.81)" id="img-3b7fec4c-35" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-81.66)" id="img-3b7fec4c-36" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,168.01)" id="img-3b7fec4c-37" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,163.3)" id="img-3b7fec4c-38" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,158.59)" id="img-3b7fec4c-39" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,153.88)" id="img-3b7fec4c-40" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,149.17)" id="img-3b7fec4c-41" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,144.45)" id="img-3b7fec4c-42" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,139.74)" id="img-3b7fec4c-43" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,135.03)" id="img-3b7fec4c-44" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,130.32)" id="img-3b7fec4c-45" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,125.61)" id="img-3b7fec4c-46" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,120.9)" id="img-3b7fec4c-47" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,116.19)" id="img-3b7fec4c-48" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,111.48)" id="img-3b7fec4c-49" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,106.77)" id="img-3b7fec4c-50" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,102.06)" id="img-3b7fec4c-51" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,97.35)" id="img-3b7fec4c-52" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,92.64)" id="img-3b7fec4c-53" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,87.93)" id="img-3b7fec4c-54" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,83.22)" id="img-3b7fec4c-55" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,78.51)" id="img-3b7fec4c-56" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,73.79)" id="img-3b7fec4c-57" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,69.08)" id="img-3b7fec4c-58" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,64.37)" id="img-3b7fec4c-59" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,59.66)" id="img-3b7fec4c-60" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,54.95)" id="img-3b7fec4c-61" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-62" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,45.53)" id="img-3b7fec4c-63" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,40.82)" id="img-3b7fec4c-64" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,36.11)" id="img-3b7fec4c-65" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,31.4)" id="img-3b7fec4c-66" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,26.69)" id="img-3b7fec4c-67" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,21.98)" id="img-3b7fec4c-68" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,17.27)" id="img-3b7fec4c-69" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,12.56)" id="img-3b7fec4c-70" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,7.85)" id="img-3b7fec4c-71" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,3.13)" id="img-3b7fec4c-72" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-1.58)" id="img-3b7fec4c-73" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-6.29)" id="img-3b7fec4c-74" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-11)" id="img-3b7fec4c-75" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-15.71)" id="img-3b7fec4c-76" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-20.42)" id="img-3b7fec4c-77" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-25.13)" id="img-3b7fec4c-78" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-29.84)" id="img-3b7fec4c-79" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-34.55)" id="img-3b7fec4c-80" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-39.26)" id="img-3b7fec4c-81" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-43.97)" id="img-3b7fec4c-82" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-48.68)" id="img-3b7fec4c-83" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-53.39)" id="img-3b7fec4c-84" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-58.1)" id="img-3b7fec4c-85" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-62.81)" id="img-3b7fec4c-86" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,182.14)" id="img-3b7fec4c-87" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,87.93)" id="img-3b7fec4c-88" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-6.29)" id="img-3b7fec4c-89" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-100.5)" id="img-3b7fec4c-90" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,168.01)" id="img-3b7fec4c-91" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,163.3)" id="img-3b7fec4c-92" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,158.59)" id="img-3b7fec4c-93" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,153.88)" id="img-3b7fec4c-94" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,149.17)" id="img-3b7fec4c-95" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,144.45)" id="img-3b7fec4c-96" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,139.74)" id="img-3b7fec4c-97" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,135.03)" id="img-3b7fec4c-98" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,130.32)" id="img-3b7fec4c-99" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,125.61)" id="img-3b7fec4c-100" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,120.9)" id="img-3b7fec4c-101" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,116.19)" id="img-3b7fec4c-102" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,111.48)" id="img-3b7fec4c-103" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,106.77)" id="img-3b7fec4c-104" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,102.06)" id="img-3b7fec4c-105" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,97.35)" id="img-3b7fec4c-106" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,92.64)" id="img-3b7fec4c-107" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,87.93)" id="img-3b7fec4c-108" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,83.22)" id="img-3b7fec4c-109" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,78.51)" id="img-3b7fec4c-110" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,73.79)" id="img-3b7fec4c-111" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,69.08)" id="img-3b7fec4c-112" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,64.37)" id="img-3b7fec4c-113" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,59.66)" id="img-3b7fec4c-114" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,54.95)" id="img-3b7fec4c-115" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-116" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,45.53)" id="img-3b7fec4c-117" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,40.82)" id="img-3b7fec4c-118" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,36.11)" id="img-3b7fec4c-119" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,31.4)" id="img-3b7fec4c-120" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,26.69)" id="img-3b7fec4c-121" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,21.98)" id="img-3b7fec4c-122" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,17.27)" id="img-3b7fec4c-123" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,12.56)" id="img-3b7fec4c-124" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,7.85)" id="img-3b7fec4c-125" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,3.13)" id="img-3b7fec4c-126" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-1.58)" id="img-3b7fec4c-127" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-6.29)" id="img-3b7fec4c-128" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-11)" id="img-3b7fec4c-129" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-15.71)" id="img-3b7fec4c-130" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-20.42)" id="img-3b7fec4c-131" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-25.13)" id="img-3b7fec4c-132" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-29.84)" id="img-3b7fec4c-133" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-34.55)" id="img-3b7fec4c-134" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-39.26)" id="img-3b7fec4c-135" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-43.97)" id="img-3b7fec4c-136" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-48.68)" id="img-3b7fec4c-137" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-53.39)" id="img-3b7fec4c-138" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-58.1)" id="img-3b7fec4c-139" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
        <g transform="translate(67.74,-62.81)" id="img-3b7fec4c-140" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-54.96,0 L54.96,0 " class="primitive"/>
        </g>
      </g>
      <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-3b7fec4c-141">
        <g transform="translate(-144.11,50.24)" id="img-3b7fec4c-142" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-91.15,50.24)" id="img-3b7fec4c-143" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-38.19,50.24)" id="img-3b7fec4c-144" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(14.78,50.24)" id="img-3b7fec4c-145" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-146" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.24)" id="img-3b7fec4c-147" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(173.67,50.24)" id="img-3b7fec4c-148" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(226.64,50.24)" id="img-3b7fec4c-149" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(279.6,50.24)" id="img-3b7fec4c-150" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-91.15,50.24)" id="img-3b7fec4c-151" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-80.56,50.24)" id="img-3b7fec4c-152" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-69.96,50.24)" id="img-3b7fec4c-153" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-59.37,50.24)" id="img-3b7fec4c-154" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-48.78,50.24)" id="img-3b7fec4c-155" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-38.19,50.24)" id="img-3b7fec4c-156" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-27.59,50.24)" id="img-3b7fec4c-157" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-17,50.24)" id="img-3b7fec4c-158" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-6.41,50.24)" id="img-3b7fec4c-159" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(4.19,50.24)" id="img-3b7fec4c-160" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(14.78,50.24)" id="img-3b7fec4c-161" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(25.37,50.24)" id="img-3b7fec4c-162" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(35.97,50.24)" id="img-3b7fec4c-163" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(46.56,50.24)" id="img-3b7fec4c-164" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(57.15,50.24)" id="img-3b7fec4c-165" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-166" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(78.34,50.24)" id="img-3b7fec4c-167" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(88.93,50.24)" id="img-3b7fec4c-168" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(99.52,50.24)" id="img-3b7fec4c-169" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(110.12,50.24)" id="img-3b7fec4c-170" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.24)" id="img-3b7fec4c-171" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(131.3,50.24)" id="img-3b7fec4c-172" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(141.89,50.24)" id="img-3b7fec4c-173" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(152.49,50.24)" id="img-3b7fec4c-174" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(163.08,50.24)" id="img-3b7fec4c-175" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(173.67,50.24)" id="img-3b7fec4c-176" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(184.27,50.24)" id="img-3b7fec4c-177" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(194.86,50.24)" id="img-3b7fec4c-178" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(205.45,50.24)" id="img-3b7fec4c-179" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(216.05,50.24)" id="img-3b7fec4c-180" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(226.64,50.24)" id="img-3b7fec4c-181" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-91.15,50.24)" id="img-3b7fec4c-182" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(14.78,50.24)" id="img-3b7fec4c-183" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.24)" id="img-3b7fec4c-184" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(226.64,50.24)" id="img-3b7fec4c-185" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-91.15,50.24)" id="img-3b7fec4c-186" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-85.85,50.24)" id="img-3b7fec4c-187" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-80.56,50.24)" id="img-3b7fec4c-188" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-75.26,50.24)" id="img-3b7fec4c-189" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-69.96,50.24)" id="img-3b7fec4c-190" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-64.67,50.24)" id="img-3b7fec4c-191" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-59.37,50.24)" id="img-3b7fec4c-192" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-54.07,50.24)" id="img-3b7fec4c-193" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-48.78,50.24)" id="img-3b7fec4c-194" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-43.48,50.24)" id="img-3b7fec4c-195" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-38.19,50.24)" id="img-3b7fec4c-196" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-32.89,50.24)" id="img-3b7fec4c-197" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-27.59,50.24)" id="img-3b7fec4c-198" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-22.3,50.24)" id="img-3b7fec4c-199" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-17,50.24)" id="img-3b7fec4c-200" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-11.7,50.24)" id="img-3b7fec4c-201" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-6.41,50.24)" id="img-3b7fec4c-202" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(-1.11,50.24)" id="img-3b7fec4c-203" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(4.19,50.24)" id="img-3b7fec4c-204" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(9.48,50.24)" id="img-3b7fec4c-205" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(14.78,50.24)" id="img-3b7fec4c-206" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(20.08,50.24)" id="img-3b7fec4c-207" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(25.37,50.24)" id="img-3b7fec4c-208" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(30.67,50.24)" id="img-3b7fec4c-209" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(35.97,50.24)" id="img-3b7fec4c-210" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(41.26,50.24)" id="img-3b7fec4c-211" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(46.56,50.24)" id="img-3b7fec4c-212" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(51.85,50.24)" id="img-3b7fec4c-213" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(57.15,50.24)" id="img-3b7fec4c-214" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(62.45,50.24)" id="img-3b7fec4c-215" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(67.74,50.24)" id="img-3b7fec4c-216" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(73.04,50.24)" id="img-3b7fec4c-217" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(78.34,50.24)" id="img-3b7fec4c-218" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(83.63,50.24)" id="img-3b7fec4c-219" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(88.93,50.24)" id="img-3b7fec4c-220" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(94.23,50.24)" id="img-3b7fec4c-221" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(99.52,50.24)" id="img-3b7fec4c-222" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(104.82,50.24)" id="img-3b7fec4c-223" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(110.12,50.24)" id="img-3b7fec4c-224" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(115.41,50.24)" id="img-3b7fec4c-225" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(120.71,50.24)" id="img-3b7fec4c-226" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(126.01,50.24)" id="img-3b7fec4c-227" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(131.3,50.24)" id="img-3b7fec4c-228" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(136.6,50.24)" id="img-3b7fec4c-229" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(141.89,50.24)" id="img-3b7fec4c-230" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(147.19,50.24)" id="img-3b7fec4c-231" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(152.49,50.24)" id="img-3b7fec4c-232" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(157.78,50.24)" id="img-3b7fec4c-233" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(163.08,50.24)" id="img-3b7fec4c-234" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(168.38,50.24)" id="img-3b7fec4c-235" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(173.67,50.24)" id="img-3b7fec4c-236" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(178.97,50.24)" id="img-3b7fec4c-237" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(184.27,50.24)" id="img-3b7fec4c-238" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(189.56,50.24)" id="img-3b7fec4c-239" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(194.86,50.24)" id="img-3b7fec4c-240" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(200.16,50.24)" id="img-3b7fec4c-241" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(205.45,50.24)" id="img-3b7fec4c-242" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(210.75,50.24)" id="img-3b7fec4c-243" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(216.05,50.24)" id="img-3b7fec4c-244" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(221.34,50.24)" id="img-3b7fec4c-245" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
        <g transform="translate(226.64,50.24)" id="img-3b7fec4c-246" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.69 L0,39.69 " class="primitive"/>
        </g>
      </g>
      <g class="plotpanel" id="img-3b7fec4c-247">
        <metadata>
          <boundingbox value="12.779492187499997mm 10.556027560763894mm 109.92922841612895mm 79.3706027560764mm"/>
          <unitbox value="-1.888053023612392 0.8212284357759234 103.77610604722479 -0.8424568715518467"/>
        </metadata>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-3b7fec4c-248">
          <g class="color_RGBA{N0f8}(0.0,0.502,0.0,1.0)" stroke-dasharray="none" stroke="#008000" id="img-3b7fec4c-249">
            <g transform="translate(68.27,52.62)" id="img-3b7fec4c-250">
              <path fill="none" d="M-52.43,-9.33 L-51.38,-18.67 -50.32,-26.2 -49.26,-31.3 -48.2,-33.64 -47.14,-32.78 -46.08,-29.04 -45.02,-22.37 -43.96,-13.87 -42.9,-4.23 -41.84,6.06 -40.78,15.82 -39.72,24.41 -38.66,30.56 -37.6,34.12 -36.55,34.96 -35.49,32.35 -34.43,27.12 -33.37,19.4 -32.31,10.17 -31.25,0.11 -30.19,-10.02 -29.13,-19.3 -28.07,-26.76 -27.01,-31.78 -25.95,-33.81 -24.89,-32.86 -23.83,-28.68 -22.77,-22.19 -21.72,-13.57 -20.66,-3.79 -19.6,6.48 -18.54,16.24 -17.48,24.65 -16.42,30.85 -15.36,34.2 -14.3,34.75 -13.24,32.04 -12.18,26.63 -11.12,18.98 -10.06,9.62 -9,-0.58 -7.94,-10.55 -6.89,-19.78 -5.83,-27.11 -4.77,-31.65 -3.71,-33.71 -2.65,-32.6 -1.59,-28.32 -0.53,-21.7 0.53,-12.92 1.59,-2.93 2.65,7.18 3.71,16.99 4.77,25.28 5.83,31.19 6.89,34.68 7.94,34.93 9,32.1 10.06,26.64 11.12,18.74 12.18,9.21 13.24,-0.92 14.3,-10.86 15.36,-19.87 16.42,-27.11 17.48,-31.84 18.54,-33.32 19.6,-32.02 20.66,-27.77 21.72,-20.94 22.77,-12.05 23.83,-2.14 24.89,8.19 25.95,17.73 27.01,25.95 28.07,31.8 29.13,34.98 30.19,34.94 31.25,32.28 32.31,26.38 33.37,18.54 34.43,8.85 35.49,-1.34 36.55,-11.15 37.6,-20.33 38.66,-27.36 39.72,-31.63 40.78,-33.26 41.84,-31.65 42.9,-27.31 43.96,-20.25 45.02,-11.45 46.08,-1.46 47.14,8.75 48.2,18.46 49.26,26.42 50.32,32.16 51.38,35.12 52.43,35.05 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-3b7fec4c-251">
          <g class="color_RGBA{N0f8}(0.0,0.0,1.0,1.0)" stroke-dasharray="none" stroke="#0000FF" id="img-3b7fec4c-252">
            <g transform="translate(68.27,50.52)" id="img-3b7fec4c-253">
              <path fill="none" d="M-52.43,2.73 L-51.38,1.11 -50.32,-0.58 -49.26,-2.26 -48.2,-3.75 -47.14,-5.39 -46.08,-6.8 -45.02,-8.55 -43.96,-9.9 -42.9,-10.94 -41.84,-12.25 -40.78,-13.46 -39.72,-14.91 -38.66,-15.86 -37.6,-16.91 -36.55,-18.37 -35.49,-19.21 -34.43,-20.37 -33.37,-21.33 -32.31,-22.5 -31.25,-23.65 -30.19,-24.56 -29.13,-25.22 -28.07,-25.84 -27.01,-26.37 -25.95,-26.94 -24.89,-27.28 -23.83,-27.87 -22.77,-27.88 -21.72,-27.94 -20.66,-27.73 -19.6,-27.59 -18.54,-27.41 -17.48,-27.26 -16.42,-26.96 -15.36,-26.4 -14.3,-26.1 -13.24,-25.47 -12.18,-24.97 -11.12,-24.57 -10.06,-24.01 -9,-23.35 -7.94,-22.81 -6.89,-21.8 -5.83,-20.82 -4.77,-20.21 -3.71,-18.89 -2.65,-17.64 -1.59,-16.59 -0.53,-15.08 0.53,-13.73 1.59,-12.33 2.65,-10.55 3.71,-9.17 4.77,-7.67 5.83,-5.87 6.89,-4.54 7.94,-2.88 9,-1.21 10.06,0.18 11.12,1.77 12.18,3.39 13.24,4.76 14.3,6.07 15.36,7.58 16.42,9.24 17.48,10.9 18.54,12.08 19.6,13.7 20.66,15.34 21.72,16.97 22.77,18.43 23.83,20.09 24.89,21.53 25.95,23.12 27.01,24.39 28.07,25.8 29.13,27.02 30.19,28.42 31.25,29.1 32.31,30.36 33.37,31.04 34.43,32.07 35.49,32.7 36.55,33.01 37.6,33.97 38.66,34.5 39.72,34.65 40.78,35.17 41.84,35.41 42.9,35.91 43.96,36.1 45.02,36.5 46.08,36.71 47.14,36.87 48.2,36.66 49.26,36.65 50.32,36.49 51.38,36.22 52.43,35.82 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-3b7fec4c-254">
          <g class="color_RGBA{N0f8}(1.0,0.0,0.0,1.0)" stroke-dasharray="none" stroke="#FF0000" id="img-3b7fec4c-255">
            <g transform="translate(68.27,51.32)" id="img-3b7fec4c-256">
              <path fill="none" d="M-52.43,-1.11 L-51.38,19.15 -50.32,19.6 -49.26,15.21 -48.2,35.01 -47.14,18.77 -46.08,31.58 -45.02,-28 -43.96,-25.67 -42.9,21.71 -41.84,12.9 -40.78,16.42 -39.72,-28.81 -38.66,11.61 -37.6,30.73 -36.55,-24.16 -35.49,25.52 -34.43,15.47 -33.37,35.95 -32.31,10.72 -31.25,-21.26 -30.19,-23.69 -29.13,4.59 -28.07,20.7 -27.01,35.14 -25.95,22.57 -24.89,30.47 -23.83,-27.58 -22.77,-3.76 -21.72,-6.05 -20.66,21.13 -19.6,21.27 -18.54,14.13 -17.48,-7.47 -16.42,-12.68 -15.36,21.28 -14.3,0.21 -13.24,32.96 -12.18,35.52 -11.12,11.48 -10.06,6.96 -9,8.77 -7.94,-23.41 -6.89,15.4 -5.83,31.43 -4.77,-35.66 -3.71,6.62 -2.65,19.51 -1.59,-18.8 -0.53,7.82 0.53,-6.27 1.59,-21.07 2.65,22.1 3.71,-12.25 4.77,-25.26 5.83,11.9 6.89,-32.07 7.94,-14.96 9,9.35 10.06,-13.97 11.12,1.84 12.18,24.71 13.24,5.08 14.3,-24.15 15.36,-21.78 16.42,6.61 17.48,28.79 18.54,-36.43 19.6,-26.85 20.66,-15.6 21.72,-7.01 22.77,-28.47 23.83,-10.31 24.89,-26.27 25.95,-5.19 27.01,-29.42 28.07,-14.41 29.13,-18.31 30.19,27.12 31.25,-37.44 32.31,17.05 33.37,-13.59 34.43,32.08 35.49,20.71 36.55,-34.9 37.6,34.94 38.66,36.47 39.72,-21.89 40.78,-5.95 41.84,-34.35 42.9,-9.49 43.96,-31.33 45.02,-6.3 46.08,-1.68 47.14,5.76 48.2,-35.21 49.26,-22.89 50.32,-18.51 51.38,-12.29 52.43,-8.87 " class="primitive"/>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide crosshair" id="img-3b7fec4c-257">
        <g class="text_box" fill="#000000" id="img-3b7fec4c-258">
          <g transform="translate(115.65,11.09)" id="img-3b7fec4c-259">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em"></text>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide helpscreen" id="img-3b7fec4c-260">
        <g class="text_box" id="img-3b7fec4c-261">
          <g fill="#000000" id="img-3b7fec4c-262">
            <g transform="translate(67.74,50.24)" id="img-3b7fec4c-263">
              <path d="M-34.41,-12.5 L34.41,-12.5 34.41,12.5 -34.41,12.5  z" class="primitive"/>
            </g>
          </g>
          <g fill="#FFFF74" font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-3b7fec4c-264">
            <g transform="translate(67.74,41.15)" id="img-3b7fec4c-265">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">h,j,k,l,arrows,drag to pan</text>
              </g>
            </g>
            <g transform="translate(67.74,45.7)" id="img-3b7fec4c-266">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">i,o,+,-,scroll,shift-drag to zoom</text>
              </g>
            </g>
            <g transform="translate(67.74,50.24)" id="img-3b7fec4c-267">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">r,dbl-click to reset</text>
              </g>
            </g>
            <g transform="translate(67.74,54.79)" id="img-3b7fec4c-268">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">c for coordinates</text>
              </g>
            </g>
            <g transform="translate(67.74,59.33)" id="img-3b7fec4c-269">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">? for help</text>
              </g>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide questionmark" id="img-3b7fec4c-270">
        <g class="text_box" fill="#000000" id="img-3b7fec4c-271">
          <g transform="translate(122.71,11.09)" id="img-3b7fec4c-272">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em">?</text>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g class="guide ylabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-3b7fec4c-273">
    <g transform="translate(11.78,182.14)" id="img-3b7fec4c-274" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(11.78,163.3)" id="img-3b7fec4c-275" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(11.78,144.45)" id="img-3b7fec4c-276" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(11.78,125.61)" id="img-3b7fec4c-277" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(11.78,106.77)" id="img-3b7fec4c-278" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(11.78,87.93)" id="img-3b7fec4c-279" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(11.78,69.08)" id="img-3b7fec4c-280" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(11.78,50.24)" id="img-3b7fec4c-281" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(11.78,31.4)" id="img-3b7fec4c-282" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(11.78,12.56)" id="img-3b7fec4c-283" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(11.78,-6.29)" id="img-3b7fec4c-284" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(11.78,-25.13)" id="img-3b7fec4c-285" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(11.78,-43.97)" id="img-3b7fec4c-286" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(11.78,-62.81)" id="img-3b7fec4c-287" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(11.78,-81.66)" id="img-3b7fec4c-288" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(11.78,168.01)" id="img-3b7fec4c-289" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.85</text>
      </g>
    </g>
    <g transform="translate(11.78,163.3)" id="img-3b7fec4c-290" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.80</text>
      </g>
    </g>
    <g transform="translate(11.78,158.59)" id="img-3b7fec4c-291" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.75</text>
      </g>
    </g>
    <g transform="translate(11.78,153.88)" id="img-3b7fec4c-292" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.70</text>
      </g>
    </g>
    <g transform="translate(11.78,149.17)" id="img-3b7fec4c-293" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.65</text>
      </g>
    </g>
    <g transform="translate(11.78,144.45)" id="img-3b7fec4c-294" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.60</text>
      </g>
    </g>
    <g transform="translate(11.78,139.74)" id="img-3b7fec4c-295" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.55</text>
      </g>
    </g>
    <g transform="translate(11.78,135.03)" id="img-3b7fec4c-296" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.50</text>
      </g>
    </g>
    <g transform="translate(11.78,130.32)" id="img-3b7fec4c-297" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.45</text>
      </g>
    </g>
    <g transform="translate(11.78,125.61)" id="img-3b7fec4c-298" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.40</text>
      </g>
    </g>
    <g transform="translate(11.78,120.9)" id="img-3b7fec4c-299" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.35</text>
      </g>
    </g>
    <g transform="translate(11.78,116.19)" id="img-3b7fec4c-300" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.30</text>
      </g>
    </g>
    <g transform="translate(11.78,111.48)" id="img-3b7fec4c-301" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.25</text>
      </g>
    </g>
    <g transform="translate(11.78,106.77)" id="img-3b7fec4c-302" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.20</text>
      </g>
    </g>
    <g transform="translate(11.78,102.06)" id="img-3b7fec4c-303" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.15</text>
      </g>
    </g>
    <g transform="translate(11.78,97.35)" id="img-3b7fec4c-304" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.10</text>
      </g>
    </g>
    <g transform="translate(11.78,92.64)" id="img-3b7fec4c-305" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.05</text>
      </g>
    </g>
    <g transform="translate(11.78,87.93)" id="img-3b7fec4c-306" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.00</text>
      </g>
    </g>
    <g transform="translate(11.78,83.22)" id="img-3b7fec4c-307" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.05</text>
      </g>
    </g>
    <g transform="translate(11.78,78.51)" id="img-3b7fec4c-308" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.10</text>
      </g>
    </g>
    <g transform="translate(11.78,73.79)" id="img-3b7fec4c-309" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.15</text>
      </g>
    </g>
    <g transform="translate(11.78,69.08)" id="img-3b7fec4c-310" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.20</text>
      </g>
    </g>
    <g transform="translate(11.78,64.37)" id="img-3b7fec4c-311" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.25</text>
      </g>
    </g>
    <g transform="translate(11.78,59.66)" id="img-3b7fec4c-312" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.30</text>
      </g>
    </g>
    <g transform="translate(11.78,54.95)" id="img-3b7fec4c-313" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.35</text>
      </g>
    </g>
    <g transform="translate(11.78,50.24)" id="img-3b7fec4c-314" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.40</text>
      </g>
    </g>
    <g transform="translate(11.78,45.53)" id="img-3b7fec4c-315" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.45</text>
      </g>
    </g>
    <g transform="translate(11.78,40.82)" id="img-3b7fec4c-316" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.50</text>
      </g>
    </g>
    <g transform="translate(11.78,36.11)" id="img-3b7fec4c-317" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.55</text>
      </g>
    </g>
    <g transform="translate(11.78,31.4)" id="img-3b7fec4c-318" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.60</text>
      </g>
    </g>
    <g transform="translate(11.78,26.69)" id="img-3b7fec4c-319" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.65</text>
      </g>
    </g>
    <g transform="translate(11.78,21.98)" id="img-3b7fec4c-320" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.70</text>
      </g>
    </g>
    <g transform="translate(11.78,17.27)" id="img-3b7fec4c-321" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.75</text>
      </g>
    </g>
    <g transform="translate(11.78,12.56)" id="img-3b7fec4c-322" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.80</text>
      </g>
    </g>
    <g transform="translate(11.78,7.85)" id="img-3b7fec4c-323" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.85</text>
      </g>
    </g>
    <g transform="translate(11.78,3.13)" id="img-3b7fec4c-324" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.90</text>
      </g>
    </g>
    <g transform="translate(11.78,-1.58)" id="img-3b7fec4c-325" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.95</text>
      </g>
    </g>
    <g transform="translate(11.78,-6.29)" id="img-3b7fec4c-326" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.00</text>
      </g>
    </g>
    <g transform="translate(11.78,-11)" id="img-3b7fec4c-327" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.05</text>
      </g>
    </g>
    <g transform="translate(11.78,-15.71)" id="img-3b7fec4c-328" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.10</text>
      </g>
    </g>
    <g transform="translate(11.78,-20.42)" id="img-3b7fec4c-329" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.15</text>
      </g>
    </g>
    <g transform="translate(11.78,-25.13)" id="img-3b7fec4c-330" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.20</text>
      </g>
    </g>
    <g transform="translate(11.78,-29.84)" id="img-3b7fec4c-331" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.25</text>
      </g>
    </g>
    <g transform="translate(11.78,-34.55)" id="img-3b7fec4c-332" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.30</text>
      </g>
    </g>
    <g transform="translate(11.78,-39.26)" id="img-3b7fec4c-333" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.35</text>
      </g>
    </g>
    <g transform="translate(11.78,-43.97)" id="img-3b7fec4c-334" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.40</text>
      </g>
    </g>
    <g transform="translate(11.78,-48.68)" id="img-3b7fec4c-335" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.45</text>
      </g>
    </g>
    <g transform="translate(11.78,-53.39)" id="img-3b7fec4c-336" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.50</text>
      </g>
    </g>
    <g transform="translate(11.78,-58.1)" id="img-3b7fec4c-337" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.55</text>
      </g>
    </g>
    <g transform="translate(11.78,-62.81)" id="img-3b7fec4c-338" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.60</text>
      </g>
    </g>
    <g transform="translate(11.78,182.14)" id="img-3b7fec4c-339" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1</text>
      </g>
    </g>
    <g transform="translate(11.78,87.93)" id="img-3b7fec4c-340" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(11.78,-6.29)" id="img-3b7fec4c-341" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1</text>
      </g>
    </g>
    <g transform="translate(11.78,-100.5)" id="img-3b7fec4c-342" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2</text>
      </g>
    </g>
    <g transform="translate(11.78,168.01)" id="img-3b7fec4c-343" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.85</text>
      </g>
    </g>
    <g transform="translate(11.78,163.3)" id="img-3b7fec4c-344" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.80</text>
      </g>
    </g>
    <g transform="translate(11.78,158.59)" id="img-3b7fec4c-345" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.75</text>
      </g>
    </g>
    <g transform="translate(11.78,153.88)" id="img-3b7fec4c-346" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.70</text>
      </g>
    </g>
    <g transform="translate(11.78,149.17)" id="img-3b7fec4c-347" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.65</text>
      </g>
    </g>
    <g transform="translate(11.78,144.45)" id="img-3b7fec4c-348" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.60</text>
      </g>
    </g>
    <g transform="translate(11.78,139.74)" id="img-3b7fec4c-349" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.55</text>
      </g>
    </g>
    <g transform="translate(11.78,135.03)" id="img-3b7fec4c-350" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.50</text>
      </g>
    </g>
    <g transform="translate(11.78,130.32)" id="img-3b7fec4c-351" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.45</text>
      </g>
    </g>
    <g transform="translate(11.78,125.61)" id="img-3b7fec4c-352" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.40</text>
      </g>
    </g>
    <g transform="translate(11.78,120.9)" id="img-3b7fec4c-353" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.35</text>
      </g>
    </g>
    <g transform="translate(11.78,116.19)" id="img-3b7fec4c-354" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.30</text>
      </g>
    </g>
    <g transform="translate(11.78,111.48)" id="img-3b7fec4c-355" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.25</text>
      </g>
    </g>
    <g transform="translate(11.78,106.77)" id="img-3b7fec4c-356" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.20</text>
      </g>
    </g>
    <g transform="translate(11.78,102.06)" id="img-3b7fec4c-357" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.15</text>
      </g>
    </g>
    <g transform="translate(11.78,97.35)" id="img-3b7fec4c-358" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.10</text>
      </g>
    </g>
    <g transform="translate(11.78,92.64)" id="img-3b7fec4c-359" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.05</text>
      </g>
    </g>
    <g transform="translate(11.78,87.93)" id="img-3b7fec4c-360" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.00</text>
      </g>
    </g>
    <g transform="translate(11.78,83.22)" id="img-3b7fec4c-361" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.05</text>
      </g>
    </g>
    <g transform="translate(11.78,78.51)" id="img-3b7fec4c-362" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.10</text>
      </g>
    </g>
    <g transform="translate(11.78,73.79)" id="img-3b7fec4c-363" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.15</text>
      </g>
    </g>
    <g transform="translate(11.78,69.08)" id="img-3b7fec4c-364" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.20</text>
      </g>
    </g>
    <g transform="translate(11.78,64.37)" id="img-3b7fec4c-365" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.25</text>
      </g>
    </g>
    <g transform="translate(11.78,59.66)" id="img-3b7fec4c-366" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.30</text>
      </g>
    </g>
    <g transform="translate(11.78,54.95)" id="img-3b7fec4c-367" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.35</text>
      </g>
    </g>
    <g transform="translate(11.78,50.24)" id="img-3b7fec4c-368" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.40</text>
      </g>
    </g>
    <g transform="translate(11.78,45.53)" id="img-3b7fec4c-369" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.45</text>
      </g>
    </g>
    <g transform="translate(11.78,40.82)" id="img-3b7fec4c-370" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.50</text>
      </g>
    </g>
    <g transform="translate(11.78,36.11)" id="img-3b7fec4c-371" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.55</text>
      </g>
    </g>
    <g transform="translate(11.78,31.4)" id="img-3b7fec4c-372" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.60</text>
      </g>
    </g>
    <g transform="translate(11.78,26.69)" id="img-3b7fec4c-373" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.65</text>
      </g>
    </g>
    <g transform="translate(11.78,21.98)" id="img-3b7fec4c-374" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.70</text>
      </g>
    </g>
    <g transform="translate(11.78,17.27)" id="img-3b7fec4c-375" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.75</text>
      </g>
    </g>
    <g transform="translate(11.78,12.56)" id="img-3b7fec4c-376" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.80</text>
      </g>
    </g>
    <g transform="translate(11.78,7.85)" id="img-3b7fec4c-377" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.85</text>
      </g>
    </g>
    <g transform="translate(11.78,3.13)" id="img-3b7fec4c-378" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.90</text>
      </g>
    </g>
    <g transform="translate(11.78,-1.58)" id="img-3b7fec4c-379" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.95</text>
      </g>
    </g>
    <g transform="translate(11.78,-6.29)" id="img-3b7fec4c-380" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.00</text>
      </g>
    </g>
    <g transform="translate(11.78,-11)" id="img-3b7fec4c-381" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.05</text>
      </g>
    </g>
    <g transform="translate(11.78,-15.71)" id="img-3b7fec4c-382" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.10</text>
      </g>
    </g>
    <g transform="translate(11.78,-20.42)" id="img-3b7fec4c-383" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.15</text>
      </g>
    </g>
    <g transform="translate(11.78,-25.13)" id="img-3b7fec4c-384" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.20</text>
      </g>
    </g>
    <g transform="translate(11.78,-29.84)" id="img-3b7fec4c-385" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.25</text>
      </g>
    </g>
    <g transform="translate(11.78,-34.55)" id="img-3b7fec4c-386" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.30</text>
      </g>
    </g>
    <g transform="translate(11.78,-39.26)" id="img-3b7fec4c-387" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.35</text>
      </g>
    </g>
    <g transform="translate(11.78,-43.97)" id="img-3b7fec4c-388" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.40</text>
      </g>
    </g>
    <g transform="translate(11.78,-48.68)" id="img-3b7fec4c-389" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.45</text>
      </g>
    </g>
    <g transform="translate(11.78,-53.39)" id="img-3b7fec4c-390" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.50</text>
      </g>
    </g>
    <g transform="translate(11.78,-58.1)" id="img-3b7fec4c-391" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.55</text>
      </g>
    </g>
    <g transform="translate(11.78,-62.81)" id="img-3b7fec4c-392" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.60</text>
      </g>
    </g>
  </g>
  <g font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-3b7fec4c-393">
    <g transform="translate(67.74,5)" id="img-3b7fec4c-394">
      <g class="primitive">
        <text text-anchor="middle" dy="0.6em">Reconstructed sources</text>
      </g>
    </g>
  </g>
</g>
<defs>
  <clipPath id="img-3b7fec4c-17">
    <path d="M12.78,10.56 L122.71,10.56 122.71,89.93 12.78,89.93 " />
  </clipPath>
</defs>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
<script> <![CDATA[

(function (glob, factory) {
    // AMD support
    if (typeof define === "function" && define.amd) {
        // Define as an anonymous module
        define("Gadfly", ["Snap.svg"], function (Snap) {
            return factory(Snap);
        });
    } else {
        // Browser globals (glob is window)
        // Snap adds itself to window
        glob.Gadfly = factory(glob.Snap);
    }
}(this, function (Snap) {

var Gadfly = {};

// Get an x/y coordinate value in pixels
var xPX = function(fig, x) {
    var client_box = fig.node.getBoundingClientRect();
    return x * fig.node.viewBox.baseVal.width / client_box.width;
};

var yPX = function(fig, y) {
    var client_box = fig.node.getBoundingClientRect();
    return y * fig.node.viewBox.baseVal.height / client_box.height;
};


Snap.plugin(function (Snap, Element, Paper, global) {
    // Traverse upwards from a snap element to find and return the first
    // note with the "plotroot" class.
    Element.prototype.plotroot = function () {
        var element = this;
        while (!element.hasClass("plotroot") && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.svgroot = function () {
        var element = this;
        while (element.node.nodeName != "svg" && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.plotbounds = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.viewportplotbounds = function () {
        var root = this.svgroot();
        var bbox = root.node.getBoundingClientRect();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.plotcenter = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x: bbox.x + bbox.width / 2,
            y: bbox.y + bbox.height / 2
        };
    };

    // Emulate IE style mouseenter/mouseleave events, since Microsoft always
    // does everything right.
    // See: http://www.dynamic-tools.net/toolbox/isMouseLeaveOrEnter/
    var events = ["mouseenter", "mouseleave"];

    for (i in events) {
        (function (event_name) {
            var event_name = events[i];
            Element.prototype[event_name] = function (fn, scope) {
                if (Snap.is(fn, "function")) {
                    var fn2 = function (event) {
                        if (event.type != "mouseover" && event.type != "mouseout") {
                            return;
                        }

                        var reltg = event.relatedTarget ? event.relatedTarget :
                            event.type == "mouseout" ? event.toElement : event.fromElement;
                        while (reltg && reltg != this.node) reltg = reltg.parentNode;

                        if (reltg != this.node) {
                            return fn.apply(this, event);
                        }
                    };

                    if (event_name == "mouseenter") {
                        this.mouseover(fn2, scope);
                    } else {
                        this.mouseout(fn2, scope);
                    }
                }
                return this;
            };
        })(events[i]);
    }


    Element.prototype.mousewheel = function (fn, scope) {
        if (Snap.is(fn, "function")) {
            var el = this;
            var fn2 = function (event) {
                fn.apply(el, [event]);
            };
        }

        this.node.addEventListener("wheel", fn2);

        return this;
    };


    // Snap's attr function can be too slow for things like panning/zooming.
    // This is a function to directly update element attributes without going
    // through eve.
    Element.prototype.attribute = function(key, val) {
        if (val === undefined) {
            return this.node.getAttribute(key);
        } else {
            this.node.setAttribute(key, val);
            return this;
        }
    };

    Element.prototype.init_gadfly = function() {
        this.mouseenter(Gadfly.plot_mouseover)
            .mousemove(Gadfly.plot_mousemove)
            .mouseleave(Gadfly.plot_mouseout)
            .dblclick(Gadfly.plot_dblclick)
            .mousewheel(Gadfly.guide_background_scroll)
            .drag(Gadfly.guide_background_drag_onmove,
                  Gadfly.guide_background_drag_onstart,
                  Gadfly.guide_background_drag_onend);
        this.mouseenter(function (event) {
            init_pan_zoom(this.plotroot());
        });
        return this;
    };
});


Gadfly.plot_mousemove = function(event, _x_px, _y_px) {
    var root = this.plotroot();
    var viewbounds = root.viewportplotbounds();

    // (_x_px, _y_px) are offsets relative to page (event.layerX, event.layerY) rather than viewport
    var x_px = event.clientX - viewbounds.x0;
    var y_px = event.clientY - viewbounds.y0;
    if (root.data("crosshair")) {
        px_per_mm = root.data("px_per_mm");
        bB = root.select('boundingbox').node.getAttribute('value').split(' ');
        uB = root.select('unitbox').node.getAttribute('value').split(' ');
        xscale = root.data("xscale");
        yscale = root.data("yscale");
        xtranslate = root.data("tx");
        ytranslate = root.data("ty");

        xoff_mm = bB[0].substr(0,bB[0].length-2)/1;
        yoff_mm = bB[1].substr(0,bB[1].length-2)/1;
        xoff_unit = uB[0]/1;
        yoff_unit = uB[1]/1;
        mm_per_xunit = bB[2].substr(0,bB[2].length-2) / uB[2];
        mm_per_yunit = bB[3].substr(0,bB[3].length-2) / uB[3];

        x_unit = ((x_px / px_per_mm - xtranslate) / xscale - xoff_mm) / mm_per_xunit + xoff_unit;
        y_unit = ((y_px / px_per_mm - ytranslate) / yscale - yoff_mm) / mm_per_yunit + yoff_unit;

        root.select('.crosshair').select('.primitive').select('text')
                .node.innerHTML = x_unit.toPrecision(3)+","+y_unit.toPrecision(3);
    };
};

Gadfly.helpscreen_visible = function(event) {
    helpscreen_visible(this.plotroot());
};
var helpscreen_visible = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 1.0}, 250);
};

Gadfly.helpscreen_hidden = function(event) {
    helpscreen_hidden(this.plotroot());
};
var helpscreen_hidden = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 0.0}, 250);
};

// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_help = function(event) {
        if (event.which == 191) { // ?
            helpscreen_visible(root);
        }
    };
    root.data("keyboard_help", keyboard_help);
    window.addEventListener("keydown", keyboard_help);

    var keyboard_pan_zoom = function(event) {
        var bounds = root.plotbounds(),
            width = bounds.x1 - bounds.x0;
            height = bounds.y1 - bounds.y0;
        if (event.which == 187 || event.which == 73) { // plus or i
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189 || event.which == 79) { // minus or o
            increase_zoom_by_position(root, -0.1, true);
        } else if (event.which == 39 || event.which == 76) { // right-arrow or l
            set_plot_pan_zoom(root, root.data("tx")-width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 40 || event.which == 74) { // down-arrow or j
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")-height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 37 || event.which == 72) { // left-arrow or h
            set_plot_pan_zoom(root, root.data("tx")+width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 38 || event.which == 75) { // up-arrow or k
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")+height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 82) { // r
            set_plot_pan_zoom(root, 0.0, 0.0, 1.0, 1.0);
        } else if (event.which == 191) { // ?
            helpscreen_hidden(root);
        } else if (event.which == 67) { // c
            root.data("crosshair",!root.data("crosshair"));
            root.select(".crosshair")
                .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
        }
    };
    root.data("keyboard_pan_zoom", keyboard_pan_zoom);
    window.addEventListener("keyup", keyboard_pan_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        xgridlines.data("unfocused_strokedash",
                        xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        ygridlines.data("unfocused_strokedash",
                        ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair")
        .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_pan_zoom"));
    root.data("keyboard_pan_zoom", undefined);
    window.removeEventListener("keydown", root.data("keyboard_help"));
    root.data("keyboard_help", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        var destcolor = root.data("unfocused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        var destcolor = root.data("unfocused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair").animate({"fill-opacity": 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 0.0}, 250);
    helpscreen_hidden(root);
};


var set_geometry_transform = function(root, tx, ty, xscale, yscale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");

    var xscale = xscalable ? xscale : 1.0,
        yscale = yscalable ? yscale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);
    root.selectAll(".geometry, image").forEach(function (element, i) {
            element.transform(t);
        });

    var t = new Snap.Matrix().scale(1.0/xscale, 1.0/yscale);
    root.selectAll('.marker').forEach(function (element, i) {
        element.selectAll('.primitive').forEach(function (element, i) {
            element.transform(t);
        }) });

    bounds = root.plotbounds();
    px_per_mm = root.data("px_per_mm");

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        ylabels = root.select(".ylabels");
        if (ylabels) {
            ylabels.transform(xfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1, 1/yscale);
                           element.select("text").transform(unscale_t);

                           var y = element.attr("transform").globalMatrix.f / px_per_mm;
                           element.attr("visibility",
                               bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                       }
                   });
        }
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        xlabels = root.select(".xlabels");
        if (xlabels) {
            xlabels.transform(yfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1/xscale, 1);
                           element.select("text").transform(unscale_t);

                           var x = element.attr("transform").globalMatrix.e / px_per_mm;
                           element.attr("visibility",
                               bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                           }
                   });
        }
    }
};


// Find the most appropriate tick scale and update label visibility.
var update_tickscale = function(root, scale, axis) {
    if (!root.hasClass(axis + "scalable")) return;

    var tickscales = root.data(axis + "tickscales");
    var best_tickscale = 1.0;
    var best_tickscale_dist = Infinity;
    for (tickscale in tickscales) {
        var dist = Math.abs(Math.log(tickscale) - Math.log(scale));
        if (dist < best_tickscale_dist) {
            best_tickscale_dist = dist;
            best_tickscale = tickscale;
        }
    }

    if (best_tickscale != root.data(axis + "tickscale")) {
        root.data(axis + "tickscale", best_tickscale);
        var mark_inscale_gridlines = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("g").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("g").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, xscale, yscale) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, xscale, and yscale
    var x_min = -width * xscale - (xscale * width - width),
        x_max = width * xscale,
        y_min = -height * yscale - (yscale * height - height),
        y_max = height * yscale;

    var x0 = bounds.x0 - xscale * bounds.x0,
        y0 = bounds.y0 - yscale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale changes, we may need to alter which set of
    // ticks are being displayed
    if (xscale != old_xscale) {
        update_tickscale(root, xscale, "x");
    }
    if (yscale != old_yscale) {
        update_tickscale(root, yscale, "y");
    }

    set_geometry_transform(root, tx, ty, xscale, yscale);

    root.data("xscale", xscale);
    root.data("yscale", yscale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, xscale, yscale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var xscale0 = root.data("xscale"),
        yscale0 = root.data("yscale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - xscale0) + (width * (1 - xscale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - yscale0) + (height * (1 - yscale0)) / 2);

    // rescale offsets
    xoff = xoff * xscale / xscale0;
    yoff = yoff * yscale / yscale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - xscale),
        y_edge_adjust = bounds.y0 * (1 - yscale);

    return {
        x: xoff + x_edge_adjust + (width - width * xscale) / 2,
        y: yoff + y_edge_adjust + (height - height * yscale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

    root.data("crosshair",false);

    // The non-scaling-stroke trick. Rather than try to correct for the
    // stroke-width when zooming, we force it to a fixed value.
    var px_per_mm = root.node.getCTM().a;

    // Drag events report deltas in pixels, which we'd like to convert to
    // millimeters.
    root.data("px_per_mm", px_per_mm);

    root.selectAll("path")
        .forEach(function (element, i) {
        sw = element.asPX("stroke-width") * px_per_mm;
        if (sw > 0) {
            element.attribute("stroke-width", sw);
            element.attribute("vector-effect", "non-scaling-stroke");
        }
    });

    // Store ticks labels original tranformation
    root.selectAll(".xlabels > g, .ylabels > g")
        .forEach(function (element, i) {
            var lm = element.transform().localMatrix;
            element.data("static_transform",
                new Snap.Matrix(lm.a, lm.b, lm.c, lm.d, lm.e, lm.f));
        });

    var xgridlines = root.select(".xgridlines");
    var ygridlines = root.select(".ygridlines");
    var xlabels = root.select(".xlabels");
    var ylabels = root.select(".ylabels");

    if (root.data("tx") === undefined) root.data("tx", 0);
    if (root.data("ty") === undefined) root.data("ty", 0);
    if (root.data("xscale") === undefined) root.data("xscale", 1.0);
    if (root.data("yscale") === undefined) root.data("yscale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("g").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("g").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("g").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("g").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
        root.data("ytickscale", 1.0);  // ???
    }

    var min_scale = 1.0, max_scale = 1.0;
    for (scale in xtickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    for (scale in ytickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    root.data("min_scale", min_scale);
    root.data("max_scale", max_scale);

    // store the original positions of labels
    if (xlabels) {
        xlabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        if (element.attribute("gadfly:scale") == null) { return; }
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("g").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("g").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("g").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("g").forEach(mark_inscale);

    // figure out the upper ond lower bounds on panning using the maximum
    // and minum grid lines
    var bounds = root.plotbounds();
    var pan_bounds = {
        x0: 0.0,
        y0: 0.0,
        x1: 0.0,
        y1: 0.0
    };

    if (xgridlines) {
        xgridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.x1 - bbox.x < pan_bounds.x0) {
                        pan_bounds.x0 = bounds.x1 - bbox.x;
                    }
                    if (bounds.x0 - bbox.x > pan_bounds.x1) {
                        pan_bounds.x1 = bounds.x0 - bbox.x;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    if (ygridlines) {
        ygridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.y1 - bbox.y < pan_bounds.y0) {
                        pan_bounds.y0 = bounds.y1 - bbox.y;
                    }
                    if (bounds.y0 - bbox.y > pan_bounds.y1) {
                        pan_bounds.y1 = bounds.y0 - bbox.y;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    // nudge these values a little
    pan_bounds.x0 -= 5;
    pan_bounds.x1 += 5;
    pan_bounds.y0 -= 5;
    pan_bounds.y1 += 5;
    root.data("pan_bounds", pan_bounds);

    root.data("zoompan-ready", true)
};


// drag actions, i.e. zooming and panning
var pan_action = {
    start: function(root, x, y, event) {
        root.data("dx", 0);
        root.data("dy", 0);
        root.data("tx0", root.data("tx"));
        root.data("ty0", root.data("ty"));
    },
    update: function(root, dx, dy, x, y, event) {
        var px_per_mm = root.data("px_per_mm");
        dx /= px_per_mm;
        dy /= px_per_mm;

        var tx0 = root.data("tx"),
            ty0 = root.data("ty");

        var dx0 = root.data("dx"),
            dy0 = root.data("dy");

        root.data("dx", dx);
        root.data("dy", dy);

        dx = dx - dx0;
        dy = dy - dy0;

        var tx = tx0 + dx,
            ty = ty0 + dy;

        set_plot_pan_zoom(root, tx, ty, root.data("xscale"), root.data("yscale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"),
                root.data("xscale"), root.data("yscale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, _x, _y, event) {
        var bounds = root.plotbounds();
        // _x and _y are co-ordinates relative to page, which caused problems
        // unless the SVG is precisely at the top-left of the page
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;

        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "fill-opacity": 0.25
        });
    },
    update: function(root, dx, dy, _x, _y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;
        if (yscalable) {
            y /= px_per_mm;
            y = Math.max(bounds.y0, y);
            y = Math.min(bounds.y1, y);
        } else {
            y = bounds.y1;
        }
        if (xscalable) {
            x /= px_per_mm;
            x = Math.max(bounds.x0, x);
            x = Math.min(bounds.x1, x);
        } else {
            x = bounds.x1;
        }

        dx = x - zoom_box.attr("x");
        dy = y - zoom_box.attr("y");
        var xoffset = 0,
            yoffset = 0;
        if (dx < 0) {
            xoffset = dx;
            dx = -1 * dx;
        }
        if (dy < 0) {
            yoffset = dy;
            dy = -1 * dy;
        }
        if (isNaN(dy)) {
            dy = 0.0;
        }
        if (isNaN(dx)) {
            dx = 0.0;
        }
        zoom_box.transform("T" + xoffset + "," + yoffset);
        zoom_box.attr("width", dx);
        zoom_box.attr("height", dy);
    },
    end: function(root, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var zoom_bounds = zoom_box.getBBox();
        if (zoom_bounds.width * zoom_bounds.height <= 0) {
            return;
        }
        var plot_bounds = root.plotbounds();
        var xzoom_factor = 1.0,
            yzoom_factor = 1.0;
        if (xscalable) {
            xzoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        if (yscalable) {
            yzoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * xzoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * yzoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty,
                root.data("xscale") * xzoom_factor, root.data("yscale") * yzoom_factor);
        zoom_box.remove();
    },
    cancel: function(root) {
        zoom_box.remove();
    }
};


Gadfly.guide_background_drag_onstart = function(x, y, event) {
    var root = this.plotroot();
    var scalable = root.hasClass("xscalable") || root.hasClass("yscalable");
    var zoomable = !event.altKey && !event.ctrlKey && event.shiftKey && scalable;
    var panable = !event.altKey && !event.ctrlKey && !event.shiftKey && scalable;
    var drag_action = zoomable ? zoom_action :
                      panable  ? pan_action :
                                 undefined;
    root.data("drag_action", drag_action);
    if (drag_action) {
        var cancel_drag_action = function(event) {
            if (event.which == 27) { // esc key
                drag_action.cancel(root);
                root.data("drag_action", undefined);
            }
        };
        window.addEventListener("keyup", cancel_drag_action);
        root.data("cancel_drag_action", cancel_drag_action);
        drag_action.start(root, x, y, event);
    }
};


Gadfly.guide_background_drag_onmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.update(root, dx, dy, x, y, event);
    }
};


Gadfly.guide_background_drag_onend = function(event) {
    var root = this.plotroot();
    window.removeEventListener("keyup", root.data("cancel_drag_action"));
    root.data("cancel_drag_action", undefined);
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.end(root, event);
    }
    root.data("drag_action", undefined);
};


Gadfly.guide_background_scroll = function(event) {
    if (event.shiftKey) {
        // event.deltaY is either the number of pixels, lines, or pages scrolled past.
        var actual_delta;
        switch (event.deltaMode) {
            case 0: // Chromium-based
                actual_delta = -event.deltaY / 1000.0;
                break;
            case 1: // Firefox
                actual_delta = -event.deltaY / 50.0;
                break;
            default:
                actual_delta = -event.deltaY;
        }
        // Assumes 20 pixels/line to get reasonably consistent cross-browser behaviour.
        increase_zoom_by_position(this.plotroot(), actual_delta);
        event.preventDefault();
    }
};

// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    if (min_scale==max_scale) { return 1; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    if (min_scale==max_scale) { return min_scale; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var xposition = slider_position_from_scale(old_xscale, min_scale, max_scale),
        yposition = slider_position_from_scale(old_yscale, min_scale, max_scale);
    xposition += (root.hasClass("xscalable") ? delta_position : 0.0);
    yposition += (root.hasClass("yscalable") ? delta_position : 0.0);
    old_xscale = scale_from_slider_position(xposition, min_scale, max_scale);
    old_yscale = scale_from_slider_position(yposition, min_scale, max_scale);
    var new_xscale = Math.max(min_scale, Math.min(old_xscale, max_scale)),
        new_yscale = Math.max(min_scale, Math.min(old_yscale, max_scale));
    if (animate) {
        Snap.animate(
            [old_xscale, old_yscale],
            [new_xscale, new_yscale],
            function (new_scale) {
                update_plot_scale(root, new_scale[0], new_scale[1]);
            },
            200);
    } else {
        update_plot_scale(root, new_xscale, new_yscale);
    }
}


var update_plot_scale = function(root, new_xscale, new_yscale) {
    var trans = scale_centered_translation(root, new_xscale, new_yscale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_xscale, new_yscale);
};


var toggle_color_class = function(root, color_class, ison) {
    var escaped_color_class = color_class.replace(/([^0-9a-zA-z])/g,"\\$1");
    var guides = root.selectAll(".guide." + escaped_color_class + ",.guide ." + escaped_color_class);
    var geoms = root.selectAll(".geometry." + escaped_color_class + ",.geometry ." + escaped_color_class);
    if (ison) {
        guides.animate({opacity: 0.5}, 250);
        geoms.animate({opacity: 0.0}, 250);
    } else {
        guides.animate({opacity: 1.0}, 250);
        geoms.animate({opacity: 1.0}, 250);
    }
};


Gadfly.colorkey_swatch_click = function(event) {
    var root = this.plotroot();
    var color_class = this.data("color_class");

    if (event.shiftKey) {
        root.selectAll(".colorkey g")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (typeof other_color_class !== 'undefined' && other_color_class != color_class) {
                    toggle_color_class(root, other_color_class,
                                       element.attr("opacity") == 1.0);
                }
            });
    } else {
        toggle_color_class(root, color_class, this.attr("opacity") == 1.0);
    }
};


return Gadfly;

}));


//@ sourceURL=gadfly.js

(function (glob, factory) {
    // AMD support
      if (typeof require === "function" && typeof define === "function" && define.amd) {
        require(["Snap.svg", "Gadfly"], function (Snap, Gadfly) {
            factory(Snap, Gadfly);
        });
      } else {
          factory(glob.Snap, glob.Gadfly);
      }
})(window, function (Snap, Gadfly) {
    var fig = Snap("#img-3b7fec4c");
fig.select("#img-3b7fec4c-3")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-3b7fec4c-18")
   .init_gadfly();
fig.select("#img-3b7fec4c-21")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-3b7fec4c-21")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-3b7fec4c-141")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-3b7fec4c-141")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-3b7fec4c-271")
   .mouseenter(Gadfly.helpscreen_visible)
.mouseleave(Gadfly.helpscreen_hidden)
;
    });
]]> </script>
</svg>




## Reproduced signals


```julia
Mads.plotseries(Wipopt * Hipopt, title="Reproduced signals", name="Signal", quiet=true)
```




<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xmlns:gadfly="http://www.gadflyjl.org/ns"
     version="1.2"
     width="141.42mm" height="100mm" viewBox="0 0 141.42 100"
     stroke="none"
     fill="#000000"
     stroke-width="0.3"
     font-size="3.88"

     id="img-f4d13d34">
<defs>
  <marker id="arrow" markerWidth="15" markerHeight="7" refX="5" refY="3.5" orient="auto" markerUnits="strokeWidth">
    <path d="M0,0 L15,3.5 L0,7 z" stroke="context-stroke" fill="context-stroke"/>
  </marker>
</defs>
<g class="plotroot xscalable yscalable" id="img-f4d13d34-1">
  <g class="guide xlabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-f4d13d34-2">
    <g transform="translate(-153.19,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-150</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(285.04,94)" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">250</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-87.46,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-76.5,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-65.54,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-54.59,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-32.68,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-21.72,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-10.77,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(0.19,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(22.1,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(33.06,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(44.01,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(54.97,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(76.88,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(87.84,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(98.79,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(109.75,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(131.66,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(142.62,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(153.57,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(164.53,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(186.44,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(197.39,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(208.35,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(219.31,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
    <g transform="translate(-98.41,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-100</text>
      </g>
    </g>
    <g transform="translate(-92.93,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-95</text>
      </g>
    </g>
    <g transform="translate(-87.46,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-90</text>
      </g>
    </g>
    <g transform="translate(-81.98,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-85</text>
      </g>
    </g>
    <g transform="translate(-76.5,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-80</text>
      </g>
    </g>
    <g transform="translate(-71.02,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-75</text>
      </g>
    </g>
    <g transform="translate(-65.54,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-70</text>
      </g>
    </g>
    <g transform="translate(-60.07,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-65</text>
      </g>
    </g>
    <g transform="translate(-54.59,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-60</text>
      </g>
    </g>
    <g transform="translate(-49.11,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-55</text>
      </g>
    </g>
    <g transform="translate(-43.63,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-50</text>
      </g>
    </g>
    <g transform="translate(-38.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-45</text>
      </g>
    </g>
    <g transform="translate(-32.68,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-40</text>
      </g>
    </g>
    <g transform="translate(-27.2,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-35</text>
      </g>
    </g>
    <g transform="translate(-21.72,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-30</text>
      </g>
    </g>
    <g transform="translate(-16.24,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-25</text>
      </g>
    </g>
    <g transform="translate(-10.77,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-20</text>
      </g>
    </g>
    <g transform="translate(-5.29,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-15</text>
      </g>
    </g>
    <g transform="translate(0.19,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-10</text>
      </g>
    </g>
    <g transform="translate(5.67,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">-5</text>
      </g>
    </g>
    <g transform="translate(11.15,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">0</text>
      </g>
    </g>
    <g transform="translate(16.62,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">5</text>
      </g>
    </g>
    <g transform="translate(22.1,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">10</text>
      </g>
    </g>
    <g transform="translate(27.58,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">15</text>
      </g>
    </g>
    <g transform="translate(33.06,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">20</text>
      </g>
    </g>
    <g transform="translate(38.54,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">25</text>
      </g>
    </g>
    <g transform="translate(44.01,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">30</text>
      </g>
    </g>
    <g transform="translate(49.49,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">35</text>
      </g>
    </g>
    <g transform="translate(54.97,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">40</text>
      </g>
    </g>
    <g transform="translate(60.45,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">45</text>
      </g>
    </g>
    <g transform="translate(65.92,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">50</text>
      </g>
    </g>
    <g transform="translate(71.4,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">55</text>
      </g>
    </g>
    <g transform="translate(76.88,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">60</text>
      </g>
    </g>
    <g transform="translate(82.36,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">65</text>
      </g>
    </g>
    <g transform="translate(87.84,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">70</text>
      </g>
    </g>
    <g transform="translate(93.31,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">75</text>
      </g>
    </g>
    <g transform="translate(98.79,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">80</text>
      </g>
    </g>
    <g transform="translate(104.27,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">85</text>
      </g>
    </g>
    <g transform="translate(109.75,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">90</text>
      </g>
    </g>
    <g transform="translate(115.23,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">95</text>
      </g>
    </g>
    <g transform="translate(120.7,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">100</text>
      </g>
    </g>
    <g transform="translate(126.18,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">105</text>
      </g>
    </g>
    <g transform="translate(131.66,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">110</text>
      </g>
    </g>
    <g transform="translate(137.14,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">115</text>
      </g>
    </g>
    <g transform="translate(142.62,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">120</text>
      </g>
    </g>
    <g transform="translate(148.09,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">125</text>
      </g>
    </g>
    <g transform="translate(153.57,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">130</text>
      </g>
    </g>
    <g transform="translate(159.05,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">135</text>
      </g>
    </g>
    <g transform="translate(164.53,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">140</text>
      </g>
    </g>
    <g transform="translate(170,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">145</text>
      </g>
    </g>
    <g transform="translate(175.48,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">150</text>
      </g>
    </g>
    <g transform="translate(180.96,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">155</text>
      </g>
    </g>
    <g transform="translate(186.44,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">160</text>
      </g>
    </g>
    <g transform="translate(191.92,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">165</text>
      </g>
    </g>
    <g transform="translate(197.39,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">170</text>
      </g>
    </g>
    <g transform="translate(202.87,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">175</text>
      </g>
    </g>
    <g transform="translate(208.35,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">180</text>
      </g>
    </g>
    <g transform="translate(213.83,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">185</text>
      </g>
    </g>
    <g transform="translate(219.31,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">190</text>
      </g>
    </g>
    <g transform="translate(224.78,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">195</text>
      </g>
    </g>
    <g transform="translate(230.26,94)" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="middle" dy="-0em">200</text>
      </g>
    </g>
  </g>
  <g class="guide colorkey" id="img-f4d13d34-3">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-f4d13d34-4">
      <g transform="translate(127.31,46.07)" id="img-f4d13d34-5">
        <g class="primitive">
          <text dy="0.35em">Signal 1</text>
        </g>
      </g>
      <g transform="translate(127.31,49.68)" id="img-f4d13d34-6">
        <g class="primitive">
          <text dy="0.35em">Signal 2</text>
        </g>
      </g>
      <g transform="translate(127.31,53.29)" id="img-f4d13d34-7">
        <g class="primitive">
          <text dy="0.35em">Signal 3</text>
        </g>
      </g>
      <g transform="translate(127.31,56.9)" id="img-f4d13d34-8">
        <g class="primitive">
          <text dy="0.35em">Signal 4</text>
        </g>
      </g>
    </g>
    <g stroke-width="0" id="img-f4d13d34-9">
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FFA500" id="img-f4d13d34-10">
        <g transform="translate(124.51,56.9)" id="img-f4d13d34-11">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#008000" id="img-f4d13d34-12">
        <g transform="translate(124.51,53.29)" id="img-f4d13d34-13">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#0000FF" id="img-f4d13d34-14">
        <g transform="translate(124.51,49.68)" id="img-f4d13d34-15">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
      <g stroke="#000000" stroke-opacity="0.000" fill-opacity="1" fill="#FF0000" id="img-f4d13d34-16">
        <g transform="translate(124.51,46.07)" id="img-f4d13d34-17">
          <circle cx="0" cy="0" r="0.9" class="primitive"/>
        </g>
      </g>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-f4d13d34-18">
      <g transform="translate(123.7,42.77)" id="img-f4d13d34-19">
        <g class="primitive">
          <text dy="-0em"></text>
        </g>
      </g>
    </g>
  </g>
  <g clip-path="url(#img-f4d13d34-20)">
    <g id="img-f4d13d34-21">
      <g pointer-events="visible" stroke-width="0.3" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-f4d13d34-22">
        <g transform="translate(65.92,50.74)" id="img-f4d13d34-23">
          <path d="M-56.78,-39.19 L56.78,-39.19 56.78,39.19 -56.78,39.19  z" class="primitive"/>
        </g>
      </g>
      <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-f4d13d34-24">
        <g transform="translate(65.92,187.1)" id="img-f4d13d34-25" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-f4d13d34-26" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-f4d13d34-27" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-f4d13d34-28" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-f4d13d34-29" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-f4d13d34-30" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-f4d13d34-31" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-f4d13d34-32" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-f4d13d34-33" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-f4d13d34-34" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-f4d13d34-35" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-85.63)" id="img-f4d13d34-36" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-f4d13d34-37" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,157.35)" id="img-f4d13d34-38" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,152.39)" id="img-f4d13d34-39" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,147.43)" id="img-f4d13d34-40" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,142.47)" id="img-f4d13d34-41" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-f4d13d34-42" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,132.56)" id="img-f4d13d34-43" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,127.6)" id="img-f4d13d34-44" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,122.64)" id="img-f4d13d34-45" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,117.68)" id="img-f4d13d34-46" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-f4d13d34-47" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,107.76)" id="img-f4d13d34-48" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,102.8)" id="img-f4d13d34-49" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,97.84)" id="img-f4d13d34-50" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,92.89)" id="img-f4d13d34-51" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-f4d13d34-52" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,82.97)" id="img-f4d13d34-53" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,78.01)" id="img-f4d13d34-54" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,73.05)" id="img-f4d13d34-55" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,68.09)" id="img-f4d13d34-56" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-f4d13d34-57" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,58.17)" id="img-f4d13d34-58" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,53.21)" id="img-f4d13d34-59" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,48.26)" id="img-f4d13d34-60" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,43.3)" id="img-f4d13d34-61" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-f4d13d34-62" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,33.38)" id="img-f4d13d34-63" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,28.42)" id="img-f4d13d34-64" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,23.46)" id="img-f4d13d34-65" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,18.5)" id="img-f4d13d34-66" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-f4d13d34-67" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,8.58)" id="img-f4d13d34-68" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,3.63)" id="img-f4d13d34-69" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-1.33)" id="img-f4d13d34-70" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-6.29)" id="img-f4d13d34-71" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-f4d13d34-72" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-16.21)" id="img-f4d13d34-73" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-21.17)" id="img-f4d13d34-74" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-26.13)" id="img-f4d13d34-75" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-31.09)" id="img-f4d13d34-76" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-f4d13d34-77" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-41)" id="img-f4d13d34-78" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-45.96)" id="img-f4d13d34-79" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-50.92)" id="img-f4d13d34-80" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-55.88)" id="img-f4d13d34-81" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-f4d13d34-82" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-f4d13d34-83" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-f4d13d34-84" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-f4d13d34-85" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-f4d13d34-86" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,162.31)" id="img-f4d13d34-87" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,159.83)" id="img-f4d13d34-88" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,157.35)" id="img-f4d13d34-89" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,154.87)" id="img-f4d13d34-90" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,152.39)" id="img-f4d13d34-91" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,149.91)" id="img-f4d13d34-92" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,147.43)" id="img-f4d13d34-93" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,144.95)" id="img-f4d13d34-94" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,142.47)" id="img-f4d13d34-95" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,139.99)" id="img-f4d13d34-96" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,137.52)" id="img-f4d13d34-97" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,135.04)" id="img-f4d13d34-98" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,132.56)" id="img-f4d13d34-99" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,130.08)" id="img-f4d13d34-100" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,127.6)" id="img-f4d13d34-101" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,125.12)" id="img-f4d13d34-102" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,122.64)" id="img-f4d13d34-103" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,120.16)" id="img-f4d13d34-104" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,117.68)" id="img-f4d13d34-105" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,115.2)" id="img-f4d13d34-106" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,112.72)" id="img-f4d13d34-107" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,110.24)" id="img-f4d13d34-108" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,107.76)" id="img-f4d13d34-109" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,105.28)" id="img-f4d13d34-110" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,102.8)" id="img-f4d13d34-111" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,100.32)" id="img-f4d13d34-112" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,97.84)" id="img-f4d13d34-113" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,95.36)" id="img-f4d13d34-114" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,92.89)" id="img-f4d13d34-115" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,90.41)" id="img-f4d13d34-116" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,87.93)" id="img-f4d13d34-117" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,85.45)" id="img-f4d13d34-118" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,82.97)" id="img-f4d13d34-119" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,80.49)" id="img-f4d13d34-120" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,78.01)" id="img-f4d13d34-121" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,75.53)" id="img-f4d13d34-122" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,73.05)" id="img-f4d13d34-123" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,70.57)" id="img-f4d13d34-124" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,68.09)" id="img-f4d13d34-125" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,65.61)" id="img-f4d13d34-126" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,63.13)" id="img-f4d13d34-127" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,60.65)" id="img-f4d13d34-128" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,58.17)" id="img-f4d13d34-129" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,55.69)" id="img-f4d13d34-130" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,53.21)" id="img-f4d13d34-131" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-f4d13d34-132" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,48.26)" id="img-f4d13d34-133" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,45.78)" id="img-f4d13d34-134" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,43.3)" id="img-f4d13d34-135" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,40.82)" id="img-f4d13d34-136" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,38.34)" id="img-f4d13d34-137" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,35.86)" id="img-f4d13d34-138" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,33.38)" id="img-f4d13d34-139" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,30.9)" id="img-f4d13d34-140" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,28.42)" id="img-f4d13d34-141" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,25.94)" id="img-f4d13d34-142" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,23.46)" id="img-f4d13d34-143" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,20.98)" id="img-f4d13d34-144" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,18.5)" id="img-f4d13d34-145" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,16.02)" id="img-f4d13d34-146" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,13.54)" id="img-f4d13d34-147" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,11.06)" id="img-f4d13d34-148" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,8.58)" id="img-f4d13d34-149" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,6.11)" id="img-f4d13d34-150" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,3.63)" id="img-f4d13d34-151" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,1.15)" id="img-f4d13d34-152" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-1.33)" id="img-f4d13d34-153" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-3.81)" id="img-f4d13d34-154" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-6.29)" id="img-f4d13d34-155" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-8.77)" id="img-f4d13d34-156" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-11.25)" id="img-f4d13d34-157" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-13.73)" id="img-f4d13d34-158" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-16.21)" id="img-f4d13d34-159" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-18.69)" id="img-f4d13d34-160" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-21.17)" id="img-f4d13d34-161" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-23.65)" id="img-f4d13d34-162" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-26.13)" id="img-f4d13d34-163" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-28.61)" id="img-f4d13d34-164" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-31.09)" id="img-f4d13d34-165" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-33.57)" id="img-f4d13d34-166" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-36.04)" id="img-f4d13d34-167" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-38.52)" id="img-f4d13d34-168" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-41)" id="img-f4d13d34-169" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-43.48)" id="img-f4d13d34-170" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-45.96)" id="img-f4d13d34-171" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-48.44)" id="img-f4d13d34-172" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-50.92)" id="img-f4d13d34-173" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-53.4)" id="img-f4d13d34-174" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-55.88)" id="img-f4d13d34-175" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-58.36)" id="img-f4d13d34-176" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
        <g transform="translate(65.92,-60.84)" id="img-f4d13d34-177" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M-56.78,0 L56.78,0 " class="primitive"/>
        </g>
      </g>
      <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-f4d13d34-178">
        <g transform="translate(-153.19,50.74)" id="img-f4d13d34-179" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-f4d13d34-180" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-f4d13d34-181" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-f4d13d34-182" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-f4d13d34-183" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-f4d13d34-184" gadfly:scale="1.0" visibility="visible">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-f4d13d34-185" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-f4d13d34-186" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(285.04,50.74)" id="img-f4d13d34-187" gadfly:scale="1.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-f4d13d34-188" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-87.46,50.74)" id="img-f4d13d34-189" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-76.5,50.74)" id="img-f4d13d34-190" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-65.54,50.74)" id="img-f4d13d34-191" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-54.59,50.74)" id="img-f4d13d34-192" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-f4d13d34-193" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-32.68,50.74)" id="img-f4d13d34-194" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-21.72,50.74)" id="img-f4d13d34-195" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-10.77,50.74)" id="img-f4d13d34-196" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(0.19,50.74)" id="img-f4d13d34-197" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-f4d13d34-198" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(22.1,50.74)" id="img-f4d13d34-199" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(33.06,50.74)" id="img-f4d13d34-200" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(44.01,50.74)" id="img-f4d13d34-201" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(54.97,50.74)" id="img-f4d13d34-202" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-f4d13d34-203" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(76.88,50.74)" id="img-f4d13d34-204" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(87.84,50.74)" id="img-f4d13d34-205" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(98.79,50.74)" id="img-f4d13d34-206" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(109.75,50.74)" id="img-f4d13d34-207" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-f4d13d34-208" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(131.66,50.74)" id="img-f4d13d34-209" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(142.62,50.74)" id="img-f4d13d34-210" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(153.57,50.74)" id="img-f4d13d34-211" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(164.53,50.74)" id="img-f4d13d34-212" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-f4d13d34-213" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(186.44,50.74)" id="img-f4d13d34-214" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(197.39,50.74)" id="img-f4d13d34-215" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(208.35,50.74)" id="img-f4d13d34-216" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(219.31,50.74)" id="img-f4d13d34-217" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-f4d13d34-218" gadfly:scale="5.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-f4d13d34-219" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-f4d13d34-220" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-f4d13d34-221" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-f4d13d34-222" gadfly:scale="0.5" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-98.41,50.74)" id="img-f4d13d34-223" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-92.93,50.74)" id="img-f4d13d34-224" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-87.46,50.74)" id="img-f4d13d34-225" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-81.98,50.74)" id="img-f4d13d34-226" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-76.5,50.74)" id="img-f4d13d34-227" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-71.02,50.74)" id="img-f4d13d34-228" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-65.54,50.74)" id="img-f4d13d34-229" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-60.07,50.74)" id="img-f4d13d34-230" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-54.59,50.74)" id="img-f4d13d34-231" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-49.11,50.74)" id="img-f4d13d34-232" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-43.63,50.74)" id="img-f4d13d34-233" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-38.15,50.74)" id="img-f4d13d34-234" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-32.68,50.74)" id="img-f4d13d34-235" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-27.2,50.74)" id="img-f4d13d34-236" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-21.72,50.74)" id="img-f4d13d34-237" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-16.24,50.74)" id="img-f4d13d34-238" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-10.77,50.74)" id="img-f4d13d34-239" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(-5.29,50.74)" id="img-f4d13d34-240" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(0.19,50.74)" id="img-f4d13d34-241" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(5.67,50.74)" id="img-f4d13d34-242" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(11.15,50.74)" id="img-f4d13d34-243" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(16.62,50.74)" id="img-f4d13d34-244" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(22.1,50.74)" id="img-f4d13d34-245" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(27.58,50.74)" id="img-f4d13d34-246" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(33.06,50.74)" id="img-f4d13d34-247" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(38.54,50.74)" id="img-f4d13d34-248" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(44.01,50.74)" id="img-f4d13d34-249" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(49.49,50.74)" id="img-f4d13d34-250" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(54.97,50.74)" id="img-f4d13d34-251" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(60.45,50.74)" id="img-f4d13d34-252" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(65.92,50.74)" id="img-f4d13d34-253" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(71.4,50.74)" id="img-f4d13d34-254" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(76.88,50.74)" id="img-f4d13d34-255" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(82.36,50.74)" id="img-f4d13d34-256" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(87.84,50.74)" id="img-f4d13d34-257" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(93.31,50.74)" id="img-f4d13d34-258" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(98.79,50.74)" id="img-f4d13d34-259" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(104.27,50.74)" id="img-f4d13d34-260" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(109.75,50.74)" id="img-f4d13d34-261" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(115.23,50.74)" id="img-f4d13d34-262" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(120.7,50.74)" id="img-f4d13d34-263" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(126.18,50.74)" id="img-f4d13d34-264" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(131.66,50.74)" id="img-f4d13d34-265" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(137.14,50.74)" id="img-f4d13d34-266" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(142.62,50.74)" id="img-f4d13d34-267" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(148.09,50.74)" id="img-f4d13d34-268" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(153.57,50.74)" id="img-f4d13d34-269" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(159.05,50.74)" id="img-f4d13d34-270" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(164.53,50.74)" id="img-f4d13d34-271" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(170,50.74)" id="img-f4d13d34-272" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(175.48,50.74)" id="img-f4d13d34-273" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(180.96,50.74)" id="img-f4d13d34-274" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(186.44,50.74)" id="img-f4d13d34-275" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(191.92,50.74)" id="img-f4d13d34-276" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(197.39,50.74)" id="img-f4d13d34-277" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(202.87,50.74)" id="img-f4d13d34-278" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(208.35,50.74)" id="img-f4d13d34-279" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(213.83,50.74)" id="img-f4d13d34-280" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(219.31,50.74)" id="img-f4d13d34-281" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(224.78,50.74)" id="img-f4d13d34-282" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
        <g transform="translate(230.26,50.74)" id="img-f4d13d34-283" gadfly:scale="10.0" visibility="hidden">
          <path fill="none" d="M0,-39.19 L0,39.19 " class="primitive"/>
        </g>
      </g>
      <g class="plotpanel" id="img-f4d13d34-284">
        <metadata>
          <boundingbox value="9.146294487847229mm 11.543736436631946mm 113.55725847255258mm 78.38289388020833mm"/>
          <unitbox value="-1.8255294335437036 3.0806637075678025 103.65105886708741 -3.1613274151356046"/>
        </metadata>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-f4d13d34-285">
          <g class="color_RGBA{N0f8}(1.0,0.647,0.0,1.0)" stroke-dasharray="none" stroke="#FFA500" id="img-f4d13d34-286">
            <g transform="translate(66.47,48.45)" id="img-f4d13d34-287">
              <path fill="none" d="M-54.23,-5.66 L-53.14,-12.95 -52.04,-18.99 -50.94,-23.28 -49.85,-25.51 -48.75,-25.52 -47.66,-23.37 -46.56,-19.29 -45.47,-13.7 -44.37,-7.15 -43.28,-0.28 -42.18,6.26 -41.08,11.84 -39.99,15.91 -38.89,18.07 -37.8,18.09 -36.7,15.93 -35.61,11.74 -34.51,5.86 -33.41,-1.22 -32.32,-8.88 -31.22,-16.49 -30.13,-23.37 -29.03,-28.95 -27.94,-32.73 -26.84,-34.42 -25.75,-33.86 -24.65,-31.12 -23.55,-26.46 -22.46,-20.3 -21.36,-13.19 -20.27,-5.78 -19.17,1.27 -18.08,7.35 -16.98,11.9 -15.89,14.54 -14.79,15.03 -13.69,13.35 -12.6,9.66 -11.5,4.32 -10.41,-2.19 -9.31,-9.25 -8.22,-16.21 -7.12,-22.42 -6.03,-27.29 -4.93,-30.36 -3.83,-31.31 -2.74,-30.03 -1.64,-26.59 -0.55,-21.26 0.55,-14.46 1.64,-6.77 2.74,1.17 3.83,8.7 4.93,15.2 6.03,20.14 7.12,23.12 8.22,23.93 9.31,22.55 10.41,19.16 11.5,14.1 12.6,7.9 13.69,1.14 14.79,-5.5 15.89,-11.39 16.98,-15.93 18.08,-18.68 19.17,-19.33 20.27,-17.78 21.36,-14.11 22.46,-8.59 23.55,-1.68 24.65,6.07 25.75,14 26.84,21.45 27.94,27.81 29.03,32.55 30.13,35.28 31.22,35.81 32.32,34.12 33.41,30.41 34.51,25.02 35.61,18.49 36.7,11.43 37.8,4.48 38.89,-1.7 39.99,-6.53 41.08,-9.58 42.18,-10.53 43.28,-9.31 44.37,-5.99 45.47,-0.87 46.56,5.59 47.66,12.84 48.75,20.22 49.85,27.08 50.94,32.79 52.04,36.85 53.14,38.87 54.23,38.67 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-f4d13d34-288">
          <g class="color_RGBA{N0f8}(0.0,0.502,0.0,1.0)" stroke-dasharray="none" stroke="#008000" id="img-f4d13d34-289">
            <g transform="translate(66.47,48.85)" id="img-f4d13d34-290">
              <path fill="none" d="M-54.23,0.35 L-53.14,13.07 -52.04,12.69 -50.94,9.11 -49.85,21.59 -48.75,10.22 -47.66,18.12 -46.56,-21.91 -45.47,-20.9 -44.37,9.98 -43.28,3.65 -42.18,5.5 -41.08,-24.92 -39.99,1.39 -38.89,13.6 -37.8,-23.22 -36.7,9.24 -35.61,2.14 -34.51,15.27 -33.41,-1.86 -32.32,-23.43 -31.22,-25.41 -30.13,-7.01 -29.03,3.37 -27.94,12.68 -26.84,4.16 -25.75,9.24 -24.65,-29.32 -23.55,-13.59 -22.46,-15.11 -21.36,2.92 -20.27,3.08 -19.17,-1.55 -18.08,-15.75 -16.98,-19.06 -15.89,3.58 -14.79,-10.21 -13.69,11.66 -12.6,13.55 -11.5,-2.17 -10.41,-4.94 -9.31,-3.49 -8.22,-24.53 -7.12,1.48 -6.03,12.45 -4.93,-31.61 -3.83,-3.17 -2.74,5.83 -1.64,-19.03 -0.55,-0.85 0.55,-9.61 1.64,-18.81 2.74,10.4 3.83,-11.72 4.93,-19.7 6.03,5.55 7.12,-22.94 8.22,-10.99 9.31,5.72 10.41,-9.13 11.5,1.94 12.6,17.67 13.69,5.24 14.79,-13.54 15.89,-11.39 16.98,8.01 18.08,23.31 19.17,-19.28 20.27,-12.31 21.36,-4.22 22.46,2.1 23.55,-11.48 24.65,1.18 25.75,-8.78 26.84,5.78 27.94,-9.7 29.03,0.77 30.13,-1.31 31.22,29.23 32.32,-13.12 33.41,23.35 34.51,3.38 35.61,33.94 36.7,26.67 37.8,-9.93 38.89,36.56 39.99,37.77 41.08,-0.71 42.18,10.02 43.28,-8.63 44.37,7.98 45.47,-6.35 46.56,10.34 47.66,13.49 48.75,18.47 49.85,-8.66 50.94,-0.52 52.04,2.32 53.14,6.32 54.23,8.42 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-f4d13d34-291">
          <g class="color_RGBA{N0f8}(0.0,0.0,1.0,1.0)" stroke-dasharray="none" stroke="#0000FF" id="img-f4d13d34-292">
            <g transform="translate(66.47,50.08)" id="img-f4d13d34-293">
              <path fill="none" d="M-54.23,-7.13 L-53.14,-7.13 -52.04,-12.44 -50.94,-17.61 -49.85,-12.69 -48.75,-17.49 -47.66,-10.5 -46.56,-25.57 -45.47,-18.63 -44.37,4.18 -43.28,8.69 -42.18,16.94 -41.08,8.05 -39.99,26.01 -38.89,34.97 -37.8,17.25 -36.7,31.94 -35.61,24.8 -34.51,26.04 -33.41,10.93 -32.32,-7.04 -31.22,-15.19 -30.13,-12.48 -29.03,-12.5 -27.94,-11.32 -26.84,-16.99 -25.75,-13.67 -24.65,-30.03 -23.55,-17.36 -22.46,-11.88 -21.36,4.29 -20.27,11.77 -19.17,16.46 -18.08,15.34 -16.98,18.09 -15.89,31.86 -14.79,25.23 -13.69,34.2 -12.6,31.14 -11.5,17.57 -10.41,9.27 -9.31,2.48 -8.22,-15.49 -7.12,-9.21 -6.03,-9.17 -4.93,-34.87 -3.83,-22.24 -2.74,-17.13 -1.64,-26.82 -0.55,-13.13 0.55,-11.47 1.64,-9.17 2.74,12.57 3.83,8.22 4.93,9.88 6.03,26.57 7.12,14.42 8.22,20.31 9.31,26.38 10.41,14.65 11.5,14.2 12.6,14.93 13.69,1.03 14.79,-15.93 15.89,-21.67 16.98,-17.43 18.08,-13.45 19.17,-36.3 20.27,-32.15 21.36,-25.32 22.46,-17.5 23.55,-18.22 24.65,-4.97 25.75,-2.82 26.84,11.14 27.94,9.01 29.03,18.26 30.13,19.26 31.22,34.4 32.32,10.92 33.41,24.84 34.51,8.93 35.61,17.16 36.7,5.98 37.8,-19.7 38.89,-3.03 39.99,-7.61 41.08,-30.2 42.18,-26.06 43.28,-34.37 44.37,-22.93 45.47,-25.1 46.56,-10.37 47.66,-1.58 48.75,8.3 49.85,1.65 50.94,11.54 52.04,17.16 53.14,21.38 54.23,22.48 " class="primitive"/>
            </g>
          </g>
        </g>
        <g stroke-width="0.71" fill="#000000" fill-opacity="0.000" class="geometry" id="img-f4d13d34-294">
          <g class="color_RGBA{N0f8}(1.0,0.0,0.0,1.0)" stroke-dasharray="none" stroke="#FF0000" id="img-f4d13d34-295">
            <g transform="translate(66.47,48.65)" id="img-f4d13d34-296">
              <path fill="none" d="M-54.23,-2.66 L-53.14,0.06 -52.04,-3.15 -50.94,-7.09 -49.85,-1.96 -48.75,-7.65 -47.66,-2.62 -46.56,-20.6 -45.47,-17.3 -44.37,1.41 -43.28,1.69 -42.18,5.88 -41.08,-6.54 -39.99,8.65 -38.89,15.84 -37.8,-2.56 -36.7,12.58 -35.61,6.94 -34.51,10.56 -33.41,-1.54 -32.32,-16.16 -31.22,-20.95 -30.13,-15.19 -29.03,-12.79 -27.94,-10.03 -26.84,-15.13 -25.75,-12.31 -24.65,-30.22 -23.55,-20.02 -22.46,-17.7 -21.36,-5.14 -20.27,-1.35 -19.17,-0.14 -18.08,-4.2 -16.98,-3.58 -15.89,9.06 -14.79,2.41 -13.69,12.51 -12.6,11.61 -11.5,1.07 -10.41,-3.56 -9.31,-6.37 -8.22,-20.37 -7.12,-10.47 -6.03,-7.42 -4.93,-30.98 -3.83,-17.24 -2.74,-12.1 -1.64,-22.81 -0.55,-11.05 0.55,-12.04 1.64,-12.79 2.74,5.78 3.83,-1.51 4.93,-2.25 6.03,12.85 7.12,0.09 8.22,6.47 9.31,14.14 10.41,5.02 11.5,8.02 12.6,12.78 13.69,3.19 14.79,-9.52 15.89,-11.39 16.98,-3.96 18.08,2.31 19.17,-19.31 20.27,-15.04 21.36,-9.17 22.46,-3.25 23.55,-6.58 24.65,3.62 25.75,2.61 26.84,13.62 27.94,9.05 29.03,16.66 30.13,16.98 31.22,32.52 32.32,10.5 33.41,26.88 34.51,14.2 35.61,26.22 36.7,19.05 37.8,-2.72 38.89,17.43 39.99,15.62 41.08,-5.14 42.18,-0.26 43.28,-8.97 44.37,1 45.47,-3.61 46.56,7.97 47.66,13.16 48.75,19.35 49.85,9.21 50.94,16.14 52.04,19.58 53.14,22.59 54.23,23.55 " class="primitive"/>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide crosshair" id="img-f4d13d34-297">
        <g class="text_box" fill="#000000" id="img-f4d13d34-298">
          <g transform="translate(115.65,12.07)" id="img-f4d13d34-299">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em"></text>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide helpscreen" id="img-f4d13d34-300">
        <g class="text_box" id="img-f4d13d34-301">
          <g fill="#000000" id="img-f4d13d34-302">
            <g transform="translate(65.92,50.74)" id="img-f4d13d34-303">
              <path d="M-34.41,-12.5 L34.41,-12.5 34.41,12.5 -34.41,12.5  z" class="primitive"/>
            </g>
          </g>
          <g fill="#FFFF74" font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-f4d13d34-304">
            <g transform="translate(65.92,41.65)" id="img-f4d13d34-305">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">h,j,k,l,arrows,drag to pan</text>
              </g>
            </g>
            <g transform="translate(65.92,46.19)" id="img-f4d13d34-306">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">i,o,+,-,scroll,shift-drag to zoom</text>
              </g>
            </g>
            <g transform="translate(65.92,50.74)" id="img-f4d13d34-307">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">r,dbl-click to reset</text>
              </g>
            </g>
            <g transform="translate(65.92,55.28)" id="img-f4d13d34-308">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">c for coordinates</text>
              </g>
            </g>
            <g transform="translate(65.92,59.82)" id="img-f4d13d34-309">
              <g class="primitive">
                <text text-anchor="middle" dy="0.35em">? for help</text>
              </g>
            </g>
          </g>
        </g>
      </g>
      <g fill-opacity="0" class="guide questionmark" id="img-f4d13d34-310">
        <g class="text_box" fill="#000000" id="img-f4d13d34-311">
          <g transform="translate(122.7,12.07)" id="img-f4d13d34-312">
            <g class="primitive">
              <text text-anchor="end" dy="0.6em">?</text>
            </g>
          </g>
        </g>
      </g>
    </g>
  </g>
  <g class="guide ylabels" font-size="4.23" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-f4d13d34-313">
    <g transform="translate(8.15,187.1)" id="img-f4d13d34-314" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-4</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-f4d13d34-315" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-f4d13d34-316" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-f4d13d34-317" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-f4d13d34-318" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-f4d13d34-319" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-f4d13d34-320" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-f4d13d34-321" gadfly:scale="1.0" visibility="visible">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-f4d13d34-322" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-f4d13d34-323" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-f4d13d34-324" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6</text>
      </g>
    </g>
    <g transform="translate(8.15,-85.63)" id="img-f4d13d34-325" gadfly:scale="1.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">7</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-f4d13d34-326" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,157.35)" id="img-f4d13d34-327" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,152.39)" id="img-f4d13d34-328" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,147.43)" id="img-f4d13d34-329" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,142.47)" id="img-f4d13d34-330" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-f4d13d34-331" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,132.56)" id="img-f4d13d34-332" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,127.6)" id="img-f4d13d34-333" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,122.64)" id="img-f4d13d34-334" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,117.68)" id="img-f4d13d34-335" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-f4d13d34-336" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,107.76)" id="img-f4d13d34-337" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,102.8)" id="img-f4d13d34-338" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,97.84)" id="img-f4d13d34-339" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,92.89)" id="img-f4d13d34-340" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-f4d13d34-341" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(8.15,82.97)" id="img-f4d13d34-342" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,78.01)" id="img-f4d13d34-343" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,73.05)" id="img-f4d13d34-344" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,68.09)" id="img-f4d13d34-345" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-f4d13d34-346" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,58.17)" id="img-f4d13d34-347" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,53.21)" id="img-f4d13d34-348" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,48.26)" id="img-f4d13d34-349" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,43.3)" id="img-f4d13d34-350" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-f4d13d34-351" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,33.38)" id="img-f4d13d34-352" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,28.42)" id="img-f4d13d34-353" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,23.46)" id="img-f4d13d34-354" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,18.5)" id="img-f4d13d34-355" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-f4d13d34-356" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,8.58)" id="img-f4d13d34-357" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.2</text>
      </g>
    </g>
    <g transform="translate(8.15,3.63)" id="img-f4d13d34-358" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-1.33)" id="img-f4d13d34-359" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-6.29)" id="img-f4d13d34-360" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-f4d13d34-361" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-16.21)" id="img-f4d13d34-362" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-21.17)" id="img-f4d13d34-363" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-26.13)" id="img-f4d13d34-364" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-31.09)" id="img-f4d13d34-365" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-f4d13d34-366" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-41)" id="img-f4d13d34-367" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-45.96)" id="img-f4d13d34-368" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-50.92)" id="img-f4d13d34-369" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-55.88)" id="img-f4d13d34-370" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-f4d13d34-371" gadfly:scale="5.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6.0</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-f4d13d34-372" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-f4d13d34-373" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-f4d13d34-374" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-f4d13d34-375" gadfly:scale="0.5" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6</text>
      </g>
    </g>
    <g transform="translate(8.15,162.31)" id="img-f4d13d34-376" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,159.83)" id="img-f4d13d34-377" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.9</text>
      </g>
    </g>
    <g transform="translate(8.15,157.35)" id="img-f4d13d34-378" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,154.87)" id="img-f4d13d34-379" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.7</text>
      </g>
    </g>
    <g transform="translate(8.15,152.39)" id="img-f4d13d34-380" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,149.91)" id="img-f4d13d34-381" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.5</text>
      </g>
    </g>
    <g transform="translate(8.15,147.43)" id="img-f4d13d34-382" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,144.95)" id="img-f4d13d34-383" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.3</text>
      </g>
    </g>
    <g transform="translate(8.15,142.47)" id="img-f4d13d34-384" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,139.99)" id="img-f4d13d34-385" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.1</text>
      </g>
    </g>
    <g transform="translate(8.15,137.52)" id="img-f4d13d34-386" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,135.04)" id="img-f4d13d34-387" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.9</text>
      </g>
    </g>
    <g transform="translate(8.15,132.56)" id="img-f4d13d34-388" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,130.08)" id="img-f4d13d34-389" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.7</text>
      </g>
    </g>
    <g transform="translate(8.15,127.6)" id="img-f4d13d34-390" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,125.12)" id="img-f4d13d34-391" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.5</text>
      </g>
    </g>
    <g transform="translate(8.15,122.64)" id="img-f4d13d34-392" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,120.16)" id="img-f4d13d34-393" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.3</text>
      </g>
    </g>
    <g transform="translate(8.15,117.68)" id="img-f4d13d34-394" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,115.2)" id="img-f4d13d34-395" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.1</text>
      </g>
    </g>
    <g transform="translate(8.15,112.72)" id="img-f4d13d34-396" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,110.24)" id="img-f4d13d34-397" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.9</text>
      </g>
    </g>
    <g transform="translate(8.15,107.76)" id="img-f4d13d34-398" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,105.28)" id="img-f4d13d34-399" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.7</text>
      </g>
    </g>
    <g transform="translate(8.15,102.8)" id="img-f4d13d34-400" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,100.32)" id="img-f4d13d34-401" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.5</text>
      </g>
    </g>
    <g transform="translate(8.15,97.84)" id="img-f4d13d34-402" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,95.36)" id="img-f4d13d34-403" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.3</text>
      </g>
    </g>
    <g transform="translate(8.15,92.89)" id="img-f4d13d34-404" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,90.41)" id="img-f4d13d34-405" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">-0.1</text>
      </g>
    </g>
    <g transform="translate(8.15,87.93)" id="img-f4d13d34-406" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.0</text>
      </g>
    </g>
    <g transform="translate(8.15,85.45)" id="img-f4d13d34-407" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.1</text>
      </g>
    </g>
    <g transform="translate(8.15,82.97)" id="img-f4d13d34-408" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.2</text>
      </g>
    </g>
    <g transform="translate(8.15,80.49)" id="img-f4d13d34-409" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.3</text>
      </g>
    </g>
    <g transform="translate(8.15,78.01)" id="img-f4d13d34-410" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.4</text>
      </g>
    </g>
    <g transform="translate(8.15,75.53)" id="img-f4d13d34-411" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.5</text>
      </g>
    </g>
    <g transform="translate(8.15,73.05)" id="img-f4d13d34-412" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.6</text>
      </g>
    </g>
    <g transform="translate(8.15,70.57)" id="img-f4d13d34-413" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.7</text>
      </g>
    </g>
    <g transform="translate(8.15,68.09)" id="img-f4d13d34-414" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.8</text>
      </g>
    </g>
    <g transform="translate(8.15,65.61)" id="img-f4d13d34-415" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">0.9</text>
      </g>
    </g>
    <g transform="translate(8.15,63.13)" id="img-f4d13d34-416" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.0</text>
      </g>
    </g>
    <g transform="translate(8.15,60.65)" id="img-f4d13d34-417" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.1</text>
      </g>
    </g>
    <g transform="translate(8.15,58.17)" id="img-f4d13d34-418" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.2</text>
      </g>
    </g>
    <g transform="translate(8.15,55.69)" id="img-f4d13d34-419" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.3</text>
      </g>
    </g>
    <g transform="translate(8.15,53.21)" id="img-f4d13d34-420" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.4</text>
      </g>
    </g>
    <g transform="translate(8.15,50.74)" id="img-f4d13d34-421" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.5</text>
      </g>
    </g>
    <g transform="translate(8.15,48.26)" id="img-f4d13d34-422" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.6</text>
      </g>
    </g>
    <g transform="translate(8.15,45.78)" id="img-f4d13d34-423" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.7</text>
      </g>
    </g>
    <g transform="translate(8.15,43.3)" id="img-f4d13d34-424" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.8</text>
      </g>
    </g>
    <g transform="translate(8.15,40.82)" id="img-f4d13d34-425" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">1.9</text>
      </g>
    </g>
    <g transform="translate(8.15,38.34)" id="img-f4d13d34-426" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.0</text>
      </g>
    </g>
    <g transform="translate(8.15,35.86)" id="img-f4d13d34-427" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.1</text>
      </g>
    </g>
    <g transform="translate(8.15,33.38)" id="img-f4d13d34-428" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.2</text>
      </g>
    </g>
    <g transform="translate(8.15,30.9)" id="img-f4d13d34-429" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.3</text>
      </g>
    </g>
    <g transform="translate(8.15,28.42)" id="img-f4d13d34-430" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.4</text>
      </g>
    </g>
    <g transform="translate(8.15,25.94)" id="img-f4d13d34-431" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.5</text>
      </g>
    </g>
    <g transform="translate(8.15,23.46)" id="img-f4d13d34-432" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.6</text>
      </g>
    </g>
    <g transform="translate(8.15,20.98)" id="img-f4d13d34-433" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.7</text>
      </g>
    </g>
    <g transform="translate(8.15,18.5)" id="img-f4d13d34-434" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.8</text>
      </g>
    </g>
    <g transform="translate(8.15,16.02)" id="img-f4d13d34-435" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">2.9</text>
      </g>
    </g>
    <g transform="translate(8.15,13.54)" id="img-f4d13d34-436" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.0</text>
      </g>
    </g>
    <g transform="translate(8.15,11.06)" id="img-f4d13d34-437" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.1</text>
      </g>
    </g>
    <g transform="translate(8.15,8.58)" id="img-f4d13d34-438" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.2</text>
      </g>
    </g>
    <g transform="translate(8.15,6.11)" id="img-f4d13d34-439" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.3</text>
      </g>
    </g>
    <g transform="translate(8.15,3.63)" id="img-f4d13d34-440" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.4</text>
      </g>
    </g>
    <g transform="translate(8.15,1.15)" id="img-f4d13d34-441" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-1.33)" id="img-f4d13d34-442" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-3.81)" id="img-f4d13d34-443" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-6.29)" id="img-f4d13d34-444" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-8.77)" id="img-f4d13d34-445" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">3.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-11.25)" id="img-f4d13d34-446" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-13.73)" id="img-f4d13d34-447" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.1</text>
      </g>
    </g>
    <g transform="translate(8.15,-16.21)" id="img-f4d13d34-448" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-18.69)" id="img-f4d13d34-449" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.3</text>
      </g>
    </g>
    <g transform="translate(8.15,-21.17)" id="img-f4d13d34-450" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-23.65)" id="img-f4d13d34-451" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-26.13)" id="img-f4d13d34-452" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-28.61)" id="img-f4d13d34-453" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-31.09)" id="img-f4d13d34-454" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-33.57)" id="img-f4d13d34-455" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">4.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-36.04)" id="img-f4d13d34-456" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.0</text>
      </g>
    </g>
    <g transform="translate(8.15,-38.52)" id="img-f4d13d34-457" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.1</text>
      </g>
    </g>
    <g transform="translate(8.15,-41)" id="img-f4d13d34-458" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.2</text>
      </g>
    </g>
    <g transform="translate(8.15,-43.48)" id="img-f4d13d34-459" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.3</text>
      </g>
    </g>
    <g transform="translate(8.15,-45.96)" id="img-f4d13d34-460" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.4</text>
      </g>
    </g>
    <g transform="translate(8.15,-48.44)" id="img-f4d13d34-461" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.5</text>
      </g>
    </g>
    <g transform="translate(8.15,-50.92)" id="img-f4d13d34-462" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.6</text>
      </g>
    </g>
    <g transform="translate(8.15,-53.4)" id="img-f4d13d34-463" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.7</text>
      </g>
    </g>
    <g transform="translate(8.15,-55.88)" id="img-f4d13d34-464" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.8</text>
      </g>
    </g>
    <g transform="translate(8.15,-58.36)" id="img-f4d13d34-465" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">5.9</text>
      </g>
    </g>
    <g transform="translate(8.15,-60.84)" id="img-f4d13d34-466" gadfly:scale="10.0" visibility="hidden">
      <g class="primitive">
        <text text-anchor="end" dy="0.35em">6.0</text>
      </g>
    </g>
  </g>
  <g font-size="4.94" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-f4d13d34-467">
    <g transform="translate(65.92,5)" id="img-f4d13d34-468">
      <g class="primitive">
        <text text-anchor="middle" dy="0.6em">Reproduced signals</text>
      </g>
    </g>
  </g>
</g>
<defs>
  <clipPath id="img-f4d13d34-20">
    <path d="M9.15,11.54 L122.7,11.54 122.7,89.93 9.15,89.93 " />
  </clipPath>
</defs>
<script> <![CDATA[
(function(N){var k=/[\.\/]/,L=/\s*,\s*/,C=function(a,d){return a-d},a,v,y={n:{}},M=function(){for(var a=0,d=this.length;a<d;a++)if("undefined"!=typeof this[a])return this[a]},A=function(){for(var a=this.length;--a;)if("undefined"!=typeof this[a])return this[a]},w=function(k,d){k=String(k);var f=v,n=Array.prototype.slice.call(arguments,2),u=w.listeners(k),p=0,b,q=[],e={},l=[],r=a;l.firstDefined=M;l.lastDefined=A;a=k;for(var s=v=0,x=u.length;s<x;s++)"zIndex"in u[s]&&(q.push(u[s].zIndex),0>u[s].zIndex&&
(e[u[s].zIndex]=u[s]));for(q.sort(C);0>q[p];)if(b=e[q[p++] ],l.push(b.apply(d,n)),v)return v=f,l;for(s=0;s<x;s++)if(b=u[s],"zIndex"in b)if(b.zIndex==q[p]){l.push(b.apply(d,n));if(v)break;do if(p++,(b=e[q[p] ])&&l.push(b.apply(d,n)),v)break;while(b)}else e[b.zIndex]=b;else if(l.push(b.apply(d,n)),v)break;v=f;a=r;return l};w._events=y;w.listeners=function(a){a=a.split(k);var d=y,f,n,u,p,b,q,e,l=[d],r=[];u=0;for(p=a.length;u<p;u++){e=[];b=0;for(q=l.length;b<q;b++)for(d=l[b].n,f=[d[a[u] ],d["*"] ],n=2;n--;)if(d=
f[n])e.push(d),r=r.concat(d.f||[]);l=e}return r};w.on=function(a,d){a=String(a);if("function"!=typeof d)return function(){};for(var f=a.split(L),n=0,u=f.length;n<u;n++)(function(a){a=a.split(k);for(var b=y,f,e=0,l=a.length;e<l;e++)b=b.n,b=b.hasOwnProperty(a[e])&&b[a[e] ]||(b[a[e] ]={n:{}});b.f=b.f||[];e=0;for(l=b.f.length;e<l;e++)if(b.f[e]==d){f=!0;break}!f&&b.f.push(d)})(f[n]);return function(a){+a==+a&&(d.zIndex=+a)}};w.f=function(a){var d=[].slice.call(arguments,1);return function(){w.apply(null,
[a,null].concat(d).concat([].slice.call(arguments,0)))}};w.stop=function(){v=1};w.nt=function(k){return k?(new RegExp("(?:\\.|\\/|^)"+k+"(?:\\.|\\/|$)")).test(a):a};w.nts=function(){return a.split(k)};w.off=w.unbind=function(a,d){if(a){var f=a.split(L);if(1<f.length)for(var n=0,u=f.length;n<u;n++)w.off(f[n],d);else{for(var f=a.split(k),p,b,q,e,l=[y],n=0,u=f.length;n<u;n++)for(e=0;e<l.length;e+=q.length-2){q=[e,1];p=l[e].n;if("*"!=f[n])p[f[n] ]&&q.push(p[f[n] ]);else for(b in p)p.hasOwnProperty(b)&&
q.push(p[b]);l.splice.apply(l,q)}n=0;for(u=l.length;n<u;n++)for(p=l[n];p.n;){if(d){if(p.f){e=0;for(f=p.f.length;e<f;e++)if(p.f[e]==d){p.f.splice(e,1);break}!p.f.length&&delete p.f}for(b in p.n)if(p.n.hasOwnProperty(b)&&p.n[b].f){q=p.n[b].f;e=0;for(f=q.length;e<f;e++)if(q[e]==d){q.splice(e,1);break}!q.length&&delete p.n[b].f}}else for(b in delete p.f,p.n)p.n.hasOwnProperty(b)&&p.n[b].f&&delete p.n[b].f;p=p.n}}}else w._events=y={n:{}}};w.once=function(a,d){var f=function(){w.unbind(a,f);return d.apply(this,
arguments)};return w.on(a,f)};w.version="0.4.2";w.toString=function(){return"You are running Eve 0.4.2"};"undefined"!=typeof module&&module.exports?module.exports=w:"function"===typeof define&&define.amd?define("eve",[],function(){return w}):N.eve=w})(this);
(function(N,k){"function"===typeof define&&define.amd?define("Snap.svg",["eve"],function(L){return k(N,L)}):k(N,N.eve)})(this,function(N,k){var L=function(a){var k={},y=N.requestAnimationFrame||N.webkitRequestAnimationFrame||N.mozRequestAnimationFrame||N.oRequestAnimationFrame||N.msRequestAnimationFrame||function(a){setTimeout(a,16)},M=Array.isArray||function(a){return a instanceof Array||"[object Array]"==Object.prototype.toString.call(a)},A=0,w="M"+(+new Date).toString(36),z=function(a){if(null==
a)return this.s;var b=this.s-a;this.b+=this.dur*b;this.B+=this.dur*b;this.s=a},d=function(a){if(null==a)return this.spd;this.spd=a},f=function(a){if(null==a)return this.dur;this.s=this.s*a/this.dur;this.dur=a},n=function(){delete k[this.id];this.update();a("mina.stop."+this.id,this)},u=function(){this.pdif||(delete k[this.id],this.update(),this.pdif=this.get()-this.b)},p=function(){this.pdif&&(this.b=this.get()-this.pdif,delete this.pdif,k[this.id]=this)},b=function(){var a;if(M(this.start)){a=[];
for(var b=0,e=this.start.length;b<e;b++)a[b]=+this.start[b]+(this.end[b]-this.start[b])*this.easing(this.s)}else a=+this.start+(this.end-this.start)*this.easing(this.s);this.set(a)},q=function(){var l=0,b;for(b in k)if(k.hasOwnProperty(b)){var e=k[b],f=e.get();l++;e.s=(f-e.b)/(e.dur/e.spd);1<=e.s&&(delete k[b],e.s=1,l--,function(b){setTimeout(function(){a("mina.finish."+b.id,b)})}(e));e.update()}l&&y(q)},e=function(a,r,s,x,G,h,J){a={id:w+(A++).toString(36),start:a,end:r,b:s,s:0,dur:x-s,spd:1,get:G,
set:h,easing:J||e.linear,status:z,speed:d,duration:f,stop:n,pause:u,resume:p,update:b};k[a.id]=a;r=0;for(var K in k)if(k.hasOwnProperty(K)&&(r++,2==r))break;1==r&&y(q);return a};e.time=Date.now||function(){return+new Date};e.getById=function(a){return k[a]||null};e.linear=function(a){return a};e.easeout=function(a){return Math.pow(a,1.7)};e.easein=function(a){return Math.pow(a,0.48)};e.easeinout=function(a){if(1==a)return 1;if(0==a)return 0;var b=0.48-a/1.04,e=Math.sqrt(0.1734+b*b);a=e-b;a=Math.pow(Math.abs(a),
1/3)*(0>a?-1:1);b=-e-b;b=Math.pow(Math.abs(b),1/3)*(0>b?-1:1);a=a+b+0.5;return 3*(1-a)*a*a+a*a*a};e.backin=function(a){return 1==a?1:a*a*(2.70158*a-1.70158)};e.backout=function(a){if(0==a)return 0;a-=1;return a*a*(2.70158*a+1.70158)+1};e.elastic=function(a){return a==!!a?a:Math.pow(2,-10*a)*Math.sin(2*(a-0.075)*Math.PI/0.3)+1};e.bounce=function(a){a<1/2.75?a*=7.5625*a:a<2/2.75?(a-=1.5/2.75,a=7.5625*a*a+0.75):a<2.5/2.75?(a-=2.25/2.75,a=7.5625*a*a+0.9375):(a-=2.625/2.75,a=7.5625*a*a+0.984375);return a};
return N.mina=e}("undefined"==typeof k?function(){}:k),C=function(){function a(c,t){if(c){if(c.tagName)return x(c);if(y(c,"array")&&a.set)return a.set.apply(a,c);if(c instanceof e)return c;if(null==t)return c=G.doc.querySelector(c),x(c)}return new s(null==c?"100%":c,null==t?"100%":t)}function v(c,a){if(a){"#text"==c&&(c=G.doc.createTextNode(a.text||""));"string"==typeof c&&(c=v(c));if("string"==typeof a)return"xlink:"==a.substring(0,6)?c.getAttributeNS(m,a.substring(6)):"xml:"==a.substring(0,4)?c.getAttributeNS(la,
a.substring(4)):c.getAttribute(a);for(var da in a)if(a[h](da)){var b=J(a[da]);b?"xlink:"==da.substring(0,6)?c.setAttributeNS(m,da.substring(6),b):"xml:"==da.substring(0,4)?c.setAttributeNS(la,da.substring(4),b):c.setAttribute(da,b):c.removeAttribute(da)}}else c=G.doc.createElementNS(la,c);return c}function y(c,a){a=J.prototype.toLowerCase.call(a);return"finite"==a?isFinite(c):"array"==a&&(c instanceof Array||Array.isArray&&Array.isArray(c))?!0:"null"==a&&null===c||a==typeof c&&null!==c||"object"==
a&&c===Object(c)||$.call(c).slice(8,-1).toLowerCase()==a}function M(c){if("function"==typeof c||Object(c)!==c)return c;var a=new c.constructor,b;for(b in c)c[h](b)&&(a[b]=M(c[b]));return a}function A(c,a,b){function m(){var e=Array.prototype.slice.call(arguments,0),f=e.join("\u2400"),d=m.cache=m.cache||{},l=m.count=m.count||[];if(d[h](f)){a:for(var e=l,l=f,B=0,H=e.length;B<H;B++)if(e[B]===l){e.push(e.splice(B,1)[0]);break a}return b?b(d[f]):d[f]}1E3<=l.length&&delete d[l.shift()];l.push(f);d[f]=c.apply(a,
e);return b?b(d[f]):d[f]}return m}function w(c,a,b,m,e,f){return null==e?(c-=b,a-=m,c||a?(180*I.atan2(-a,-c)/C+540)%360:0):w(c,a,e,f)-w(b,m,e,f)}function z(c){return c%360*C/180}function d(c){var a=[];c=c.replace(/(?:^|\s)(\w+)\(([^)]+)\)/g,function(c,b,m){m=m.split(/\s*,\s*|\s+/);"rotate"==b&&1==m.length&&m.push(0,0);"scale"==b&&(2<m.length?m=m.slice(0,2):2==m.length&&m.push(0,0),1==m.length&&m.push(m[0],0,0));"skewX"==b?a.push(["m",1,0,I.tan(z(m[0])),1,0,0]):"skewY"==b?a.push(["m",1,I.tan(z(m[0])),
0,1,0,0]):a.push([b.charAt(0)].concat(m));return c});return a}function f(c,t){var b=O(c),m=new a.Matrix;if(b)for(var e=0,f=b.length;e<f;e++){var h=b[e],d=h.length,B=J(h[0]).toLowerCase(),H=h[0]!=B,l=H?m.invert():0,E;"t"==B&&2==d?m.translate(h[1],0):"t"==B&&3==d?H?(d=l.x(0,0),B=l.y(0,0),H=l.x(h[1],h[2]),l=l.y(h[1],h[2]),m.translate(H-d,l-B)):m.translate(h[1],h[2]):"r"==B?2==d?(E=E||t,m.rotate(h[1],E.x+E.width/2,E.y+E.height/2)):4==d&&(H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.rotate(h[1],H,l)):m.rotate(h[1],
h[2],h[3])):"s"==B?2==d||3==d?(E=E||t,m.scale(h[1],h[d-1],E.x+E.width/2,E.y+E.height/2)):4==d?H?(H=l.x(h[2],h[3]),l=l.y(h[2],h[3]),m.scale(h[1],h[1],H,l)):m.scale(h[1],h[1],h[2],h[3]):5==d&&(H?(H=l.x(h[3],h[4]),l=l.y(h[3],h[4]),m.scale(h[1],h[2],H,l)):m.scale(h[1],h[2],h[3],h[4])):"m"==B&&7==d&&m.add(h[1],h[2],h[3],h[4],h[5],h[6])}return m}function n(c,t){if(null==t){var m=!0;t="linearGradient"==c.type||"radialGradient"==c.type?c.node.getAttribute("gradientTransform"):"pattern"==c.type?c.node.getAttribute("patternTransform"):
c.node.getAttribute("transform");if(!t)return new a.Matrix;t=d(t)}else t=a._.rgTransform.test(t)?J(t).replace(/\.{3}|\u2026/g,c._.transform||aa):d(t),y(t,"array")&&(t=a.path?a.path.toString.call(t):J(t)),c._.transform=t;var b=f(t,c.getBBox(1));if(m)return b;c.matrix=b}function u(c){c=c.node.ownerSVGElement&&x(c.node.ownerSVGElement)||c.node.parentNode&&x(c.node.parentNode)||a.select("svg")||a(0,0);var t=c.select("defs"),t=null==t?!1:t.node;t||(t=r("defs",c.node).node);return t}function p(c){return c.node.ownerSVGElement&&
x(c.node.ownerSVGElement)||a.select("svg")}function b(c,a,m){function b(c){if(null==c)return aa;if(c==+c)return c;v(B,{width:c});try{return B.getBBox().width}catch(a){return 0}}function h(c){if(null==c)return aa;if(c==+c)return c;v(B,{height:c});try{return B.getBBox().height}catch(a){return 0}}function e(b,B){null==a?d[b]=B(c.attr(b)||0):b==a&&(d=B(null==m?c.attr(b)||0:m))}var f=p(c).node,d={},B=f.querySelector(".svg---mgr");B||(B=v("rect"),v(B,{x:-9E9,y:-9E9,width:10,height:10,"class":"svg---mgr",
fill:"none"}),f.appendChild(B));switch(c.type){case "rect":e("rx",b),e("ry",h);case "image":e("width",b),e("height",h);case "text":e("x",b);e("y",h);break;case "circle":e("cx",b);e("cy",h);e("r",b);break;case "ellipse":e("cx",b);e("cy",h);e("rx",b);e("ry",h);break;case "line":e("x1",b);e("x2",b);e("y1",h);e("y2",h);break;case "marker":e("refX",b);e("markerWidth",b);e("refY",h);e("markerHeight",h);break;case "radialGradient":e("fx",b);e("fy",h);break;case "tspan":e("dx",b);e("dy",h);break;default:e(a,
b)}f.removeChild(B);return d}function q(c){y(c,"array")||(c=Array.prototype.slice.call(arguments,0));for(var a=0,b=0,m=this.node;this[a];)delete this[a++];for(a=0;a<c.length;a++)"set"==c[a].type?c[a].forEach(function(c){m.appendChild(c.node)}):m.appendChild(c[a].node);for(var h=m.childNodes,a=0;a<h.length;a++)this[b++]=x(h[a]);return this}function e(c){if(c.snap in E)return E[c.snap];var a=this.id=V(),b;try{b=c.ownerSVGElement}catch(m){}this.node=c;b&&(this.paper=new s(b));this.type=c.tagName;this.anims=
{};this._={transform:[]};c.snap=a;E[a]=this;"g"==this.type&&(this.add=q);if(this.type in{g:1,mask:1,pattern:1})for(var e in s.prototype)s.prototype[h](e)&&(this[e]=s.prototype[e])}function l(c){this.node=c}function r(c,a){var b=v(c);a.appendChild(b);return x(b)}function s(c,a){var b,m,f,d=s.prototype;if(c&&"svg"==c.tagName){if(c.snap in E)return E[c.snap];var l=c.ownerDocument;b=new e(c);m=c.getElementsByTagName("desc")[0];f=c.getElementsByTagName("defs")[0];m||(m=v("desc"),m.appendChild(l.createTextNode("Created with Snap")),
b.node.appendChild(m));f||(f=v("defs"),b.node.appendChild(f));b.defs=f;for(var ca in d)d[h](ca)&&(b[ca]=d[ca]);b.paper=b.root=b}else b=r("svg",G.doc.body),v(b.node,{height:a,version:1.1,width:c,xmlns:la});return b}function x(c){return!c||c instanceof e||c instanceof l?c:c.tagName&&"svg"==c.tagName.toLowerCase()?new s(c):c.tagName&&"object"==c.tagName.toLowerCase()&&"image/svg+xml"==c.type?new s(c.contentDocument.getElementsByTagName("svg")[0]):new e(c)}a.version="0.3.0";a.toString=function(){return"Snap v"+
this.version};a._={};var G={win:N,doc:N.document};a._.glob=G;var h="hasOwnProperty",J=String,K=parseFloat,U=parseInt,I=Math,P=I.max,Q=I.min,Y=I.abs,C=I.PI,aa="",$=Object.prototype.toString,F=/^\s*((#[a-f\d]{6})|(#[a-f\d]{3})|rgba?\(\s*([\d\.]+%?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+%?(?:\s*,\s*[\d\.]+%?)?)\s*\)|hsba?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\)|hsla?\(\s*([\d\.]+(?:deg|\xb0|%)?\s*,\s*[\d\.]+%?\s*,\s*[\d\.]+(?:%?\s*,\s*[\d\.]+)?%?)\s*\))\s*$/i;a._.separator=
RegExp("[,\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]+");var S=RegExp("[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*"),X={hs:1,rg:1},W=RegExp("([a-z])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)",
"ig"),ma=RegExp("([rstm])[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029,]*((-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*)+)","ig"),Z=RegExp("(-?\\d*\\.?\\d*(?:e[\\-+]?\\d+)?)[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*,?[\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*",
"ig"),na=0,ba="S"+(+new Date).toString(36),V=function(){return ba+(na++).toString(36)},m="http://www.w3.org/1999/xlink",la="http://www.w3.org/2000/svg",E={},ca=a.url=function(c){return"url('#"+c+"')"};a._.$=v;a._.id=V;a.format=function(){var c=/\{([^\}]+)\}/g,a=/(?:(?:^|\.)(.+?)(?=\[|\.|$|\()|\[('|")(.+?)\2\])(\(\))?/g,b=function(c,b,m){var h=m;b.replace(a,function(c,a,b,m,t){a=a||m;h&&(a in h&&(h=h[a]),"function"==typeof h&&t&&(h=h()))});return h=(null==h||h==m?c:h)+""};return function(a,m){return J(a).replace(c,
function(c,a){return b(c,a,m)})}}();a._.clone=M;a._.cacher=A;a.rad=z;a.deg=function(c){return 180*c/C%360};a.angle=w;a.is=y;a.snapTo=function(c,a,b){b=y(b,"finite")?b:10;if(y(c,"array"))for(var m=c.length;m--;){if(Y(c[m]-a)<=b)return c[m]}else{c=+c;m=a%c;if(m<b)return a-m;if(m>c-b)return a-m+c}return a};a.getRGB=A(function(c){if(!c||(c=J(c)).indexOf("-")+1)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};if("none"==c)return{r:-1,g:-1,b:-1,hex:"none",toString:ka};!X[h](c.toLowerCase().substring(0,
2))&&"#"!=c.charAt()&&(c=T(c));if(!c)return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka};var b,m,e,f,d;if(c=c.match(F)){c[2]&&(e=U(c[2].substring(5),16),m=U(c[2].substring(3,5),16),b=U(c[2].substring(1,3),16));c[3]&&(e=U((d=c[3].charAt(3))+d,16),m=U((d=c[3].charAt(2))+d,16),b=U((d=c[3].charAt(1))+d,16));c[4]&&(d=c[4].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b*=2.55),m=K(d[1]),"%"==d[1].slice(-1)&&(m*=2.55),e=K(d[2]),"%"==d[2].slice(-1)&&(e*=2.55),"rgba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),
d[3]&&"%"==d[3].slice(-1)&&(f/=100));if(c[5])return d=c[5].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsba"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsb2rgb(b,m,e,f);if(c[6])return d=c[6].split(S),b=K(d[0]),"%"==d[0].slice(-1)&&(b/=100),m=K(d[1]),"%"==d[1].slice(-1)&&(m/=100),e=K(d[2]),"%"==d[2].slice(-1)&&(e/=100),
"deg"!=d[0].slice(-3)&&"\u00b0"!=d[0].slice(-1)||(b/=360),"hsla"==c[1].toLowerCase().slice(0,4)&&(f=K(d[3])),d[3]&&"%"==d[3].slice(-1)&&(f/=100),a.hsl2rgb(b,m,e,f);b=Q(I.round(b),255);m=Q(I.round(m),255);e=Q(I.round(e),255);f=Q(P(f,0),1);c={r:b,g:m,b:e,toString:ka};c.hex="#"+(16777216|e|m<<8|b<<16).toString(16).slice(1);c.opacity=y(f,"finite")?f:1;return c}return{r:-1,g:-1,b:-1,hex:"none",error:1,toString:ka}},a);a.hsb=A(function(c,b,m){return a.hsb2rgb(c,b,m).hex});a.hsl=A(function(c,b,m){return a.hsl2rgb(c,
b,m).hex});a.rgb=A(function(c,a,b,m){if(y(m,"finite")){var e=I.round;return"rgba("+[e(c),e(a),e(b),+m.toFixed(2)]+")"}return"#"+(16777216|b|a<<8|c<<16).toString(16).slice(1)});var T=function(c){var a=G.doc.getElementsByTagName("head")[0]||G.doc.getElementsByTagName("svg")[0];T=A(function(c){if("red"==c.toLowerCase())return"rgb(255, 0, 0)";a.style.color="rgb(255, 0, 0)";a.style.color=c;c=G.doc.defaultView.getComputedStyle(a,aa).getPropertyValue("color");return"rgb(255, 0, 0)"==c?null:c});return T(c)},
qa=function(){return"hsb("+[this.h,this.s,this.b]+")"},ra=function(){return"hsl("+[this.h,this.s,this.l]+")"},ka=function(){return 1==this.opacity||null==this.opacity?this.hex:"rgba("+[this.r,this.g,this.b,this.opacity]+")"},D=function(c,b,m){null==b&&y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&(m=c.b,b=c.g,c=c.r);null==b&&y(c,string)&&(m=a.getRGB(c),c=m.r,b=m.g,m=m.b);if(1<c||1<b||1<m)c/=255,b/=255,m/=255;return[c,b,m]},oa=function(c,b,m,e){c=I.round(255*c);b=I.round(255*b);m=I.round(255*m);c={r:c,
g:b,b:m,opacity:y(e,"finite")?e:1,hex:a.rgb(c,b,m),toString:ka};y(e,"finite")&&(c.opacity=e);return c};a.color=function(c){var b;y(c,"object")&&"h"in c&&"s"in c&&"b"in c?(b=a.hsb2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):y(c,"object")&&"h"in c&&"s"in c&&"l"in c?(b=a.hsl2rgb(c),c.r=b.r,c.g=b.g,c.b=b.b,c.opacity=1,c.hex=b.hex):(y(c,"string")&&(c=a.getRGB(c)),y(c,"object")&&"r"in c&&"g"in c&&"b"in c&&!("error"in c)?(b=a.rgb2hsl(c),c.h=b.h,c.s=b.s,c.l=b.l,b=a.rgb2hsb(c),c.v=b.b):(c={hex:"none"},
c.r=c.g=c.b=c.h=c.s=c.v=c.l=-1,c.error=1));c.toString=ka;return c};a.hsb2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"b"in c&&(b=c.b,a=c.s,c=c.h,m=c.o);var e,h,d;c=360*c%360/60;d=b*a;a=d*(1-Y(c%2-1));b=e=h=b-d;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.hsl2rgb=function(c,a,b,m){y(c,"object")&&"h"in c&&"s"in c&&"l"in c&&(b=c.l,a=c.s,c=c.h);if(1<c||1<a||1<b)c/=360,a/=100,b/=100;var e,h,d;c=360*c%360/60;d=2*a*(0.5>b?b:1-b);a=d*(1-Y(c%2-1));b=e=
h=b-d/2;c=~~c;b+=[d,a,0,0,a,d][c];e+=[a,d,d,a,0,0][c];h+=[0,0,a,d,d,a][c];return oa(b,e,h,m)};a.rgb2hsb=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e;m=P(c,a,b);e=m-Q(c,a,b);c=((0==e?0:m==c?(a-b)/e:m==a?(b-c)/e+2:(c-a)/e+4)+360)%6*60/360;return{h:c,s:0==e?0:e/m,b:m,toString:qa}};a.rgb2hsl=function(c,a,b){b=D(c,a,b);c=b[0];a=b[1];b=b[2];var m,e,h;m=P(c,a,b);e=Q(c,a,b);h=m-e;c=((0==h?0:m==c?(a-b)/h:m==a?(b-c)/h+2:(c-a)/h+4)+360)%6*60/360;m=(m+e)/2;return{h:c,s:0==h?0:0.5>m?h/(2*m):h/(2-2*
m),l:m,toString:ra}};a.parsePathString=function(c){if(!c)return null;var b=a.path(c);if(b.arr)return a.path.clone(b.arr);var m={a:7,c:6,o:2,h:1,l:2,m:2,r:4,q:4,s:4,t:2,v:1,u:3,z:0},e=[];y(c,"array")&&y(c[0],"array")&&(e=a.path.clone(c));e.length||J(c).replace(W,function(c,a,b){var h=[];c=a.toLowerCase();b.replace(Z,function(c,a){a&&h.push(+a)});"m"==c&&2<h.length&&(e.push([a].concat(h.splice(0,2))),c="l",a="m"==a?"l":"L");"o"==c&&1==h.length&&e.push([a,h[0] ]);if("r"==c)e.push([a].concat(h));else for(;h.length>=
m[c]&&(e.push([a].concat(h.splice(0,m[c]))),m[c]););});e.toString=a.path.toString;b.arr=a.path.clone(e);return e};var O=a.parseTransformString=function(c){if(!c)return null;var b=[];y(c,"array")&&y(c[0],"array")&&(b=a.path.clone(c));b.length||J(c).replace(ma,function(c,a,m){var e=[];a.toLowerCase();m.replace(Z,function(c,a){a&&e.push(+a)});b.push([a].concat(e))});b.toString=a.path.toString;return b};a._.svgTransform2string=d;a._.rgTransform=RegExp("^[a-z][\t\n\x0B\f\r \u00a0\u1680\u180e\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200a\u202f\u205f\u3000\u2028\u2029]*-?\\.?\\d",
"i");a._.transform2matrix=f;a._unit2px=b;a._.getSomeDefs=u;a._.getSomeSVG=p;a.select=function(c){return x(G.doc.querySelector(c))};a.selectAll=function(c){c=G.doc.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};setInterval(function(){for(var c in E)if(E[h](c)){var a=E[c],b=a.node;("svg"!=a.type&&!b.ownerSVGElement||"svg"==a.type&&(!b.parentNode||"ownerSVGElement"in b.parentNode&&!b.ownerSVGElement))&&delete E[c]}},1E4);(function(c){function m(c){function a(c,
b){var m=v(c.node,b);(m=(m=m&&m.match(d))&&m[2])&&"#"==m.charAt()&&(m=m.substring(1))&&(f[m]=(f[m]||[]).concat(function(a){var m={};m[b]=ca(a);v(c.node,m)}))}function b(c){var a=v(c.node,"xlink:href");a&&"#"==a.charAt()&&(a=a.substring(1))&&(f[a]=(f[a]||[]).concat(function(a){c.attr("xlink:href","#"+a)}))}var e=c.selectAll("*"),h,d=/^\s*url\(("|'|)(.*)\1\)\s*$/;c=[];for(var f={},l=0,E=e.length;l<E;l++){h=e[l];a(h,"fill");a(h,"stroke");a(h,"filter");a(h,"mask");a(h,"clip-path");b(h);var t=v(h.node,
"id");t&&(v(h.node,{id:h.id}),c.push({old:t,id:h.id}))}l=0;for(E=c.length;l<E;l++)if(e=f[c[l].old])for(h=0,t=e.length;h<t;h++)e[h](c[l].id)}function e(c,a,b){return function(m){m=m.slice(c,a);1==m.length&&(m=m[0]);return b?b(m):m}}function d(c){return function(){var a=c?"<"+this.type:"",b=this.node.attributes,m=this.node.childNodes;if(c)for(var e=0,h=b.length;e<h;e++)a+=" "+b[e].name+'="'+b[e].value.replace(/"/g,'\\"')+'"';if(m.length){c&&(a+=">");e=0;for(h=m.length;e<h;e++)3==m[e].nodeType?a+=m[e].nodeValue:
1==m[e].nodeType&&(a+=x(m[e]).toString());c&&(a+="</"+this.type+">")}else c&&(a+="/>");return a}}c.attr=function(c,a){if(!c)return this;if(y(c,"string"))if(1<arguments.length){var b={};b[c]=a;c=b}else return k("snap.util.getattr."+c,this).firstDefined();for(var m in c)c[h](m)&&k("snap.util.attr."+m,this,c[m]);return this};c.getBBox=function(c){if(!a.Matrix||!a.path)return this.node.getBBox();var b=this,m=new a.Matrix;if(b.removed)return a._.box();for(;"use"==b.type;)if(c||(m=m.add(b.transform().localMatrix.translate(b.attr("x")||
0,b.attr("y")||0))),b.original)b=b.original;else var e=b.attr("xlink:href"),b=b.original=b.node.ownerDocument.getElementById(e.substring(e.indexOf("#")+1));var e=b._,h=a.path.get[b.type]||a.path.get.deflt;try{if(c)return e.bboxwt=h?a.path.getBBox(b.realPath=h(b)):a._.box(b.node.getBBox()),a._.box(e.bboxwt);b.realPath=h(b);b.matrix=b.transform().localMatrix;e.bbox=a.path.getBBox(a.path.map(b.realPath,m.add(b.matrix)));return a._.box(e.bbox)}catch(d){return a._.box()}};var f=function(){return this.string};
c.transform=function(c){var b=this._;if(null==c){var m=this;c=new a.Matrix(this.node.getCTM());for(var e=n(this),h=[e],d=new a.Matrix,l=e.toTransformString(),b=J(e)==J(this.matrix)?J(b.transform):l;"svg"!=m.type&&(m=m.parent());)h.push(n(m));for(m=h.length;m--;)d.add(h[m]);return{string:b,globalMatrix:c,totalMatrix:d,localMatrix:e,diffMatrix:c.clone().add(e.invert()),global:c.toTransformString(),total:d.toTransformString(),local:l,toString:f}}c instanceof a.Matrix?this.matrix=c:n(this,c);this.node&&
("linearGradient"==this.type||"radialGradient"==this.type?v(this.node,{gradientTransform:this.matrix}):"pattern"==this.type?v(this.node,{patternTransform:this.matrix}):v(this.node,{transform:this.matrix}));return this};c.parent=function(){return x(this.node.parentNode)};c.append=c.add=function(c){if(c){if("set"==c.type){var a=this;c.forEach(function(c){a.add(c)});return this}c=x(c);this.node.appendChild(c.node);c.paper=this.paper}return this};c.appendTo=function(c){c&&(c=x(c),c.append(this));return this};
c.prepend=function(c){if(c){if("set"==c.type){var a=this,b;c.forEach(function(c){b?b.after(c):a.prepend(c);b=c});return this}c=x(c);var m=c.parent();this.node.insertBefore(c.node,this.node.firstChild);this.add&&this.add();c.paper=this.paper;this.parent()&&this.parent().add();m&&m.add()}return this};c.prependTo=function(c){c=x(c);c.prepend(this);return this};c.before=function(c){if("set"==c.type){var a=this;c.forEach(function(c){var b=c.parent();a.node.parentNode.insertBefore(c.node,a.node);b&&b.add()});
this.parent().add();return this}c=x(c);var b=c.parent();this.node.parentNode.insertBefore(c.node,this.node);this.parent()&&this.parent().add();b&&b.add();c.paper=this.paper;return this};c.after=function(c){c=x(c);var a=c.parent();this.node.nextSibling?this.node.parentNode.insertBefore(c.node,this.node.nextSibling):this.node.parentNode.appendChild(c.node);this.parent()&&this.parent().add();a&&a.add();c.paper=this.paper;return this};c.insertBefore=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,
c.node);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.insertAfter=function(c){c=x(c);var a=this.parent();c.node.parentNode.insertBefore(this.node,c.node.nextSibling);this.paper=c.paper;a&&a.add();c.parent()&&c.parent().add();return this};c.remove=function(){var c=this.parent();this.node.parentNode&&this.node.parentNode.removeChild(this.node);delete this.paper;this.removed=!0;c&&c.add();return this};c.select=function(c){return x(this.node.querySelector(c))};c.selectAll=
function(c){c=this.node.querySelectorAll(c);for(var b=(a.set||Array)(),m=0;m<c.length;m++)b.push(x(c[m]));return b};c.asPX=function(c,a){null==a&&(a=this.attr(c));return+b(this,c,a)};c.use=function(){var c,a=this.node.id;a||(a=this.id,v(this.node,{id:a}));c="linearGradient"==this.type||"radialGradient"==this.type||"pattern"==this.type?r(this.type,this.node.parentNode):r("use",this.node.parentNode);v(c.node,{"xlink:href":"#"+a});c.original=this;return c};var l=/\S+/g;c.addClass=function(c){var a=(c||
"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h,d;if(a.length){for(e=0;d=a[e++];)h=m.indexOf(d),~h||m.push(d);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.removeClass=function(c){var a=(c||"").match(l)||[];c=this.node;var b=c.className.baseVal,m=b.match(l)||[],e,h;if(m.length){for(e=0;h=a[e++];)h=m.indexOf(h),~h&&m.splice(h,1);a=m.join(" ");b!=a&&(c.className.baseVal=a)}return this};c.hasClass=function(c){return!!~(this.node.className.baseVal.match(l)||[]).indexOf(c)};
c.toggleClass=function(c,a){if(null!=a)return a?this.addClass(c):this.removeClass(c);var b=(c||"").match(l)||[],m=this.node,e=m.className.baseVal,h=e.match(l)||[],d,f,E;for(d=0;E=b[d++];)f=h.indexOf(E),~f?h.splice(f,1):h.push(E);b=h.join(" ");e!=b&&(m.className.baseVal=b);return this};c.clone=function(){var c=x(this.node.cloneNode(!0));v(c.node,"id")&&v(c.node,{id:c.id});m(c);c.insertAfter(this);return c};c.toDefs=function(){u(this).appendChild(this.node);return this};c.pattern=c.toPattern=function(c,
a,b,m){var e=r("pattern",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,c=c.x);v(e.node,{x:c,y:a,width:b,height:m,patternUnits:"userSpaceOnUse",id:e.id,viewBox:[c,a,b,m].join(" ")});e.node.appendChild(this.node);return e};c.marker=function(c,a,b,m,e,h){var d=r("marker",u(this));null==c&&(c=this.getBBox());y(c,"object")&&"x"in c&&(a=c.y,b=c.width,m=c.height,e=c.refX||c.cx,h=c.refY||c.cy,c=c.x);v(d.node,{viewBox:[c,a,b,m].join(" "),markerWidth:b,markerHeight:m,
orient:"auto",refX:e||0,refY:h||0,id:d.id});d.node.appendChild(this.node);return d};var E=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);this.attr=c;this.dur=a;b&&(this.easing=b);m&&(this.callback=m)};a._.Animation=E;a.animation=function(c,a,b,m){return new E(c,a,b,m)};c.inAnim=function(){var c=[],a;for(a in this.anims)this.anims[h](a)&&function(a){c.push({anim:new E(a._attrs,a.dur,a.easing,a._callback),mina:a,curStatus:a.status(),status:function(c){return a.status(c)},stop:function(){a.stop()}})}(this.anims[a]);
return c};a.animate=function(c,a,b,m,e,h){"function"!=typeof e||e.length||(h=e,e=L.linear);var d=L.time();c=L(c,a,d,d+m,L.time,b,e);h&&k.once("mina.finish."+c.id,h);return c};c.stop=function(){for(var c=this.inAnim(),a=0,b=c.length;a<b;a++)c[a].stop();return this};c.animate=function(c,a,b,m){"function"!=typeof b||b.length||(m=b,b=L.linear);c instanceof E&&(m=c.callback,b=c.easing,a=b.dur,c=c.attr);var d=[],f=[],l={},t,ca,n,T=this,q;for(q in c)if(c[h](q)){T.equal?(n=T.equal(q,J(c[q])),t=n.from,ca=
n.to,n=n.f):(t=+T.attr(q),ca=+c[q]);var la=y(t,"array")?t.length:1;l[q]=e(d.length,d.length+la,n);d=d.concat(t);f=f.concat(ca)}t=L.time();var p=L(d,f,t,t+a,L.time,function(c){var a={},b;for(b in l)l[h](b)&&(a[b]=l[b](c));T.attr(a)},b);T.anims[p.id]=p;p._attrs=c;p._callback=m;k("snap.animcreated."+T.id,p);k.once("mina.finish."+p.id,function(){delete T.anims[p.id];m&&m.call(T)});k.once("mina.stop."+p.id,function(){delete T.anims[p.id]});return T};var T={};c.data=function(c,b){var m=T[this.id]=T[this.id]||
{};if(0==arguments.length)return k("snap.data.get."+this.id,this,m,null),m;if(1==arguments.length){if(a.is(c,"object")){for(var e in c)c[h](e)&&this.data(e,c[e]);return this}k("snap.data.get."+this.id,this,m[c],c);return m[c]}m[c]=b;k("snap.data.set."+this.id,this,b,c);return this};c.removeData=function(c){null==c?T[this.id]={}:T[this.id]&&delete T[this.id][c];return this};c.outerSVG=c.toString=d(1);c.innerSVG=d()})(e.prototype);a.parse=function(c){var a=G.doc.createDocumentFragment(),b=!0,m=G.doc.createElement("div");
c=J(c);c.match(/^\s*<\s*svg(?:\s|>)/)||(c="<svg>"+c+"</svg>",b=!1);m.innerHTML=c;if(c=m.getElementsByTagName("svg")[0])if(b)a=c;else for(;c.firstChild;)a.appendChild(c.firstChild);m.innerHTML=aa;return new l(a)};l.prototype.select=e.prototype.select;l.prototype.selectAll=e.prototype.selectAll;a.fragment=function(){for(var c=Array.prototype.slice.call(arguments,0),b=G.doc.createDocumentFragment(),m=0,e=c.length;m<e;m++){var h=c[m];h.node&&h.node.nodeType&&b.appendChild(h.node);h.nodeType&&b.appendChild(h);
"string"==typeof h&&b.appendChild(a.parse(h).node)}return new l(b)};a._.make=r;a._.wrap=x;s.prototype.el=function(c,a){var b=r(c,this.node);a&&b.attr(a);return b};k.on("snap.util.getattr",function(){var c=k.nt(),c=c.substring(c.lastIndexOf(".")+1),a=c.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});return pa[h](a)?this.node.ownerDocument.defaultView.getComputedStyle(this.node,null).getPropertyValue(a):v(this.node,c)});var pa={"alignment-baseline":0,"baseline-shift":0,clip:0,"clip-path":0,
"clip-rule":0,color:0,"color-interpolation":0,"color-interpolation-filters":0,"color-profile":0,"color-rendering":0,cursor:0,direction:0,display:0,"dominant-baseline":0,"enable-background":0,fill:0,"fill-opacity":0,"fill-rule":0,filter:0,"flood-color":0,"flood-opacity":0,font:0,"font-family":0,"font-size":0,"font-size-adjust":0,"font-stretch":0,"font-style":0,"font-variant":0,"font-weight":0,"glyph-orientation-horizontal":0,"glyph-orientation-vertical":0,"image-rendering":0,kerning:0,"letter-spacing":0,
"lighting-color":0,marker:0,"marker-end":0,"marker-mid":0,"marker-start":0,mask:0,opacity:0,overflow:0,"pointer-events":0,"shape-rendering":0,"stop-color":0,"stop-opacity":0,stroke:0,"stroke-dasharray":0,"stroke-dashoffset":0,"stroke-linecap":0,"stroke-linejoin":0,"stroke-miterlimit":0,"stroke-opacity":0,"stroke-width":0,"text-anchor":0,"text-decoration":0,"text-rendering":0,"unicode-bidi":0,visibility:0,"word-spacing":0,"writing-mode":0};k.on("snap.util.attr",function(c){var a=k.nt(),b={},a=a.substring(a.lastIndexOf(".")+
1);b[a]=c;var m=a.replace(/-(\w)/gi,function(c,a){return a.toUpperCase()}),a=a.replace(/[A-Z]/g,function(c){return"-"+c.toLowerCase()});pa[h](a)?this.node.style[m]=null==c?aa:c:v(this.node,b)});a.ajax=function(c,a,b,m){var e=new XMLHttpRequest,h=V();if(e){if(y(a,"function"))m=b,b=a,a=null;else if(y(a,"object")){var d=[],f;for(f in a)a.hasOwnProperty(f)&&d.push(encodeURIComponent(f)+"="+encodeURIComponent(a[f]));a=d.join("&")}e.open(a?"POST":"GET",c,!0);a&&(e.setRequestHeader("X-Requested-With","XMLHttpRequest"),
e.setRequestHeader("Content-type","application/x-www-form-urlencoded"));b&&(k.once("snap.ajax."+h+".0",b),k.once("snap.ajax."+h+".200",b),k.once("snap.ajax."+h+".304",b));e.onreadystatechange=function(){4==e.readyState&&k("snap.ajax."+h+"."+e.status,m,e)};if(4==e.readyState)return e;e.send(a);return e}};a.load=function(c,b,m){a.ajax(c,function(c){c=a.parse(c.responseText);m?b.call(m,c):b(c)})};a.getElementByPoint=function(c,a){var b,m,e=G.doc.elementFromPoint(c,a);if(G.win.opera&&"svg"==e.tagName){b=
e;m=b.getBoundingClientRect();b=b.ownerDocument;var h=b.body,d=b.documentElement;b=m.top+(g.win.pageYOffset||d.scrollTop||h.scrollTop)-(d.clientTop||h.clientTop||0);m=m.left+(g.win.pageXOffset||d.scrollLeft||h.scrollLeft)-(d.clientLeft||h.clientLeft||0);h=e.createSVGRect();h.x=c-m;h.y=a-b;h.width=h.height=1;b=e.getIntersectionList(h,null);b.length&&(e=b[b.length-1])}return e?x(e):null};a.plugin=function(c){c(a,e,s,G,l)};return G.win.Snap=a}();C.plugin(function(a,k,y,M,A){function w(a,d,f,b,q,e){null==
d&&"[object SVGMatrix]"==z.call(a)?(this.a=a.a,this.b=a.b,this.c=a.c,this.d=a.d,this.e=a.e,this.f=a.f):null!=a?(this.a=+a,this.b=+d,this.c=+f,this.d=+b,this.e=+q,this.f=+e):(this.a=1,this.c=this.b=0,this.d=1,this.f=this.e=0)}var z=Object.prototype.toString,d=String,f=Math;(function(n){function k(a){return a[0]*a[0]+a[1]*a[1]}function p(a){var d=f.sqrt(k(a));a[0]&&(a[0]/=d);a[1]&&(a[1]/=d)}n.add=function(a,d,e,f,n,p){var k=[[],[],[] ],u=[[this.a,this.c,this.e],[this.b,this.d,this.f],[0,0,1] ];d=[[a,
e,n],[d,f,p],[0,0,1] ];a&&a instanceof w&&(d=[[a.a,a.c,a.e],[a.b,a.d,a.f],[0,0,1] ]);for(a=0;3>a;a++)for(e=0;3>e;e++){for(f=n=0;3>f;f++)n+=u[a][f]*d[f][e];k[a][e]=n}this.a=k[0][0];this.b=k[1][0];this.c=k[0][1];this.d=k[1][1];this.e=k[0][2];this.f=k[1][2];return this};n.invert=function(){var a=this.a*this.d-this.b*this.c;return new w(this.d/a,-this.b/a,-this.c/a,this.a/a,(this.c*this.f-this.d*this.e)/a,(this.b*this.e-this.a*this.f)/a)};n.clone=function(){return new w(this.a,this.b,this.c,this.d,this.e,
this.f)};n.translate=function(a,d){return this.add(1,0,0,1,a,d)};n.scale=function(a,d,e,f){null==d&&(d=a);(e||f)&&this.add(1,0,0,1,e,f);this.add(a,0,0,d,0,0);(e||f)&&this.add(1,0,0,1,-e,-f);return this};n.rotate=function(b,d,e){b=a.rad(b);d=d||0;e=e||0;var l=+f.cos(b).toFixed(9);b=+f.sin(b).toFixed(9);this.add(l,b,-b,l,d,e);return this.add(1,0,0,1,-d,-e)};n.x=function(a,d){return a*this.a+d*this.c+this.e};n.y=function(a,d){return a*this.b+d*this.d+this.f};n.get=function(a){return+this[d.fromCharCode(97+
a)].toFixed(4)};n.toString=function(){return"matrix("+[this.get(0),this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)].join()+")"};n.offset=function(){return[this.e.toFixed(4),this.f.toFixed(4)]};n.determinant=function(){return this.a*this.d-this.b*this.c};n.split=function(){var b={};b.dx=this.e;b.dy=this.f;var d=[[this.a,this.c],[this.b,this.d] ];b.scalex=f.sqrt(k(d[0]));p(d[0]);b.shear=d[0][0]*d[1][0]+d[0][1]*d[1][1];d[1]=[d[1][0]-d[0][0]*b.shear,d[1][1]-d[0][1]*b.shear];b.scaley=f.sqrt(k(d[1]));
p(d[1]);b.shear/=b.scaley;0>this.determinant()&&(b.scalex=-b.scalex);var e=-d[0][1],d=d[1][1];0>d?(b.rotate=a.deg(f.acos(d)),0>e&&(b.rotate=360-b.rotate)):b.rotate=a.deg(f.asin(e));b.isSimple=!+b.shear.toFixed(9)&&(b.scalex.toFixed(9)==b.scaley.toFixed(9)||!b.rotate);b.isSuperSimple=!+b.shear.toFixed(9)&&b.scalex.toFixed(9)==b.scaley.toFixed(9)&&!b.rotate;b.noRotation=!+b.shear.toFixed(9)&&!b.rotate;return b};n.toTransformString=function(a){a=a||this.split();if(+a.shear.toFixed(9))return"m"+[this.get(0),
this.get(1),this.get(2),this.get(3),this.get(4),this.get(5)];a.scalex=+a.scalex.toFixed(4);a.scaley=+a.scaley.toFixed(4);a.rotate=+a.rotate.toFixed(4);return(a.dx||a.dy?"t"+[+a.dx.toFixed(4),+a.dy.toFixed(4)]:"")+(1!=a.scalex||1!=a.scaley?"s"+[a.scalex,a.scaley,0,0]:"")+(a.rotate?"r"+[+a.rotate.toFixed(4),0,0]:"")}})(w.prototype);a.Matrix=w;a.matrix=function(a,d,f,b,k,e){return new w(a,d,f,b,k,e)}});C.plugin(function(a,v,y,M,A){function w(h){return function(d){k.stop();d instanceof A&&1==d.node.childNodes.length&&
("radialGradient"==d.node.firstChild.tagName||"linearGradient"==d.node.firstChild.tagName||"pattern"==d.node.firstChild.tagName)&&(d=d.node.firstChild,b(this).appendChild(d),d=u(d));if(d instanceof v)if("radialGradient"==d.type||"linearGradient"==d.type||"pattern"==d.type){d.node.id||e(d.node,{id:d.id});var f=l(d.node.id)}else f=d.attr(h);else f=a.color(d),f.error?(f=a(b(this).ownerSVGElement).gradient(d))?(f.node.id||e(f.node,{id:f.id}),f=l(f.node.id)):f=d:f=r(f);d={};d[h]=f;e(this.node,d);this.node.style[h]=
x}}function z(a){k.stop();a==+a&&(a+="px");this.node.style.fontSize=a}function d(a){var b=[];a=a.childNodes;for(var e=0,f=a.length;e<f;e++){var l=a[e];3==l.nodeType&&b.push(l.nodeValue);"tspan"==l.tagName&&(1==l.childNodes.length&&3==l.firstChild.nodeType?b.push(l.firstChild.nodeValue):b.push(d(l)))}return b}function f(){k.stop();return this.node.style.fontSize}var n=a._.make,u=a._.wrap,p=a.is,b=a._.getSomeDefs,q=/^url\(#?([^)]+)\)$/,e=a._.$,l=a.url,r=String,s=a._.separator,x="";k.on("snap.util.attr.mask",
function(a){if(a instanceof v||a instanceof A){k.stop();a instanceof A&&1==a.node.childNodes.length&&(a=a.node.firstChild,b(this).appendChild(a),a=u(a));if("mask"==a.type)var d=a;else d=n("mask",b(this)),d.node.appendChild(a.node);!d.node.id&&e(d.node,{id:d.id});e(this.node,{mask:l(d.id)})}});(function(a){k.on("snap.util.attr.clip",a);k.on("snap.util.attr.clip-path",a);k.on("snap.util.attr.clipPath",a)})(function(a){if(a instanceof v||a instanceof A){k.stop();if("clipPath"==a.type)var d=a;else d=
n("clipPath",b(this)),d.node.appendChild(a.node),!d.node.id&&e(d.node,{id:d.id});e(this.node,{"clip-path":l(d.id)})}});k.on("snap.util.attr.fill",w("fill"));k.on("snap.util.attr.stroke",w("stroke"));var G=/^([lr])(?:\(([^)]*)\))?(.*)$/i;k.on("snap.util.grad.parse",function(a){a=r(a);var b=a.match(G);if(!b)return null;a=b[1];var e=b[2],b=b[3],e=e.split(/\s*,\s*/).map(function(a){return+a==a?+a:a});1==e.length&&0==e[0]&&(e=[]);b=b.split("-");b=b.map(function(a){a=a.split(":");var b={color:a[0]};a[1]&&
(b.offset=parseFloat(a[1]));return b});return{type:a,params:e,stops:b}});k.on("snap.util.attr.d",function(b){k.stop();p(b,"array")&&p(b[0],"array")&&(b=a.path.toString.call(b));b=r(b);b.match(/[ruo]/i)&&(b=a.path.toAbsolute(b));e(this.node,{d:b})})(-1);k.on("snap.util.attr.#text",function(a){k.stop();a=r(a);for(a=M.doc.createTextNode(a);this.node.firstChild;)this.node.removeChild(this.node.firstChild);this.node.appendChild(a)})(-1);k.on("snap.util.attr.path",function(a){k.stop();this.attr({d:a})})(-1);
k.on("snap.util.attr.class",function(a){k.stop();this.node.className.baseVal=a})(-1);k.on("snap.util.attr.viewBox",function(a){a=p(a,"object")&&"x"in a?[a.x,a.y,a.width,a.height].join(" "):p(a,"array")?a.join(" "):a;e(this.node,{viewBox:a});k.stop()})(-1);k.on("snap.util.attr.transform",function(a){this.transform(a);k.stop()})(-1);k.on("snap.util.attr.r",function(a){"rect"==this.type&&(k.stop(),e(this.node,{rx:a,ry:a}))})(-1);k.on("snap.util.attr.textpath",function(a){k.stop();if("text"==this.type){var d,
f;if(!a&&this.textPath){for(a=this.textPath;a.node.firstChild;)this.node.appendChild(a.node.firstChild);a.remove();delete this.textPath}else if(p(a,"string")?(d=b(this),a=u(d.parentNode).path(a),d.appendChild(a.node),d=a.id,a.attr({id:d})):(a=u(a),a instanceof v&&(d=a.attr("id"),d||(d=a.id,a.attr({id:d})))),d)if(a=this.textPath,f=this.node,a)a.attr({"xlink:href":"#"+d});else{for(a=e("textPath",{"xlink:href":"#"+d});f.firstChild;)a.appendChild(f.firstChild);f.appendChild(a);this.textPath=u(a)}}})(-1);
k.on("snap.util.attr.text",function(a){if("text"==this.type){for(var b=this.node,d=function(a){var b=e("tspan");if(p(a,"array"))for(var f=0;f<a.length;f++)b.appendChild(d(a[f]));else b.appendChild(M.doc.createTextNode(a));b.normalize&&b.normalize();return b};b.firstChild;)b.removeChild(b.firstChild);for(a=d(a);a.firstChild;)b.appendChild(a.firstChild)}k.stop()})(-1);k.on("snap.util.attr.fontSize",z)(-1);k.on("snap.util.attr.font-size",z)(-1);k.on("snap.util.getattr.transform",function(){k.stop();
return this.transform()})(-1);k.on("snap.util.getattr.textpath",function(){k.stop();return this.textPath})(-1);(function(){function b(d){return function(){k.stop();var b=M.doc.defaultView.getComputedStyle(this.node,null).getPropertyValue("marker-"+d);return"none"==b?b:a(M.doc.getElementById(b.match(q)[1]))}}function d(a){return function(b){k.stop();var d="marker"+a.charAt(0).toUpperCase()+a.substring(1);if(""==b||!b)this.node.style[d]="none";else if("marker"==b.type){var f=b.node.id;f||e(b.node,{id:b.id});
this.node.style[d]=l(f)}}}k.on("snap.util.getattr.marker-end",b("end"))(-1);k.on("snap.util.getattr.markerEnd",b("end"))(-1);k.on("snap.util.getattr.marker-start",b("start"))(-1);k.on("snap.util.getattr.markerStart",b("start"))(-1);k.on("snap.util.getattr.marker-mid",b("mid"))(-1);k.on("snap.util.getattr.markerMid",b("mid"))(-1);k.on("snap.util.attr.marker-end",d("end"))(-1);k.on("snap.util.attr.markerEnd",d("end"))(-1);k.on("snap.util.attr.marker-start",d("start"))(-1);k.on("snap.util.attr.markerStart",
d("start"))(-1);k.on("snap.util.attr.marker-mid",d("mid"))(-1);k.on("snap.util.attr.markerMid",d("mid"))(-1)})();k.on("snap.util.getattr.r",function(){if("rect"==this.type&&e(this.node,"rx")==e(this.node,"ry"))return k.stop(),e(this.node,"rx")})(-1);k.on("snap.util.getattr.text",function(){if("text"==this.type||"tspan"==this.type){k.stop();var a=d(this.node);return 1==a.length?a[0]:a}})(-1);k.on("snap.util.getattr.#text",function(){return this.node.textContent})(-1);k.on("snap.util.getattr.viewBox",
function(){k.stop();var b=e(this.node,"viewBox");if(b)return b=b.split(s),a._.box(+b[0],+b[1],+b[2],+b[3])})(-1);k.on("snap.util.getattr.points",function(){var a=e(this.node,"points");k.stop();if(a)return a.split(s)})(-1);k.on("snap.util.getattr.path",function(){var a=e(this.node,"d");k.stop();return a})(-1);k.on("snap.util.getattr.class",function(){return this.node.className.baseVal})(-1);k.on("snap.util.getattr.fontSize",f)(-1);k.on("snap.util.getattr.font-size",f)(-1)});C.plugin(function(a,v,y,
M,A){function w(a){return a}function z(a){return function(b){return+b.toFixed(3)+a}}var d={"+":function(a,b){return a+b},"-":function(a,b){return a-b},"/":function(a,b){return a/b},"*":function(a,b){return a*b}},f=String,n=/[a-z]+$/i,u=/^\s*([+\-\/*])\s*=\s*([\d.eE+\-]+)\s*([^\d\s]+)?\s*$/;k.on("snap.util.attr",function(a){if(a=f(a).match(u)){var b=k.nt(),b=b.substring(b.lastIndexOf(".")+1),q=this.attr(b),e={};k.stop();var l=a[3]||"",r=q.match(n),s=d[a[1] ];r&&r==l?a=s(parseFloat(q),+a[2]):(q=this.asPX(b),
a=s(this.asPX(b),this.asPX(b,a[2]+l)));isNaN(q)||isNaN(a)||(e[b]=a,this.attr(e))}})(-10);k.on("snap.util.equal",function(a,b){var q=f(this.attr(a)||""),e=f(b).match(u);if(e){k.stop();var l=e[3]||"",r=q.match(n),s=d[e[1] ];if(r&&r==l)return{from:parseFloat(q),to:s(parseFloat(q),+e[2]),f:z(r)};q=this.asPX(a);return{from:q,to:s(q,this.asPX(a,e[2]+l)),f:w}}})(-10)});C.plugin(function(a,v,y,M,A){var w=y.prototype,z=a.is;w.rect=function(a,d,k,p,b,q){var e;null==q&&(q=b);z(a,"object")&&"[object Object]"==
a?e=a:null!=a&&(e={x:a,y:d,width:k,height:p},null!=b&&(e.rx=b,e.ry=q));return this.el("rect",e)};w.circle=function(a,d,k){var p;z(a,"object")&&"[object Object]"==a?p=a:null!=a&&(p={cx:a,cy:d,r:k});return this.el("circle",p)};var d=function(){function a(){this.parentNode.removeChild(this)}return function(d,k){var p=M.doc.createElement("img"),b=M.doc.body;p.style.cssText="position:absolute;left:-9999em;top:-9999em";p.onload=function(){k.call(p);p.onload=p.onerror=null;b.removeChild(p)};p.onerror=a;
b.appendChild(p);p.src=d}}();w.image=function(f,n,k,p,b){var q=this.el("image");if(z(f,"object")&&"src"in f)q.attr(f);else if(null!=f){var e={"xlink:href":f,preserveAspectRatio:"none"};null!=n&&null!=k&&(e.x=n,e.y=k);null!=p&&null!=b?(e.width=p,e.height=b):d(f,function(){a._.$(q.node,{width:this.offsetWidth,height:this.offsetHeight})});a._.$(q.node,e)}return q};w.ellipse=function(a,d,k,p){var b;z(a,"object")&&"[object Object]"==a?b=a:null!=a&&(b={cx:a,cy:d,rx:k,ry:p});return this.el("ellipse",b)};
w.path=function(a){var d;z(a,"object")&&!z(a,"array")?d=a:a&&(d={d:a});return this.el("path",d)};w.group=w.g=function(a){var d=this.el("g");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.svg=function(a,d,k,p,b,q,e,l){var r={};z(a,"object")&&null==d?r=a:(null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l]));return this.el("svg",r)};w.mask=function(a){var d=
this.el("mask");1==arguments.length&&a&&!a.type?d.attr(a):arguments.length&&d.add(Array.prototype.slice.call(arguments,0));return d};w.ptrn=function(a,d,k,p,b,q,e,l){if(z(a,"object"))var r=a;else arguments.length?(r={},null!=a&&(r.x=a),null!=d&&(r.y=d),null!=k&&(r.width=k),null!=p&&(r.height=p),null!=b&&null!=q&&null!=e&&null!=l&&(r.viewBox=[b,q,e,l])):r={patternUnits:"userSpaceOnUse"};return this.el("pattern",r)};w.use=function(a){return null!=a?(make("use",this.node),a instanceof v&&(a.attr("id")||
a.attr({id:ID()}),a=a.attr("id")),this.el("use",{"xlink:href":a})):v.prototype.use.call(this)};w.text=function(a,d,k){var p={};z(a,"object")?p=a:null!=a&&(p={x:a,y:d,text:k||""});return this.el("text",p)};w.line=function(a,d,k,p){var b={};z(a,"object")?b=a:null!=a&&(b={x1:a,x2:k,y1:d,y2:p});return this.el("line",b)};w.polyline=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polyline",d)};
w.polygon=function(a){1<arguments.length&&(a=Array.prototype.slice.call(arguments,0));var d={};z(a,"object")&&!z(a,"array")?d=a:null!=a&&(d={points:a});return this.el("polygon",d)};(function(){function d(){return this.selectAll("stop")}function n(b,d){var f=e("stop"),k={offset:+d+"%"};b=a.color(b);k["stop-color"]=b.hex;1>b.opacity&&(k["stop-opacity"]=b.opacity);e(f,k);this.node.appendChild(f);return this}function u(){if("linearGradient"==this.type){var b=e(this.node,"x1")||0,d=e(this.node,"x2")||
1,f=e(this.node,"y1")||0,k=e(this.node,"y2")||0;return a._.box(b,f,math.abs(d-b),math.abs(k-f))}b=this.node.r||0;return a._.box((this.node.cx||0.5)-b,(this.node.cy||0.5)-b,2*b,2*b)}function p(a,d){function f(a,b){for(var d=(b-u)/(a-w),e=w;e<a;e++)h[e].offset=+(+u+d*(e-w)).toFixed(2);w=a;u=b}var n=k("snap.util.grad.parse",null,d).firstDefined(),p;if(!n)return null;n.params.unshift(a);p="l"==n.type.toLowerCase()?b.apply(0,n.params):q.apply(0,n.params);n.type!=n.type.toLowerCase()&&e(p.node,{gradientUnits:"userSpaceOnUse"});
var h=n.stops,n=h.length,u=0,w=0;n--;for(var v=0;v<n;v++)"offset"in h[v]&&f(v,h[v].offset);h[n].offset=h[n].offset||100;f(n,h[n].offset);for(v=0;v<=n;v++){var y=h[v];p.addStop(y.color,y.offset)}return p}function b(b,k,p,q,w){b=a._.make("linearGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{x1:k,y1:p,x2:q,y2:w});return b}function q(b,k,p,q,w,h){b=a._.make("radialGradient",b);b.stops=d;b.addStop=n;b.getBBox=u;null!=k&&e(b.node,{cx:k,cy:p,r:q});null!=w&&null!=h&&e(b.node,{fx:w,fy:h});
return b}var e=a._.$;w.gradient=function(a){return p(this.defs,a)};w.gradientLinear=function(a,d,e,f){return b(this.defs,a,d,e,f)};w.gradientRadial=function(a,b,d,e,f){return q(this.defs,a,b,d,e,f)};w.toString=function(){var b=this.node.ownerDocument,d=b.createDocumentFragment(),b=b.createElement("div"),e=this.node.cloneNode(!0);d.appendChild(b);b.appendChild(e);a._.$(e,{xmlns:"http://www.w3.org/2000/svg"});b=b.innerHTML;d.removeChild(d.firstChild);return b};w.clear=function(){for(var a=this.node.firstChild,
b;a;)b=a.nextSibling,"defs"!=a.tagName?a.parentNode.removeChild(a):w.clear.call({node:a}),a=b}})()});C.plugin(function(a,k,y,M){function A(a){var b=A.ps=A.ps||{};b[a]?b[a].sleep=100:b[a]={sleep:100};setTimeout(function(){for(var d in b)b[L](d)&&d!=a&&(b[d].sleep--,!b[d].sleep&&delete b[d])});return b[a]}function w(a,b,d,e){null==a&&(a=b=d=e=0);null==b&&(b=a.y,d=a.width,e=a.height,a=a.x);return{x:a,y:b,width:d,w:d,height:e,h:e,x2:a+d,y2:b+e,cx:a+d/2,cy:b+e/2,r1:F.min(d,e)/2,r2:F.max(d,e)/2,r0:F.sqrt(d*
d+e*e)/2,path:s(a,b,d,e),vb:[a,b,d,e].join(" ")}}function z(){return this.join(",").replace(N,"$1")}function d(a){a=C(a);a.toString=z;return a}function f(a,b,d,h,f,k,l,n,p){if(null==p)return e(a,b,d,h,f,k,l,n);if(0>p||e(a,b,d,h,f,k,l,n)<p)p=void 0;else{var q=0.5,O=1-q,s;for(s=e(a,b,d,h,f,k,l,n,O);0.01<Z(s-p);)q/=2,O+=(s<p?1:-1)*q,s=e(a,b,d,h,f,k,l,n,O);p=O}return u(a,b,d,h,f,k,l,n,p)}function n(b,d){function e(a){return+(+a).toFixed(3)}return a._.cacher(function(a,h,l){a instanceof k&&(a=a.attr("d"));
a=I(a);for(var n,p,D,q,O="",s={},c=0,t=0,r=a.length;t<r;t++){D=a[t];if("M"==D[0])n=+D[1],p=+D[2];else{q=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6]);if(c+q>h){if(d&&!s.start){n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c);O+=["C"+e(n.start.x),e(n.start.y),e(n.m.x),e(n.m.y),e(n.x),e(n.y)];if(l)return O;s.start=O;O=["M"+e(n.x),e(n.y)+"C"+e(n.n.x),e(n.n.y),e(n.end.x),e(n.end.y),e(D[5]),e(D[6])].join();c+=q;n=+D[5];p=+D[6];continue}if(!b&&!d)return n=f(n,p,D[1],D[2],D[3],D[4],D[5],D[6],h-c)}c+=q;n=+D[5];p=+D[6]}O+=
D.shift()+D}s.end=O;return n=b?c:d?s:u(n,p,D[0],D[1],D[2],D[3],D[4],D[5],1)},null,a._.clone)}function u(a,b,d,e,h,f,k,l,n){var p=1-n,q=ma(p,3),s=ma(p,2),c=n*n,t=c*n,r=q*a+3*s*n*d+3*p*n*n*h+t*k,q=q*b+3*s*n*e+3*p*n*n*f+t*l,s=a+2*n*(d-a)+c*(h-2*d+a),t=b+2*n*(e-b)+c*(f-2*e+b),x=d+2*n*(h-d)+c*(k-2*h+d),c=e+2*n*(f-e)+c*(l-2*f+e);a=p*a+n*d;b=p*b+n*e;h=p*h+n*k;f=p*f+n*l;l=90-180*F.atan2(s-x,t-c)/S;return{x:r,y:q,m:{x:s,y:t},n:{x:x,y:c},start:{x:a,y:b},end:{x:h,y:f},alpha:l}}function p(b,d,e,h,f,n,k,l){a.is(b,
"array")||(b=[b,d,e,h,f,n,k,l]);b=U.apply(null,b);return w(b.min.x,b.min.y,b.max.x-b.min.x,b.max.y-b.min.y)}function b(a,b,d){return b>=a.x&&b<=a.x+a.width&&d>=a.y&&d<=a.y+a.height}function q(a,d){a=w(a);d=w(d);return b(d,a.x,a.y)||b(d,a.x2,a.y)||b(d,a.x,a.y2)||b(d,a.x2,a.y2)||b(a,d.x,d.y)||b(a,d.x2,d.y)||b(a,d.x,d.y2)||b(a,d.x2,d.y2)||(a.x<d.x2&&a.x>d.x||d.x<a.x2&&d.x>a.x)&&(a.y<d.y2&&a.y>d.y||d.y<a.y2&&d.y>a.y)}function e(a,b,d,e,h,f,n,k,l){null==l&&(l=1);l=(1<l?1:0>l?0:l)/2;for(var p=[-0.1252,
0.1252,-0.3678,0.3678,-0.5873,0.5873,-0.7699,0.7699,-0.9041,0.9041,-0.9816,0.9816],q=[0.2491,0.2491,0.2335,0.2335,0.2032,0.2032,0.1601,0.1601,0.1069,0.1069,0.0472,0.0472],s=0,c=0;12>c;c++)var t=l*p[c]+l,r=t*(t*(-3*a+9*d-9*h+3*n)+6*a-12*d+6*h)-3*a+3*d,t=t*(t*(-3*b+9*e-9*f+3*k)+6*b-12*e+6*f)-3*b+3*e,s=s+q[c]*F.sqrt(r*r+t*t);return l*s}function l(a,b,d){a=I(a);b=I(b);for(var h,f,l,n,k,s,r,O,x,c,t=d?0:[],w=0,v=a.length;w<v;w++)if(x=a[w],"M"==x[0])h=k=x[1],f=s=x[2];else{"C"==x[0]?(x=[h,f].concat(x.slice(1)),
h=x[6],f=x[7]):(x=[h,f,h,f,k,s,k,s],h=k,f=s);for(var G=0,y=b.length;G<y;G++)if(c=b[G],"M"==c[0])l=r=c[1],n=O=c[2];else{"C"==c[0]?(c=[l,n].concat(c.slice(1)),l=c[6],n=c[7]):(c=[l,n,l,n,r,O,r,O],l=r,n=O);var z;var K=x,B=c;z=d;var H=p(K),J=p(B);if(q(H,J)){for(var H=e.apply(0,K),J=e.apply(0,B),H=~~(H/8),J=~~(J/8),U=[],A=[],F={},M=z?0:[],P=0;P<H+1;P++){var C=u.apply(0,K.concat(P/H));U.push({x:C.x,y:C.y,t:P/H})}for(P=0;P<J+1;P++)C=u.apply(0,B.concat(P/J)),A.push({x:C.x,y:C.y,t:P/J});for(P=0;P<H;P++)for(K=
0;K<J;K++){var Q=U[P],L=U[P+1],B=A[K],C=A[K+1],N=0.001>Z(L.x-Q.x)?"y":"x",S=0.001>Z(C.x-B.x)?"y":"x",R;R=Q.x;var Y=Q.y,V=L.x,ea=L.y,fa=B.x,ga=B.y,ha=C.x,ia=C.y;if(W(R,V)<X(fa,ha)||X(R,V)>W(fa,ha)||W(Y,ea)<X(ga,ia)||X(Y,ea)>W(ga,ia))R=void 0;else{var $=(R*ea-Y*V)*(fa-ha)-(R-V)*(fa*ia-ga*ha),aa=(R*ea-Y*V)*(ga-ia)-(Y-ea)*(fa*ia-ga*ha),ja=(R-V)*(ga-ia)-(Y-ea)*(fa-ha);if(ja){var $=$/ja,aa=aa/ja,ja=+$.toFixed(2),ba=+aa.toFixed(2);R=ja<+X(R,V).toFixed(2)||ja>+W(R,V).toFixed(2)||ja<+X(fa,ha).toFixed(2)||
ja>+W(fa,ha).toFixed(2)||ba<+X(Y,ea).toFixed(2)||ba>+W(Y,ea).toFixed(2)||ba<+X(ga,ia).toFixed(2)||ba>+W(ga,ia).toFixed(2)?void 0:{x:$,y:aa}}else R=void 0}R&&F[R.x.toFixed(4)]!=R.y.toFixed(4)&&(F[R.x.toFixed(4)]=R.y.toFixed(4),Q=Q.t+Z((R[N]-Q[N])/(L[N]-Q[N]))*(L.t-Q.t),B=B.t+Z((R[S]-B[S])/(C[S]-B[S]))*(C.t-B.t),0<=Q&&1>=Q&&0<=B&&1>=B&&(z?M++:M.push({x:R.x,y:R.y,t1:Q,t2:B})))}z=M}else z=z?0:[];if(d)t+=z;else{H=0;for(J=z.length;H<J;H++)z[H].segment1=w,z[H].segment2=G,z[H].bez1=x,z[H].bez2=c;t=t.concat(z)}}}return t}
function r(a){var b=A(a);if(b.bbox)return C(b.bbox);if(!a)return w();a=I(a);for(var d=0,e=0,h=[],f=[],l,n=0,k=a.length;n<k;n++)l=a[n],"M"==l[0]?(d=l[1],e=l[2],h.push(d),f.push(e)):(d=U(d,e,l[1],l[2],l[3],l[4],l[5],l[6]),h=h.concat(d.min.x,d.max.x),f=f.concat(d.min.y,d.max.y),d=l[5],e=l[6]);a=X.apply(0,h);l=X.apply(0,f);h=W.apply(0,h);f=W.apply(0,f);f=w(a,l,h-a,f-l);b.bbox=C(f);return f}function s(a,b,d,e,h){if(h)return[["M",+a+ +h,b],["l",d-2*h,0],["a",h,h,0,0,1,h,h],["l",0,e-2*h],["a",h,h,0,0,1,
-h,h],["l",2*h-d,0],["a",h,h,0,0,1,-h,-h],["l",0,2*h-e],["a",h,h,0,0,1,h,-h],["z"] ];a=[["M",a,b],["l",d,0],["l",0,e],["l",-d,0],["z"] ];a.toString=z;return a}function x(a,b,d,e,h){null==h&&null==e&&(e=d);a=+a;b=+b;d=+d;e=+e;if(null!=h){var f=Math.PI/180,l=a+d*Math.cos(-e*f);a+=d*Math.cos(-h*f);var n=b+d*Math.sin(-e*f);b+=d*Math.sin(-h*f);d=[["M",l,n],["A",d,d,0,+(180<h-e),0,a,b] ]}else d=[["M",a,b],["m",0,-e],["a",d,e,0,1,1,0,2*e],["a",d,e,0,1,1,0,-2*e],["z"] ];d.toString=z;return d}function G(b){var e=
A(b);if(e.abs)return d(e.abs);Q(b,"array")&&Q(b&&b[0],"array")||(b=a.parsePathString(b));if(!b||!b.length)return[["M",0,0] ];var h=[],f=0,l=0,n=0,k=0,p=0;"M"==b[0][0]&&(f=+b[0][1],l=+b[0][2],n=f,k=l,p++,h[0]=["M",f,l]);for(var q=3==b.length&&"M"==b[0][0]&&"R"==b[1][0].toUpperCase()&&"Z"==b[2][0].toUpperCase(),s,r,w=p,c=b.length;w<c;w++){h.push(s=[]);r=b[w];p=r[0];if(p!=p.toUpperCase())switch(s[0]=p.toUpperCase(),s[0]){case "A":s[1]=r[1];s[2]=r[2];s[3]=r[3];s[4]=r[4];s[5]=r[5];s[6]=+r[6]+f;s[7]=+r[7]+
l;break;case "V":s[1]=+r[1]+l;break;case "H":s[1]=+r[1]+f;break;case "R":for(var t=[f,l].concat(r.slice(1)),u=2,v=t.length;u<v;u++)t[u]=+t[u]+f,t[++u]=+t[u]+l;h.pop();h=h.concat(P(t,q));break;case "O":h.pop();t=x(f,l,r[1],r[2]);t.push(t[0]);h=h.concat(t);break;case "U":h.pop();h=h.concat(x(f,l,r[1],r[2],r[3]));s=["U"].concat(h[h.length-1].slice(-2));break;case "M":n=+r[1]+f,k=+r[2]+l;default:for(u=1,v=r.length;u<v;u++)s[u]=+r[u]+(u%2?f:l)}else if("R"==p)t=[f,l].concat(r.slice(1)),h.pop(),h=h.concat(P(t,
q)),s=["R"].concat(r.slice(-2));else if("O"==p)h.pop(),t=x(f,l,r[1],r[2]),t.push(t[0]),h=h.concat(t);else if("U"==p)h.pop(),h=h.concat(x(f,l,r[1],r[2],r[3])),s=["U"].concat(h[h.length-1].slice(-2));else for(t=0,u=r.length;t<u;t++)s[t]=r[t];p=p.toUpperCase();if("O"!=p)switch(s[0]){case "Z":f=+n;l=+k;break;case "H":f=s[1];break;case "V":l=s[1];break;case "M":n=s[s.length-2],k=s[s.length-1];default:f=s[s.length-2],l=s[s.length-1]}}h.toString=z;e.abs=d(h);return h}function h(a,b,d,e){return[a,b,d,e,d,
e]}function J(a,b,d,e,h,f){var l=1/3,n=2/3;return[l*a+n*d,l*b+n*e,l*h+n*d,l*f+n*e,h,f]}function K(b,d,e,h,f,l,n,k,p,s){var r=120*S/180,q=S/180*(+f||0),c=[],t,x=a._.cacher(function(a,b,c){var d=a*F.cos(c)-b*F.sin(c);a=a*F.sin(c)+b*F.cos(c);return{x:d,y:a}});if(s)v=s[0],t=s[1],l=s[2],u=s[3];else{t=x(b,d,-q);b=t.x;d=t.y;t=x(k,p,-q);k=t.x;p=t.y;F.cos(S/180*f);F.sin(S/180*f);t=(b-k)/2;v=(d-p)/2;u=t*t/(e*e)+v*v/(h*h);1<u&&(u=F.sqrt(u),e*=u,h*=u);var u=e*e,w=h*h,u=(l==n?-1:1)*F.sqrt(Z((u*w-u*v*v-w*t*t)/
(u*v*v+w*t*t)));l=u*e*v/h+(b+k)/2;var u=u*-h*t/e+(d+p)/2,v=F.asin(((d-u)/h).toFixed(9));t=F.asin(((p-u)/h).toFixed(9));v=b<l?S-v:v;t=k<l?S-t:t;0>v&&(v=2*S+v);0>t&&(t=2*S+t);n&&v>t&&(v-=2*S);!n&&t>v&&(t-=2*S)}if(Z(t-v)>r){var c=t,w=k,G=p;t=v+r*(n&&t>v?1:-1);k=l+e*F.cos(t);p=u+h*F.sin(t);c=K(k,p,e,h,f,0,n,w,G,[t,c,l,u])}l=t-v;f=F.cos(v);r=F.sin(v);n=F.cos(t);t=F.sin(t);l=F.tan(l/4);e=4/3*e*l;l*=4/3*h;h=[b,d];b=[b+e*r,d-l*f];d=[k+e*t,p-l*n];k=[k,p];b[0]=2*h[0]-b[0];b[1]=2*h[1]-b[1];if(s)return[b,d,k].concat(c);
c=[b,d,k].concat(c).join().split(",");s=[];k=0;for(p=c.length;k<p;k++)s[k]=k%2?x(c[k-1],c[k],q).y:x(c[k],c[k+1],q).x;return s}function U(a,b,d,e,h,f,l,k){for(var n=[],p=[[],[] ],s,r,c,t,q=0;2>q;++q)0==q?(r=6*a-12*d+6*h,s=-3*a+9*d-9*h+3*l,c=3*d-3*a):(r=6*b-12*e+6*f,s=-3*b+9*e-9*f+3*k,c=3*e-3*b),1E-12>Z(s)?1E-12>Z(r)||(s=-c/r,0<s&&1>s&&n.push(s)):(t=r*r-4*c*s,c=F.sqrt(t),0>t||(t=(-r+c)/(2*s),0<t&&1>t&&n.push(t),s=(-r-c)/(2*s),0<s&&1>s&&n.push(s)));for(r=q=n.length;q--;)s=n[q],c=1-s,p[0][q]=c*c*c*a+3*
c*c*s*d+3*c*s*s*h+s*s*s*l,p[1][q]=c*c*c*b+3*c*c*s*e+3*c*s*s*f+s*s*s*k;p[0][r]=a;p[1][r]=b;p[0][r+1]=l;p[1][r+1]=k;p[0].length=p[1].length=r+2;return{min:{x:X.apply(0,p[0]),y:X.apply(0,p[1])},max:{x:W.apply(0,p[0]),y:W.apply(0,p[1])}}}function I(a,b){var e=!b&&A(a);if(!b&&e.curve)return d(e.curve);var f=G(a),l=b&&G(b),n={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},k={x:0,y:0,bx:0,by:0,X:0,Y:0,qx:null,qy:null},p=function(a,b,c){if(!a)return["C",b.x,b.y,b.x,b.y,b.x,b.y];a[0]in{T:1,Q:1}||(b.qx=b.qy=null);
switch(a[0]){case "M":b.X=a[1];b.Y=a[2];break;case "A":a=["C"].concat(K.apply(0,[b.x,b.y].concat(a.slice(1))));break;case "S":"C"==c||"S"==c?(c=2*b.x-b.bx,b=2*b.y-b.by):(c=b.x,b=b.y);a=["C",c,b].concat(a.slice(1));break;case "T":"Q"==c||"T"==c?(b.qx=2*b.x-b.qx,b.qy=2*b.y-b.qy):(b.qx=b.x,b.qy=b.y);a=["C"].concat(J(b.x,b.y,b.qx,b.qy,a[1],a[2]));break;case "Q":b.qx=a[1];b.qy=a[2];a=["C"].concat(J(b.x,b.y,a[1],a[2],a[3],a[4]));break;case "L":a=["C"].concat(h(b.x,b.y,a[1],a[2]));break;case "H":a=["C"].concat(h(b.x,
b.y,a[1],b.y));break;case "V":a=["C"].concat(h(b.x,b.y,b.x,a[1]));break;case "Z":a=["C"].concat(h(b.x,b.y,b.X,b.Y))}return a},s=function(a,b){if(7<a[b].length){a[b].shift();for(var c=a[b];c.length;)q[b]="A",l&&(u[b]="A"),a.splice(b++,0,["C"].concat(c.splice(0,6)));a.splice(b,1);v=W(f.length,l&&l.length||0)}},r=function(a,b,c,d,e){a&&b&&"M"==a[e][0]&&"M"!=b[e][0]&&(b.splice(e,0,["M",d.x,d.y]),c.bx=0,c.by=0,c.x=a[e][1],c.y=a[e][2],v=W(f.length,l&&l.length||0))},q=[],u=[],c="",t="",x=0,v=W(f.length,
l&&l.length||0);for(;x<v;x++){f[x]&&(c=f[x][0]);"C"!=c&&(q[x]=c,x&&(t=q[x-1]));f[x]=p(f[x],n,t);"A"!=q[x]&&"C"==c&&(q[x]="C");s(f,x);l&&(l[x]&&(c=l[x][0]),"C"!=c&&(u[x]=c,x&&(t=u[x-1])),l[x]=p(l[x],k,t),"A"!=u[x]&&"C"==c&&(u[x]="C"),s(l,x));r(f,l,n,k,x);r(l,f,k,n,x);var w=f[x],z=l&&l[x],y=w.length,U=l&&z.length;n.x=w[y-2];n.y=w[y-1];n.bx=$(w[y-4])||n.x;n.by=$(w[y-3])||n.y;k.bx=l&&($(z[U-4])||k.x);k.by=l&&($(z[U-3])||k.y);k.x=l&&z[U-2];k.y=l&&z[U-1]}l||(e.curve=d(f));return l?[f,l]:f}function P(a,
b){for(var d=[],e=0,h=a.length;h-2*!b>e;e+=2){var f=[{x:+a[e-2],y:+a[e-1]},{x:+a[e],y:+a[e+1]},{x:+a[e+2],y:+a[e+3]},{x:+a[e+4],y:+a[e+5]}];b?e?h-4==e?f[3]={x:+a[0],y:+a[1]}:h-2==e&&(f[2]={x:+a[0],y:+a[1]},f[3]={x:+a[2],y:+a[3]}):f[0]={x:+a[h-2],y:+a[h-1]}:h-4==e?f[3]=f[2]:e||(f[0]={x:+a[e],y:+a[e+1]});d.push(["C",(-f[0].x+6*f[1].x+f[2].x)/6,(-f[0].y+6*f[1].y+f[2].y)/6,(f[1].x+6*f[2].x-f[3].x)/6,(f[1].y+6*f[2].y-f[3].y)/6,f[2].x,f[2].y])}return d}y=k.prototype;var Q=a.is,C=a._.clone,L="hasOwnProperty",
N=/,?([a-z]),?/gi,$=parseFloat,F=Math,S=F.PI,X=F.min,W=F.max,ma=F.pow,Z=F.abs;M=n(1);var na=n(),ba=n(0,1),V=a._unit2px;a.path=A;a.path.getTotalLength=M;a.path.getPointAtLength=na;a.path.getSubpath=function(a,b,d){if(1E-6>this.getTotalLength(a)-d)return ba(a,b).end;a=ba(a,d,1);return b?ba(a,b).end:a};y.getTotalLength=function(){if(this.node.getTotalLength)return this.node.getTotalLength()};y.getPointAtLength=function(a){return na(this.attr("d"),a)};y.getSubpath=function(b,d){return a.path.getSubpath(this.attr("d"),
b,d)};a._.box=w;a.path.findDotsAtSegment=u;a.path.bezierBBox=p;a.path.isPointInsideBBox=b;a.path.isBBoxIntersect=q;a.path.intersection=function(a,b){return l(a,b)};a.path.intersectionNumber=function(a,b){return l(a,b,1)};a.path.isPointInside=function(a,d,e){var h=r(a);return b(h,d,e)&&1==l(a,[["M",d,e],["H",h.x2+10] ],1)%2};a.path.getBBox=r;a.path.get={path:function(a){return a.attr("path")},circle:function(a){a=V(a);return x(a.cx,a.cy,a.r)},ellipse:function(a){a=V(a);return x(a.cx||0,a.cy||0,a.rx,
a.ry)},rect:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height,a.rx,a.ry)},image:function(a){a=V(a);return s(a.x||0,a.y||0,a.width,a.height)},line:function(a){return"M"+[a.attr("x1")||0,a.attr("y1")||0,a.attr("x2"),a.attr("y2")]},polyline:function(a){return"M"+a.attr("points")},polygon:function(a){return"M"+a.attr("points")+"z"},deflt:function(a){a=a.node.getBBox();return s(a.x,a.y,a.width,a.height)}};a.path.toRelative=function(b){var e=A(b),h=String.prototype.toLowerCase;if(e.rel)return d(e.rel);
a.is(b,"array")&&a.is(b&&b[0],"array")||(b=a.parsePathString(b));var f=[],l=0,n=0,k=0,p=0,s=0;"M"==b[0][0]&&(l=b[0][1],n=b[0][2],k=l,p=n,s++,f.push(["M",l,n]));for(var r=b.length;s<r;s++){var q=f[s]=[],x=b[s];if(x[0]!=h.call(x[0]))switch(q[0]=h.call(x[0]),q[0]){case "a":q[1]=x[1];q[2]=x[2];q[3]=x[3];q[4]=x[4];q[5]=x[5];q[6]=+(x[6]-l).toFixed(3);q[7]=+(x[7]-n).toFixed(3);break;case "v":q[1]=+(x[1]-n).toFixed(3);break;case "m":k=x[1],p=x[2];default:for(var c=1,t=x.length;c<t;c++)q[c]=+(x[c]-(c%2?l:
n)).toFixed(3)}else for(f[s]=[],"m"==x[0]&&(k=x[1]+l,p=x[2]+n),q=0,c=x.length;q<c;q++)f[s][q]=x[q];x=f[s].length;switch(f[s][0]){case "z":l=k;n=p;break;case "h":l+=+f[s][x-1];break;case "v":n+=+f[s][x-1];break;default:l+=+f[s][x-2],n+=+f[s][x-1]}}f.toString=z;e.rel=d(f);return f};a.path.toAbsolute=G;a.path.toCubic=I;a.path.map=function(a,b){if(!b)return a;var d,e,h,f,l,n,k;a=I(a);h=0;for(l=a.length;h<l;h++)for(k=a[h],f=1,n=k.length;f<n;f+=2)d=b.x(k[f],k[f+1]),e=b.y(k[f],k[f+1]),k[f]=d,k[f+1]=e;return a};
a.path.toString=z;a.path.clone=d});C.plugin(function(a,v,y,C){var A=Math.max,w=Math.min,z=function(a){this.items=[];this.bindings={};this.length=0;this.type="set";if(a)for(var f=0,n=a.length;f<n;f++)a[f]&&(this[this.items.length]=this.items[this.items.length]=a[f],this.length++)};v=z.prototype;v.push=function(){for(var a,f,n=0,k=arguments.length;n<k;n++)if(a=arguments[n])f=this.items.length,this[f]=this.items[f]=a,this.length++;return this};v.pop=function(){this.length&&delete this[this.length--];
return this.items.pop()};v.forEach=function(a,f){for(var n=0,k=this.items.length;n<k&&!1!==a.call(f,this.items[n],n);n++);return this};v.animate=function(d,f,n,u){"function"!=typeof n||n.length||(u=n,n=L.linear);d instanceof a._.Animation&&(u=d.callback,n=d.easing,f=n.dur,d=d.attr);var p=arguments;if(a.is(d,"array")&&a.is(p[p.length-1],"array"))var b=!0;var q,e=function(){q?this.b=q:q=this.b},l=0,r=u&&function(){l++==this.length&&u.call(this)};return this.forEach(function(a,l){k.once("snap.animcreated."+
a.id,e);b?p[l]&&a.animate.apply(a,p[l]):a.animate(d,f,n,r)})};v.remove=function(){for(;this.length;)this.pop().remove();return this};v.bind=function(a,f,k){var u={};if("function"==typeof f)this.bindings[a]=f;else{var p=k||a;this.bindings[a]=function(a){u[p]=a;f.attr(u)}}return this};v.attr=function(a){var f={},k;for(k in a)if(this.bindings[k])this.bindings[k](a[k]);else f[k]=a[k];a=0;for(k=this.items.length;a<k;a++)this.items[a].attr(f);return this};v.clear=function(){for(;this.length;)this.pop()};
v.splice=function(a,f,k){a=0>a?A(this.length+a,0):a;f=A(0,w(this.length-a,f));var u=[],p=[],b=[],q;for(q=2;q<arguments.length;q++)b.push(arguments[q]);for(q=0;q<f;q++)p.push(this[a+q]);for(;q<this.length-a;q++)u.push(this[a+q]);var e=b.length;for(q=0;q<e+u.length;q++)this.items[a+q]=this[a+q]=q<e?b[q]:u[q-e];for(q=this.items.length=this.length-=f-e;this[q];)delete this[q++];return new z(p)};v.exclude=function(a){for(var f=0,k=this.length;f<k;f++)if(this[f]==a)return this.splice(f,1),!0;return!1};
v.insertAfter=function(a){for(var f=this.items.length;f--;)this.items[f].insertAfter(a);return this};v.getBBox=function(){for(var a=[],f=[],k=[],u=[],p=this.items.length;p--;)if(!this.items[p].removed){var b=this.items[p].getBBox();a.push(b.x);f.push(b.y);k.push(b.x+b.width);u.push(b.y+b.height)}a=w.apply(0,a);f=w.apply(0,f);k=A.apply(0,k);u=A.apply(0,u);return{x:a,y:f,x2:k,y2:u,width:k-a,height:u-f,cx:a+(k-a)/2,cy:f+(u-f)/2}};v.clone=function(a){a=new z;for(var f=0,k=this.items.length;f<k;f++)a.push(this.items[f].clone());
return a};v.toString=function(){return"Snap\u2018s set"};v.type="set";a.set=function(){var a=new z;arguments.length&&a.push.apply(a,Array.prototype.slice.call(arguments,0));return a}});C.plugin(function(a,v,y,C){function A(a){var b=a[0];switch(b.toLowerCase()){case "t":return[b,0,0];case "m":return[b,1,0,0,1,0,0];case "r":return 4==a.length?[b,0,a[2],a[3] ]:[b,0];case "s":return 5==a.length?[b,1,1,a[3],a[4] ]:3==a.length?[b,1,1]:[b,1]}}function w(b,d,f){d=q(d).replace(/\.{3}|\u2026/g,b);b=a.parseTransformString(b)||
[];d=a.parseTransformString(d)||[];for(var k=Math.max(b.length,d.length),p=[],v=[],h=0,w,z,y,I;h<k;h++){y=b[h]||A(d[h]);I=d[h]||A(y);if(y[0]!=I[0]||"r"==y[0].toLowerCase()&&(y[2]!=I[2]||y[3]!=I[3])||"s"==y[0].toLowerCase()&&(y[3]!=I[3]||y[4]!=I[4])){b=a._.transform2matrix(b,f());d=a._.transform2matrix(d,f());p=[["m",b.a,b.b,b.c,b.d,b.e,b.f] ];v=[["m",d.a,d.b,d.c,d.d,d.e,d.f] ];break}p[h]=[];v[h]=[];w=0;for(z=Math.max(y.length,I.length);w<z;w++)w in y&&(p[h][w]=y[w]),w in I&&(v[h][w]=I[w])}return{from:u(p),
to:u(v),f:n(p)}}function z(a){return a}function d(a){return function(b){return+b.toFixed(3)+a}}function f(b){return a.rgb(b[0],b[1],b[2])}function n(a){var b=0,d,f,k,n,h,p,q=[];d=0;for(f=a.length;d<f;d++){h="[";p=['"'+a[d][0]+'"'];k=1;for(n=a[d].length;k<n;k++)p[k]="val["+b++ +"]";h+=p+"]";q[d]=h}return Function("val","return Snap.path.toString.call(["+q+"])")}function u(a){for(var b=[],d=0,f=a.length;d<f;d++)for(var k=1,n=a[d].length;k<n;k++)b.push(a[d][k]);return b}var p={},b=/[a-z]+$/i,q=String;
p.stroke=p.fill="colour";v.prototype.equal=function(a,b){return k("snap.util.equal",this,a,b).firstDefined()};k.on("snap.util.equal",function(e,k){var r,s;r=q(this.attr(e)||"");var x=this;if(r==+r&&k==+k)return{from:+r,to:+k,f:z};if("colour"==p[e])return r=a.color(r),s=a.color(k),{from:[r.r,r.g,r.b,r.opacity],to:[s.r,s.g,s.b,s.opacity],f:f};if("transform"==e||"gradientTransform"==e||"patternTransform"==e)return k instanceof a.Matrix&&(k=k.toTransformString()),a._.rgTransform.test(k)||(k=a._.svgTransform2string(k)),
w(r,k,function(){return x.getBBox(1)});if("d"==e||"path"==e)return r=a.path.toCubic(r,k),{from:u(r[0]),to:u(r[1]),f:n(r[0])};if("points"==e)return r=q(r).split(a._.separator),s=q(k).split(a._.separator),{from:r,to:s,f:function(a){return a}};aUnit=r.match(b);s=q(k).match(b);return aUnit&&aUnit==s?{from:parseFloat(r),to:parseFloat(k),f:d(aUnit)}:{from:this.asPX(e),to:this.asPX(e,k),f:z}})});C.plugin(function(a,v,y,C){var A=v.prototype,w="createTouch"in C.doc;v="click dblclick mousedown mousemove mouseout mouseover mouseup touchstart touchmove touchend touchcancel".split(" ");
var z={mousedown:"touchstart",mousemove:"touchmove",mouseup:"touchend"},d=function(a,b){var d="y"==a?"scrollTop":"scrollLeft",e=b&&b.node?b.node.ownerDocument:C.doc;return e[d in e.documentElement?"documentElement":"body"][d]},f=function(){this.returnValue=!1},n=function(){return this.originalEvent.preventDefault()},u=function(){this.cancelBubble=!0},p=function(){return this.originalEvent.stopPropagation()},b=function(){if(C.doc.addEventListener)return function(a,b,e,f){var k=w&&z[b]?z[b]:b,l=function(k){var l=
d("y",f),q=d("x",f);if(w&&z.hasOwnProperty(b))for(var r=0,u=k.targetTouches&&k.targetTouches.length;r<u;r++)if(k.targetTouches[r].target==a||a.contains(k.targetTouches[r].target)){u=k;k=k.targetTouches[r];k.originalEvent=u;k.preventDefault=n;k.stopPropagation=p;break}return e.call(f,k,k.clientX+q,k.clientY+l)};b!==k&&a.addEventListener(b,l,!1);a.addEventListener(k,l,!1);return function(){b!==k&&a.removeEventListener(b,l,!1);a.removeEventListener(k,l,!1);return!0}};if(C.doc.attachEvent)return function(a,
b,e,h){var k=function(a){a=a||h.node.ownerDocument.window.event;var b=d("y",h),k=d("x",h),k=a.clientX+k,b=a.clientY+b;a.preventDefault=a.preventDefault||f;a.stopPropagation=a.stopPropagation||u;return e.call(h,a,k,b)};a.attachEvent("on"+b,k);return function(){a.detachEvent("on"+b,k);return!0}}}(),q=[],e=function(a){for(var b=a.clientX,e=a.clientY,f=d("y"),l=d("x"),n,p=q.length;p--;){n=q[p];if(w)for(var r=a.touches&&a.touches.length,u;r--;){if(u=a.touches[r],u.identifier==n.el._drag.id||n.el.node.contains(u.target)){b=
u.clientX;e=u.clientY;(a.originalEvent?a.originalEvent:a).preventDefault();break}}else a.preventDefault();b+=l;e+=f;k("snap.drag.move."+n.el.id,n.move_scope||n.el,b-n.el._drag.x,e-n.el._drag.y,b,e,a)}},l=function(b){a.unmousemove(e).unmouseup(l);for(var d=q.length,f;d--;)f=q[d],f.el._drag={},k("snap.drag.end."+f.el.id,f.end_scope||f.start_scope||f.move_scope||f.el,b);q=[]};for(y=v.length;y--;)(function(d){a[d]=A[d]=function(e,f){a.is(e,"function")&&(this.events=this.events||[],this.events.push({name:d,
f:e,unbind:b(this.node||document,d,e,f||this)}));return this};a["un"+d]=A["un"+d]=function(a){for(var b=this.events||[],e=b.length;e--;)if(b[e].name==d&&(b[e].f==a||!a)){b[e].unbind();b.splice(e,1);!b.length&&delete this.events;break}return this}})(v[y]);A.hover=function(a,b,d,e){return this.mouseover(a,d).mouseout(b,e||d)};A.unhover=function(a,b){return this.unmouseover(a).unmouseout(b)};var r=[];A.drag=function(b,d,f,h,n,p){function u(r,v,w){(r.originalEvent||r).preventDefault();this._drag.x=v;
this._drag.y=w;this._drag.id=r.identifier;!q.length&&a.mousemove(e).mouseup(l);q.push({el:this,move_scope:h,start_scope:n,end_scope:p});d&&k.on("snap.drag.start."+this.id,d);b&&k.on("snap.drag.move."+this.id,b);f&&k.on("snap.drag.end."+this.id,f);k("snap.drag.start."+this.id,n||h||this,v,w,r)}if(!arguments.length){var v;return this.drag(function(a,b){this.attr({transform:v+(v?"T":"t")+[a,b]})},function(){v=this.transform().local})}this._drag={};r.push({el:this,start:u});this.mousedown(u);return this};
A.undrag=function(){for(var b=r.length;b--;)r[b].el==this&&(this.unmousedown(r[b].start),r.splice(b,1),k.unbind("snap.drag.*."+this.id));!r.length&&a.unmousemove(e).unmouseup(l);return this}});C.plugin(function(a,v,y,C){y=y.prototype;var A=/^\s*url\((.+)\)/,w=String,z=a._.$;a.filter={};y.filter=function(d){var f=this;"svg"!=f.type&&(f=f.paper);d=a.parse(w(d));var k=a._.id(),u=z("filter");z(u,{id:k,filterUnits:"userSpaceOnUse"});u.appendChild(d.node);f.defs.appendChild(u);return new v(u)};k.on("snap.util.getattr.filter",
function(){k.stop();var d=z(this.node,"filter");if(d)return(d=w(d).match(A))&&a.select(d[1])});k.on("snap.util.attr.filter",function(d){if(d instanceof v&&"filter"==d.type){k.stop();var f=d.node.id;f||(z(d.node,{id:d.id}),f=d.id);z(this.node,{filter:a.url(f)})}d&&"none"!=d||(k.stop(),this.node.removeAttribute("filter"))});a.filter.blur=function(d,f){null==d&&(d=2);return a.format('<feGaussianBlur stdDeviation="{def}"/>',{def:null==f?d:[d,f]})};a.filter.blur.toString=function(){return this()};a.filter.shadow=
function(d,f,k,u,p){"string"==typeof k&&(p=u=k,k=4);"string"!=typeof u&&(p=u,u="#000");null==k&&(k=4);null==p&&(p=1);null==d&&(d=0,f=2);null==f&&(f=d);u=a.color(u||"#000");return a.format('<feGaussianBlur in="SourceAlpha" stdDeviation="{blur}"/><feOffset dx="{dx}" dy="{dy}" result="offsetblur"/><feFlood flood-color="{color}"/><feComposite in2="offsetblur" operator="in"/><feComponentTransfer><feFuncA type="linear" slope="{opacity}"/></feComponentTransfer><feMerge><feMergeNode/><feMergeNode in="SourceGraphic"/></feMerge>',
{color:u,dx:d,dy:f,blur:k,opacity:p})};a.filter.shadow.toString=function(){return this()};a.filter.grayscale=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {b} {h} 0 0 0 0 0 1 0"/>',{a:0.2126+0.7874*(1-d),b:0.7152-0.7152*(1-d),c:0.0722-0.0722*(1-d),d:0.2126-0.2126*(1-d),e:0.7152+0.2848*(1-d),f:0.0722-0.0722*(1-d),g:0.2126-0.2126*(1-d),h:0.0722+0.9278*(1-d)})};a.filter.grayscale.toString=function(){return this()};a.filter.sepia=
function(d){null==d&&(d=1);return a.format('<feColorMatrix type="matrix" values="{a} {b} {c} 0 0 {d} {e} {f} 0 0 {g} {h} {i} 0 0 0 0 0 1 0"/>',{a:0.393+0.607*(1-d),b:0.769-0.769*(1-d),c:0.189-0.189*(1-d),d:0.349-0.349*(1-d),e:0.686+0.314*(1-d),f:0.168-0.168*(1-d),g:0.272-0.272*(1-d),h:0.534-0.534*(1-d),i:0.131+0.869*(1-d)})};a.filter.sepia.toString=function(){return this()};a.filter.saturate=function(d){null==d&&(d=1);return a.format('<feColorMatrix type="saturate" values="{amount}"/>',{amount:1-
d})};a.filter.saturate.toString=function(){return this()};a.filter.hueRotate=function(d){return a.format('<feColorMatrix type="hueRotate" values="{angle}"/>',{angle:d||0})};a.filter.hueRotate.toString=function(){return this()};a.filter.invert=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="table" tableValues="{amount} {amount2}"/><feFuncG type="table" tableValues="{amount} {amount2}"/><feFuncB type="table" tableValues="{amount} {amount2}"/></feComponentTransfer>',{amount:d,
amount2:1-d})};a.filter.invert.toString=function(){return this()};a.filter.brightness=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}"/><feFuncG type="linear" slope="{amount}"/><feFuncB type="linear" slope="{amount}"/></feComponentTransfer>',{amount:d})};a.filter.brightness.toString=function(){return this()};a.filter.contrast=function(d){null==d&&(d=1);return a.format('<feComponentTransfer><feFuncR type="linear" slope="{amount}" intercept="{amount2}"/><feFuncG type="linear" slope="{amount}" intercept="{amount2}"/><feFuncB type="linear" slope="{amount}" intercept="{amount2}"/></feComponentTransfer>',
{amount:d,amount2:0.5-d/2})};a.filter.contrast.toString=function(){return this()}});return C});

]]> </script>
<script> <![CDATA[

(function (glob, factory) {
    // AMD support
    if (typeof define === "function" && define.amd) {
        // Define as an anonymous module
        define("Gadfly", ["Snap.svg"], function (Snap) {
            return factory(Snap);
        });
    } else {
        // Browser globals (glob is window)
        // Snap adds itself to window
        glob.Gadfly = factory(glob.Snap);
    }
}(this, function (Snap) {

var Gadfly = {};

// Get an x/y coordinate value in pixels
var xPX = function(fig, x) {
    var client_box = fig.node.getBoundingClientRect();
    return x * fig.node.viewBox.baseVal.width / client_box.width;
};

var yPX = function(fig, y) {
    var client_box = fig.node.getBoundingClientRect();
    return y * fig.node.viewBox.baseVal.height / client_box.height;
};


Snap.plugin(function (Snap, Element, Paper, global) {
    // Traverse upwards from a snap element to find and return the first
    // note with the "plotroot" class.
    Element.prototype.plotroot = function () {
        var element = this;
        while (!element.hasClass("plotroot") && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.svgroot = function () {
        var element = this;
        while (element.node.nodeName != "svg" && element.parent() != null) {
            element = element.parent();
        }
        return element;
    };

    Element.prototype.plotbounds = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.viewportplotbounds = function () {
        var root = this.svgroot();
        var bbox = root.node.getBoundingClientRect();
        return {
            x0: bbox.x,
            x1: bbox.x + bbox.width,
            y0: bbox.y,
            y1: bbox.y + bbox.height
        };
    };

    Element.prototype.plotcenter = function () {
        var root = this.plotroot()
        var bbox = root.select(".guide.background").node.getBBox();
        return {
            x: bbox.x + bbox.width / 2,
            y: bbox.y + bbox.height / 2
        };
    };

    // Emulate IE style mouseenter/mouseleave events, since Microsoft always
    // does everything right.
    // See: http://www.dynamic-tools.net/toolbox/isMouseLeaveOrEnter/
    var events = ["mouseenter", "mouseleave"];

    for (i in events) {
        (function (event_name) {
            var event_name = events[i];
            Element.prototype[event_name] = function (fn, scope) {
                if (Snap.is(fn, "function")) {
                    var fn2 = function (event) {
                        if (event.type != "mouseover" && event.type != "mouseout") {
                            return;
                        }

                        var reltg = event.relatedTarget ? event.relatedTarget :
                            event.type == "mouseout" ? event.toElement : event.fromElement;
                        while (reltg && reltg != this.node) reltg = reltg.parentNode;

                        if (reltg != this.node) {
                            return fn.apply(this, event);
                        }
                    };

                    if (event_name == "mouseenter") {
                        this.mouseover(fn2, scope);
                    } else {
                        this.mouseout(fn2, scope);
                    }
                }
                return this;
            };
        })(events[i]);
    }


    Element.prototype.mousewheel = function (fn, scope) {
        if (Snap.is(fn, "function")) {
            var el = this;
            var fn2 = function (event) {
                fn.apply(el, [event]);
            };
        }

        this.node.addEventListener("wheel", fn2);

        return this;
    };


    // Snap's attr function can be too slow for things like panning/zooming.
    // This is a function to directly update element attributes without going
    // through eve.
    Element.prototype.attribute = function(key, val) {
        if (val === undefined) {
            return this.node.getAttribute(key);
        } else {
            this.node.setAttribute(key, val);
            return this;
        }
    };

    Element.prototype.init_gadfly = function() {
        this.mouseenter(Gadfly.plot_mouseover)
            .mousemove(Gadfly.plot_mousemove)
            .mouseleave(Gadfly.plot_mouseout)
            .dblclick(Gadfly.plot_dblclick)
            .mousewheel(Gadfly.guide_background_scroll)
            .drag(Gadfly.guide_background_drag_onmove,
                  Gadfly.guide_background_drag_onstart,
                  Gadfly.guide_background_drag_onend);
        this.mouseenter(function (event) {
            init_pan_zoom(this.plotroot());
        });
        return this;
    };
});


Gadfly.plot_mousemove = function(event, _x_px, _y_px) {
    var root = this.plotroot();
    var viewbounds = root.viewportplotbounds();

    // (_x_px, _y_px) are offsets relative to page (event.layerX, event.layerY) rather than viewport
    var x_px = event.clientX - viewbounds.x0;
    var y_px = event.clientY - viewbounds.y0;
    if (root.data("crosshair")) {
        px_per_mm = root.data("px_per_mm");
        bB = root.select('boundingbox').node.getAttribute('value').split(' ');
        uB = root.select('unitbox').node.getAttribute('value').split(' ');
        xscale = root.data("xscale");
        yscale = root.data("yscale");
        xtranslate = root.data("tx");
        ytranslate = root.data("ty");

        xoff_mm = bB[0].substr(0,bB[0].length-2)/1;
        yoff_mm = bB[1].substr(0,bB[1].length-2)/1;
        xoff_unit = uB[0]/1;
        yoff_unit = uB[1]/1;
        mm_per_xunit = bB[2].substr(0,bB[2].length-2) / uB[2];
        mm_per_yunit = bB[3].substr(0,bB[3].length-2) / uB[3];

        x_unit = ((x_px / px_per_mm - xtranslate) / xscale - xoff_mm) / mm_per_xunit + xoff_unit;
        y_unit = ((y_px / px_per_mm - ytranslate) / yscale - yoff_mm) / mm_per_yunit + yoff_unit;

        root.select('.crosshair').select('.primitive').select('text')
                .node.innerHTML = x_unit.toPrecision(3)+","+y_unit.toPrecision(3);
    };
};

Gadfly.helpscreen_visible = function(event) {
    helpscreen_visible(this.plotroot());
};
var helpscreen_visible = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 1.0}, 250);
};

Gadfly.helpscreen_hidden = function(event) {
    helpscreen_hidden(this.plotroot());
};
var helpscreen_hidden = function(root) {
    root.select(".helpscreen").animate({"fill-opacity": 0.0}, 250);
};

// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_help = function(event) {
        if (event.which == 191) { // ?
            helpscreen_visible(root);
        }
    };
    root.data("keyboard_help", keyboard_help);
    window.addEventListener("keydown", keyboard_help);

    var keyboard_pan_zoom = function(event) {
        var bounds = root.plotbounds(),
            width = bounds.x1 - bounds.x0;
            height = bounds.y1 - bounds.y0;
        if (event.which == 187 || event.which == 73) { // plus or i
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189 || event.which == 79) { // minus or o
            increase_zoom_by_position(root, -0.1, true);
        } else if (event.which == 39 || event.which == 76) { // right-arrow or l
            set_plot_pan_zoom(root, root.data("tx")-width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 40 || event.which == 74) { // down-arrow or j
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")-height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 37 || event.which == 72) { // left-arrow or h
            set_plot_pan_zoom(root, root.data("tx")+width/10, root.data("ty"),
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 38 || event.which == 75) { // up-arrow or k
            set_plot_pan_zoom(root, root.data("tx"), root.data("ty")+height/10,
                    root.data("xscale"), root.data("yscale"));
        } else if (event.which == 82) { // r
            set_plot_pan_zoom(root, 0.0, 0.0, 1.0, 1.0);
        } else if (event.which == 191) { // ?
            helpscreen_hidden(root);
        } else if (event.which == 67) { // c
            root.data("crosshair",!root.data("crosshair"));
            root.select(".crosshair")
                .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
        }
    };
    root.data("keyboard_pan_zoom", keyboard_pan_zoom);
    window.addEventListener("keyup", keyboard_pan_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        xgridlines.data("unfocused_strokedash",
                        xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        ygridlines.data("unfocused_strokedash",
                        ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
        var destcolor = root.data("focused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", "none")
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair")
        .animate({"fill-opacity": root.data("crosshair") ? 1.0 : 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_pan_zoom"));
    root.data("keyboard_pan_zoom", undefined);
    window.removeEventListener("keydown", root.data("keyboard_help"));
    root.data("keyboard_help", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    if (xgridlines) {
        var destcolor = root.data("unfocused_xgrid_color");
        xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    if (ygridlines) {
        var destcolor = root.data("unfocused_ygrid_color");
        ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
                  .selectAll("path")
                  .animate({stroke: destcolor}, 250);
    }

    root.select(".crosshair").animate({"fill-opacity": 0.0}, 250);
    root.select(".questionmark").animate({"fill-opacity": 0.0}, 250);
    helpscreen_hidden(root);
};


var set_geometry_transform = function(root, tx, ty, xscale, yscale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");

    var xscale = xscalable ? xscale : 1.0,
        yscale = yscalable ? yscale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);
    root.selectAll(".geometry, image").forEach(function (element, i) {
            element.transform(t);
        });

    var t = new Snap.Matrix().scale(1.0/xscale, 1.0/yscale);
    root.selectAll('.marker').forEach(function (element, i) {
        element.selectAll('.primitive').forEach(function (element, i) {
            element.transform(t);
        }) });

    bounds = root.plotbounds();
    px_per_mm = root.data("px_per_mm");

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        ylabels = root.select(".ylabels");
        if (ylabels) {
            ylabels.transform(xfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1, 1/yscale);
                           element.select("text").transform(unscale_t);

                           var y = element.attr("transform").globalMatrix.f / px_per_mm;
                           element.attr("visibility",
                               bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                       }
                   });
        }
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        xlabels = root.select(".xlabels");
        if (xlabels) {
            xlabels.transform(yfixed_t)
                   .selectAll("g")
                   .forEach(function (element, i) {
                       if (element.attribute("gadfly:inscale") == "true") {
                           unscale_t = new Snap.Matrix();
                           unscale_t.scale(1/xscale, 1);
                           element.select("text").transform(unscale_t);

                           var x = element.attr("transform").globalMatrix.e / px_per_mm;
                           element.attr("visibility",
                               bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                           }
                   });
        }
    }
};


// Find the most appropriate tick scale and update label visibility.
var update_tickscale = function(root, scale, axis) {
    if (!root.hasClass(axis + "scalable")) return;

    var tickscales = root.data(axis + "tickscales");
    var best_tickscale = 1.0;
    var best_tickscale_dist = Infinity;
    for (tickscale in tickscales) {
        var dist = Math.abs(Math.log(tickscale) - Math.log(scale));
        if (dist < best_tickscale_dist) {
            best_tickscale_dist = dist;
            best_tickscale = tickscale;
        }
    }

    if (best_tickscale != root.data(axis + "tickscale")) {
        root.data(axis + "tickscale", best_tickscale);
        var mark_inscale_gridlines = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            if (element.attribute("gadfly:inscale") == null) { return; }
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("g").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("g").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, xscale, yscale) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, xscale, and yscale
    var x_min = -width * xscale - (xscale * width - width),
        x_max = width * xscale,
        y_min = -height * yscale - (yscale * height - height),
        y_max = height * yscale;

    var x0 = bounds.x0 - xscale * bounds.x0,
        y0 = bounds.y0 - yscale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale changes, we may need to alter which set of
    // ticks are being displayed
    if (xscale != old_xscale) {
        update_tickscale(root, xscale, "x");
    }
    if (yscale != old_yscale) {
        update_tickscale(root, yscale, "y");
    }

    set_geometry_transform(root, tx, ty, xscale, yscale);

    root.data("xscale", xscale);
    root.data("yscale", yscale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, xscale, yscale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var xscale0 = root.data("xscale"),
        yscale0 = root.data("yscale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - xscale0) + (width * (1 - xscale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - yscale0) + (height * (1 - yscale0)) / 2);

    // rescale offsets
    xoff = xoff * xscale / xscale0;
    yoff = yoff * yscale / yscale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - xscale),
        y_edge_adjust = bounds.y0 * (1 - yscale);

    return {
        x: xoff + x_edge_adjust + (width - width * xscale) / 2,
        y: yoff + y_edge_adjust + (height - height * yscale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

    root.data("crosshair",false);

    // The non-scaling-stroke trick. Rather than try to correct for the
    // stroke-width when zooming, we force it to a fixed value.
    var px_per_mm = root.node.getCTM().a;

    // Drag events report deltas in pixels, which we'd like to convert to
    // millimeters.
    root.data("px_per_mm", px_per_mm);

    root.selectAll("path")
        .forEach(function (element, i) {
        sw = element.asPX("stroke-width") * px_per_mm;
        if (sw > 0) {
            element.attribute("stroke-width", sw);
            element.attribute("vector-effect", "non-scaling-stroke");
        }
    });

    // Store ticks labels original tranformation
    root.selectAll(".xlabels > g, .ylabels > g")
        .forEach(function (element, i) {
            var lm = element.transform().localMatrix;
            element.data("static_transform",
                new Snap.Matrix(lm.a, lm.b, lm.c, lm.d, lm.e, lm.f));
        });

    var xgridlines = root.select(".xgridlines");
    var ygridlines = root.select(".ygridlines");
    var xlabels = root.select(".xlabels");
    var ylabels = root.select(".ylabels");

    if (root.data("tx") === undefined) root.data("tx", 0);
    if (root.data("ty") === undefined) root.data("ty", 0);
    if (root.data("xscale") === undefined) root.data("xscale", 1.0);
    if (root.data("yscale") === undefined) root.data("yscale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            if (element.attribute("gadfly:scale")==null) { return; }
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("g").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("g").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("g").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("g").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
        root.data("ytickscale", 1.0);  // ???
    }

    var min_scale = 1.0, max_scale = 1.0;
    for (scale in xtickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    for (scale in ytickscales) {
        min_scale = Math.min(min_scale, scale);
        max_scale = Math.max(max_scale, scale);
    }
    root.data("min_scale", min_scale);
    root.data("max_scale", max_scale);

    // store the original positions of labels
    if (xlabels) {
        xlabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("g")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        if (element.attribute("gadfly:scale") == null) { return; }
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("g").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("g").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("g").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("g").forEach(mark_inscale);

    // figure out the upper ond lower bounds on panning using the maximum
    // and minum grid lines
    var bounds = root.plotbounds();
    var pan_bounds = {
        x0: 0.0,
        y0: 0.0,
        x1: 0.0,
        y1: 0.0
    };

    if (xgridlines) {
        xgridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.x1 - bbox.x < pan_bounds.x0) {
                        pan_bounds.x0 = bounds.x1 - bbox.x;
                    }
                    if (bounds.x0 - bbox.x > pan_bounds.x1) {
                        pan_bounds.x1 = bounds.x0 - bbox.x;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    if (ygridlines) {
        ygridlines
            .selectAll("g")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var bbox = element.node.getBBox();
                    if (bounds.y1 - bbox.y < pan_bounds.y0) {
                        pan_bounds.y0 = bounds.y1 - bbox.y;
                    }
                    if (bounds.y0 - bbox.y > pan_bounds.y1) {
                        pan_bounds.y1 = bounds.y0 - bbox.y;
                    }
                    element.attr("visibility", "visible");
                }
            });
    }

    // nudge these values a little
    pan_bounds.x0 -= 5;
    pan_bounds.x1 += 5;
    pan_bounds.y0 -= 5;
    pan_bounds.y1 += 5;
    root.data("pan_bounds", pan_bounds);

    root.data("zoompan-ready", true)
};


// drag actions, i.e. zooming and panning
var pan_action = {
    start: function(root, x, y, event) {
        root.data("dx", 0);
        root.data("dy", 0);
        root.data("tx0", root.data("tx"));
        root.data("ty0", root.data("ty"));
    },
    update: function(root, dx, dy, x, y, event) {
        var px_per_mm = root.data("px_per_mm");
        dx /= px_per_mm;
        dy /= px_per_mm;

        var tx0 = root.data("tx"),
            ty0 = root.data("ty");

        var dx0 = root.data("dx"),
            dy0 = root.data("dy");

        root.data("dx", dx);
        root.data("dy", dy);

        dx = dx - dx0;
        dy = dy - dy0;

        var tx = tx0 + dx,
            ty = ty0 + dy;

        set_plot_pan_zoom(root, tx, ty, root.data("xscale"), root.data("yscale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"),
                root.data("xscale"), root.data("yscale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, _x, _y, event) {
        var bounds = root.plotbounds();
        // _x and _y are co-ordinates relative to page, which caused problems
        // unless the SVG is precisely at the top-left of the page
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;

        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "fill-opacity": 0.25
        });
    },
    update: function(root, dx, dy, _x, _y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
        var viewbounds = root.viewportplotbounds();
        var x = event.clientX - viewbounds.x0;
        var y = event.clientY - viewbounds.y0;
        if (yscalable) {
            y /= px_per_mm;
            y = Math.max(bounds.y0, y);
            y = Math.min(bounds.y1, y);
        } else {
            y = bounds.y1;
        }
        if (xscalable) {
            x /= px_per_mm;
            x = Math.max(bounds.x0, x);
            x = Math.min(bounds.x1, x);
        } else {
            x = bounds.x1;
        }

        dx = x - zoom_box.attr("x");
        dy = y - zoom_box.attr("y");
        var xoffset = 0,
            yoffset = 0;
        if (dx < 0) {
            xoffset = dx;
            dx = -1 * dx;
        }
        if (dy < 0) {
            yoffset = dy;
            dy = -1 * dy;
        }
        if (isNaN(dy)) {
            dy = 0.0;
        }
        if (isNaN(dx)) {
            dx = 0.0;
        }
        zoom_box.transform("T" + xoffset + "," + yoffset);
        zoom_box.attr("width", dx);
        zoom_box.attr("height", dy);
    },
    end: function(root, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var zoom_bounds = zoom_box.getBBox();
        if (zoom_bounds.width * zoom_bounds.height <= 0) {
            return;
        }
        var plot_bounds = root.plotbounds();
        var xzoom_factor = 1.0,
            yzoom_factor = 1.0;
        if (xscalable) {
            xzoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        if (yscalable) {
            yzoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * xzoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * yzoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty,
                root.data("xscale") * xzoom_factor, root.data("yscale") * yzoom_factor);
        zoom_box.remove();
    },
    cancel: function(root) {
        zoom_box.remove();
    }
};


Gadfly.guide_background_drag_onstart = function(x, y, event) {
    var root = this.plotroot();
    var scalable = root.hasClass("xscalable") || root.hasClass("yscalable");
    var zoomable = !event.altKey && !event.ctrlKey && event.shiftKey && scalable;
    var panable = !event.altKey && !event.ctrlKey && !event.shiftKey && scalable;
    var drag_action = zoomable ? zoom_action :
                      panable  ? pan_action :
                                 undefined;
    root.data("drag_action", drag_action);
    if (drag_action) {
        var cancel_drag_action = function(event) {
            if (event.which == 27) { // esc key
                drag_action.cancel(root);
                root.data("drag_action", undefined);
            }
        };
        window.addEventListener("keyup", cancel_drag_action);
        root.data("cancel_drag_action", cancel_drag_action);
        drag_action.start(root, x, y, event);
    }
};


Gadfly.guide_background_drag_onmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.update(root, dx, dy, x, y, event);
    }
};


Gadfly.guide_background_drag_onend = function(event) {
    var root = this.plotroot();
    window.removeEventListener("keyup", root.data("cancel_drag_action"));
    root.data("cancel_drag_action", undefined);
    var drag_action = root.data("drag_action");
    if (drag_action) {
        drag_action.end(root, event);
    }
    root.data("drag_action", undefined);
};


Gadfly.guide_background_scroll = function(event) {
    if (event.shiftKey) {
        // event.deltaY is either the number of pixels, lines, or pages scrolled past.
        var actual_delta;
        switch (event.deltaMode) {
            case 0: // Chromium-based
                actual_delta = -event.deltaY / 1000.0;
                break;
            case 1: // Firefox
                actual_delta = -event.deltaY / 50.0;
                break;
            default:
                actual_delta = -event.deltaY;
        }
        // Assumes 20 pixels/line to get reasonably consistent cross-browser behaviour.
        increase_zoom_by_position(this.plotroot(), actual_delta);
        event.preventDefault();
    }
};

// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    if (min_scale==max_scale) { return 1; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    if (min_scale==max_scale) { return min_scale; }
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var old_xscale = root.data("xscale"),
        old_yscale = root.data("yscale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var xposition = slider_position_from_scale(old_xscale, min_scale, max_scale),
        yposition = slider_position_from_scale(old_yscale, min_scale, max_scale);
    xposition += (root.hasClass("xscalable") ? delta_position : 0.0);
    yposition += (root.hasClass("yscalable") ? delta_position : 0.0);
    old_xscale = scale_from_slider_position(xposition, min_scale, max_scale);
    old_yscale = scale_from_slider_position(yposition, min_scale, max_scale);
    var new_xscale = Math.max(min_scale, Math.min(old_xscale, max_scale)),
        new_yscale = Math.max(min_scale, Math.min(old_yscale, max_scale));
    if (animate) {
        Snap.animate(
            [old_xscale, old_yscale],
            [new_xscale, new_yscale],
            function (new_scale) {
                update_plot_scale(root, new_scale[0], new_scale[1]);
            },
            200);
    } else {
        update_plot_scale(root, new_xscale, new_yscale);
    }
}


var update_plot_scale = function(root, new_xscale, new_yscale) {
    var trans = scale_centered_translation(root, new_xscale, new_yscale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_xscale, new_yscale);
};


var toggle_color_class = function(root, color_class, ison) {
    var escaped_color_class = color_class.replace(/([^0-9a-zA-z])/g,"\\$1");
    var guides = root.selectAll(".guide." + escaped_color_class + ",.guide ." + escaped_color_class);
    var geoms = root.selectAll(".geometry." + escaped_color_class + ",.geometry ." + escaped_color_class);
    if (ison) {
        guides.animate({opacity: 0.5}, 250);
        geoms.animate({opacity: 0.0}, 250);
    } else {
        guides.animate({opacity: 1.0}, 250);
        geoms.animate({opacity: 1.0}, 250);
    }
};


Gadfly.colorkey_swatch_click = function(event) {
    var root = this.plotroot();
    var color_class = this.data("color_class");

    if (event.shiftKey) {
        root.selectAll(".colorkey g")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (typeof other_color_class !== 'undefined' && other_color_class != color_class) {
                    toggle_color_class(root, other_color_class,
                                       element.attr("opacity") == 1.0);
                }
            });
    } else {
        toggle_color_class(root, color_class, this.attr("opacity") == 1.0);
    }
};


return Gadfly;

}));


//@ sourceURL=gadfly.js

(function (glob, factory) {
    // AMD support
      if (typeof require === "function" && typeof define === "function" && define.amd) {
        require(["Snap.svg", "Gadfly"], function (Snap, Gadfly) {
            factory(Snap, Gadfly);
        });
      } else {
          factory(glob.Snap, glob.Gadfly);
      }
})(window, function (Snap, Gadfly) {
    var fig = Snap("#img-f4d13d34");
fig.select("#img-f4d13d34-3")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-f4d13d34-21")
   .init_gadfly();
fig.select("#img-f4d13d34-24")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-f4d13d34-24")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-f4d13d34-178")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-f4d13d34-178")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-f4d13d34-311")
   .mouseenter(Gadfly.helpscreen_visible)
.mouseleave(Gadfly.helpscreen_hidden)
;
    });
]]> </script>
</svg>



