# Blind Source Separation


```julia
import Mads
```


```julia
import NMF
```


```julia
srand(2015)
nk = 3
s1 = (sin(0.05:0.05:5)+1)/2
s2 = (sin(0.3:0.3:30)+1)/2
s3 = rand(100);
```

## Source matrix (assumed unknown)


```julia
S = [s1 s2 s3]
```




    100×3 Array{Float64,2}:
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
Mads.plotseries(S, title="Original sources", name="Source", combined=true)
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

     id="img-0ef873d2">
<g class="plotroot xscalable yscalable" id="img-0ef873d2-1">
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-0ef873d2-2">
    <text x="63.43" y="89.28" text-anchor="middle" dy="0.6em">X</text>
  </g>
  <g class="guide xlabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-0ef873d2-3">
    <text x="-114.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-150</text>
    <text x="-70.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-100</text>
    <text x="-25.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-50</text>
    <text x="18.89" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="63.43" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">50</text>
    <text x="107.98" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">100</text>
    <text x="152.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">150</text>
    <text x="197.06" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">200</text>
    <text x="241.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">250</text>
    <text x="-70.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-100</text>
    <text x="-65.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-95</text>
    <text x="-61.29" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-90</text>
    <text x="-56.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-85</text>
    <text x="-52.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-80</text>
    <text x="-47.93" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-75</text>
    <text x="-43.48" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-70</text>
    <text x="-39.02" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-65</text>
    <text x="-34.57" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-60</text>
    <text x="-30.11" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-55</text>
    <text x="-25.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-50</text>
    <text x="-21.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-45</text>
    <text x="-16.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-40</text>
    <text x="-12.3" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-35</text>
    <text x="-7.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-30</text>
    <text x="-3.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-25</text>
    <text x="1.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-20</text>
    <text x="5.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-15</text>
    <text x="9.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-10</text>
    <text x="14.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-5</text>
    <text x="18.89" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">0</text>
    <text x="23.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">5</text>
    <text x="27.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">10</text>
    <text x="32.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">15</text>
    <text x="36.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">20</text>
    <text x="41.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">25</text>
    <text x="45.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">30</text>
    <text x="50.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">35</text>
    <text x="54.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">40</text>
    <text x="58.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">45</text>
    <text x="63.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">50</text>
    <text x="67.89" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">55</text>
    <text x="72.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">60</text>
    <text x="76.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">65</text>
    <text x="81.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">70</text>
    <text x="85.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">75</text>
    <text x="90.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">80</text>
    <text x="94.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">85</text>
    <text x="99.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">90</text>
    <text x="103.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">95</text>
    <text x="107.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">100</text>
    <text x="112.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">105</text>
    <text x="116.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">110</text>
    <text x="121.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">115</text>
    <text x="125.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">120</text>
    <text x="130.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">125</text>
    <text x="134.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">130</text>
    <text x="139.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">135</text>
    <text x="143.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">140</text>
    <text x="148.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">145</text>
    <text x="152.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">150</text>
    <text x="156.97" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">155</text>
    <text x="161.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">160</text>
    <text x="165.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">165</text>
    <text x="170.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">170</text>
    <text x="174.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">175</text>
    <text x="179.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">180</text>
    <text x="183.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">185</text>
    <text x="188.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">190</text>
    <text x="192.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">195</text>
    <text x="197.06" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">200</text>
    <text x="-70.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">-100</text>
    <text x="18.89" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="107.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">100</text>
    <text x="197.06" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">200</text>
    <text x="-70.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-100</text>
    <text x="-61.29" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-90</text>
    <text x="-52.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-80</text>
    <text x="-43.48" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-70</text>
    <text x="-34.57" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-60</text>
    <text x="-25.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-50</text>
    <text x="-16.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-40</text>
    <text x="-7.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-30</text>
    <text x="1.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-20</text>
    <text x="9.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-10</text>
    <text x="18.89" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">0</text>
    <text x="27.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">10</text>
    <text x="36.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">20</text>
    <text x="45.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">30</text>
    <text x="54.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">40</text>
    <text x="63.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">50</text>
    <text x="72.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">60</text>
    <text x="81.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">70</text>
    <text x="90.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">80</text>
    <text x="99.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">90</text>
    <text x="107.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">100</text>
    <text x="116.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">110</text>
    <text x="125.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">120</text>
    <text x="134.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">130</text>
    <text x="143.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">140</text>
    <text x="152.52" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">150</text>
    <text x="161.43" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">160</text>
    <text x="170.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">170</text>
    <text x="179.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">180</text>
    <text x="188.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">190</text>
    <text x="197.06" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">200</text>
  </g>
  <g class="guide colorkey" id="img-0ef873d2-4">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-0ef873d2-5">
      <text x="113.5" y="42.1" dy="0.35em" id="img-0ef873d2-6" class="color_Source_1">Source 1</text>
      <text x="113.5" y="45.14" dy="0.35em" id="img-0ef873d2-7" class="color_Source_2">Source 2</text>
      <text x="113.5" y="48.18" dy="0.35em" id="img-0ef873d2-8" class="color_Source_3">Source 3</text>
    </g>
    <g stroke="#000000" stroke-opacity="0.000" id="img-0ef873d2-9">
      <rect x="110.98" y="41.33" width="1.52" height="1.52" id="img-0ef873d2-10" class="color_Source_1" fill="#00BFFF"/>
      <rect x="110.98" y="44.38" width="1.52" height="1.52" id="img-0ef873d2-11" class="color_Source_2" fill="#D4CA3A"/>
      <rect x="110.98" y="47.42" width="1.52" height="1.52" id="img-0ef873d2-12" class="color_Source_3" fill="#FF6DAE"/>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-0ef873d2-13">
      <text x="110.98" y="38.84" id="img-0ef873d2-14">Original sources</text>
    </g>
  </g>
<g clip-path="url(#img-0ef873d2-15)">
  <g id="img-0ef873d2-16">
    <g pointer-events="visible" opacity="1" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-0ef873d2-17">
      <rect x="16.89" y="5" width="93.09" height="77.23" id="img-0ef873d2-18"/>
    </g>
    <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-0ef873d2-19">
      <path fill="none" d="M16.89,190.09 L 109.98 190.09" id="img-0ef873d2-20" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,153.47 L 109.98 153.47" id="img-0ef873d2-21" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,116.85 L 109.98 116.85" id="img-0ef873d2-22" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,80.23 L 109.98 80.23" id="img-0ef873d2-23" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,43.62 L 109.98 43.62" id="img-0ef873d2-24" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,7 L 109.98 7" id="img-0ef873d2-25" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,-29.62 L 109.98 -29.62" id="img-0ef873d2-26" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,-66.23 L 109.98 -66.23" id="img-0ef873d2-27" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,-102.85 L 109.98 -102.85" id="img-0ef873d2-28" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.89,153.47 L 109.98 153.47" id="img-0ef873d2-29" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,149.81 L 109.98 149.81" id="img-0ef873d2-30" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,146.15 L 109.98 146.15" id="img-0ef873d2-31" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,142.48 L 109.98 142.48" id="img-0ef873d2-32" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,138.82 L 109.98 138.82" id="img-0ef873d2-33" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,135.16 L 109.98 135.16" id="img-0ef873d2-34" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,131.5 L 109.98 131.5" id="img-0ef873d2-35" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,127.84 L 109.98 127.84" id="img-0ef873d2-36" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,124.18 L 109.98 124.18" id="img-0ef873d2-37" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,120.51 L 109.98 120.51" id="img-0ef873d2-38" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,116.85 L 109.98 116.85" id="img-0ef873d2-39" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,113.19 L 109.98 113.19" id="img-0ef873d2-40" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,109.53 L 109.98 109.53" id="img-0ef873d2-41" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,105.87 L 109.98 105.87" id="img-0ef873d2-42" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,102.2 L 109.98 102.2" id="img-0ef873d2-43" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,98.54 L 109.98 98.54" id="img-0ef873d2-44" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,94.88 L 109.98 94.88" id="img-0ef873d2-45" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,91.22 L 109.98 91.22" id="img-0ef873d2-46" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,87.56 L 109.98 87.56" id="img-0ef873d2-47" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,83.9 L 109.98 83.9" id="img-0ef873d2-48" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,80.23 L 109.98 80.23" id="img-0ef873d2-49" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,76.57 L 109.98 76.57" id="img-0ef873d2-50" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,72.91 L 109.98 72.91" id="img-0ef873d2-51" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,69.25 L 109.98 69.25" id="img-0ef873d2-52" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,65.59 L 109.98 65.59" id="img-0ef873d2-53" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,61.93 L 109.98 61.93" id="img-0ef873d2-54" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,58.26 L 109.98 58.26" id="img-0ef873d2-55" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,54.6 L 109.98 54.6" id="img-0ef873d2-56" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,50.94 L 109.98 50.94" id="img-0ef873d2-57" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,47.28 L 109.98 47.28" id="img-0ef873d2-58" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,43.62 L 109.98 43.62" id="img-0ef873d2-59" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,39.96 L 109.98 39.96" id="img-0ef873d2-60" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,36.29 L 109.98 36.29" id="img-0ef873d2-61" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,32.63 L 109.98 32.63" id="img-0ef873d2-62" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,28.97 L 109.98 28.97" id="img-0ef873d2-63" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,25.31 L 109.98 25.31" id="img-0ef873d2-64" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,21.65 L 109.98 21.65" id="img-0ef873d2-65" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,17.99 L 109.98 17.99" id="img-0ef873d2-66" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,14.32 L 109.98 14.32" id="img-0ef873d2-67" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,10.66 L 109.98 10.66" id="img-0ef873d2-68" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,7 L 109.98 7" id="img-0ef873d2-69" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,3.34 L 109.98 3.34" id="img-0ef873d2-70" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-0.32 L 109.98 -0.32" id="img-0ef873d2-71" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-3.99 L 109.98 -3.99" id="img-0ef873d2-72" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-7.65 L 109.98 -7.65" id="img-0ef873d2-73" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-11.31 L 109.98 -11.31" id="img-0ef873d2-74" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-14.97 L 109.98 -14.97" id="img-0ef873d2-75" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-18.63 L 109.98 -18.63" id="img-0ef873d2-76" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-22.29 L 109.98 -22.29" id="img-0ef873d2-77" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-25.96 L 109.98 -25.96" id="img-0ef873d2-78" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-29.62 L 109.98 -29.62" id="img-0ef873d2-79" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-33.28 L 109.98 -33.28" id="img-0ef873d2-80" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-36.94 L 109.98 -36.94" id="img-0ef873d2-81" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-40.6 L 109.98 -40.6" id="img-0ef873d2-82" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-44.26 L 109.98 -44.26" id="img-0ef873d2-83" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-47.93 L 109.98 -47.93" id="img-0ef873d2-84" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-51.59 L 109.98 -51.59" id="img-0ef873d2-85" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-55.25 L 109.98 -55.25" id="img-0ef873d2-86" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-58.91 L 109.98 -58.91" id="img-0ef873d2-87" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-62.57 L 109.98 -62.57" id="img-0ef873d2-88" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,-66.23 L 109.98 -66.23" id="img-0ef873d2-89" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.89,153.47 L 109.98 153.47" id="img-0ef873d2-90" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.89,80.23 L 109.98 80.23" id="img-0ef873d2-91" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.89,7 L 109.98 7" id="img-0ef873d2-92" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.89,-66.23 L 109.98 -66.23" id="img-0ef873d2-93" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.89,153.47 L 109.98 153.47" id="img-0ef873d2-94" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,146.15 L 109.98 146.15" id="img-0ef873d2-95" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,138.82 L 109.98 138.82" id="img-0ef873d2-96" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,131.5 L 109.98 131.5" id="img-0ef873d2-97" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,124.18 L 109.98 124.18" id="img-0ef873d2-98" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,116.85 L 109.98 116.85" id="img-0ef873d2-99" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,109.53 L 109.98 109.53" id="img-0ef873d2-100" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,102.2 L 109.98 102.2" id="img-0ef873d2-101" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,94.88 L 109.98 94.88" id="img-0ef873d2-102" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,87.56 L 109.98 87.56" id="img-0ef873d2-103" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,80.23 L 109.98 80.23" id="img-0ef873d2-104" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,72.91 L 109.98 72.91" id="img-0ef873d2-105" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,65.59 L 109.98 65.59" id="img-0ef873d2-106" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,58.26 L 109.98 58.26" id="img-0ef873d2-107" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,50.94 L 109.98 50.94" id="img-0ef873d2-108" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,43.62 L 109.98 43.62" id="img-0ef873d2-109" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,36.29 L 109.98 36.29" id="img-0ef873d2-110" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,28.97 L 109.98 28.97" id="img-0ef873d2-111" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,21.65 L 109.98 21.65" id="img-0ef873d2-112" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,14.32 L 109.98 14.32" id="img-0ef873d2-113" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,7 L 109.98 7" id="img-0ef873d2-114" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-0.32 L 109.98 -0.32" id="img-0ef873d2-115" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-7.65 L 109.98 -7.65" id="img-0ef873d2-116" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-14.97 L 109.98 -14.97" id="img-0ef873d2-117" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-22.29 L 109.98 -22.29" id="img-0ef873d2-118" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-29.62 L 109.98 -29.62" id="img-0ef873d2-119" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-36.94 L 109.98 -36.94" id="img-0ef873d2-120" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-44.26 L 109.98 -44.26" id="img-0ef873d2-121" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-51.59 L 109.98 -51.59" id="img-0ef873d2-122" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-58.91 L 109.98 -58.91" id="img-0ef873d2-123" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.89,-66.23 L 109.98 -66.23" id="img-0ef873d2-124" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-0ef873d2-125">
      <path fill="none" d="M-114.75,5 L -114.75 82.23" id="img-0ef873d2-126" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-70.2,5 L -70.2 82.23" id="img-0ef873d2-127" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-25.66,5 L -25.66 82.23" id="img-0ef873d2-128" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M18.89,5 L 18.89 82.23" id="img-0ef873d2-129" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M63.43,5 L 63.43 82.23" id="img-0ef873d2-130" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M107.98,5 L 107.98 82.23" id="img-0ef873d2-131" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M152.52,5 L 152.52 82.23" id="img-0ef873d2-132" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M197.06,5 L 197.06 82.23" id="img-0ef873d2-133" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M241.61,5 L 241.61 82.23" id="img-0ef873d2-134" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-70.2,5 L -70.2 82.23" id="img-0ef873d2-135" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-65.75,5 L -65.75 82.23" id="img-0ef873d2-136" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-61.29,5 L -61.29 82.23" id="img-0ef873d2-137" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-56.84,5 L -56.84 82.23" id="img-0ef873d2-138" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-52.39,5 L -52.39 82.23" id="img-0ef873d2-139" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-47.93,5 L -47.93 82.23" id="img-0ef873d2-140" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-43.48,5 L -43.48 82.23" id="img-0ef873d2-141" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-39.02,5 L -39.02 82.23" id="img-0ef873d2-142" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-34.57,5 L -34.57 82.23" id="img-0ef873d2-143" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-30.11,5 L -30.11 82.23" id="img-0ef873d2-144" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-25.66,5 L -25.66 82.23" id="img-0ef873d2-145" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-21.2,5 L -21.2 82.23" id="img-0ef873d2-146" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-16.75,5 L -16.75 82.23" id="img-0ef873d2-147" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-12.3,5 L -12.3 82.23" id="img-0ef873d2-148" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-7.84,5 L -7.84 82.23" id="img-0ef873d2-149" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-3.39,5 L -3.39 82.23" id="img-0ef873d2-150" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M1.07,5 L 1.07 82.23" id="img-0ef873d2-151" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M5.52,5 L 5.52 82.23" id="img-0ef873d2-152" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M9.98,5 L 9.98 82.23" id="img-0ef873d2-153" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.43,5 L 14.43 82.23" id="img-0ef873d2-154" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M18.89,5 L 18.89 82.23" id="img-0ef873d2-155" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M23.34,5 L 23.34 82.23" id="img-0ef873d2-156" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M27.79,5 L 27.79 82.23" id="img-0ef873d2-157" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M32.25,5 L 32.25 82.23" id="img-0ef873d2-158" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M36.7,5 L 36.7 82.23" id="img-0ef873d2-159" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M41.16,5 L 41.16 82.23" id="img-0ef873d2-160" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M45.61,5 L 45.61 82.23" id="img-0ef873d2-161" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M50.07,5 L 50.07 82.23" id="img-0ef873d2-162" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M54.52,5 L 54.52 82.23" id="img-0ef873d2-163" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M58.98,5 L 58.98 82.23" id="img-0ef873d2-164" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M63.43,5 L 63.43 82.23" id="img-0ef873d2-165" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M67.89,5 L 67.89 82.23" id="img-0ef873d2-166" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M72.34,5 L 72.34 82.23" id="img-0ef873d2-167" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M76.79,5 L 76.79 82.23" id="img-0ef873d2-168" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M81.25,5 L 81.25 82.23" id="img-0ef873d2-169" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M85.7,5 L 85.7 82.23" id="img-0ef873d2-170" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M90.16,5 L 90.16 82.23" id="img-0ef873d2-171" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M94.61,5 L 94.61 82.23" id="img-0ef873d2-172" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M99.07,5 L 99.07 82.23" id="img-0ef873d2-173" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M103.52,5 L 103.52 82.23" id="img-0ef873d2-174" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M107.98,5 L 107.98 82.23" id="img-0ef873d2-175" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M112.43,5 L 112.43 82.23" id="img-0ef873d2-176" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M116.88,5 L 116.88 82.23" id="img-0ef873d2-177" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M121.34,5 L 121.34 82.23" id="img-0ef873d2-178" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M125.79,5 L 125.79 82.23" id="img-0ef873d2-179" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M130.25,5 L 130.25 82.23" id="img-0ef873d2-180" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M134.7,5 L 134.7 82.23" id="img-0ef873d2-181" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M139.16,5 L 139.16 82.23" id="img-0ef873d2-182" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M143.61,5 L 143.61 82.23" id="img-0ef873d2-183" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M148.07,5 L 148.07 82.23" id="img-0ef873d2-184" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M152.52,5 L 152.52 82.23" id="img-0ef873d2-185" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M156.97,5 L 156.97 82.23" id="img-0ef873d2-186" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M161.43,5 L 161.43 82.23" id="img-0ef873d2-187" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M165.88,5 L 165.88 82.23" id="img-0ef873d2-188" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M170.34,5 L 170.34 82.23" id="img-0ef873d2-189" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M174.79,5 L 174.79 82.23" id="img-0ef873d2-190" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M179.25,5 L 179.25 82.23" id="img-0ef873d2-191" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M183.7,5 L 183.7 82.23" id="img-0ef873d2-192" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M188.16,5 L 188.16 82.23" id="img-0ef873d2-193" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M192.61,5 L 192.61 82.23" id="img-0ef873d2-194" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M197.06,5 L 197.06 82.23" id="img-0ef873d2-195" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-70.2,5 L -70.2 82.23" id="img-0ef873d2-196" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M18.89,5 L 18.89 82.23" id="img-0ef873d2-197" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M107.98,5 L 107.98 82.23" id="img-0ef873d2-198" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M197.06,5 L 197.06 82.23" id="img-0ef873d2-199" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M-70.2,5 L -70.2 82.23" id="img-0ef873d2-200" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-61.29,5 L -61.29 82.23" id="img-0ef873d2-201" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-52.39,5 L -52.39 82.23" id="img-0ef873d2-202" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-43.48,5 L -43.48 82.23" id="img-0ef873d2-203" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-34.57,5 L -34.57 82.23" id="img-0ef873d2-204" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-25.66,5 L -25.66 82.23" id="img-0ef873d2-205" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-16.75,5 L -16.75 82.23" id="img-0ef873d2-206" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-7.84,5 L -7.84 82.23" id="img-0ef873d2-207" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M1.07,5 L 1.07 82.23" id="img-0ef873d2-208" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M9.98,5 L 9.98 82.23" id="img-0ef873d2-209" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M18.89,5 L 18.89 82.23" id="img-0ef873d2-210" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M27.79,5 L 27.79 82.23" id="img-0ef873d2-211" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M36.7,5 L 36.7 82.23" id="img-0ef873d2-212" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M45.61,5 L 45.61 82.23" id="img-0ef873d2-213" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M54.52,5 L 54.52 82.23" id="img-0ef873d2-214" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M63.43,5 L 63.43 82.23" id="img-0ef873d2-215" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M72.34,5 L 72.34 82.23" id="img-0ef873d2-216" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M81.25,5 L 81.25 82.23" id="img-0ef873d2-217" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M90.16,5 L 90.16 82.23" id="img-0ef873d2-218" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M99.07,5 L 99.07 82.23" id="img-0ef873d2-219" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M107.98,5 L 107.98 82.23" id="img-0ef873d2-220" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M116.88,5 L 116.88 82.23" id="img-0ef873d2-221" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M125.79,5 L 125.79 82.23" id="img-0ef873d2-222" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M134.7,5 L 134.7 82.23" id="img-0ef873d2-223" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M143.61,5 L 143.61 82.23" id="img-0ef873d2-224" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M152.52,5 L 152.52 82.23" id="img-0ef873d2-225" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M161.43,5 L 161.43 82.23" id="img-0ef873d2-226" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M170.34,5 L 170.34 82.23" id="img-0ef873d2-227" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M179.25,5 L 179.25 82.23" id="img-0ef873d2-228" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M188.16,5 L 188.16 82.23" id="img-0ef873d2-229" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M197.06,5 L 197.06 82.23" id="img-0ef873d2-230" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="plotpanel" id="img-0ef873d2-231">
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_3" stroke-dasharray="none" stroke="#FF6DAE" id="img-0ef873d2-232">
        <path fill="none" d="M19.78,42.26 L 20.67 61.97 21.56 62.31 22.45 57.93 23.34 77.25 24.23 61.34 25.12 73.88 26.01 15.62 26.9 17.94 27.79 64.35 28.69 55.8 29.58 59.31 30.47 15.11 31.36 54.68 32.25 73.4 33.14 19.68 34.03 68.23 34.92 58.34 35.81 78.28 36.7 53.5 37.59 22.11 38.49 19.62 39.38 47.2 40.27 62.88 41.16 76.95 42.05 64.62 42.94 72.35 43.83 15.59 44.72 38.95 45.61 36.79 46.5 63.46 47.39 63.69 48.29 56.8 49.18 35.74 50.07 30.71 50.96 63.96 51.85 43.37 52.74 75.39 53.63 77.85 54.52 54.28 55.41 49.79 56.3 51.48 57.19 19.93 58.09 57.83 58.98 73.47 59.87 7.82 60.76 49.18 61.65 61.82 62.54 24.41 63.43 50.54 64.32 36.85 65.21 22.5 66.1 64.84 66.99 31.36 67.89 18.74 68.78 55.17 69.67 12.22 70.56 28.98 71.45 52.78 72.34 29.95 73.23 45.38 74.12 67.69 75.01 48.43 75.9 19.78 76.79 22.04 77.69 49.79 78.58 71.47 79.47 7.69 80.36 17.11 81.25 28.18 82.14 36.67 83.03 15.79 83.92 33.67 84.81 18.18 85.7 38.91 86.59 15.31 87.48 30.07 88.38 26.31 89.27 70.77 90.16 7.61 91.05 60.89 91.94 30.86 92.83 75.47 93.72 64.27 94.61 9.79 95.5 78.05 96.39 79.5 97.28 22.37 98.18 37.96 99.07 10.2 99.96 34.56 100.85 13.27 101.74 37.84 102.63 42.45 103.52 49.82 104.41 9.82 105.3 21.94 106.19 26.28 107.08 32.38 107.98 35.72" id="img-0ef873d2-233"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_2" stroke-dasharray="none" stroke="#D4CA3A" id="img-0ef873d2-234">
        <path fill="none" d="M19.78,32.8 L 20.67 22.94 21.56 14.93 22.45 9.49 23.34 7.09 24.23 7.96 25.12 12.01 26.01 18.88 26.9 27.97 27.79 38.45 28.69 49.39 29.58 59.82 30.47 68.8 31.36 75.53 32.25 79.41 33.14 80.09 34.03 77.52 34.92 71.91 35.81 63.78 36.7 53.85 37.59 43 38.49 32.21 39.38 22.44 40.27 14.56 41.16 9.27 42.05 7.05 42.94 8.1 43.83 12.32 44.72 19.34 45.61 28.53 46.5 39.06 47.39 50 48.29 60.37 49.18 69.24 50.07 75.83 50.96 79.54 51.85 80.03 52.74 77.28 53.63 71.52 54.52 63.26 55.41 53.26 56.3 42.39 57.19 31.63 58.09 21.94 58.98 14.18 59.87 9.06 60.76 7.03 61.65 8.26 62.54 12.65 63.43 19.81 64.32 29.09 65.21 39.67 66.1 50.61 66.99 60.92 67.89 69.68 68.78 76.12 69.67 79.65 70.56 79.97 71.45 77.03 72.34 71.12 73.23 62.74 74.12 52.66 75.01 41.77 75.9 31.05 76.79 21.44 77.69 13.82 78.58 8.86 79.47 7.01 80.36 8.42 81.25 12.98 82.14 20.28 83.03 29.66 83.92 40.28 84.81 51.21 85.7 61.46 86.59 70.11 87.48 76.4 88.38 79.76 89.27 79.89 90.16 76.78 91.05 70.71 91.94 62.21 92.83 52.06 93.72 41.16 94.61 30.47 95.5 20.96 96.39 13.47 97.28 8.67 98.18 7 99.07 8.6 99.96 13.32 100.85 20.75 101.74 30.23 102.63 40.9 103.52 51.81 104.41 61.99 105.3 70.53 106.19 76.67 107.08 79.85 107.98 79.8" id="img-0ef873d2-235"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_1" stroke-dasharray="none" stroke="#00BFFF" id="img-0ef873d2-236">
        <path fill="none" d="M19.78,41.79 L 20.67 39.96 21.56 38.15 22.45 36.34 23.34 34.56 24.23 32.8 25.12 31.06 26.01 29.36 26.9 27.69 27.79 26.06 28.69 24.48 29.58 22.94 30.47 21.46 31.36 20.03 32.25 18.66 33.14 17.35 34.03 16.11 34.92 14.93 35.81 13.83 36.7 12.8 37.59 11.85 38.49 10.98 39.38 10.19 40.27 9.49 41.16 8.87 42.05 8.33 42.94 7.89 43.83 7.53 44.72 7.27 45.61 7.09 46.5 7.01 47.39 7.02 48.29 7.11 49.18 7.31 50.07 7.59 50.96 7.96 51.85 8.42 52.74 8.97 53.63 9.6 54.52 10.32 55.41 11.12 56.3 12.01 57.19 12.97 58.09 14.01 58.98 15.13 59.87 16.31 60.76 17.57 61.65 18.88 62.54 20.26 63.43 21.7 64.32 23.2 65.21 24.74 66.1 26.33 66.99 27.97 67.89 29.64 68.78 31.35 69.67 33.09 70.56 34.86 71.45 36.64 72.34 38.45 73.23 40.27 74.12 42.09 75.01 43.93 75.9 45.75 76.79 47.58 77.69 49.39 78.58 51.19 79.47 52.97 80.36 54.73 81.25 56.46 82.14 58.16 83.03 59.82 83.92 61.44 84.81 63.02 85.7 64.55 86.59 66.02 87.48 67.44 88.38 68.8 89.27 70.1 90.16 71.33 91.05 72.49 91.94 73.58 92.83 74.59 93.72 75.53 94.61 76.39 95.5 77.16 96.39 77.86 97.28 78.46 98.18 78.98 99.07 79.41 99.96 79.75 100.85 80 101.74 80.16 102.63 80.23 103.52 80.21 104.41 80.09 105.3 79.89 106.19 79.59 107.08 79.21 107.98 78.73" id="img-0ef873d2-237"/>
      </g>
    </g>
    <g opacity="0" class="guide zoomslider" stroke="#000000" stroke-opacity="0.000" id="img-0ef873d2-238">
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-0ef873d2-239">
        <rect x="102.98" y="8" width="4" height="4" id="img-0ef873d2-240"/>
        <g class="button_logo" fill="#6A6A6A" id="img-0ef873d2-241">
          <path d="M103.78,9.6 L 104.58 9.6 104.58 8.8 105.38 8.8 105.38 9.6 106.18 9.6 106.18 10.4 105.38 10.4 105.38 11.2 104.58 11.2 104.58 10.4 103.78 10.4 z" id="img-0ef873d2-242"/>
        </g>
      </g>
      <g fill="#EAEAEA" id="img-0ef873d2-243">
        <rect x="83.48" y="8" width="19" height="4" id="img-0ef873d2-244"/>
      </g>
      <g class="zoomslider_thumb" fill="#6A6A6A" id="img-0ef873d2-245">
        <rect x="91.98" y="8" width="2" height="4" id="img-0ef873d2-246"/>
      </g>
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-0ef873d2-247">
        <rect x="78.98" y="8" width="4" height="4" id="img-0ef873d2-248"/>
        <g class="button_logo" fill="#6A6A6A" id="img-0ef873d2-249">
          <path d="M79.78,9.6 L 82.18 9.6 82.18 10.4 79.78 10.4 z" id="img-0ef873d2-250"/>
        </g>
      </g>
    </g>
  </g>
</g>
  <g class="guide ylabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-0ef873d2-251">
    <text x="15.89" y="190.09" text-anchor="end" dy="0.35em" id="img-0ef873d2-252" visibility="hidden" gadfly:scale="1.0">-1.5</text>
    <text x="15.89" y="153.47" text-anchor="end" dy="0.35em" id="img-0ef873d2-253" visibility="hidden" gadfly:scale="1.0">-1.0</text>
    <text x="15.89" y="116.85" text-anchor="end" dy="0.35em" id="img-0ef873d2-254" visibility="hidden" gadfly:scale="1.0">-0.5</text>
    <text x="15.89" y="80.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-255" visibility="visible" gadfly:scale="1.0">0.0</text>
    <text x="15.89" y="43.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-256" visibility="visible" gadfly:scale="1.0">0.5</text>
    <text x="15.89" y="7" text-anchor="end" dy="0.35em" id="img-0ef873d2-257" visibility="visible" gadfly:scale="1.0">1.0</text>
    <text x="15.89" y="-29.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-258" visibility="hidden" gadfly:scale="1.0">1.5</text>
    <text x="15.89" y="-66.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-259" visibility="hidden" gadfly:scale="1.0">2.0</text>
    <text x="15.89" y="-102.85" text-anchor="end" dy="0.35em" id="img-0ef873d2-260" visibility="hidden" gadfly:scale="1.0">2.5</text>
    <text x="15.89" y="153.47" text-anchor="end" dy="0.35em" id="img-0ef873d2-261" visibility="hidden" gadfly:scale="10.0">-1.00</text>
    <text x="15.89" y="149.81" text-anchor="end" dy="0.35em" id="img-0ef873d2-262" visibility="hidden" gadfly:scale="10.0">-0.95</text>
    <text x="15.89" y="146.15" text-anchor="end" dy="0.35em" id="img-0ef873d2-263" visibility="hidden" gadfly:scale="10.0">-0.90</text>
    <text x="15.89" y="142.48" text-anchor="end" dy="0.35em" id="img-0ef873d2-264" visibility="hidden" gadfly:scale="10.0">-0.85</text>
    <text x="15.89" y="138.82" text-anchor="end" dy="0.35em" id="img-0ef873d2-265" visibility="hidden" gadfly:scale="10.0">-0.80</text>
    <text x="15.89" y="135.16" text-anchor="end" dy="0.35em" id="img-0ef873d2-266" visibility="hidden" gadfly:scale="10.0">-0.75</text>
    <text x="15.89" y="131.5" text-anchor="end" dy="0.35em" id="img-0ef873d2-267" visibility="hidden" gadfly:scale="10.0">-0.70</text>
    <text x="15.89" y="127.84" text-anchor="end" dy="0.35em" id="img-0ef873d2-268" visibility="hidden" gadfly:scale="10.0">-0.65</text>
    <text x="15.89" y="124.18" text-anchor="end" dy="0.35em" id="img-0ef873d2-269" visibility="hidden" gadfly:scale="10.0">-0.60</text>
    <text x="15.89" y="120.51" text-anchor="end" dy="0.35em" id="img-0ef873d2-270" visibility="hidden" gadfly:scale="10.0">-0.55</text>
    <text x="15.89" y="116.85" text-anchor="end" dy="0.35em" id="img-0ef873d2-271" visibility="hidden" gadfly:scale="10.0">-0.50</text>
    <text x="15.89" y="113.19" text-anchor="end" dy="0.35em" id="img-0ef873d2-272" visibility="hidden" gadfly:scale="10.0">-0.45</text>
    <text x="15.89" y="109.53" text-anchor="end" dy="0.35em" id="img-0ef873d2-273" visibility="hidden" gadfly:scale="10.0">-0.40</text>
    <text x="15.89" y="105.87" text-anchor="end" dy="0.35em" id="img-0ef873d2-274" visibility="hidden" gadfly:scale="10.0">-0.35</text>
    <text x="15.89" y="102.2" text-anchor="end" dy="0.35em" id="img-0ef873d2-275" visibility="hidden" gadfly:scale="10.0">-0.30</text>
    <text x="15.89" y="98.54" text-anchor="end" dy="0.35em" id="img-0ef873d2-276" visibility="hidden" gadfly:scale="10.0">-0.25</text>
    <text x="15.89" y="94.88" text-anchor="end" dy="0.35em" id="img-0ef873d2-277" visibility="hidden" gadfly:scale="10.0">-0.20</text>
    <text x="15.89" y="91.22" text-anchor="end" dy="0.35em" id="img-0ef873d2-278" visibility="hidden" gadfly:scale="10.0">-0.15</text>
    <text x="15.89" y="87.56" text-anchor="end" dy="0.35em" id="img-0ef873d2-279" visibility="hidden" gadfly:scale="10.0">-0.10</text>
    <text x="15.89" y="83.9" text-anchor="end" dy="0.35em" id="img-0ef873d2-280" visibility="hidden" gadfly:scale="10.0">-0.05</text>
    <text x="15.89" y="80.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-281" visibility="hidden" gadfly:scale="10.0">0.00</text>
    <text x="15.89" y="76.57" text-anchor="end" dy="0.35em" id="img-0ef873d2-282" visibility="hidden" gadfly:scale="10.0">0.05</text>
    <text x="15.89" y="72.91" text-anchor="end" dy="0.35em" id="img-0ef873d2-283" visibility="hidden" gadfly:scale="10.0">0.10</text>
    <text x="15.89" y="69.25" text-anchor="end" dy="0.35em" id="img-0ef873d2-284" visibility="hidden" gadfly:scale="10.0">0.15</text>
    <text x="15.89" y="65.59" text-anchor="end" dy="0.35em" id="img-0ef873d2-285" visibility="hidden" gadfly:scale="10.0">0.20</text>
    <text x="15.89" y="61.93" text-anchor="end" dy="0.35em" id="img-0ef873d2-286" visibility="hidden" gadfly:scale="10.0">0.25</text>
    <text x="15.89" y="58.26" text-anchor="end" dy="0.35em" id="img-0ef873d2-287" visibility="hidden" gadfly:scale="10.0">0.30</text>
    <text x="15.89" y="54.6" text-anchor="end" dy="0.35em" id="img-0ef873d2-288" visibility="hidden" gadfly:scale="10.0">0.35</text>
    <text x="15.89" y="50.94" text-anchor="end" dy="0.35em" id="img-0ef873d2-289" visibility="hidden" gadfly:scale="10.0">0.40</text>
    <text x="15.89" y="47.28" text-anchor="end" dy="0.35em" id="img-0ef873d2-290" visibility="hidden" gadfly:scale="10.0">0.45</text>
    <text x="15.89" y="43.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-291" visibility="hidden" gadfly:scale="10.0">0.50</text>
    <text x="15.89" y="39.96" text-anchor="end" dy="0.35em" id="img-0ef873d2-292" visibility="hidden" gadfly:scale="10.0">0.55</text>
    <text x="15.89" y="36.29" text-anchor="end" dy="0.35em" id="img-0ef873d2-293" visibility="hidden" gadfly:scale="10.0">0.60</text>
    <text x="15.89" y="32.63" text-anchor="end" dy="0.35em" id="img-0ef873d2-294" visibility="hidden" gadfly:scale="10.0">0.65</text>
    <text x="15.89" y="28.97" text-anchor="end" dy="0.35em" id="img-0ef873d2-295" visibility="hidden" gadfly:scale="10.0">0.70</text>
    <text x="15.89" y="25.31" text-anchor="end" dy="0.35em" id="img-0ef873d2-296" visibility="hidden" gadfly:scale="10.0">0.75</text>
    <text x="15.89" y="21.65" text-anchor="end" dy="0.35em" id="img-0ef873d2-297" visibility="hidden" gadfly:scale="10.0">0.80</text>
    <text x="15.89" y="17.99" text-anchor="end" dy="0.35em" id="img-0ef873d2-298" visibility="hidden" gadfly:scale="10.0">0.85</text>
    <text x="15.89" y="14.32" text-anchor="end" dy="0.35em" id="img-0ef873d2-299" visibility="hidden" gadfly:scale="10.0">0.90</text>
    <text x="15.89" y="10.66" text-anchor="end" dy="0.35em" id="img-0ef873d2-300" visibility="hidden" gadfly:scale="10.0">0.95</text>
    <text x="15.89" y="7" text-anchor="end" dy="0.35em" id="img-0ef873d2-301" visibility="hidden" gadfly:scale="10.0">1.00</text>
    <text x="15.89" y="3.34" text-anchor="end" dy="0.35em" id="img-0ef873d2-302" visibility="hidden" gadfly:scale="10.0">1.05</text>
    <text x="15.89" y="-0.32" text-anchor="end" dy="0.35em" id="img-0ef873d2-303" visibility="hidden" gadfly:scale="10.0">1.10</text>
    <text x="15.89" y="-3.99" text-anchor="end" dy="0.35em" id="img-0ef873d2-304" visibility="hidden" gadfly:scale="10.0">1.15</text>
    <text x="15.89" y="-7.65" text-anchor="end" dy="0.35em" id="img-0ef873d2-305" visibility="hidden" gadfly:scale="10.0">1.20</text>
    <text x="15.89" y="-11.31" text-anchor="end" dy="0.35em" id="img-0ef873d2-306" visibility="hidden" gadfly:scale="10.0">1.25</text>
    <text x="15.89" y="-14.97" text-anchor="end" dy="0.35em" id="img-0ef873d2-307" visibility="hidden" gadfly:scale="10.0">1.30</text>
    <text x="15.89" y="-18.63" text-anchor="end" dy="0.35em" id="img-0ef873d2-308" visibility="hidden" gadfly:scale="10.0">1.35</text>
    <text x="15.89" y="-22.29" text-anchor="end" dy="0.35em" id="img-0ef873d2-309" visibility="hidden" gadfly:scale="10.0">1.40</text>
    <text x="15.89" y="-25.96" text-anchor="end" dy="0.35em" id="img-0ef873d2-310" visibility="hidden" gadfly:scale="10.0">1.45</text>
    <text x="15.89" y="-29.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-311" visibility="hidden" gadfly:scale="10.0">1.50</text>
    <text x="15.89" y="-33.28" text-anchor="end" dy="0.35em" id="img-0ef873d2-312" visibility="hidden" gadfly:scale="10.0">1.55</text>
    <text x="15.89" y="-36.94" text-anchor="end" dy="0.35em" id="img-0ef873d2-313" visibility="hidden" gadfly:scale="10.0">1.60</text>
    <text x="15.89" y="-40.6" text-anchor="end" dy="0.35em" id="img-0ef873d2-314" visibility="hidden" gadfly:scale="10.0">1.65</text>
    <text x="15.89" y="-44.26" text-anchor="end" dy="0.35em" id="img-0ef873d2-315" visibility="hidden" gadfly:scale="10.0">1.70</text>
    <text x="15.89" y="-47.93" text-anchor="end" dy="0.35em" id="img-0ef873d2-316" visibility="hidden" gadfly:scale="10.0">1.75</text>
    <text x="15.89" y="-51.59" text-anchor="end" dy="0.35em" id="img-0ef873d2-317" visibility="hidden" gadfly:scale="10.0">1.80</text>
    <text x="15.89" y="-55.25" text-anchor="end" dy="0.35em" id="img-0ef873d2-318" visibility="hidden" gadfly:scale="10.0">1.85</text>
    <text x="15.89" y="-58.91" text-anchor="end" dy="0.35em" id="img-0ef873d2-319" visibility="hidden" gadfly:scale="10.0">1.90</text>
    <text x="15.89" y="-62.57" text-anchor="end" dy="0.35em" id="img-0ef873d2-320" visibility="hidden" gadfly:scale="10.0">1.95</text>
    <text x="15.89" y="-66.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-321" visibility="hidden" gadfly:scale="10.0">2.00</text>
    <text x="15.89" y="153.47" text-anchor="end" dy="0.35em" id="img-0ef873d2-322" visibility="hidden" gadfly:scale="0.5">-1</text>
    <text x="15.89" y="80.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-323" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="15.89" y="7" text-anchor="end" dy="0.35em" id="img-0ef873d2-324" visibility="hidden" gadfly:scale="0.5">1</text>
    <text x="15.89" y="-66.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-325" visibility="hidden" gadfly:scale="0.5">2</text>
    <text x="15.89" y="153.47" text-anchor="end" dy="0.35em" id="img-0ef873d2-326" visibility="hidden" gadfly:scale="5.0">-1.0</text>
    <text x="15.89" y="146.15" text-anchor="end" dy="0.35em" id="img-0ef873d2-327" visibility="hidden" gadfly:scale="5.0">-0.9</text>
    <text x="15.89" y="138.82" text-anchor="end" dy="0.35em" id="img-0ef873d2-328" visibility="hidden" gadfly:scale="5.0">-0.8</text>
    <text x="15.89" y="131.5" text-anchor="end" dy="0.35em" id="img-0ef873d2-329" visibility="hidden" gadfly:scale="5.0">-0.7</text>
    <text x="15.89" y="124.18" text-anchor="end" dy="0.35em" id="img-0ef873d2-330" visibility="hidden" gadfly:scale="5.0">-0.6</text>
    <text x="15.89" y="116.85" text-anchor="end" dy="0.35em" id="img-0ef873d2-331" visibility="hidden" gadfly:scale="5.0">-0.5</text>
    <text x="15.89" y="109.53" text-anchor="end" dy="0.35em" id="img-0ef873d2-332" visibility="hidden" gadfly:scale="5.0">-0.4</text>
    <text x="15.89" y="102.2" text-anchor="end" dy="0.35em" id="img-0ef873d2-333" visibility="hidden" gadfly:scale="5.0">-0.3</text>
    <text x="15.89" y="94.88" text-anchor="end" dy="0.35em" id="img-0ef873d2-334" visibility="hidden" gadfly:scale="5.0">-0.2</text>
    <text x="15.89" y="87.56" text-anchor="end" dy="0.35em" id="img-0ef873d2-335" visibility="hidden" gadfly:scale="5.0">-0.1</text>
    <text x="15.89" y="80.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-336" visibility="hidden" gadfly:scale="5.0">0.0</text>
    <text x="15.89" y="72.91" text-anchor="end" dy="0.35em" id="img-0ef873d2-337" visibility="hidden" gadfly:scale="5.0">0.1</text>
    <text x="15.89" y="65.59" text-anchor="end" dy="0.35em" id="img-0ef873d2-338" visibility="hidden" gadfly:scale="5.0">0.2</text>
    <text x="15.89" y="58.26" text-anchor="end" dy="0.35em" id="img-0ef873d2-339" visibility="hidden" gadfly:scale="5.0">0.3</text>
    <text x="15.89" y="50.94" text-anchor="end" dy="0.35em" id="img-0ef873d2-340" visibility="hidden" gadfly:scale="5.0">0.4</text>
    <text x="15.89" y="43.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-341" visibility="hidden" gadfly:scale="5.0">0.5</text>
    <text x="15.89" y="36.29" text-anchor="end" dy="0.35em" id="img-0ef873d2-342" visibility="hidden" gadfly:scale="5.0">0.6</text>
    <text x="15.89" y="28.97" text-anchor="end" dy="0.35em" id="img-0ef873d2-343" visibility="hidden" gadfly:scale="5.0">0.7</text>
    <text x="15.89" y="21.65" text-anchor="end" dy="0.35em" id="img-0ef873d2-344" visibility="hidden" gadfly:scale="5.0">0.8</text>
    <text x="15.89" y="14.32" text-anchor="end" dy="0.35em" id="img-0ef873d2-345" visibility="hidden" gadfly:scale="5.0">0.9</text>
    <text x="15.89" y="7" text-anchor="end" dy="0.35em" id="img-0ef873d2-346" visibility="hidden" gadfly:scale="5.0">1.0</text>
    <text x="15.89" y="-0.32" text-anchor="end" dy="0.35em" id="img-0ef873d2-347" visibility="hidden" gadfly:scale="5.0">1.1</text>
    <text x="15.89" y="-7.65" text-anchor="end" dy="0.35em" id="img-0ef873d2-348" visibility="hidden" gadfly:scale="5.0">1.2</text>
    <text x="15.89" y="-14.97" text-anchor="end" dy="0.35em" id="img-0ef873d2-349" visibility="hidden" gadfly:scale="5.0">1.3</text>
    <text x="15.89" y="-22.29" text-anchor="end" dy="0.35em" id="img-0ef873d2-350" visibility="hidden" gadfly:scale="5.0">1.4</text>
    <text x="15.89" y="-29.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-351" visibility="hidden" gadfly:scale="5.0">1.5</text>
    <text x="15.89" y="-36.94" text-anchor="end" dy="0.35em" id="img-0ef873d2-352" visibility="hidden" gadfly:scale="5.0">1.6</text>
    <text x="15.89" y="-44.26" text-anchor="end" dy="0.35em" id="img-0ef873d2-353" visibility="hidden" gadfly:scale="5.0">1.7</text>
    <text x="15.89" y="-51.59" text-anchor="end" dy="0.35em" id="img-0ef873d2-354" visibility="hidden" gadfly:scale="5.0">1.8</text>
    <text x="15.89" y="-58.91" text-anchor="end" dy="0.35em" id="img-0ef873d2-355" visibility="hidden" gadfly:scale="5.0">1.9</text>
    <text x="15.89" y="-66.23" text-anchor="end" dy="0.35em" id="img-0ef873d2-356" visibility="hidden" gadfly:scale="5.0">2.0</text>
  </g>
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-0ef873d2-357">
    <text x="9.11" y="43.62" text-anchor="end" dy="0.35em" id="img-0ef873d2-358">Y</text>
  </g>
</g>
<defs>
  <clipPath id="img-0ef873d2-15">
  <path d="M16.89,5 L 109.98 5 109.98 82.23 16.89 82.23" />
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

        this.node.addEventListener(
            /Firefox/i.test(navigator.userAgent) ? "DOMMouseScroll" : "mousewheel",
            fn2);

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


// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_zoom = function(event) {
        if (event.which == 187) { // plus
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189) { // minus
            increase_zoom_by_position(root, -0.1, true);
        }
    };
    root.data("keyboard_zoom", keyboard_zoom);
    window.addEventListener("keyup", keyboard_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    xgridlines.data("unfocused_strokedash",
                    xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
    ygridlines.data("unfocused_strokedash",
                    ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));

    // emphasize grid lines
    var destcolor = root.data("focused_xgrid_color");
    xgridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("focused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // reveal zoom slider
    root.select(".zoomslider")
        .animate({opacity: 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_zoom"));
    root.data("keyboard_zoom", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    var destcolor = root.data("unfocused_xgrid_color");

    xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("unfocused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // hide zoom slider
    root.select(".zoomslider")
        .animate({opacity: 0.0}, 250);
};


var set_geometry_transform = function(root, tx, ty, scale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_scale = root.data("scale");

    var xscale = xscalable ? scale : 1.0,
        yscale = yscalable ? scale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);

    root.selectAll(".geometry, image")
        .forEach(function (element, i) {
            element.transform(t);
        });

    bounds = root.plotbounds();

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        root.select(".ylabels")
            .transform(xfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1, 1/scale, cx, cy).add(st);
                    element.transform(unscale_t);

                    var y = cy * scale + ty;
                    element.attr("visibility",
                        bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                }
            });
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        root.select(".xlabels")
            .transform(yfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1/scale, 1, cx, cy).add(st);

                    element.transform(unscale_t);

                    var x = cx * scale + tx;
                    element.attr("visibility",
                        bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                    }
            });
    }

    // we must unscale anything that is scale invariance: widths, raiduses, etc.
    var size_attribs = ["font-size"];
    var unscaled_selection = ".geometry, .geometry *";
    if (xscalable) {
        size_attribs.push("rx");
        unscaled_selection += ", .xgridlines";
    }
    if (yscalable) {
        size_attribs.push("ry");
        unscaled_selection += ", .ygridlines";
    }

    root.selectAll(unscaled_selection)
        .forEach(function (element, i) {
            // circle need special help
            if (element.node.nodeName == "circle") {
                var cx = element.attribute("cx"),
                    cy = element.attribute("cy");
                unscale_t = new Snap.Matrix().scale(1/xscale, 1/yscale,
                                                        cx, cy);
                element.transform(unscale_t);
                return;
            }

            for (i in size_attribs) {
                var key = size_attribs[i];
                var val = parseFloat(element.attribute(key));
                if (val !== undefined && val != 0 && !isNaN(val)) {
                    element.attribute(key, val * old_scale / scale);
                }
            }
        });
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
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("path").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("text").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, scale) {
    var old_scale = root.data("scale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, and scale
    var x_min = -width * scale - (scale * width - width),
        x_max = width * scale,
        y_min = -height * scale - (scale * height - height),
        y_max = height * scale;

    var x0 = bounds.x0 - scale * bounds.x0,
        y0 = bounds.y0 - scale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale change, we may need to alter which set of
    // ticks is being displayed
    if (scale != old_scale) {
        update_tickscale(root, scale, "x");
        update_tickscale(root, scale, "y");
    }

    set_geometry_transform(root, tx, ty, scale);

    root.data("scale", scale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, scale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var scale0 = root.data("scale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - scale0) + (width * (1 - scale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - scale0) + (height * (1 - scale0)) / 2);

    // rescale offsets
    xoff = xoff * scale / scale0;
    yoff = yoff * scale / scale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - scale),
        y_edge_adjust = bounds.y0 * (1 - scale);

    return {
        x: xoff + x_edge_adjust + (width - width * scale) / 2,
        y: yoff + y_edge_adjust + (height - height * scale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

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
    root.selectAll(".xlabels > text, .ylabels > text")
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
    if (root.data("scale") === undefined) root.data("scale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("path").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("path").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("text").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("text").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
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
        xlabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("path").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("path").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("text").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("text").forEach(mark_inscale);

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
            .selectAll("path")
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
            .selectAll("path")
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

        set_plot_pan_zoom(root, tx, ty, root.data("scale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"), root.data("scale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, x, y, event) {
        var bounds = root.plotbounds();
        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var ratio = width / height;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "opacity": 0.25
        });
        zoom_box.data("ratio", ratio);
    },
    update: function(root, dx, dy, x, y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
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
        if (xscalable && yscalable) {
            var ratio = zoom_box.data("ratio");
            var width = Math.min(Math.abs(dx), ratio * Math.abs(dy));
            var height = Math.min(Math.abs(dy), Math.abs(dx) / ratio);
            dx = width * dx / Math.abs(dx);
            dy = height * dy / Math.abs(dy);
        }
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
        var zoom_factor = 1.0;
        if (yscalable) {
            zoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        } else {
            zoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * zoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * zoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty, root.data("scale") * zoom_factor);
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
        increase_zoom_by_position(this.plotroot(), 0.001 * event.wheelDelta);
        event.preventDefault();
    }
};


Gadfly.zoomslider_button_mouseover = function(event) {
    this.select(".button_logo")
         .animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_button_mouseout = function(event) {
     this.select(".button_logo")
         .animate({fill: this.data("mouseout_color")}, 100);
};


Gadfly.zoomslider_zoomout_click = function(event) {
    increase_zoom_by_position(this.plotroot(), -0.1, true);
};


Gadfly.zoomslider_zoomin_click = function(event) {
    increase_zoom_by_position(this.plotroot(), 0.1, true);
};


Gadfly.zoomslider_track_click = function(event) {
    // TODO
};


// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var scale = root.data("scale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var position = slider_position_from_scale(scale, min_scale, max_scale);
    position += delta_position;
    scale = scale_from_slider_position(position, min_scale, max_scale);
    set_zoom(root, scale, animate);
}

var set_zoom = function(root, scale, animate) {
    var min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("scale");
    var new_scale = Math.max(min_scale, Math.min(scale, max_scale));
    if (animate) {
        Snap.animate(
            old_scale,
            new_scale,
            function (new_scale) {
                update_plot_scale(root, new_scale);
            },
            200);
    } else {
        update_plot_scale(root, new_scale);
    }
}


var update_plot_scale = function(root, new_scale) {
    var trans = scale_centered_translation(root, new_scale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_scale);

    root.selectAll(".zoomslider_thumb")
        .forEach(function (element, i) {
            var min_pos = element.data("min_pos"),
                max_pos = element.data("max_pos"),
                min_scale = root.data("min_scale"),
                max_scale = root.data("max_scale");
            var xmid = (min_pos + max_pos) / 2;
            var xpos = slider_position_from_scale(new_scale, min_scale, max_scale);
            element.transform(new Snap.Matrix().translate(
                Math.max(min_pos, Math.min(
                         max_pos, min_pos + (max_pos - min_pos) * xpos)) - xmid, 0));
    });
};


Gadfly.zoomslider_thumb_dragmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var min_pos = this.data("min_pos"),
        max_pos = this.data("max_pos"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("old_scale");

    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var xmid = (min_pos + max_pos) / 2;
    var xpos = slider_position_from_scale(old_scale, min_scale, max_scale) +
                   dx / (max_pos - min_pos);

    // compute the new scale
    var new_scale = scale_from_slider_position(xpos, min_scale, max_scale);
    new_scale = Math.min(max_scale, Math.max(min_scale, new_scale));

    update_plot_scale(root, new_scale);
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragstart = function(x, y, event) {
    this.animate({fill: this.data("mouseover_color")}, 100);
    var root = this.plotroot();

    // keep track of what the scale was when we started dragging
    root.data("old_scale", root.data("scale"));
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragend = function(event) {
    this.animate({fill: this.data("mouseout_color")}, 100);
    event.stopPropagation();
};


var toggle_color_class = function(root, color_class, ison) {
    var guides = root.selectAll(".guide." + color_class + ",.guide ." + color_class);
    var geoms = root.selectAll(".geometry." + color_class + ",.geometry ." + color_class);
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
        root.selectAll(".colorkey text")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (other_color_class != color_class) {
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
    var fig = Snap("#img-0ef873d2");
fig.select("#img-0ef873d2-4")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-0ef873d2-6")
   .data("color_class", "color_Source_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-7")
   .data("color_class", "color_Source_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-8")
   .data("color_class", "color_Source_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-10")
   .data("color_class", "color_Source_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-11")
   .data("color_class", "color_Source_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-12")
   .data("color_class", "color_Source_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-0ef873d2-16")
   .init_gadfly();
fig.select("#img-0ef873d2-19")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-0ef873d2-19")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-0ef873d2-125")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-0ef873d2-125")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-0ef873d2-239")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-0ef873d2-239")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-0ef873d2-239")
   .click(Gadfly.zoomslider_zoomin_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
fig.select("#img-0ef873d2-243")
   .data("max_pos", 93.98)
;
fig.select("#img-0ef873d2-243")
   .data("min_pos", 76.98)
;
fig.select("#img-0ef873d2-243")
   .click(Gadfly.zoomslider_track_click);
fig.select("#img-0ef873d2-245")
   .data("max_pos", 93.98)
;
fig.select("#img-0ef873d2-245")
   .data("min_pos", 76.98)
;
fig.select("#img-0ef873d2-245")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-0ef873d2-245")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-0ef873d2-245")
   .drag(Gadfly.zoomslider_thumb_dragmove,
     Gadfly.zoomslider_thumb_dragstart,
     Gadfly.zoomslider_thumb_dragend)
;
fig.select("#img-0ef873d2-247")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-0ef873d2-247")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-0ef873d2-247")
   .click(Gadfly.zoomslider_zoomout_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
    });
]]> </script>
</svg>




## Mixing matrix (assumed unknown)


```julia
H = [[1,1,1] [0,2,1] [1,0,2] [1,2,0]]
```




    3×4 Array{Int64,2}:
     1  0  1  1
     1  2  0  2
     1  1  2  0



## Data matix (known)


```julia
X = S * H
```




    100×4 Array{Float64,2}:
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
Mads.plotseries(X, title="Mixed signals", name="Signal", combined=true)
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

     id="img-ff422800">
<g class="plotroot xscalable yscalable" id="img-ff422800-1">
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-ff422800-2">
    <text x="64.34" y="89.28" text-anchor="middle" dy="0.6em">X</text>
  </g>
  <g class="guide xlabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-ff422800-3">
    <text x="-126.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-150</text>
    <text x="-79.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-100</text>
    <text x="-31.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-50</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="64.34" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">50</text>
    <text x="112.15" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">100</text>
    <text x="159.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">150</text>
    <text x="207.76" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">200</text>
    <text x="255.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">250</text>
    <text x="-79.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-100</text>
    <text x="-74.29" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-95</text>
    <text x="-69.51" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-90</text>
    <text x="-64.73" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-85</text>
    <text x="-59.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-80</text>
    <text x="-55.17" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-75</text>
    <text x="-50.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-70</text>
    <text x="-45.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-65</text>
    <text x="-40.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-60</text>
    <text x="-36.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-55</text>
    <text x="-31.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-50</text>
    <text x="-26.49" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-45</text>
    <text x="-21.71" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-40</text>
    <text x="-16.93" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-35</text>
    <text x="-12.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-30</text>
    <text x="-7.36" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-25</text>
    <text x="-2.58" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-20</text>
    <text x="2.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-15</text>
    <text x="6.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-10</text>
    <text x="11.76" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-5</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">0</text>
    <text x="21.32" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">5</text>
    <text x="26.1" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">10</text>
    <text x="30.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">15</text>
    <text x="35.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">20</text>
    <text x="40.44" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">25</text>
    <text x="45.22" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">30</text>
    <text x="50" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">35</text>
    <text x="54.78" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">40</text>
    <text x="59.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">45</text>
    <text x="64.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">50</text>
    <text x="69.12" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">55</text>
    <text x="73.9" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">60</text>
    <text x="78.68" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">65</text>
    <text x="83.46" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">70</text>
    <text x="88.24" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">75</text>
    <text x="93.03" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">80</text>
    <text x="97.81" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">85</text>
    <text x="102.59" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">90</text>
    <text x="107.37" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">95</text>
    <text x="112.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">100</text>
    <text x="116.93" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">105</text>
    <text x="121.71" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">110</text>
    <text x="126.49" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">115</text>
    <text x="131.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">120</text>
    <text x="136.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">125</text>
    <text x="140.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">130</text>
    <text x="145.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">135</text>
    <text x="150.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">140</text>
    <text x="155.17" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">145</text>
    <text x="159.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">150</text>
    <text x="164.73" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">155</text>
    <text x="169.51" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">160</text>
    <text x="174.29" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">165</text>
    <text x="179.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">170</text>
    <text x="183.85" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">175</text>
    <text x="188.63" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">180</text>
    <text x="193.42" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">185</text>
    <text x="198.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">190</text>
    <text x="202.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">195</text>
    <text x="207.76" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">200</text>
    <text x="-79.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">-100</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="112.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">100</text>
    <text x="207.76" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">200</text>
    <text x="-79.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-100</text>
    <text x="-69.51" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-90</text>
    <text x="-59.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-80</text>
    <text x="-50.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-70</text>
    <text x="-40.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-60</text>
    <text x="-31.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-50</text>
    <text x="-21.71" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-40</text>
    <text x="-12.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-30</text>
    <text x="-2.58" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-20</text>
    <text x="6.98" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-10</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">0</text>
    <text x="26.1" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">10</text>
    <text x="35.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">20</text>
    <text x="45.22" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">30</text>
    <text x="54.78" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">40</text>
    <text x="64.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">50</text>
    <text x="73.9" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">60</text>
    <text x="83.46" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">70</text>
    <text x="93.03" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">80</text>
    <text x="102.59" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">90</text>
    <text x="112.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">100</text>
    <text x="121.71" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">110</text>
    <text x="131.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">120</text>
    <text x="140.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">130</text>
    <text x="150.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">140</text>
    <text x="159.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">150</text>
    <text x="169.51" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">160</text>
    <text x="179.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">170</text>
    <text x="188.63" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">180</text>
    <text x="198.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">190</text>
    <text x="207.76" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">200</text>
  </g>
  <g class="guide colorkey" id="img-ff422800-4">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-ff422800-5">
      <text x="117.95" y="40.01" dy="0.35em" id="img-ff422800-6" class="color_Signal_1">Signal 1</text>
      <text x="117.95" y="43.62" dy="0.35em" id="img-ff422800-7" class="color_Signal_2">Signal 2</text>
      <text x="117.95" y="47.22" dy="0.35em" id="img-ff422800-8" class="color_Signal_3">Signal 3</text>
      <text x="117.95" y="50.83" dy="0.35em" id="img-ff422800-9" class="color_Signal_4">Signal 4</text>
    </g>
    <g stroke="#000000" stroke-opacity="0.000" id="img-ff422800-10">
      <rect x="115.15" y="39.11" width="1.8" height="1.8" id="img-ff422800-11" class="color_Signal_1" fill="#00BFFF"/>
      <rect x="115.15" y="42.72" width="1.8" height="1.8" id="img-ff422800-12" class="color_Signal_2" fill="#D4CA3A"/>
      <rect x="115.15" y="46.32" width="1.8" height="1.8" id="img-ff422800-13" class="color_Signal_3" fill="#FF6DAE"/>
      <rect x="115.15" y="49.93" width="1.8" height="1.8" id="img-ff422800-14" class="color_Signal_4" fill="#00B78D"/>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-ff422800-15">
      <text x="115.15" y="36.19" id="img-ff422800-16">Mixed signals</text>
    </g>
  </g>
<g clip-path="url(#img-ff422800-17)">
  <g id="img-ff422800-18">
    <g pointer-events="visible" opacity="1" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-ff422800-19">
      <rect x="14.54" y="5" width="99.61" height="77.23" id="img-ff422800-20"/>
    </g>
    <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-ff422800-21">
      <path fill="none" d="M14.54,177.88 L 114.15 177.88" id="img-ff422800-22" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,153.47 L 114.15 153.47" id="img-ff422800-23" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,129.06 L 114.15 129.06" id="img-ff422800-24" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,104.65 L 114.15 104.65" id="img-ff422800-25" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,80.23 L 114.15 80.23" id="img-ff422800-26" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,55.82 L 114.15 55.82" id="img-ff422800-27" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,31.41 L 114.15 31.41" id="img-ff422800-28" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,7 L 114.15 7" id="img-ff422800-29" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-17.41 L 114.15 -17.41" id="img-ff422800-30" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-41.82 L 114.15 -41.82" id="img-ff422800-31" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-66.23 L 114.15 -66.23" id="img-ff422800-32" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-90.65 L 114.15 -90.65" id="img-ff422800-33" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,153.47 L 114.15 153.47" id="img-ff422800-34" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,151.03 L 114.15 151.03" id="img-ff422800-35" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,148.59 L 114.15 148.59" id="img-ff422800-36" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,146.15 L 114.15 146.15" id="img-ff422800-37" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,143.7 L 114.15 143.7" id="img-ff422800-38" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,141.26 L 114.15 141.26" id="img-ff422800-39" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,138.82 L 114.15 138.82" id="img-ff422800-40" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,136.38 L 114.15 136.38" id="img-ff422800-41" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,133.94 L 114.15 133.94" id="img-ff422800-42" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,131.5 L 114.15 131.5" id="img-ff422800-43" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,129.06 L 114.15 129.06" id="img-ff422800-44" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,126.62 L 114.15 126.62" id="img-ff422800-45" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,124.18 L 114.15 124.18" id="img-ff422800-46" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,121.73 L 114.15 121.73" id="img-ff422800-47" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,119.29 L 114.15 119.29" id="img-ff422800-48" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,116.85 L 114.15 116.85" id="img-ff422800-49" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,114.41 L 114.15 114.41" id="img-ff422800-50" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,111.97 L 114.15 111.97" id="img-ff422800-51" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,109.53 L 114.15 109.53" id="img-ff422800-52" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,107.09 L 114.15 107.09" id="img-ff422800-53" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,104.65 L 114.15 104.65" id="img-ff422800-54" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,102.2 L 114.15 102.2" id="img-ff422800-55" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,99.76 L 114.15 99.76" id="img-ff422800-56" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,97.32 L 114.15 97.32" id="img-ff422800-57" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,94.88 L 114.15 94.88" id="img-ff422800-58" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,92.44 L 114.15 92.44" id="img-ff422800-59" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,90 L 114.15 90" id="img-ff422800-60" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,87.56 L 114.15 87.56" id="img-ff422800-61" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,85.12 L 114.15 85.12" id="img-ff422800-62" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,82.68 L 114.15 82.68" id="img-ff422800-63" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,80.23 L 114.15 80.23" id="img-ff422800-64" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,77.79 L 114.15 77.79" id="img-ff422800-65" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,75.35 L 114.15 75.35" id="img-ff422800-66" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,72.91 L 114.15 72.91" id="img-ff422800-67" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,70.47 L 114.15 70.47" id="img-ff422800-68" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,68.03 L 114.15 68.03" id="img-ff422800-69" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,65.59 L 114.15 65.59" id="img-ff422800-70" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,63.15 L 114.15 63.15" id="img-ff422800-71" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,60.71 L 114.15 60.71" id="img-ff422800-72" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,58.26 L 114.15 58.26" id="img-ff422800-73" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,55.82 L 114.15 55.82" id="img-ff422800-74" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,53.38 L 114.15 53.38" id="img-ff422800-75" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,50.94 L 114.15 50.94" id="img-ff422800-76" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,48.5 L 114.15 48.5" id="img-ff422800-77" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,46.06 L 114.15 46.06" id="img-ff422800-78" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,43.62 L 114.15 43.62" id="img-ff422800-79" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,41.18 L 114.15 41.18" id="img-ff422800-80" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,38.73 L 114.15 38.73" id="img-ff422800-81" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,36.29 L 114.15 36.29" id="img-ff422800-82" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,33.85 L 114.15 33.85" id="img-ff422800-83" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,31.41 L 114.15 31.41" id="img-ff422800-84" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,28.97 L 114.15 28.97" id="img-ff422800-85" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,26.53 L 114.15 26.53" id="img-ff422800-86" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,24.09 L 114.15 24.09" id="img-ff422800-87" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,21.65 L 114.15 21.65" id="img-ff422800-88" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,19.21 L 114.15 19.21" id="img-ff422800-89" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,16.76 L 114.15 16.76" id="img-ff422800-90" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,14.32 L 114.15 14.32" id="img-ff422800-91" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,11.88 L 114.15 11.88" id="img-ff422800-92" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,9.44 L 114.15 9.44" id="img-ff422800-93" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,7 L 114.15 7" id="img-ff422800-94" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,4.56 L 114.15 4.56" id="img-ff422800-95" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,2.12 L 114.15 2.12" id="img-ff422800-96" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-0.32 L 114.15 -0.32" id="img-ff422800-97" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-2.76 L 114.15 -2.76" id="img-ff422800-98" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-5.21 L 114.15 -5.21" id="img-ff422800-99" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-7.65 L 114.15 -7.65" id="img-ff422800-100" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-10.09 L 114.15 -10.09" id="img-ff422800-101" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-12.53 L 114.15 -12.53" id="img-ff422800-102" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-14.97 L 114.15 -14.97" id="img-ff422800-103" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-17.41 L 114.15 -17.41" id="img-ff422800-104" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-19.85 L 114.15 -19.85" id="img-ff422800-105" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-22.29 L 114.15 -22.29" id="img-ff422800-106" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-24.73 L 114.15 -24.73" id="img-ff422800-107" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-27.18 L 114.15 -27.18" id="img-ff422800-108" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-29.62 L 114.15 -29.62" id="img-ff422800-109" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-32.06 L 114.15 -32.06" id="img-ff422800-110" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-34.5 L 114.15 -34.5" id="img-ff422800-111" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-36.94 L 114.15 -36.94" id="img-ff422800-112" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-39.38 L 114.15 -39.38" id="img-ff422800-113" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-41.82 L 114.15 -41.82" id="img-ff422800-114" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-44.26 L 114.15 -44.26" id="img-ff422800-115" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-46.71 L 114.15 -46.71" id="img-ff422800-116" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-49.15 L 114.15 -49.15" id="img-ff422800-117" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-51.59 L 114.15 -51.59" id="img-ff422800-118" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-54.03 L 114.15 -54.03" id="img-ff422800-119" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-56.47 L 114.15 -56.47" id="img-ff422800-120" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-58.91 L 114.15 -58.91" id="img-ff422800-121" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-61.35 L 114.15 -61.35" id="img-ff422800-122" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-63.79 L 114.15 -63.79" id="img-ff422800-123" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-66.23 L 114.15 -66.23" id="img-ff422800-124" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,153.47 L 114.15 153.47" id="img-ff422800-125" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,80.23 L 114.15 80.23" id="img-ff422800-126" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,7 L 114.15 7" id="img-ff422800-127" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,-66.23 L 114.15 -66.23" id="img-ff422800-128" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,153.47 L 114.15 153.47" id="img-ff422800-129" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,148.59 L 114.15 148.59" id="img-ff422800-130" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,143.7 L 114.15 143.7" id="img-ff422800-131" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,138.82 L 114.15 138.82" id="img-ff422800-132" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,133.94 L 114.15 133.94" id="img-ff422800-133" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,129.06 L 114.15 129.06" id="img-ff422800-134" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,124.18 L 114.15 124.18" id="img-ff422800-135" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,119.29 L 114.15 119.29" id="img-ff422800-136" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,114.41 L 114.15 114.41" id="img-ff422800-137" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,109.53 L 114.15 109.53" id="img-ff422800-138" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,104.65 L 114.15 104.65" id="img-ff422800-139" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,99.76 L 114.15 99.76" id="img-ff422800-140" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,94.88 L 114.15 94.88" id="img-ff422800-141" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,90 L 114.15 90" id="img-ff422800-142" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,85.12 L 114.15 85.12" id="img-ff422800-143" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,80.23 L 114.15 80.23" id="img-ff422800-144" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,75.35 L 114.15 75.35" id="img-ff422800-145" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,70.47 L 114.15 70.47" id="img-ff422800-146" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,65.59 L 114.15 65.59" id="img-ff422800-147" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,60.71 L 114.15 60.71" id="img-ff422800-148" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,55.82 L 114.15 55.82" id="img-ff422800-149" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,50.94 L 114.15 50.94" id="img-ff422800-150" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,46.06 L 114.15 46.06" id="img-ff422800-151" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,41.18 L 114.15 41.18" id="img-ff422800-152" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,36.29 L 114.15 36.29" id="img-ff422800-153" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,31.41 L 114.15 31.41" id="img-ff422800-154" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,26.53 L 114.15 26.53" id="img-ff422800-155" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,21.65 L 114.15 21.65" id="img-ff422800-156" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,16.76 L 114.15 16.76" id="img-ff422800-157" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,11.88 L 114.15 11.88" id="img-ff422800-158" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,7 L 114.15 7" id="img-ff422800-159" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,2.12 L 114.15 2.12" id="img-ff422800-160" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-2.76 L 114.15 -2.76" id="img-ff422800-161" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-7.65 L 114.15 -7.65" id="img-ff422800-162" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-12.53 L 114.15 -12.53" id="img-ff422800-163" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-17.41 L 114.15 -17.41" id="img-ff422800-164" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-22.29 L 114.15 -22.29" id="img-ff422800-165" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-27.18 L 114.15 -27.18" id="img-ff422800-166" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-32.06 L 114.15 -32.06" id="img-ff422800-167" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-36.94 L 114.15 -36.94" id="img-ff422800-168" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-41.82 L 114.15 -41.82" id="img-ff422800-169" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-46.71 L 114.15 -46.71" id="img-ff422800-170" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-51.59 L 114.15 -51.59" id="img-ff422800-171" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-56.47 L 114.15 -56.47" id="img-ff422800-172" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-61.35 L 114.15 -61.35" id="img-ff422800-173" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-66.23 L 114.15 -66.23" id="img-ff422800-174" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-ff422800-175">
      <path fill="none" d="M-126.88,5 L -126.88 82.23" id="img-ff422800-176" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-79.07,5 L -79.07 82.23" id="img-ff422800-177" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-31.27,5 L -31.27 82.23" id="img-ff422800-178" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-ff422800-179" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M64.34,5 L 64.34 82.23" id="img-ff422800-180" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M112.15,5 L 112.15 82.23" id="img-ff422800-181" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M159.95,5 L 159.95 82.23" id="img-ff422800-182" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M207.76,5 L 207.76 82.23" id="img-ff422800-183" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M255.56,5 L 255.56 82.23" id="img-ff422800-184" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-79.07,5 L -79.07 82.23" id="img-ff422800-185" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-74.29,5 L -74.29 82.23" id="img-ff422800-186" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-69.51,5 L -69.51 82.23" id="img-ff422800-187" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-64.73,5 L -64.73 82.23" id="img-ff422800-188" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-59.95,5 L -59.95 82.23" id="img-ff422800-189" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-55.17,5 L -55.17 82.23" id="img-ff422800-190" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-50.39,5 L -50.39 82.23" id="img-ff422800-191" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-45.61,5 L -45.61 82.23" id="img-ff422800-192" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-40.83,5 L -40.83 82.23" id="img-ff422800-193" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-36.05,5 L -36.05 82.23" id="img-ff422800-194" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-31.27,5 L -31.27 82.23" id="img-ff422800-195" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-26.49,5 L -26.49 82.23" id="img-ff422800-196" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-21.71,5 L -21.71 82.23" id="img-ff422800-197" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-16.93,5 L -16.93 82.23" id="img-ff422800-198" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-12.15,5 L -12.15 82.23" id="img-ff422800-199" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-7.36,5 L -7.36 82.23" id="img-ff422800-200" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-2.58,5 L -2.58 82.23" id="img-ff422800-201" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M2.2,5 L 2.2 82.23" id="img-ff422800-202" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M6.98,5 L 6.98 82.23" id="img-ff422800-203" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M11.76,5 L 11.76 82.23" id="img-ff422800-204" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-ff422800-205" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M21.32,5 L 21.32 82.23" id="img-ff422800-206" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M26.1,5 L 26.1 82.23" id="img-ff422800-207" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M30.88,5 L 30.88 82.23" id="img-ff422800-208" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M35.66,5 L 35.66 82.23" id="img-ff422800-209" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M40.44,5 L 40.44 82.23" id="img-ff422800-210" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M45.22,5 L 45.22 82.23" id="img-ff422800-211" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M50,5 L 50 82.23" id="img-ff422800-212" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M54.78,5 L 54.78 82.23" id="img-ff422800-213" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M59.56,5 L 59.56 82.23" id="img-ff422800-214" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M64.34,5 L 64.34 82.23" id="img-ff422800-215" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M69.12,5 L 69.12 82.23" id="img-ff422800-216" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M73.9,5 L 73.9 82.23" id="img-ff422800-217" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M78.68,5 L 78.68 82.23" id="img-ff422800-218" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M83.46,5 L 83.46 82.23" id="img-ff422800-219" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M88.24,5 L 88.24 82.23" id="img-ff422800-220" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M93.03,5 L 93.03 82.23" id="img-ff422800-221" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M97.81,5 L 97.81 82.23" id="img-ff422800-222" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M102.59,5 L 102.59 82.23" id="img-ff422800-223" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M107.37,5 L 107.37 82.23" id="img-ff422800-224" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M112.15,5 L 112.15 82.23" id="img-ff422800-225" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M116.93,5 L 116.93 82.23" id="img-ff422800-226" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M121.71,5 L 121.71 82.23" id="img-ff422800-227" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M126.49,5 L 126.49 82.23" id="img-ff422800-228" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M131.27,5 L 131.27 82.23" id="img-ff422800-229" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M136.05,5 L 136.05 82.23" id="img-ff422800-230" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M140.83,5 L 140.83 82.23" id="img-ff422800-231" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M145.61,5 L 145.61 82.23" id="img-ff422800-232" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M150.39,5 L 150.39 82.23" id="img-ff422800-233" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M155.17,5 L 155.17 82.23" id="img-ff422800-234" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M159.95,5 L 159.95 82.23" id="img-ff422800-235" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M164.73,5 L 164.73 82.23" id="img-ff422800-236" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M169.51,5 L 169.51 82.23" id="img-ff422800-237" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M174.29,5 L 174.29 82.23" id="img-ff422800-238" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M179.07,5 L 179.07 82.23" id="img-ff422800-239" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M183.85,5 L 183.85 82.23" id="img-ff422800-240" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M188.63,5 L 188.63 82.23" id="img-ff422800-241" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M193.42,5 L 193.42 82.23" id="img-ff422800-242" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M198.2,5 L 198.2 82.23" id="img-ff422800-243" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M202.98,5 L 202.98 82.23" id="img-ff422800-244" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M207.76,5 L 207.76 82.23" id="img-ff422800-245" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-79.07,5 L -79.07 82.23" id="img-ff422800-246" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-ff422800-247" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M112.15,5 L 112.15 82.23" id="img-ff422800-248" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M207.76,5 L 207.76 82.23" id="img-ff422800-249" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M-79.07,5 L -79.07 82.23" id="img-ff422800-250" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-69.51,5 L -69.51 82.23" id="img-ff422800-251" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-59.95,5 L -59.95 82.23" id="img-ff422800-252" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-50.39,5 L -50.39 82.23" id="img-ff422800-253" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-40.83,5 L -40.83 82.23" id="img-ff422800-254" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-31.27,5 L -31.27 82.23" id="img-ff422800-255" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-21.71,5 L -21.71 82.23" id="img-ff422800-256" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-12.15,5 L -12.15 82.23" id="img-ff422800-257" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-2.58,5 L -2.58 82.23" id="img-ff422800-258" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M6.98,5 L 6.98 82.23" id="img-ff422800-259" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-ff422800-260" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M26.1,5 L 26.1 82.23" id="img-ff422800-261" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M35.66,5 L 35.66 82.23" id="img-ff422800-262" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M45.22,5 L 45.22 82.23" id="img-ff422800-263" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M54.78,5 L 54.78 82.23" id="img-ff422800-264" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M64.34,5 L 64.34 82.23" id="img-ff422800-265" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M73.9,5 L 73.9 82.23" id="img-ff422800-266" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M83.46,5 L 83.46 82.23" id="img-ff422800-267" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M93.03,5 L 93.03 82.23" id="img-ff422800-268" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M102.59,5 L 102.59 82.23" id="img-ff422800-269" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M112.15,5 L 112.15 82.23" id="img-ff422800-270" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M121.71,5 L 121.71 82.23" id="img-ff422800-271" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M131.27,5 L 131.27 82.23" id="img-ff422800-272" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M140.83,5 L 140.83 82.23" id="img-ff422800-273" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M150.39,5 L 150.39 82.23" id="img-ff422800-274" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M159.95,5 L 159.95 82.23" id="img-ff422800-275" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M169.51,5 L 169.51 82.23" id="img-ff422800-276" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M179.07,5 L 179.07 82.23" id="img-ff422800-277" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M188.63,5 L 188.63 82.23" id="img-ff422800-278" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M198.2,5 L 198.2 82.23" id="img-ff422800-279" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M207.76,5 L 207.76 82.23" id="img-ff422800-280" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="plotpanel" id="img-ff422800-281">
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_4" stroke-dasharray="none" stroke="#00B78D" id="img-ff422800-282">
        <path fill="none" d="M17.49,35.79 L 18.45 28.61 19.41 22.67 20.36 18.44 21.32 16.25 22.27 16.24 23.23 18.36 24.19 22.38 25.14 27.88 26.1 34.32 27.05 41.09 28.01 47.53 28.97 53.02 29.92 57.03 30.88 59.16 31.84 59.18 32.79 57.05 33.75 52.92 34.7 47.13 35.66 40.17 36.62 32.62 37.57 25.13 38.53 18.36 39.48 12.87 40.44 9.14 41.4 7.48 42.35 8.03 43.31 10.73 44.26 15.32 45.22 21.38 46.18 28.38 47.13 35.67 48.09 42.62 49.04 48.6 50 53.08 50.96 55.68 51.91 56.16 52.87 54.51 53.83 50.88 54.78 45.62 55.74 39.21 56.69 32.26 57.65 25.41 58.61 19.3 59.56 14.5 60.52 11.48 61.47 10.54 62.43 11.8 63.39 15.19 64.34 20.44 65.3 27.13 66.25 34.69 67.21 42.51 68.17 49.93 69.12 56.33 70.08 61.2 71.04 64.13 71.99 64.93 72.95 63.57 73.9 60.23 74.86 55.25 75.82 49.14 76.77 42.49 77.73 35.95 78.68 30.16 79.64 25.68 80.6 22.97 81.55 22.33 82.51 23.86 83.46 27.47 84.42 32.9 85.38 39.71 86.33 47.34 87.29 55.15 88.24 62.49 89.2 68.75 90.16 73.41 91.11 76.1 92.07 76.62 93.03 74.96 93.98 71.3 94.94 66 95.89 59.57 96.85 52.61 97.81 45.78 98.76 39.69 99.72 34.93 100.67 31.94 101.63 30.99 102.59 32.2 103.54 35.47 104.5 40.5 105.45 46.87 106.41 54.01 107.37 61.28 108.32 68.03 109.28 73.65 110.23 77.64 111.19 79.63 112.15 79.44" id="img-ff422800-283"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_3" stroke-dasharray="none" stroke="#FF6DAE" id="img-ff422800-284">
        <path fill="none" d="M17.49,42.11 L 18.45 54.63 19.41 54.25 20.36 50.74 21.32 63.02 22.27 51.82 23.23 59.6 24.19 20.2 25.14 21.19 26.1 51.59 27.05 45.36 28.01 47.18 28.97 17.23 29.92 43.13 30.88 55.15 31.84 18.9 32.79 50.86 33.75 43.87 34.7 56.8 35.66 39.94 36.62 18.69 37.57 16.74 38.53 34.86 39.48 45.08 40.44 54.25 41.4 45.86 42.35 50.86 43.31 12.9 44.26 28.39 45.22 26.89 46.18 44.64 47.13 44.8 48.09 40.24 49.04 26.26 50 23 50.96 45.29 51.91 31.72 52.87 53.25 53.83 55.1 54.78 39.63 55.74 36.9 56.69 38.32 57.65 17.61 58.61 43.23 59.56 54.02 60.52 10.65 61.47 38.64 62.43 47.51 63.39 23.03 64.34 40.93 65.3 32.3 66.25 23.25 67.21 52.01 68.17 30.23 69.12 22.37 70.08 47.23 71.04 19.18 71.99 30.94 72.95 47.4 73.9 32.78 74.86 43.67 75.82 59.16 76.77 46.93 77.73 28.44 78.68 30.55 79.64 49.66 80.6 64.71 81.55 22.78 82.51 29.65 83.46 37.61 84.42 43.83 85.38 30.47 86.33 42.92 87.29 33.12 88.24 47.46 89.2 32.21 90.16 42.53 91.11 40.47 92.07 70.55 93.03 28.85 93.98 64.75 94.94 45.1 95.89 75.18 96.85 68.02 97.81 31.99 98.76 77.76 99.72 78.95 100.67 41.07 101.63 51.63 102.59 33.27 103.54 49.62 104.5 35.51 105.45 51.95 106.41 55.04 107.37 59.95 108.32 33.24 109.28 41.26 110.23 44.05 111.19 47.99 112.15 50.05" id="img-ff422800-285"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_2" stroke-dasharray="none" stroke="#D4CA3A" id="img-ff422800-286">
        <path fill="none" d="M17.49,35.95 L 18.45 35.95 19.41 30.73 20.36 25.64 21.32 30.48 22.27 25.75 23.23 32.63 24.19 17.79 25.14 24.63 26.1 47.08 27.05 51.53 28.01 59.65 28.97 50.9 29.92 68.58 30.88 77.41 31.84 59.96 32.79 74.42 33.75 67.39 34.7 68.62 35.66 53.73 36.62 36.04 37.57 28.01 38.53 30.69 39.48 30.66 40.44 31.83 41.4 26.24 42.35 29.52 43.31 13.41 44.26 25.88 45.22 31.28 46.18 47.19 47.13 54.56 48.09 59.18 49.04 58.08 50 60.79 50.96 74.34 51.91 67.81 52.87 76.65 53.83 73.63 54.78 60.27 55.74 52.1 56.69 45.42 57.65 27.73 58.61 33.9 59.56 33.95 60.52 8.65 61.47 21.08 62.43 26.11 63.39 16.57 64.34 30.05 65.3 31.68 66.25 33.95 67.21 55.35 68.17 51.06 69.12 52.7 70.08 69.14 71.04 57.17 71.99 62.97 72.95 68.95 73.9 57.39 74.86 56.95 75.82 57.67 76.77 43.99 77.73 27.29 78.68 21.64 79.64 25.81 80.6 29.73 81.55 7.23 82.51 11.32 83.46 18.05 84.42 25.74 85.38 25.03 86.33 38.08 87.29 40.2 88.24 53.94 89.2 51.84 90.16 60.95 91.11 61.94 92.07 76.85 93.03 53.72 93.98 67.43 94.94 51.76 95.89 59.87 96.85 48.86 97.81 23.58 98.76 39.99 99.72 35.48 100.67 13.24 101.63 17.32 102.59 9.13 103.54 20.4 104.5 18.26 105.45 32.77 106.41 41.41 107.37 51.15 108.32 44.6 109.28 54.33 110.23 59.87 111.19 64.03 112.15 65.1" id="img-ff422800-287"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_1" stroke-dasharray="none" stroke="#00BFFF" id="img-ff422800-288">
        <path fill="none" d="M17.49,38.95 L 18.45 41.62 19.41 38.46 20.36 34.59 21.32 39.63 22.27 34.03 23.23 38.98 24.19 21.29 25.14 24.53 26.1 42.96 27.05 43.22 28.01 47.36 28.97 35.12 29.92 50.08 30.88 57.16 31.84 39.04 32.79 53.95 33.75 48.39 34.7 51.97 35.66 40.05 36.62 25.66 37.57 20.94 38.53 26.61 39.48 28.97 40.44 31.69 41.4 26.67 42.35 29.45 43.31 11.81 44.26 21.85 45.22 24.13 46.18 36.51 47.13 40.24 48.09 41.43 49.04 37.43 50 38.04 50.96 50.49 51.91 43.94 52.87 53.88 53.83 52.99 54.78 42.62 55.74 38.06 56.69 35.29 57.65 21.51 58.61 31.26 59.56 34.26 60.52 11.06 61.47 24.59 62.43 29.65 63.39 19.11 64.34 30.68 65.3 29.71 66.25 28.97 67.21 47.26 68.17 40.08 69.12 39.35 70.08 54.21 71.04 41.65 71.99 47.94 72.95 55.49 73.9 46.5 74.86 49.46 75.82 54.15 76.77 44.71 77.73 32.19 78.68 30.35 79.64 37.67 80.6 43.84 81.55 22.56 82.51 26.75 83.46 32.54 84.42 38.37 85.38 35.09 86.33 45.13 87.29 44.13 88.24 54.97 89.2 50.48 90.16 57.97 91.11 58.29 92.07 73.58 93.03 51.91 93.98 68.03 94.94 55.55 95.89 67.38 96.85 60.32 97.81 38.88 98.76 58.72 99.72 56.94 100.67 36.5 101.63 41.31 102.59 32.74 103.54 42.55 104.5 38.01 105.45 49.41 106.41 54.53 107.37 60.61 108.32 50.63 109.28 57.45 110.23 60.85 111.19 63.81 112.15 64.75" id="img-ff422800-289"/>
      </g>
    </g>
    <g opacity="0" class="guide zoomslider" stroke="#000000" stroke-opacity="0.000" id="img-ff422800-290">
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-ff422800-291">
        <rect x="107.15" y="8" width="4" height="4" id="img-ff422800-292"/>
        <g class="button_logo" fill="#6A6A6A" id="img-ff422800-293">
          <path d="M107.95,9.6 L 108.75 9.6 108.75 8.8 109.55 8.8 109.55 9.6 110.35 9.6 110.35 10.4 109.55 10.4 109.55 11.2 108.75 11.2 108.75 10.4 107.95 10.4 z" id="img-ff422800-294"/>
        </g>
      </g>
      <g fill="#EAEAEA" id="img-ff422800-295">
        <rect x="87.65" y="8" width="19" height="4" id="img-ff422800-296"/>
      </g>
      <g class="zoomslider_thumb" fill="#6A6A6A" id="img-ff422800-297">
        <rect x="96.15" y="8" width="2" height="4" id="img-ff422800-298"/>
      </g>
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-ff422800-299">
        <rect x="83.15" y="8" width="4" height="4" id="img-ff422800-300"/>
        <g class="button_logo" fill="#6A6A6A" id="img-ff422800-301">
          <path d="M83.95,9.6 L 86.35 9.6 86.35 10.4 83.95 10.4 z" id="img-ff422800-302"/>
        </g>
      </g>
    </g>
  </g>
</g>
  <g class="guide ylabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-ff422800-303">
    <text x="13.54" y="177.88" text-anchor="end" dy="0.35em" id="img-ff422800-304" visibility="hidden" gadfly:scale="1.0">-4</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-ff422800-305" visibility="hidden" gadfly:scale="1.0">-3</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-ff422800-306" visibility="hidden" gadfly:scale="1.0">-2</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-ff422800-307" visibility="hidden" gadfly:scale="1.0">-1</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-ff422800-308" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-ff422800-309" visibility="visible" gadfly:scale="1.0">1</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-ff422800-310" visibility="visible" gadfly:scale="1.0">2</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-ff422800-311" visibility="visible" gadfly:scale="1.0">3</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-ff422800-312" visibility="hidden" gadfly:scale="1.0">4</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-ff422800-313" visibility="hidden" gadfly:scale="1.0">5</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-ff422800-314" visibility="hidden" gadfly:scale="1.0">6</text>
    <text x="13.54" y="-90.65" text-anchor="end" dy="0.35em" id="img-ff422800-315" visibility="hidden" gadfly:scale="1.0">7</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-ff422800-316" visibility="hidden" gadfly:scale="10.0">-3.0</text>
    <text x="13.54" y="151.03" text-anchor="end" dy="0.35em" id="img-ff422800-317" visibility="hidden" gadfly:scale="10.0">-2.9</text>
    <text x="13.54" y="148.59" text-anchor="end" dy="0.35em" id="img-ff422800-318" visibility="hidden" gadfly:scale="10.0">-2.8</text>
    <text x="13.54" y="146.15" text-anchor="end" dy="0.35em" id="img-ff422800-319" visibility="hidden" gadfly:scale="10.0">-2.7</text>
    <text x="13.54" y="143.7" text-anchor="end" dy="0.35em" id="img-ff422800-320" visibility="hidden" gadfly:scale="10.0">-2.6</text>
    <text x="13.54" y="141.26" text-anchor="end" dy="0.35em" id="img-ff422800-321" visibility="hidden" gadfly:scale="10.0">-2.5</text>
    <text x="13.54" y="138.82" text-anchor="end" dy="0.35em" id="img-ff422800-322" visibility="hidden" gadfly:scale="10.0">-2.4</text>
    <text x="13.54" y="136.38" text-anchor="end" dy="0.35em" id="img-ff422800-323" visibility="hidden" gadfly:scale="10.0">-2.3</text>
    <text x="13.54" y="133.94" text-anchor="end" dy="0.35em" id="img-ff422800-324" visibility="hidden" gadfly:scale="10.0">-2.2</text>
    <text x="13.54" y="131.5" text-anchor="end" dy="0.35em" id="img-ff422800-325" visibility="hidden" gadfly:scale="10.0">-2.1</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-ff422800-326" visibility="hidden" gadfly:scale="10.0">-2.0</text>
    <text x="13.54" y="126.62" text-anchor="end" dy="0.35em" id="img-ff422800-327" visibility="hidden" gadfly:scale="10.0">-1.9</text>
    <text x="13.54" y="124.18" text-anchor="end" dy="0.35em" id="img-ff422800-328" visibility="hidden" gadfly:scale="10.0">-1.8</text>
    <text x="13.54" y="121.73" text-anchor="end" dy="0.35em" id="img-ff422800-329" visibility="hidden" gadfly:scale="10.0">-1.7</text>
    <text x="13.54" y="119.29" text-anchor="end" dy="0.35em" id="img-ff422800-330" visibility="hidden" gadfly:scale="10.0">-1.6</text>
    <text x="13.54" y="116.85" text-anchor="end" dy="0.35em" id="img-ff422800-331" visibility="hidden" gadfly:scale="10.0">-1.5</text>
    <text x="13.54" y="114.41" text-anchor="end" dy="0.35em" id="img-ff422800-332" visibility="hidden" gadfly:scale="10.0">-1.4</text>
    <text x="13.54" y="111.97" text-anchor="end" dy="0.35em" id="img-ff422800-333" visibility="hidden" gadfly:scale="10.0">-1.3</text>
    <text x="13.54" y="109.53" text-anchor="end" dy="0.35em" id="img-ff422800-334" visibility="hidden" gadfly:scale="10.0">-1.2</text>
    <text x="13.54" y="107.09" text-anchor="end" dy="0.35em" id="img-ff422800-335" visibility="hidden" gadfly:scale="10.0">-1.1</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-ff422800-336" visibility="hidden" gadfly:scale="10.0">-1.0</text>
    <text x="13.54" y="102.2" text-anchor="end" dy="0.35em" id="img-ff422800-337" visibility="hidden" gadfly:scale="10.0">-0.9</text>
    <text x="13.54" y="99.76" text-anchor="end" dy="0.35em" id="img-ff422800-338" visibility="hidden" gadfly:scale="10.0">-0.8</text>
    <text x="13.54" y="97.32" text-anchor="end" dy="0.35em" id="img-ff422800-339" visibility="hidden" gadfly:scale="10.0">-0.7</text>
    <text x="13.54" y="94.88" text-anchor="end" dy="0.35em" id="img-ff422800-340" visibility="hidden" gadfly:scale="10.0">-0.6</text>
    <text x="13.54" y="92.44" text-anchor="end" dy="0.35em" id="img-ff422800-341" visibility="hidden" gadfly:scale="10.0">-0.5</text>
    <text x="13.54" y="90" text-anchor="end" dy="0.35em" id="img-ff422800-342" visibility="hidden" gadfly:scale="10.0">-0.4</text>
    <text x="13.54" y="87.56" text-anchor="end" dy="0.35em" id="img-ff422800-343" visibility="hidden" gadfly:scale="10.0">-0.3</text>
    <text x="13.54" y="85.12" text-anchor="end" dy="0.35em" id="img-ff422800-344" visibility="hidden" gadfly:scale="10.0">-0.2</text>
    <text x="13.54" y="82.68" text-anchor="end" dy="0.35em" id="img-ff422800-345" visibility="hidden" gadfly:scale="10.0">-0.1</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-ff422800-346" visibility="hidden" gadfly:scale="10.0">0.0</text>
    <text x="13.54" y="77.79" text-anchor="end" dy="0.35em" id="img-ff422800-347" visibility="hidden" gadfly:scale="10.0">0.1</text>
    <text x="13.54" y="75.35" text-anchor="end" dy="0.35em" id="img-ff422800-348" visibility="hidden" gadfly:scale="10.0">0.2</text>
    <text x="13.54" y="72.91" text-anchor="end" dy="0.35em" id="img-ff422800-349" visibility="hidden" gadfly:scale="10.0">0.3</text>
    <text x="13.54" y="70.47" text-anchor="end" dy="0.35em" id="img-ff422800-350" visibility="hidden" gadfly:scale="10.0">0.4</text>
    <text x="13.54" y="68.03" text-anchor="end" dy="0.35em" id="img-ff422800-351" visibility="hidden" gadfly:scale="10.0">0.5</text>
    <text x="13.54" y="65.59" text-anchor="end" dy="0.35em" id="img-ff422800-352" visibility="hidden" gadfly:scale="10.0">0.6</text>
    <text x="13.54" y="63.15" text-anchor="end" dy="0.35em" id="img-ff422800-353" visibility="hidden" gadfly:scale="10.0">0.7</text>
    <text x="13.54" y="60.71" text-anchor="end" dy="0.35em" id="img-ff422800-354" visibility="hidden" gadfly:scale="10.0">0.8</text>
    <text x="13.54" y="58.26" text-anchor="end" dy="0.35em" id="img-ff422800-355" visibility="hidden" gadfly:scale="10.0">0.9</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-ff422800-356" visibility="hidden" gadfly:scale="10.0">1.0</text>
    <text x="13.54" y="53.38" text-anchor="end" dy="0.35em" id="img-ff422800-357" visibility="hidden" gadfly:scale="10.0">1.1</text>
    <text x="13.54" y="50.94" text-anchor="end" dy="0.35em" id="img-ff422800-358" visibility="hidden" gadfly:scale="10.0">1.2</text>
    <text x="13.54" y="48.5" text-anchor="end" dy="0.35em" id="img-ff422800-359" visibility="hidden" gadfly:scale="10.0">1.3</text>
    <text x="13.54" y="46.06" text-anchor="end" dy="0.35em" id="img-ff422800-360" visibility="hidden" gadfly:scale="10.0">1.4</text>
    <text x="13.54" y="43.62" text-anchor="end" dy="0.35em" id="img-ff422800-361" visibility="hidden" gadfly:scale="10.0">1.5</text>
    <text x="13.54" y="41.18" text-anchor="end" dy="0.35em" id="img-ff422800-362" visibility="hidden" gadfly:scale="10.0">1.6</text>
    <text x="13.54" y="38.73" text-anchor="end" dy="0.35em" id="img-ff422800-363" visibility="hidden" gadfly:scale="10.0">1.7</text>
    <text x="13.54" y="36.29" text-anchor="end" dy="0.35em" id="img-ff422800-364" visibility="hidden" gadfly:scale="10.0">1.8</text>
    <text x="13.54" y="33.85" text-anchor="end" dy="0.35em" id="img-ff422800-365" visibility="hidden" gadfly:scale="10.0">1.9</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-ff422800-366" visibility="hidden" gadfly:scale="10.0">2.0</text>
    <text x="13.54" y="28.97" text-anchor="end" dy="0.35em" id="img-ff422800-367" visibility="hidden" gadfly:scale="10.0">2.1</text>
    <text x="13.54" y="26.53" text-anchor="end" dy="0.35em" id="img-ff422800-368" visibility="hidden" gadfly:scale="10.0">2.2</text>
    <text x="13.54" y="24.09" text-anchor="end" dy="0.35em" id="img-ff422800-369" visibility="hidden" gadfly:scale="10.0">2.3</text>
    <text x="13.54" y="21.65" text-anchor="end" dy="0.35em" id="img-ff422800-370" visibility="hidden" gadfly:scale="10.0">2.4</text>
    <text x="13.54" y="19.21" text-anchor="end" dy="0.35em" id="img-ff422800-371" visibility="hidden" gadfly:scale="10.0">2.5</text>
    <text x="13.54" y="16.76" text-anchor="end" dy="0.35em" id="img-ff422800-372" visibility="hidden" gadfly:scale="10.0">2.6</text>
    <text x="13.54" y="14.32" text-anchor="end" dy="0.35em" id="img-ff422800-373" visibility="hidden" gadfly:scale="10.0">2.7</text>
    <text x="13.54" y="11.88" text-anchor="end" dy="0.35em" id="img-ff422800-374" visibility="hidden" gadfly:scale="10.0">2.8</text>
    <text x="13.54" y="9.44" text-anchor="end" dy="0.35em" id="img-ff422800-375" visibility="hidden" gadfly:scale="10.0">2.9</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-ff422800-376" visibility="hidden" gadfly:scale="10.0">3.0</text>
    <text x="13.54" y="4.56" text-anchor="end" dy="0.35em" id="img-ff422800-377" visibility="hidden" gadfly:scale="10.0">3.1</text>
    <text x="13.54" y="2.12" text-anchor="end" dy="0.35em" id="img-ff422800-378" visibility="hidden" gadfly:scale="10.0">3.2</text>
    <text x="13.54" y="-0.32" text-anchor="end" dy="0.35em" id="img-ff422800-379" visibility="hidden" gadfly:scale="10.0">3.3</text>
    <text x="13.54" y="-2.76" text-anchor="end" dy="0.35em" id="img-ff422800-380" visibility="hidden" gadfly:scale="10.0">3.4</text>
    <text x="13.54" y="-5.21" text-anchor="end" dy="0.35em" id="img-ff422800-381" visibility="hidden" gadfly:scale="10.0">3.5</text>
    <text x="13.54" y="-7.65" text-anchor="end" dy="0.35em" id="img-ff422800-382" visibility="hidden" gadfly:scale="10.0">3.6</text>
    <text x="13.54" y="-10.09" text-anchor="end" dy="0.35em" id="img-ff422800-383" visibility="hidden" gadfly:scale="10.0">3.7</text>
    <text x="13.54" y="-12.53" text-anchor="end" dy="0.35em" id="img-ff422800-384" visibility="hidden" gadfly:scale="10.0">3.8</text>
    <text x="13.54" y="-14.97" text-anchor="end" dy="0.35em" id="img-ff422800-385" visibility="hidden" gadfly:scale="10.0">3.9</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-ff422800-386" visibility="hidden" gadfly:scale="10.0">4.0</text>
    <text x="13.54" y="-19.85" text-anchor="end" dy="0.35em" id="img-ff422800-387" visibility="hidden" gadfly:scale="10.0">4.1</text>
    <text x="13.54" y="-22.29" text-anchor="end" dy="0.35em" id="img-ff422800-388" visibility="hidden" gadfly:scale="10.0">4.2</text>
    <text x="13.54" y="-24.73" text-anchor="end" dy="0.35em" id="img-ff422800-389" visibility="hidden" gadfly:scale="10.0">4.3</text>
    <text x="13.54" y="-27.18" text-anchor="end" dy="0.35em" id="img-ff422800-390" visibility="hidden" gadfly:scale="10.0">4.4</text>
    <text x="13.54" y="-29.62" text-anchor="end" dy="0.35em" id="img-ff422800-391" visibility="hidden" gadfly:scale="10.0">4.5</text>
    <text x="13.54" y="-32.06" text-anchor="end" dy="0.35em" id="img-ff422800-392" visibility="hidden" gadfly:scale="10.0">4.6</text>
    <text x="13.54" y="-34.5" text-anchor="end" dy="0.35em" id="img-ff422800-393" visibility="hidden" gadfly:scale="10.0">4.7</text>
    <text x="13.54" y="-36.94" text-anchor="end" dy="0.35em" id="img-ff422800-394" visibility="hidden" gadfly:scale="10.0">4.8</text>
    <text x="13.54" y="-39.38" text-anchor="end" dy="0.35em" id="img-ff422800-395" visibility="hidden" gadfly:scale="10.0">4.9</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-ff422800-396" visibility="hidden" gadfly:scale="10.0">5.0</text>
    <text x="13.54" y="-44.26" text-anchor="end" dy="0.35em" id="img-ff422800-397" visibility="hidden" gadfly:scale="10.0">5.1</text>
    <text x="13.54" y="-46.71" text-anchor="end" dy="0.35em" id="img-ff422800-398" visibility="hidden" gadfly:scale="10.0">5.2</text>
    <text x="13.54" y="-49.15" text-anchor="end" dy="0.35em" id="img-ff422800-399" visibility="hidden" gadfly:scale="10.0">5.3</text>
    <text x="13.54" y="-51.59" text-anchor="end" dy="0.35em" id="img-ff422800-400" visibility="hidden" gadfly:scale="10.0">5.4</text>
    <text x="13.54" y="-54.03" text-anchor="end" dy="0.35em" id="img-ff422800-401" visibility="hidden" gadfly:scale="10.0">5.5</text>
    <text x="13.54" y="-56.47" text-anchor="end" dy="0.35em" id="img-ff422800-402" visibility="hidden" gadfly:scale="10.0">5.6</text>
    <text x="13.54" y="-58.91" text-anchor="end" dy="0.35em" id="img-ff422800-403" visibility="hidden" gadfly:scale="10.0">5.7</text>
    <text x="13.54" y="-61.35" text-anchor="end" dy="0.35em" id="img-ff422800-404" visibility="hidden" gadfly:scale="10.0">5.8</text>
    <text x="13.54" y="-63.79" text-anchor="end" dy="0.35em" id="img-ff422800-405" visibility="hidden" gadfly:scale="10.0">5.9</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-ff422800-406" visibility="hidden" gadfly:scale="10.0">6.0</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-ff422800-407" visibility="hidden" gadfly:scale="0.5">-3</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-ff422800-408" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-ff422800-409" visibility="hidden" gadfly:scale="0.5">3</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-ff422800-410" visibility="hidden" gadfly:scale="0.5">6</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-ff422800-411" visibility="hidden" gadfly:scale="5.0">-3.0</text>
    <text x="13.54" y="148.59" text-anchor="end" dy="0.35em" id="img-ff422800-412" visibility="hidden" gadfly:scale="5.0">-2.8</text>
    <text x="13.54" y="143.7" text-anchor="end" dy="0.35em" id="img-ff422800-413" visibility="hidden" gadfly:scale="5.0">-2.6</text>
    <text x="13.54" y="138.82" text-anchor="end" dy="0.35em" id="img-ff422800-414" visibility="hidden" gadfly:scale="5.0">-2.4</text>
    <text x="13.54" y="133.94" text-anchor="end" dy="0.35em" id="img-ff422800-415" visibility="hidden" gadfly:scale="5.0">-2.2</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-ff422800-416" visibility="hidden" gadfly:scale="5.0">-2.0</text>
    <text x="13.54" y="124.18" text-anchor="end" dy="0.35em" id="img-ff422800-417" visibility="hidden" gadfly:scale="5.0">-1.8</text>
    <text x="13.54" y="119.29" text-anchor="end" dy="0.35em" id="img-ff422800-418" visibility="hidden" gadfly:scale="5.0">-1.6</text>
    <text x="13.54" y="114.41" text-anchor="end" dy="0.35em" id="img-ff422800-419" visibility="hidden" gadfly:scale="5.0">-1.4</text>
    <text x="13.54" y="109.53" text-anchor="end" dy="0.35em" id="img-ff422800-420" visibility="hidden" gadfly:scale="5.0">-1.2</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-ff422800-421" visibility="hidden" gadfly:scale="5.0">-1.0</text>
    <text x="13.54" y="99.76" text-anchor="end" dy="0.35em" id="img-ff422800-422" visibility="hidden" gadfly:scale="5.0">-0.8</text>
    <text x="13.54" y="94.88" text-anchor="end" dy="0.35em" id="img-ff422800-423" visibility="hidden" gadfly:scale="5.0">-0.6</text>
    <text x="13.54" y="90" text-anchor="end" dy="0.35em" id="img-ff422800-424" visibility="hidden" gadfly:scale="5.0">-0.4</text>
    <text x="13.54" y="85.12" text-anchor="end" dy="0.35em" id="img-ff422800-425" visibility="hidden" gadfly:scale="5.0">-0.2</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-ff422800-426" visibility="hidden" gadfly:scale="5.0">0.0</text>
    <text x="13.54" y="75.35" text-anchor="end" dy="0.35em" id="img-ff422800-427" visibility="hidden" gadfly:scale="5.0">0.2</text>
    <text x="13.54" y="70.47" text-anchor="end" dy="0.35em" id="img-ff422800-428" visibility="hidden" gadfly:scale="5.0">0.4</text>
    <text x="13.54" y="65.59" text-anchor="end" dy="0.35em" id="img-ff422800-429" visibility="hidden" gadfly:scale="5.0">0.6</text>
    <text x="13.54" y="60.71" text-anchor="end" dy="0.35em" id="img-ff422800-430" visibility="hidden" gadfly:scale="5.0">0.8</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-ff422800-431" visibility="hidden" gadfly:scale="5.0">1.0</text>
    <text x="13.54" y="50.94" text-anchor="end" dy="0.35em" id="img-ff422800-432" visibility="hidden" gadfly:scale="5.0">1.2</text>
    <text x="13.54" y="46.06" text-anchor="end" dy="0.35em" id="img-ff422800-433" visibility="hidden" gadfly:scale="5.0">1.4</text>
    <text x="13.54" y="41.18" text-anchor="end" dy="0.35em" id="img-ff422800-434" visibility="hidden" gadfly:scale="5.0">1.6</text>
    <text x="13.54" y="36.29" text-anchor="end" dy="0.35em" id="img-ff422800-435" visibility="hidden" gadfly:scale="5.0">1.8</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-ff422800-436" visibility="hidden" gadfly:scale="5.0">2.0</text>
    <text x="13.54" y="26.53" text-anchor="end" dy="0.35em" id="img-ff422800-437" visibility="hidden" gadfly:scale="5.0">2.2</text>
    <text x="13.54" y="21.65" text-anchor="end" dy="0.35em" id="img-ff422800-438" visibility="hidden" gadfly:scale="5.0">2.4</text>
    <text x="13.54" y="16.76" text-anchor="end" dy="0.35em" id="img-ff422800-439" visibility="hidden" gadfly:scale="5.0">2.6</text>
    <text x="13.54" y="11.88" text-anchor="end" dy="0.35em" id="img-ff422800-440" visibility="hidden" gadfly:scale="5.0">2.8</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-ff422800-441" visibility="hidden" gadfly:scale="5.0">3.0</text>
    <text x="13.54" y="2.12" text-anchor="end" dy="0.35em" id="img-ff422800-442" visibility="hidden" gadfly:scale="5.0">3.2</text>
    <text x="13.54" y="-2.76" text-anchor="end" dy="0.35em" id="img-ff422800-443" visibility="hidden" gadfly:scale="5.0">3.4</text>
    <text x="13.54" y="-7.65" text-anchor="end" dy="0.35em" id="img-ff422800-444" visibility="hidden" gadfly:scale="5.0">3.6</text>
    <text x="13.54" y="-12.53" text-anchor="end" dy="0.35em" id="img-ff422800-445" visibility="hidden" gadfly:scale="5.0">3.8</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-ff422800-446" visibility="hidden" gadfly:scale="5.0">4.0</text>
    <text x="13.54" y="-22.29" text-anchor="end" dy="0.35em" id="img-ff422800-447" visibility="hidden" gadfly:scale="5.0">4.2</text>
    <text x="13.54" y="-27.18" text-anchor="end" dy="0.35em" id="img-ff422800-448" visibility="hidden" gadfly:scale="5.0">4.4</text>
    <text x="13.54" y="-32.06" text-anchor="end" dy="0.35em" id="img-ff422800-449" visibility="hidden" gadfly:scale="5.0">4.6</text>
    <text x="13.54" y="-36.94" text-anchor="end" dy="0.35em" id="img-ff422800-450" visibility="hidden" gadfly:scale="5.0">4.8</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-ff422800-451" visibility="hidden" gadfly:scale="5.0">5.0</text>
    <text x="13.54" y="-46.71" text-anchor="end" dy="0.35em" id="img-ff422800-452" visibility="hidden" gadfly:scale="5.0">5.2</text>
    <text x="13.54" y="-51.59" text-anchor="end" dy="0.35em" id="img-ff422800-453" visibility="hidden" gadfly:scale="5.0">5.4</text>
    <text x="13.54" y="-56.47" text-anchor="end" dy="0.35em" id="img-ff422800-454" visibility="hidden" gadfly:scale="5.0">5.6</text>
    <text x="13.54" y="-61.35" text-anchor="end" dy="0.35em" id="img-ff422800-455" visibility="hidden" gadfly:scale="5.0">5.8</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-ff422800-456" visibility="hidden" gadfly:scale="5.0">6.0</text>
  </g>
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-ff422800-457">
    <text x="9.11" y="43.62" text-anchor="end" dy="0.35em" id="img-ff422800-458">Y</text>
  </g>
</g>
<defs>
  <clipPath id="img-ff422800-17">
  <path d="M14.54,5 L 114.15 5 114.15 82.23 14.54 82.23" />
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

        this.node.addEventListener(
            /Firefox/i.test(navigator.userAgent) ? "DOMMouseScroll" : "mousewheel",
            fn2);

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


// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_zoom = function(event) {
        if (event.which == 187) { // plus
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189) { // minus
            increase_zoom_by_position(root, -0.1, true);
        }
    };
    root.data("keyboard_zoom", keyboard_zoom);
    window.addEventListener("keyup", keyboard_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    xgridlines.data("unfocused_strokedash",
                    xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
    ygridlines.data("unfocused_strokedash",
                    ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));

    // emphasize grid lines
    var destcolor = root.data("focused_xgrid_color");
    xgridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("focused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // reveal zoom slider
    root.select(".zoomslider")
        .animate({opacity: 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_zoom"));
    root.data("keyboard_zoom", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    var destcolor = root.data("unfocused_xgrid_color");

    xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("unfocused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // hide zoom slider
    root.select(".zoomslider")
        .animate({opacity: 0.0}, 250);
};


var set_geometry_transform = function(root, tx, ty, scale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_scale = root.data("scale");

    var xscale = xscalable ? scale : 1.0,
        yscale = yscalable ? scale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);

    root.selectAll(".geometry, image")
        .forEach(function (element, i) {
            element.transform(t);
        });

    bounds = root.plotbounds();

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        root.select(".ylabels")
            .transform(xfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1, 1/scale, cx, cy).add(st);
                    element.transform(unscale_t);

                    var y = cy * scale + ty;
                    element.attr("visibility",
                        bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                }
            });
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        root.select(".xlabels")
            .transform(yfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1/scale, 1, cx, cy).add(st);

                    element.transform(unscale_t);

                    var x = cx * scale + tx;
                    element.attr("visibility",
                        bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                    }
            });
    }

    // we must unscale anything that is scale invariance: widths, raiduses, etc.
    var size_attribs = ["font-size"];
    var unscaled_selection = ".geometry, .geometry *";
    if (xscalable) {
        size_attribs.push("rx");
        unscaled_selection += ", .xgridlines";
    }
    if (yscalable) {
        size_attribs.push("ry");
        unscaled_selection += ", .ygridlines";
    }

    root.selectAll(unscaled_selection)
        .forEach(function (element, i) {
            // circle need special help
            if (element.node.nodeName == "circle") {
                var cx = element.attribute("cx"),
                    cy = element.attribute("cy");
                unscale_t = new Snap.Matrix().scale(1/xscale, 1/yscale,
                                                        cx, cy);
                element.transform(unscale_t);
                return;
            }

            for (i in size_attribs) {
                var key = size_attribs[i];
                var val = parseFloat(element.attribute(key));
                if (val !== undefined && val != 0 && !isNaN(val)) {
                    element.attribute(key, val * old_scale / scale);
                }
            }
        });
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
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("path").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("text").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, scale) {
    var old_scale = root.data("scale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, and scale
    var x_min = -width * scale - (scale * width - width),
        x_max = width * scale,
        y_min = -height * scale - (scale * height - height),
        y_max = height * scale;

    var x0 = bounds.x0 - scale * bounds.x0,
        y0 = bounds.y0 - scale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale change, we may need to alter which set of
    // ticks is being displayed
    if (scale != old_scale) {
        update_tickscale(root, scale, "x");
        update_tickscale(root, scale, "y");
    }

    set_geometry_transform(root, tx, ty, scale);

    root.data("scale", scale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, scale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var scale0 = root.data("scale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - scale0) + (width * (1 - scale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - scale0) + (height * (1 - scale0)) / 2);

    // rescale offsets
    xoff = xoff * scale / scale0;
    yoff = yoff * scale / scale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - scale),
        y_edge_adjust = bounds.y0 * (1 - scale);

    return {
        x: xoff + x_edge_adjust + (width - width * scale) / 2,
        y: yoff + y_edge_adjust + (height - height * scale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

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
    root.selectAll(".xlabels > text, .ylabels > text")
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
    if (root.data("scale") === undefined) root.data("scale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("path").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("path").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("text").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("text").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
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
        xlabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("path").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("path").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("text").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("text").forEach(mark_inscale);

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
            .selectAll("path")
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
            .selectAll("path")
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

        set_plot_pan_zoom(root, tx, ty, root.data("scale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"), root.data("scale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, x, y, event) {
        var bounds = root.plotbounds();
        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var ratio = width / height;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "opacity": 0.25
        });
        zoom_box.data("ratio", ratio);
    },
    update: function(root, dx, dy, x, y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
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
        if (xscalable && yscalable) {
            var ratio = zoom_box.data("ratio");
            var width = Math.min(Math.abs(dx), ratio * Math.abs(dy));
            var height = Math.min(Math.abs(dy), Math.abs(dx) / ratio);
            dx = width * dx / Math.abs(dx);
            dy = height * dy / Math.abs(dy);
        }
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
        var zoom_factor = 1.0;
        if (yscalable) {
            zoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        } else {
            zoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * zoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * zoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty, root.data("scale") * zoom_factor);
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
        increase_zoom_by_position(this.plotroot(), 0.001 * event.wheelDelta);
        event.preventDefault();
    }
};


Gadfly.zoomslider_button_mouseover = function(event) {
    this.select(".button_logo")
         .animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_button_mouseout = function(event) {
     this.select(".button_logo")
         .animate({fill: this.data("mouseout_color")}, 100);
};


Gadfly.zoomslider_zoomout_click = function(event) {
    increase_zoom_by_position(this.plotroot(), -0.1, true);
};


Gadfly.zoomslider_zoomin_click = function(event) {
    increase_zoom_by_position(this.plotroot(), 0.1, true);
};


Gadfly.zoomslider_track_click = function(event) {
    // TODO
};


// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var scale = root.data("scale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var position = slider_position_from_scale(scale, min_scale, max_scale);
    position += delta_position;
    scale = scale_from_slider_position(position, min_scale, max_scale);
    set_zoom(root, scale, animate);
}

var set_zoom = function(root, scale, animate) {
    var min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("scale");
    var new_scale = Math.max(min_scale, Math.min(scale, max_scale));
    if (animate) {
        Snap.animate(
            old_scale,
            new_scale,
            function (new_scale) {
                update_plot_scale(root, new_scale);
            },
            200);
    } else {
        update_plot_scale(root, new_scale);
    }
}


var update_plot_scale = function(root, new_scale) {
    var trans = scale_centered_translation(root, new_scale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_scale);

    root.selectAll(".zoomslider_thumb")
        .forEach(function (element, i) {
            var min_pos = element.data("min_pos"),
                max_pos = element.data("max_pos"),
                min_scale = root.data("min_scale"),
                max_scale = root.data("max_scale");
            var xmid = (min_pos + max_pos) / 2;
            var xpos = slider_position_from_scale(new_scale, min_scale, max_scale);
            element.transform(new Snap.Matrix().translate(
                Math.max(min_pos, Math.min(
                         max_pos, min_pos + (max_pos - min_pos) * xpos)) - xmid, 0));
    });
};


Gadfly.zoomslider_thumb_dragmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var min_pos = this.data("min_pos"),
        max_pos = this.data("max_pos"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("old_scale");

    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var xmid = (min_pos + max_pos) / 2;
    var xpos = slider_position_from_scale(old_scale, min_scale, max_scale) +
                   dx / (max_pos - min_pos);

    // compute the new scale
    var new_scale = scale_from_slider_position(xpos, min_scale, max_scale);
    new_scale = Math.min(max_scale, Math.max(min_scale, new_scale));

    update_plot_scale(root, new_scale);
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragstart = function(x, y, event) {
    this.animate({fill: this.data("mouseover_color")}, 100);
    var root = this.plotroot();

    // keep track of what the scale was when we started dragging
    root.data("old_scale", root.data("scale"));
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragend = function(event) {
    this.animate({fill: this.data("mouseout_color")}, 100);
    event.stopPropagation();
};


var toggle_color_class = function(root, color_class, ison) {
    var guides = root.selectAll(".guide." + color_class + ",.guide ." + color_class);
    var geoms = root.selectAll(".geometry." + color_class + ",.geometry ." + color_class);
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
        root.selectAll(".colorkey text")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (other_color_class != color_class) {
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
    var fig = Snap("#img-ff422800");
fig.select("#img-ff422800-4")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-ff422800-6")
   .data("color_class", "color_Signal_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-7")
   .data("color_class", "color_Signal_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-8")
   .data("color_class", "color_Signal_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-9")
   .data("color_class", "color_Signal_4")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-11")
   .data("color_class", "color_Signal_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-12")
   .data("color_class", "color_Signal_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-13")
   .data("color_class", "color_Signal_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-14")
   .data("color_class", "color_Signal_4")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-ff422800-18")
   .init_gadfly();
fig.select("#img-ff422800-21")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-ff422800-21")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-ff422800-175")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-ff422800-175")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-ff422800-291")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-ff422800-291")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-ff422800-291")
   .click(Gadfly.zoomslider_zoomin_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
fig.select("#img-ff422800-295")
   .data("max_pos", 98.15)
;
fig.select("#img-ff422800-295")
   .data("min_pos", 81.15)
;
fig.select("#img-ff422800-295")
   .click(Gadfly.zoomslider_track_click);
fig.select("#img-ff422800-297")
   .data("max_pos", 98.15)
;
fig.select("#img-ff422800-297")
   .data("min_pos", 81.15)
;
fig.select("#img-ff422800-297")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-ff422800-297")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-ff422800-297")
   .drag(Gadfly.zoomslider_thumb_dragmove,
     Gadfly.zoomslider_thumb_dragstart,
     Gadfly.zoomslider_thumb_dragend)
;
fig.select("#img-ff422800-299")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-ff422800-299")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-ff422800-299")
   .click(Gadfly.zoomslider_zoomout_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
    });
]]> </script>
</svg>




## Blind signal reconstruction


```julia
Wipopt, Hipopt, pipopt = Mads.NMFipopt(X, nk, retries=1);
```

    OF = 4.5864774801052004e-14


## Reconstructed sources


```julia
Mads.plotseries(Wipopt, title="Reconstructed sources", name="Source", combined=true)
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

     id="img-6ade5fa2">
<g class="plotroot xscalable yscalable" id="img-6ade5fa2-1">
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-6ade5fa2-2">
    <text x="58.32" y="89.28" text-anchor="middle" dy="0.6em">X</text>
  </g>
  <g class="guide xlabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-6ade5fa2-3">
    <text x="-99.14" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-150</text>
    <text x="-59.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-100</text>
    <text x="-20.41" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-50</text>
    <text x="18.96" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="58.32" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">50</text>
    <text x="97.69" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">100</text>
    <text x="137.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">150</text>
    <text x="176.42" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">200</text>
    <text x="215.79" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">250</text>
    <text x="-59.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-100</text>
    <text x="-55.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-95</text>
    <text x="-51.9" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-90</text>
    <text x="-47.97" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-85</text>
    <text x="-44.03" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-80</text>
    <text x="-40.09" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-75</text>
    <text x="-36.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-70</text>
    <text x="-32.22" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-65</text>
    <text x="-28.28" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-60</text>
    <text x="-24.35" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-55</text>
    <text x="-20.41" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-50</text>
    <text x="-16.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-45</text>
    <text x="-12.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-40</text>
    <text x="-8.6" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-35</text>
    <text x="-4.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-30</text>
    <text x="-0.73" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-25</text>
    <text x="3.21" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-20</text>
    <text x="7.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-15</text>
    <text x="11.08" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-10</text>
    <text x="15.02" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-5</text>
    <text x="18.96" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">0</text>
    <text x="22.89" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">5</text>
    <text x="26.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">10</text>
    <text x="30.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">15</text>
    <text x="34.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">20</text>
    <text x="38.64" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">25</text>
    <text x="42.58" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">30</text>
    <text x="46.51" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">35</text>
    <text x="50.45" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">40</text>
    <text x="54.39" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">45</text>
    <text x="58.32" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">50</text>
    <text x="62.26" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">55</text>
    <text x="66.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">60</text>
    <text x="70.13" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">65</text>
    <text x="74.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">70</text>
    <text x="78.01" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">75</text>
    <text x="81.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">80</text>
    <text x="85.88" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">85</text>
    <text x="89.82" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">90</text>
    <text x="93.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">95</text>
    <text x="97.69" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">100</text>
    <text x="101.63" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">105</text>
    <text x="105.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">110</text>
    <text x="109.5" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">115</text>
    <text x="113.44" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">120</text>
    <text x="117.37" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">125</text>
    <text x="121.31" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">130</text>
    <text x="125.24" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">135</text>
    <text x="129.18" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">140</text>
    <text x="133.12" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">145</text>
    <text x="137.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">150</text>
    <text x="140.99" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">155</text>
    <text x="144.93" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">160</text>
    <text x="148.86" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">165</text>
    <text x="152.8" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">170</text>
    <text x="156.74" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">175</text>
    <text x="160.67" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">180</text>
    <text x="164.61" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">185</text>
    <text x="168.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">190</text>
    <text x="172.48" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">195</text>
    <text x="176.42" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">200</text>
    <text x="-59.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">-100</text>
    <text x="18.96" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="97.69" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">100</text>
    <text x="176.42" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">200</text>
    <text x="-59.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-100</text>
    <text x="-51.9" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-90</text>
    <text x="-44.03" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-80</text>
    <text x="-36.16" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-70</text>
    <text x="-28.28" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-60</text>
    <text x="-20.41" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-50</text>
    <text x="-12.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-40</text>
    <text x="-4.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-30</text>
    <text x="3.21" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-20</text>
    <text x="11.08" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-10</text>
    <text x="18.96" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">0</text>
    <text x="26.83" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">10</text>
    <text x="34.7" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">20</text>
    <text x="42.58" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">30</text>
    <text x="50.45" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">40</text>
    <text x="58.32" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">50</text>
    <text x="66.2" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">60</text>
    <text x="74.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">70</text>
    <text x="81.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">80</text>
    <text x="89.82" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">90</text>
    <text x="97.69" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">100</text>
    <text x="105.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">110</text>
    <text x="113.44" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">120</text>
    <text x="121.31" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">130</text>
    <text x="129.18" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">140</text>
    <text x="137.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">150</text>
    <text x="144.93" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">160</text>
    <text x="152.8" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">170</text>
    <text x="160.67" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">180</text>
    <text x="168.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">190</text>
    <text x="176.42" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">200</text>
  </g>
  <g class="guide colorkey" id="img-6ade5fa2-4">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-6ade5fa2-5">
      <text x="103.21" y="42.1" dy="0.35em" id="img-6ade5fa2-6" class="color_Source_1">Source 1</text>
      <text x="103.21" y="45.14" dy="0.35em" id="img-6ade5fa2-7" class="color_Source_2">Source 2</text>
      <text x="103.21" y="48.18" dy="0.35em" id="img-6ade5fa2-8" class="color_Source_3">Source 3</text>
    </g>
    <g stroke="#000000" stroke-opacity="0.000" id="img-6ade5fa2-9">
      <rect x="100.69" y="41.33" width="1.52" height="1.52" id="img-6ade5fa2-10" class="color_Source_1" fill="#00BFFF"/>
      <rect x="100.69" y="44.38" width="1.52" height="1.52" id="img-6ade5fa2-11" class="color_Source_2" fill="#D4CA3A"/>
      <rect x="100.69" y="47.42" width="1.52" height="1.52" id="img-6ade5fa2-12" class="color_Source_3" fill="#FF6DAE"/>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-6ade5fa2-13">
      <text x="100.69" y="38.45" id="img-6ade5fa2-14">Reconstructed sources</text>
    </g>
  </g>
<g clip-path="url(#img-6ade5fa2-15)">
  <g id="img-6ade5fa2-16">
    <g pointer-events="visible" opacity="1" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-6ade5fa2-17">
      <rect x="16.96" y="5" width="82.73" height="77.23" id="img-6ade5fa2-18"/>
    </g>
    <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-6ade5fa2-19">
      <path fill="none" d="M16.96,171.78 L 99.69 171.78" id="img-6ade5fa2-20" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,153.47 L 99.69 153.47" id="img-6ade5fa2-21" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,135.16 L 99.69 135.16" id="img-6ade5fa2-22" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,116.85 L 99.69 116.85" id="img-6ade5fa2-23" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,98.54 L 99.69 98.54" id="img-6ade5fa2-24" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,80.23 L 99.69 80.23" id="img-6ade5fa2-25" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,61.93 L 99.69 61.93" id="img-6ade5fa2-26" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,43.62 L 99.69 43.62" id="img-6ade5fa2-27" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,25.31 L 99.69 25.31" id="img-6ade5fa2-28" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,7 L 99.69 7" id="img-6ade5fa2-29" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,-11.31 L 99.69 -11.31" id="img-6ade5fa2-30" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,-29.62 L 99.69 -29.62" id="img-6ade5fa2-31" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,-47.93 L 99.69 -47.93" id="img-6ade5fa2-32" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,-66.23 L 99.69 -66.23" id="img-6ade5fa2-33" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,-84.54 L 99.69 -84.54" id="img-6ade5fa2-34" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.96,158.05 L 99.69 158.05" id="img-6ade5fa2-35" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,153.47 L 99.69 153.47" id="img-6ade5fa2-36" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,148.89 L 99.69 148.89" id="img-6ade5fa2-37" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,144.31 L 99.69 144.31" id="img-6ade5fa2-38" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,139.74 L 99.69 139.74" id="img-6ade5fa2-39" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,135.16 L 99.69 135.16" id="img-6ade5fa2-40" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,130.58 L 99.69 130.58" id="img-6ade5fa2-41" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,126.01 L 99.69 126.01" id="img-6ade5fa2-42" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,121.43 L 99.69 121.43" id="img-6ade5fa2-43" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,116.85 L 99.69 116.85" id="img-6ade5fa2-44" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,112.27 L 99.69 112.27" id="img-6ade5fa2-45" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,107.7 L 99.69 107.7" id="img-6ade5fa2-46" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,103.12 L 99.69 103.12" id="img-6ade5fa2-47" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,98.54 L 99.69 98.54" id="img-6ade5fa2-48" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,93.97 L 99.69 93.97" id="img-6ade5fa2-49" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,89.39 L 99.69 89.39" id="img-6ade5fa2-50" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,84.81 L 99.69 84.81" id="img-6ade5fa2-51" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,80.23 L 99.69 80.23" id="img-6ade5fa2-52" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,75.66 L 99.69 75.66" id="img-6ade5fa2-53" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,71.08 L 99.69 71.08" id="img-6ade5fa2-54" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,66.5 L 99.69 66.5" id="img-6ade5fa2-55" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,61.93 L 99.69 61.93" id="img-6ade5fa2-56" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,57.35 L 99.69 57.35" id="img-6ade5fa2-57" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,52.77 L 99.69 52.77" id="img-6ade5fa2-58" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,48.19 L 99.69 48.19" id="img-6ade5fa2-59" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,43.62 L 99.69 43.62" id="img-6ade5fa2-60" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,39.04 L 99.69 39.04" id="img-6ade5fa2-61" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,34.46 L 99.69 34.46" id="img-6ade5fa2-62" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,29.89 L 99.69 29.89" id="img-6ade5fa2-63" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,25.31 L 99.69 25.31" id="img-6ade5fa2-64" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,20.73 L 99.69 20.73" id="img-6ade5fa2-65" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,16.15 L 99.69 16.15" id="img-6ade5fa2-66" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,11.58 L 99.69 11.58" id="img-6ade5fa2-67" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,7 L 99.69 7" id="img-6ade5fa2-68" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,2.42 L 99.69 2.42" id="img-6ade5fa2-69" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-2.15 L 99.69 -2.15" id="img-6ade5fa2-70" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-6.73 L 99.69 -6.73" id="img-6ade5fa2-71" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-11.31 L 99.69 -11.31" id="img-6ade5fa2-72" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-15.89 L 99.69 -15.89" id="img-6ade5fa2-73" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-20.46 L 99.69 -20.46" id="img-6ade5fa2-74" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-25.04 L 99.69 -25.04" id="img-6ade5fa2-75" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-29.62 L 99.69 -29.62" id="img-6ade5fa2-76" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-34.19 L 99.69 -34.19" id="img-6ade5fa2-77" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-38.77 L 99.69 -38.77" id="img-6ade5fa2-78" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-43.35 L 99.69 -43.35" id="img-6ade5fa2-79" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-47.93 L 99.69 -47.93" id="img-6ade5fa2-80" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-52.5 L 99.69 -52.5" id="img-6ade5fa2-81" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-57.08 L 99.69 -57.08" id="img-6ade5fa2-82" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-61.66 L 99.69 -61.66" id="img-6ade5fa2-83" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,-66.23 L 99.69 -66.23" id="img-6ade5fa2-84" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.96,171.78 L 99.69 171.78" id="img-6ade5fa2-85" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.96,80.23 L 99.69 80.23" id="img-6ade5fa2-86" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.96,-11.31 L 99.69 -11.31" id="img-6ade5fa2-87" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.96,-102.85 L 99.69 -102.85" id="img-6ade5fa2-88" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.96,158.05 L 99.69 158.05" id="img-6ade5fa2-89" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,153.47 L 99.69 153.47" id="img-6ade5fa2-90" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,148.89 L 99.69 148.89" id="img-6ade5fa2-91" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,144.31 L 99.69 144.31" id="img-6ade5fa2-92" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,139.74 L 99.69 139.74" id="img-6ade5fa2-93" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,135.16 L 99.69 135.16" id="img-6ade5fa2-94" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,130.58 L 99.69 130.58" id="img-6ade5fa2-95" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,126.01 L 99.69 126.01" id="img-6ade5fa2-96" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,121.43 L 99.69 121.43" id="img-6ade5fa2-97" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,116.85 L 99.69 116.85" id="img-6ade5fa2-98" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,112.27 L 99.69 112.27" id="img-6ade5fa2-99" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,107.7 L 99.69 107.7" id="img-6ade5fa2-100" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,103.12 L 99.69 103.12" id="img-6ade5fa2-101" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,98.54 L 99.69 98.54" id="img-6ade5fa2-102" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,93.97 L 99.69 93.97" id="img-6ade5fa2-103" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,89.39 L 99.69 89.39" id="img-6ade5fa2-104" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,84.81 L 99.69 84.81" id="img-6ade5fa2-105" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,80.23 L 99.69 80.23" id="img-6ade5fa2-106" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,75.66 L 99.69 75.66" id="img-6ade5fa2-107" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,71.08 L 99.69 71.08" id="img-6ade5fa2-108" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,66.5 L 99.69 66.5" id="img-6ade5fa2-109" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,61.93 L 99.69 61.93" id="img-6ade5fa2-110" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,57.35 L 99.69 57.35" id="img-6ade5fa2-111" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,52.77 L 99.69 52.77" id="img-6ade5fa2-112" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,48.19 L 99.69 48.19" id="img-6ade5fa2-113" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,43.62 L 99.69 43.62" id="img-6ade5fa2-114" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,39.04 L 99.69 39.04" id="img-6ade5fa2-115" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,34.46 L 99.69 34.46" id="img-6ade5fa2-116" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,29.89 L 99.69 29.89" id="img-6ade5fa2-117" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,25.31 L 99.69 25.31" id="img-6ade5fa2-118" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,20.73 L 99.69 20.73" id="img-6ade5fa2-119" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,16.15 L 99.69 16.15" id="img-6ade5fa2-120" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,11.58 L 99.69 11.58" id="img-6ade5fa2-121" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,7 L 99.69 7" id="img-6ade5fa2-122" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,2.42 L 99.69 2.42" id="img-6ade5fa2-123" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-2.15 L 99.69 -2.15" id="img-6ade5fa2-124" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-6.73 L 99.69 -6.73" id="img-6ade5fa2-125" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-11.31 L 99.69 -11.31" id="img-6ade5fa2-126" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-15.89 L 99.69 -15.89" id="img-6ade5fa2-127" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-20.46 L 99.69 -20.46" id="img-6ade5fa2-128" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-25.04 L 99.69 -25.04" id="img-6ade5fa2-129" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-29.62 L 99.69 -29.62" id="img-6ade5fa2-130" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-34.19 L 99.69 -34.19" id="img-6ade5fa2-131" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-38.77 L 99.69 -38.77" id="img-6ade5fa2-132" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-43.35 L 99.69 -43.35" id="img-6ade5fa2-133" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-47.93 L 99.69 -47.93" id="img-6ade5fa2-134" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-52.5 L 99.69 -52.5" id="img-6ade5fa2-135" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-57.08 L 99.69 -57.08" id="img-6ade5fa2-136" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-61.66 L 99.69 -61.66" id="img-6ade5fa2-137" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.96,-66.23 L 99.69 -66.23" id="img-6ade5fa2-138" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-6ade5fa2-139">
      <path fill="none" d="M-99.14,5 L -99.14 82.23" id="img-6ade5fa2-140" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-59.77,5 L -59.77 82.23" id="img-6ade5fa2-141" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-20.41,5 L -20.41 82.23" id="img-6ade5fa2-142" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M18.96,5 L 18.96 82.23" id="img-6ade5fa2-143" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M58.32,5 L 58.32 82.23" id="img-6ade5fa2-144" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M97.69,5 L 97.69 82.23" id="img-6ade5fa2-145" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M137.05,5 L 137.05 82.23" id="img-6ade5fa2-146" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M176.42,5 L 176.42 82.23" id="img-6ade5fa2-147" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M215.79,5 L 215.79 82.23" id="img-6ade5fa2-148" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-59.77,5 L -59.77 82.23" id="img-6ade5fa2-149" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-55.84,5 L -55.84 82.23" id="img-6ade5fa2-150" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-51.9,5 L -51.9 82.23" id="img-6ade5fa2-151" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-47.97,5 L -47.97 82.23" id="img-6ade5fa2-152" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-44.03,5 L -44.03 82.23" id="img-6ade5fa2-153" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-40.09,5 L -40.09 82.23" id="img-6ade5fa2-154" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-36.16,5 L -36.16 82.23" id="img-6ade5fa2-155" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-32.22,5 L -32.22 82.23" id="img-6ade5fa2-156" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-28.28,5 L -28.28 82.23" id="img-6ade5fa2-157" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-24.35,5 L -24.35 82.23" id="img-6ade5fa2-158" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-20.41,5 L -20.41 82.23" id="img-6ade5fa2-159" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-16.47,5 L -16.47 82.23" id="img-6ade5fa2-160" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-12.54,5 L -12.54 82.23" id="img-6ade5fa2-161" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-8.6,5 L -8.6 82.23" id="img-6ade5fa2-162" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-4.66,5 L -4.66 82.23" id="img-6ade5fa2-163" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-0.73,5 L -0.73 82.23" id="img-6ade5fa2-164" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M3.21,5 L 3.21 82.23" id="img-6ade5fa2-165" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M7.15,5 L 7.15 82.23" id="img-6ade5fa2-166" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M11.08,5 L 11.08 82.23" id="img-6ade5fa2-167" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M15.02,5 L 15.02 82.23" id="img-6ade5fa2-168" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M18.96,5 L 18.96 82.23" id="img-6ade5fa2-169" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M22.89,5 L 22.89 82.23" id="img-6ade5fa2-170" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M26.83,5 L 26.83 82.23" id="img-6ade5fa2-171" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M30.77,5 L 30.77 82.23" id="img-6ade5fa2-172" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M34.7,5 L 34.7 82.23" id="img-6ade5fa2-173" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M38.64,5 L 38.64 82.23" id="img-6ade5fa2-174" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M42.58,5 L 42.58 82.23" id="img-6ade5fa2-175" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M46.51,5 L 46.51 82.23" id="img-6ade5fa2-176" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M50.45,5 L 50.45 82.23" id="img-6ade5fa2-177" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M54.39,5 L 54.39 82.23" id="img-6ade5fa2-178" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M58.32,5 L 58.32 82.23" id="img-6ade5fa2-179" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M62.26,5 L 62.26 82.23" id="img-6ade5fa2-180" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M66.2,5 L 66.2 82.23" id="img-6ade5fa2-181" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M70.13,5 L 70.13 82.23" id="img-6ade5fa2-182" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M74.07,5 L 74.07 82.23" id="img-6ade5fa2-183" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M78.01,5 L 78.01 82.23" id="img-6ade5fa2-184" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M81.94,5 L 81.94 82.23" id="img-6ade5fa2-185" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M85.88,5 L 85.88 82.23" id="img-6ade5fa2-186" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M89.82,5 L 89.82 82.23" id="img-6ade5fa2-187" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M93.75,5 L 93.75 82.23" id="img-6ade5fa2-188" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M97.69,5 L 97.69 82.23" id="img-6ade5fa2-189" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M101.63,5 L 101.63 82.23" id="img-6ade5fa2-190" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M105.56,5 L 105.56 82.23" id="img-6ade5fa2-191" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M109.5,5 L 109.5 82.23" id="img-6ade5fa2-192" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M113.44,5 L 113.44 82.23" id="img-6ade5fa2-193" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M117.37,5 L 117.37 82.23" id="img-6ade5fa2-194" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M121.31,5 L 121.31 82.23" id="img-6ade5fa2-195" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M125.24,5 L 125.24 82.23" id="img-6ade5fa2-196" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M129.18,5 L 129.18 82.23" id="img-6ade5fa2-197" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M133.12,5 L 133.12 82.23" id="img-6ade5fa2-198" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M137.05,5 L 137.05 82.23" id="img-6ade5fa2-199" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M140.99,5 L 140.99 82.23" id="img-6ade5fa2-200" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M144.93,5 L 144.93 82.23" id="img-6ade5fa2-201" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M148.86,5 L 148.86 82.23" id="img-6ade5fa2-202" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M152.8,5 L 152.8 82.23" id="img-6ade5fa2-203" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M156.74,5 L 156.74 82.23" id="img-6ade5fa2-204" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M160.67,5 L 160.67 82.23" id="img-6ade5fa2-205" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M164.61,5 L 164.61 82.23" id="img-6ade5fa2-206" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M168.55,5 L 168.55 82.23" id="img-6ade5fa2-207" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M172.48,5 L 172.48 82.23" id="img-6ade5fa2-208" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M176.42,5 L 176.42 82.23" id="img-6ade5fa2-209" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-59.77,5 L -59.77 82.23" id="img-6ade5fa2-210" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M18.96,5 L 18.96 82.23" id="img-6ade5fa2-211" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M97.69,5 L 97.69 82.23" id="img-6ade5fa2-212" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M176.42,5 L 176.42 82.23" id="img-6ade5fa2-213" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M-59.77,5 L -59.77 82.23" id="img-6ade5fa2-214" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-51.9,5 L -51.9 82.23" id="img-6ade5fa2-215" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-44.03,5 L -44.03 82.23" id="img-6ade5fa2-216" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-36.16,5 L -36.16 82.23" id="img-6ade5fa2-217" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-28.28,5 L -28.28 82.23" id="img-6ade5fa2-218" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-20.41,5 L -20.41 82.23" id="img-6ade5fa2-219" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-12.54,5 L -12.54 82.23" id="img-6ade5fa2-220" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-4.66,5 L -4.66 82.23" id="img-6ade5fa2-221" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M3.21,5 L 3.21 82.23" id="img-6ade5fa2-222" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M11.08,5 L 11.08 82.23" id="img-6ade5fa2-223" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M18.96,5 L 18.96 82.23" id="img-6ade5fa2-224" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M26.83,5 L 26.83 82.23" id="img-6ade5fa2-225" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M34.7,5 L 34.7 82.23" id="img-6ade5fa2-226" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M42.58,5 L 42.58 82.23" id="img-6ade5fa2-227" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M50.45,5 L 50.45 82.23" id="img-6ade5fa2-228" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M58.32,5 L 58.32 82.23" id="img-6ade5fa2-229" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M66.2,5 L 66.2 82.23" id="img-6ade5fa2-230" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M74.07,5 L 74.07 82.23" id="img-6ade5fa2-231" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M81.94,5 L 81.94 82.23" id="img-6ade5fa2-232" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M89.82,5 L 89.82 82.23" id="img-6ade5fa2-233" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M97.69,5 L 97.69 82.23" id="img-6ade5fa2-234" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M105.56,5 L 105.56 82.23" id="img-6ade5fa2-235" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M113.44,5 L 113.44 82.23" id="img-6ade5fa2-236" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M121.31,5 L 121.31 82.23" id="img-6ade5fa2-237" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M129.18,5 L 129.18 82.23" id="img-6ade5fa2-238" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M137.05,5 L 137.05 82.23" id="img-6ade5fa2-239" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M144.93,5 L 144.93 82.23" id="img-6ade5fa2-240" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M152.8,5 L 152.8 82.23" id="img-6ade5fa2-241" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M160.67,5 L 160.67 82.23" id="img-6ade5fa2-242" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M168.55,5 L 168.55 82.23" id="img-6ade5fa2-243" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M176.42,5 L 176.42 82.23" id="img-6ade5fa2-244" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="plotpanel" id="img-6ade5fa2-245">
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_3" stroke-dasharray="none" stroke="#FF6DAE" id="img-6ade5fa2-246">
        <path fill="none" d="M19.74,43.59 L 20.53 63.27 21.32 63.71 22.11 59.44 22.89 78.68 23.68 62.9 24.47 75.35 25.26 17.46 26.04 19.72 26.83 65.76 27.62 57.2 28.4 60.62 29.19 16.67 29.98 55.94 30.77 74.53 31.55 21.19 32.34 69.46 33.13 59.7 33.92 79.59 34.7 55.08 35.49 24.01 36.28 21.65 37.07 49.13 37.85 64.78 38.64 78.81 39.43 66.6 40.21 74.27 41 17.87 41.79 41.02 42.58 38.79 43.36 65.2 44.15 65.34 44.94 58.4 45.73 37.41 46.51 32.35 47.3 65.34 48.09 44.87 48.87 76.69 49.66 79.18 50.45 55.82 51.24 51.43 52.02 53.19 52.81 21.92 53.6 59.63 54.39 75.21 55.17 10.02 55.96 51.1 56.75 63.62 57.54 26.4 58.32 52.27 59.11 38.57 59.9 24.2 60.68 66.14 61.47 32.77 62.26 20.13 63.05 56.23 63.83 13.51 64.62 30.13 65.41 53.75 66.2 31.09 66.98 46.46 67.77 68.68 68.56 49.6 69.35 21.2 70.13 23.5 70.92 51.09 71.71 72.64 72.49 9.27 73.28 18.58 74.07 29.51 74.86 37.85 75.64 17 76.43 34.65 77.22 19.14 78.01 39.62 78.79 16.08 79.58 30.67 80.37 26.87 81.16 71.01 81.94 8.29 82.73 61.23 83.52 31.46 84.3 75.84 85.09 64.79 85.88 10.75 86.67 78.62 87.45 80.11 88.24 23.4 89.03 38.88 89.82 11.29 90.6 35.44 91.39 14.23 92.18 38.55 92.96 43.03 93.75 50.26 94.54 10.45 95.33 22.42 96.11 26.68 96.9 32.72 97.69 36.05" id="img-6ade5fa2-247"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_2" stroke-dasharray="none" stroke="#D4CA3A" id="img-6ade5fa2-248">
        <path fill="none" d="M19.74,36.88 L 20.53 27.82 21.32 20.51 22.11 15.55 22.89 13.28 23.68 14.11 24.47 17.75 25.26 24.22 26.04 32.48 26.83 41.84 27.62 51.84 28.4 61.32 29.19 69.65 29.98 75.63 30.77 79.09 31.55 79.9 32.34 77.36 33.13 72.28 33.92 64.79 34.7 55.83 35.49 46.05 36.28 36.22 37.07 27.21 37.85 19.96 38.64 15.09 39.43 13.11 40.21 14.03 41 18.09 41.79 24.4 42.58 32.77 43.36 42.27 44.15 52.24 44.94 61.72 45.73 69.88 46.51 75.9 47.3 79.16 48.09 79.7 48.87 77.07 49.66 71.81 50.45 64.39 51.24 55.29 52.02 45.38 52.81 35.7 53.6 26.74 54.39 19.62 55.17 15.21 55.96 13.21 56.75 14.29 57.54 18.44 58.32 24.88 59.11 33.4 59.9 43.1 60.68 52.92 61.47 62.45 62.26 70.5 63.05 76.24 63.83 79.63 64.62 79.87 65.41 77.12 66.2 71.83 66.98 64.15 67.77 54.89 68.56 45.05 69.35 35.4 70.13 26.65 70.92 19.62 71.71 15.03 72.49 13.59 73.28 14.85 74.07 18.98 74.86 25.61 75.64 34.24 76.43 43.87 77.22 53.9 78.01 63.17 78.79 71.15 79.58 76.84 80.37 79.92 81.16 79.88 81.94 77.29 82.73 71.57 83.52 63.95 84.3 54.54 85.09 44.65 85.88 35.12 86.67 26.2 87.45 19.38 88.24 15.23 89.03 13.65 89.82 15.21 90.6 19.43 91.39 26.28 92.18 34.82 92.96 44.53 93.75 54.45 94.54 63.87 95.33 71.61 96.11 77.18 96.9 80.06 97.69 79.99" id="img-6ade5fa2-249"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Source_1" stroke-dasharray="none" stroke="#00BFFF" id="img-6ade5fa2-250">
        <path fill="none" d="M19.74,46.53 L 20.53 44.97 21.32 43.32 22.11 41.68 22.89 40.24 23.68 38.65 24.47 37.28 25.26 35.58 26.04 34.27 26.83 33.26 27.62 31.98 28.4 30.81 29.19 29.4 29.98 28.47 30.77 27.45 31.55 26.04 32.34 25.21 33.13 24.09 33.92 23.16 34.7 22.02 35.49 20.91 36.28 20.02 37.07 19.38 37.85 18.77 38.64 18.26 39.43 17.71 40.21 17.38 41 16.81 41.79 16.79 42.58 16.74 43.36 16.94 44.15 17.08 44.94 17.25 45.73 17.4 46.51 17.69 47.3 18.23 48.09 18.52 48.87 19.14 49.66 19.63 50.45 20.01 51.24 20.56 52.02 21.2 52.81 21.72 53.6 22.71 54.39 23.66 55.17 24.24 55.96 25.52 56.75 26.74 57.54 27.76 58.32 29.23 59.11 30.54 59.9 31.91 60.68 33.64 61.47 34.97 62.26 36.44 63.05 38.18 63.83 39.47 64.62 41.08 65.41 42.71 66.2 44.06 66.98 45.6 67.77 47.17 68.56 48.51 69.35 49.79 70.13 51.25 70.92 52.87 71.71 54.47 72.49 55.62 73.28 57.19 74.07 58.79 74.86 60.38 75.64 61.79 76.43 63.41 77.22 64.8 78.01 66.35 78.79 67.58 79.58 68.95 80.37 70.13 81.16 71.5 81.94 72.16 82.73 73.38 83.52 74.05 84.3 75.05 85.09 75.66 85.88 75.96 86.67 76.89 87.45 77.41 88.24 77.55 89.03 78.06 89.82 78.29 90.6 78.78 91.39 78.96 92.18 79.35 92.96 79.56 93.75 79.71 94.54 79.5 95.33 79.5 96.11 79.34 96.9 79.08 97.69 78.69" id="img-6ade5fa2-251"/>
      </g>
    </g>
    <g opacity="0" class="guide zoomslider" stroke="#000000" stroke-opacity="0.000" id="img-6ade5fa2-252">
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-6ade5fa2-253">
        <rect x="92.69" y="8" width="4" height="4" id="img-6ade5fa2-254"/>
        <g class="button_logo" fill="#6A6A6A" id="img-6ade5fa2-255">
          <path d="M93.49,9.6 L 94.29 9.6 94.29 8.8 95.09 8.8 95.09 9.6 95.89 9.6 95.89 10.4 95.09 10.4 95.09 11.2 94.29 11.2 94.29 10.4 93.49 10.4 z" id="img-6ade5fa2-256"/>
        </g>
      </g>
      <g fill="#EAEAEA" id="img-6ade5fa2-257">
        <rect x="73.19" y="8" width="19" height="4" id="img-6ade5fa2-258"/>
      </g>
      <g class="zoomslider_thumb" fill="#6A6A6A" id="img-6ade5fa2-259">
        <rect x="81.69" y="8" width="2" height="4" id="img-6ade5fa2-260"/>
      </g>
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-6ade5fa2-261">
        <rect x="68.69" y="8" width="4" height="4" id="img-6ade5fa2-262"/>
        <g class="button_logo" fill="#6A6A6A" id="img-6ade5fa2-263">
          <path d="M69.49,9.6 L 71.89 9.6 71.89 10.4 69.49 10.4 z" id="img-6ade5fa2-264"/>
        </g>
      </g>
    </g>
  </g>
</g>
  <g class="guide ylabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-6ade5fa2-265">
    <text x="15.96" y="171.78" text-anchor="end" dy="0.35em" id="img-6ade5fa2-266" visibility="hidden" gadfly:scale="1.0">-1.0</text>
    <text x="15.96" y="153.47" text-anchor="end" dy="0.35em" id="img-6ade5fa2-267" visibility="hidden" gadfly:scale="1.0">-0.8</text>
    <text x="15.96" y="135.16" text-anchor="end" dy="0.35em" id="img-6ade5fa2-268" visibility="hidden" gadfly:scale="1.0">-0.6</text>
    <text x="15.96" y="116.85" text-anchor="end" dy="0.35em" id="img-6ade5fa2-269" visibility="hidden" gadfly:scale="1.0">-0.4</text>
    <text x="15.96" y="98.54" text-anchor="end" dy="0.35em" id="img-6ade5fa2-270" visibility="hidden" gadfly:scale="1.0">-0.2</text>
    <text x="15.96" y="80.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-271" visibility="visible" gadfly:scale="1.0">0.0</text>
    <text x="15.96" y="61.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-272" visibility="visible" gadfly:scale="1.0">0.2</text>
    <text x="15.96" y="43.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-273" visibility="visible" gadfly:scale="1.0">0.4</text>
    <text x="15.96" y="25.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-274" visibility="visible" gadfly:scale="1.0">0.6</text>
    <text x="15.96" y="7" text-anchor="end" dy="0.35em" id="img-6ade5fa2-275" visibility="visible" gadfly:scale="1.0">0.8</text>
    <text x="15.96" y="-11.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-276" visibility="hidden" gadfly:scale="1.0">1.0</text>
    <text x="15.96" y="-29.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-277" visibility="hidden" gadfly:scale="1.0">1.2</text>
    <text x="15.96" y="-47.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-278" visibility="hidden" gadfly:scale="1.0">1.4</text>
    <text x="15.96" y="-66.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-279" visibility="hidden" gadfly:scale="1.0">1.6</text>
    <text x="15.96" y="-84.54" text-anchor="end" dy="0.35em" id="img-6ade5fa2-280" visibility="hidden" gadfly:scale="1.0">1.8</text>
    <text x="15.96" y="158.05" text-anchor="end" dy="0.35em" id="img-6ade5fa2-281" visibility="hidden" gadfly:scale="10.0">-0.85</text>
    <text x="15.96" y="153.47" text-anchor="end" dy="0.35em" id="img-6ade5fa2-282" visibility="hidden" gadfly:scale="10.0">-0.80</text>
    <text x="15.96" y="148.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-283" visibility="hidden" gadfly:scale="10.0">-0.75</text>
    <text x="15.96" y="144.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-284" visibility="hidden" gadfly:scale="10.0">-0.70</text>
    <text x="15.96" y="139.74" text-anchor="end" dy="0.35em" id="img-6ade5fa2-285" visibility="hidden" gadfly:scale="10.0">-0.65</text>
    <text x="15.96" y="135.16" text-anchor="end" dy="0.35em" id="img-6ade5fa2-286" visibility="hidden" gadfly:scale="10.0">-0.60</text>
    <text x="15.96" y="130.58" text-anchor="end" dy="0.35em" id="img-6ade5fa2-287" visibility="hidden" gadfly:scale="10.0">-0.55</text>
    <text x="15.96" y="126.01" text-anchor="end" dy="0.35em" id="img-6ade5fa2-288" visibility="hidden" gadfly:scale="10.0">-0.50</text>
    <text x="15.96" y="121.43" text-anchor="end" dy="0.35em" id="img-6ade5fa2-289" visibility="hidden" gadfly:scale="10.0">-0.45</text>
    <text x="15.96" y="116.85" text-anchor="end" dy="0.35em" id="img-6ade5fa2-290" visibility="hidden" gadfly:scale="10.0">-0.40</text>
    <text x="15.96" y="112.27" text-anchor="end" dy="0.35em" id="img-6ade5fa2-291" visibility="hidden" gadfly:scale="10.0">-0.35</text>
    <text x="15.96" y="107.7" text-anchor="end" dy="0.35em" id="img-6ade5fa2-292" visibility="hidden" gadfly:scale="10.0">-0.30</text>
    <text x="15.96" y="103.12" text-anchor="end" dy="0.35em" id="img-6ade5fa2-293" visibility="hidden" gadfly:scale="10.0">-0.25</text>
    <text x="15.96" y="98.54" text-anchor="end" dy="0.35em" id="img-6ade5fa2-294" visibility="hidden" gadfly:scale="10.0">-0.20</text>
    <text x="15.96" y="93.97" text-anchor="end" dy="0.35em" id="img-6ade5fa2-295" visibility="hidden" gadfly:scale="10.0">-0.15</text>
    <text x="15.96" y="89.39" text-anchor="end" dy="0.35em" id="img-6ade5fa2-296" visibility="hidden" gadfly:scale="10.0">-0.10</text>
    <text x="15.96" y="84.81" text-anchor="end" dy="0.35em" id="img-6ade5fa2-297" visibility="hidden" gadfly:scale="10.0">-0.05</text>
    <text x="15.96" y="80.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-298" visibility="hidden" gadfly:scale="10.0">0.00</text>
    <text x="15.96" y="75.66" text-anchor="end" dy="0.35em" id="img-6ade5fa2-299" visibility="hidden" gadfly:scale="10.0">0.05</text>
    <text x="15.96" y="71.08" text-anchor="end" dy="0.35em" id="img-6ade5fa2-300" visibility="hidden" gadfly:scale="10.0">0.10</text>
    <text x="15.96" y="66.5" text-anchor="end" dy="0.35em" id="img-6ade5fa2-301" visibility="hidden" gadfly:scale="10.0">0.15</text>
    <text x="15.96" y="61.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-302" visibility="hidden" gadfly:scale="10.0">0.20</text>
    <text x="15.96" y="57.35" text-anchor="end" dy="0.35em" id="img-6ade5fa2-303" visibility="hidden" gadfly:scale="10.0">0.25</text>
    <text x="15.96" y="52.77" text-anchor="end" dy="0.35em" id="img-6ade5fa2-304" visibility="hidden" gadfly:scale="10.0">0.30</text>
    <text x="15.96" y="48.19" text-anchor="end" dy="0.35em" id="img-6ade5fa2-305" visibility="hidden" gadfly:scale="10.0">0.35</text>
    <text x="15.96" y="43.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-306" visibility="hidden" gadfly:scale="10.0">0.40</text>
    <text x="15.96" y="39.04" text-anchor="end" dy="0.35em" id="img-6ade5fa2-307" visibility="hidden" gadfly:scale="10.0">0.45</text>
    <text x="15.96" y="34.46" text-anchor="end" dy="0.35em" id="img-6ade5fa2-308" visibility="hidden" gadfly:scale="10.0">0.50</text>
    <text x="15.96" y="29.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-309" visibility="hidden" gadfly:scale="10.0">0.55</text>
    <text x="15.96" y="25.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-310" visibility="hidden" gadfly:scale="10.0">0.60</text>
    <text x="15.96" y="20.73" text-anchor="end" dy="0.35em" id="img-6ade5fa2-311" visibility="hidden" gadfly:scale="10.0">0.65</text>
    <text x="15.96" y="16.15" text-anchor="end" dy="0.35em" id="img-6ade5fa2-312" visibility="hidden" gadfly:scale="10.0">0.70</text>
    <text x="15.96" y="11.58" text-anchor="end" dy="0.35em" id="img-6ade5fa2-313" visibility="hidden" gadfly:scale="10.0">0.75</text>
    <text x="15.96" y="7" text-anchor="end" dy="0.35em" id="img-6ade5fa2-314" visibility="hidden" gadfly:scale="10.0">0.80</text>
    <text x="15.96" y="2.42" text-anchor="end" dy="0.35em" id="img-6ade5fa2-315" visibility="hidden" gadfly:scale="10.0">0.85</text>
    <text x="15.96" y="-2.15" text-anchor="end" dy="0.35em" id="img-6ade5fa2-316" visibility="hidden" gadfly:scale="10.0">0.90</text>
    <text x="15.96" y="-6.73" text-anchor="end" dy="0.35em" id="img-6ade5fa2-317" visibility="hidden" gadfly:scale="10.0">0.95</text>
    <text x="15.96" y="-11.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-318" visibility="hidden" gadfly:scale="10.0">1.00</text>
    <text x="15.96" y="-15.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-319" visibility="hidden" gadfly:scale="10.0">1.05</text>
    <text x="15.96" y="-20.46" text-anchor="end" dy="0.35em" id="img-6ade5fa2-320" visibility="hidden" gadfly:scale="10.0">1.10</text>
    <text x="15.96" y="-25.04" text-anchor="end" dy="0.35em" id="img-6ade5fa2-321" visibility="hidden" gadfly:scale="10.0">1.15</text>
    <text x="15.96" y="-29.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-322" visibility="hidden" gadfly:scale="10.0">1.20</text>
    <text x="15.96" y="-34.19" text-anchor="end" dy="0.35em" id="img-6ade5fa2-323" visibility="hidden" gadfly:scale="10.0">1.25</text>
    <text x="15.96" y="-38.77" text-anchor="end" dy="0.35em" id="img-6ade5fa2-324" visibility="hidden" gadfly:scale="10.0">1.30</text>
    <text x="15.96" y="-43.35" text-anchor="end" dy="0.35em" id="img-6ade5fa2-325" visibility="hidden" gadfly:scale="10.0">1.35</text>
    <text x="15.96" y="-47.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-326" visibility="hidden" gadfly:scale="10.0">1.40</text>
    <text x="15.96" y="-52.5" text-anchor="end" dy="0.35em" id="img-6ade5fa2-327" visibility="hidden" gadfly:scale="10.0">1.45</text>
    <text x="15.96" y="-57.08" text-anchor="end" dy="0.35em" id="img-6ade5fa2-328" visibility="hidden" gadfly:scale="10.0">1.50</text>
    <text x="15.96" y="-61.66" text-anchor="end" dy="0.35em" id="img-6ade5fa2-329" visibility="hidden" gadfly:scale="10.0">1.55</text>
    <text x="15.96" y="-66.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-330" visibility="hidden" gadfly:scale="10.0">1.60</text>
    <text x="15.96" y="171.78" text-anchor="end" dy="0.35em" id="img-6ade5fa2-331" visibility="hidden" gadfly:scale="0.5">-1</text>
    <text x="15.96" y="80.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-332" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="15.96" y="-11.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-333" visibility="hidden" gadfly:scale="0.5">1</text>
    <text x="15.96" y="-102.85" text-anchor="end" dy="0.35em" id="img-6ade5fa2-334" visibility="hidden" gadfly:scale="0.5">2</text>
    <text x="15.96" y="158.05" text-anchor="end" dy="0.35em" id="img-6ade5fa2-335" visibility="hidden" gadfly:scale="5.0">-0.85</text>
    <text x="15.96" y="153.47" text-anchor="end" dy="0.35em" id="img-6ade5fa2-336" visibility="hidden" gadfly:scale="5.0">-0.80</text>
    <text x="15.96" y="148.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-337" visibility="hidden" gadfly:scale="5.0">-0.75</text>
    <text x="15.96" y="144.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-338" visibility="hidden" gadfly:scale="5.0">-0.70</text>
    <text x="15.96" y="139.74" text-anchor="end" dy="0.35em" id="img-6ade5fa2-339" visibility="hidden" gadfly:scale="5.0">-0.65</text>
    <text x="15.96" y="135.16" text-anchor="end" dy="0.35em" id="img-6ade5fa2-340" visibility="hidden" gadfly:scale="5.0">-0.60</text>
    <text x="15.96" y="130.58" text-anchor="end" dy="0.35em" id="img-6ade5fa2-341" visibility="hidden" gadfly:scale="5.0">-0.55</text>
    <text x="15.96" y="126.01" text-anchor="end" dy="0.35em" id="img-6ade5fa2-342" visibility="hidden" gadfly:scale="5.0">-0.50</text>
    <text x="15.96" y="121.43" text-anchor="end" dy="0.35em" id="img-6ade5fa2-343" visibility="hidden" gadfly:scale="5.0">-0.45</text>
    <text x="15.96" y="116.85" text-anchor="end" dy="0.35em" id="img-6ade5fa2-344" visibility="hidden" gadfly:scale="5.0">-0.40</text>
    <text x="15.96" y="112.27" text-anchor="end" dy="0.35em" id="img-6ade5fa2-345" visibility="hidden" gadfly:scale="5.0">-0.35</text>
    <text x="15.96" y="107.7" text-anchor="end" dy="0.35em" id="img-6ade5fa2-346" visibility="hidden" gadfly:scale="5.0">-0.30</text>
    <text x="15.96" y="103.12" text-anchor="end" dy="0.35em" id="img-6ade5fa2-347" visibility="hidden" gadfly:scale="5.0">-0.25</text>
    <text x="15.96" y="98.54" text-anchor="end" dy="0.35em" id="img-6ade5fa2-348" visibility="hidden" gadfly:scale="5.0">-0.20</text>
    <text x="15.96" y="93.97" text-anchor="end" dy="0.35em" id="img-6ade5fa2-349" visibility="hidden" gadfly:scale="5.0">-0.15</text>
    <text x="15.96" y="89.39" text-anchor="end" dy="0.35em" id="img-6ade5fa2-350" visibility="hidden" gadfly:scale="5.0">-0.10</text>
    <text x="15.96" y="84.81" text-anchor="end" dy="0.35em" id="img-6ade5fa2-351" visibility="hidden" gadfly:scale="5.0">-0.05</text>
    <text x="15.96" y="80.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-352" visibility="hidden" gadfly:scale="5.0">0.00</text>
    <text x="15.96" y="75.66" text-anchor="end" dy="0.35em" id="img-6ade5fa2-353" visibility="hidden" gadfly:scale="5.0">0.05</text>
    <text x="15.96" y="71.08" text-anchor="end" dy="0.35em" id="img-6ade5fa2-354" visibility="hidden" gadfly:scale="5.0">0.10</text>
    <text x="15.96" y="66.5" text-anchor="end" dy="0.35em" id="img-6ade5fa2-355" visibility="hidden" gadfly:scale="5.0">0.15</text>
    <text x="15.96" y="61.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-356" visibility="hidden" gadfly:scale="5.0">0.20</text>
    <text x="15.96" y="57.35" text-anchor="end" dy="0.35em" id="img-6ade5fa2-357" visibility="hidden" gadfly:scale="5.0">0.25</text>
    <text x="15.96" y="52.77" text-anchor="end" dy="0.35em" id="img-6ade5fa2-358" visibility="hidden" gadfly:scale="5.0">0.30</text>
    <text x="15.96" y="48.19" text-anchor="end" dy="0.35em" id="img-6ade5fa2-359" visibility="hidden" gadfly:scale="5.0">0.35</text>
    <text x="15.96" y="43.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-360" visibility="hidden" gadfly:scale="5.0">0.40</text>
    <text x="15.96" y="39.04" text-anchor="end" dy="0.35em" id="img-6ade5fa2-361" visibility="hidden" gadfly:scale="5.0">0.45</text>
    <text x="15.96" y="34.46" text-anchor="end" dy="0.35em" id="img-6ade5fa2-362" visibility="hidden" gadfly:scale="5.0">0.50</text>
    <text x="15.96" y="29.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-363" visibility="hidden" gadfly:scale="5.0">0.55</text>
    <text x="15.96" y="25.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-364" visibility="hidden" gadfly:scale="5.0">0.60</text>
    <text x="15.96" y="20.73" text-anchor="end" dy="0.35em" id="img-6ade5fa2-365" visibility="hidden" gadfly:scale="5.0">0.65</text>
    <text x="15.96" y="16.15" text-anchor="end" dy="0.35em" id="img-6ade5fa2-366" visibility="hidden" gadfly:scale="5.0">0.70</text>
    <text x="15.96" y="11.58" text-anchor="end" dy="0.35em" id="img-6ade5fa2-367" visibility="hidden" gadfly:scale="5.0">0.75</text>
    <text x="15.96" y="7" text-anchor="end" dy="0.35em" id="img-6ade5fa2-368" visibility="hidden" gadfly:scale="5.0">0.80</text>
    <text x="15.96" y="2.42" text-anchor="end" dy="0.35em" id="img-6ade5fa2-369" visibility="hidden" gadfly:scale="5.0">0.85</text>
    <text x="15.96" y="-2.15" text-anchor="end" dy="0.35em" id="img-6ade5fa2-370" visibility="hidden" gadfly:scale="5.0">0.90</text>
    <text x="15.96" y="-6.73" text-anchor="end" dy="0.35em" id="img-6ade5fa2-371" visibility="hidden" gadfly:scale="5.0">0.95</text>
    <text x="15.96" y="-11.31" text-anchor="end" dy="0.35em" id="img-6ade5fa2-372" visibility="hidden" gadfly:scale="5.0">1.00</text>
    <text x="15.96" y="-15.89" text-anchor="end" dy="0.35em" id="img-6ade5fa2-373" visibility="hidden" gadfly:scale="5.0">1.05</text>
    <text x="15.96" y="-20.46" text-anchor="end" dy="0.35em" id="img-6ade5fa2-374" visibility="hidden" gadfly:scale="5.0">1.10</text>
    <text x="15.96" y="-25.04" text-anchor="end" dy="0.35em" id="img-6ade5fa2-375" visibility="hidden" gadfly:scale="5.0">1.15</text>
    <text x="15.96" y="-29.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-376" visibility="hidden" gadfly:scale="5.0">1.20</text>
    <text x="15.96" y="-34.19" text-anchor="end" dy="0.35em" id="img-6ade5fa2-377" visibility="hidden" gadfly:scale="5.0">1.25</text>
    <text x="15.96" y="-38.77" text-anchor="end" dy="0.35em" id="img-6ade5fa2-378" visibility="hidden" gadfly:scale="5.0">1.30</text>
    <text x="15.96" y="-43.35" text-anchor="end" dy="0.35em" id="img-6ade5fa2-379" visibility="hidden" gadfly:scale="5.0">1.35</text>
    <text x="15.96" y="-47.93" text-anchor="end" dy="0.35em" id="img-6ade5fa2-380" visibility="hidden" gadfly:scale="5.0">1.40</text>
    <text x="15.96" y="-52.5" text-anchor="end" dy="0.35em" id="img-6ade5fa2-381" visibility="hidden" gadfly:scale="5.0">1.45</text>
    <text x="15.96" y="-57.08" text-anchor="end" dy="0.35em" id="img-6ade5fa2-382" visibility="hidden" gadfly:scale="5.0">1.50</text>
    <text x="15.96" y="-61.66" text-anchor="end" dy="0.35em" id="img-6ade5fa2-383" visibility="hidden" gadfly:scale="5.0">1.55</text>
    <text x="15.96" y="-66.23" text-anchor="end" dy="0.35em" id="img-6ade5fa2-384" visibility="hidden" gadfly:scale="5.0">1.60</text>
  </g>
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-6ade5fa2-385">
    <text x="9.11" y="43.62" text-anchor="end" dy="0.35em" id="img-6ade5fa2-386">Y</text>
  </g>
</g>
<defs>
  <clipPath id="img-6ade5fa2-15">
  <path d="M16.96,5 L 99.69 5 99.69 82.23 16.96 82.23" />
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

        this.node.addEventListener(
            /Firefox/i.test(navigator.userAgent) ? "DOMMouseScroll" : "mousewheel",
            fn2);

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


// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_zoom = function(event) {
        if (event.which == 187) { // plus
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189) { // minus
            increase_zoom_by_position(root, -0.1, true);
        }
    };
    root.data("keyboard_zoom", keyboard_zoom);
    window.addEventListener("keyup", keyboard_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    xgridlines.data("unfocused_strokedash",
                    xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
    ygridlines.data("unfocused_strokedash",
                    ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));

    // emphasize grid lines
    var destcolor = root.data("focused_xgrid_color");
    xgridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("focused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // reveal zoom slider
    root.select(".zoomslider")
        .animate({opacity: 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_zoom"));
    root.data("keyboard_zoom", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    var destcolor = root.data("unfocused_xgrid_color");

    xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("unfocused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // hide zoom slider
    root.select(".zoomslider")
        .animate({opacity: 0.0}, 250);
};


var set_geometry_transform = function(root, tx, ty, scale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_scale = root.data("scale");

    var xscale = xscalable ? scale : 1.0,
        yscale = yscalable ? scale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);

    root.selectAll(".geometry, image")
        .forEach(function (element, i) {
            element.transform(t);
        });

    bounds = root.plotbounds();

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        root.select(".ylabels")
            .transform(xfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1, 1/scale, cx, cy).add(st);
                    element.transform(unscale_t);

                    var y = cy * scale + ty;
                    element.attr("visibility",
                        bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                }
            });
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        root.select(".xlabels")
            .transform(yfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1/scale, 1, cx, cy).add(st);

                    element.transform(unscale_t);

                    var x = cx * scale + tx;
                    element.attr("visibility",
                        bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                    }
            });
    }

    // we must unscale anything that is scale invariance: widths, raiduses, etc.
    var size_attribs = ["font-size"];
    var unscaled_selection = ".geometry, .geometry *";
    if (xscalable) {
        size_attribs.push("rx");
        unscaled_selection += ", .xgridlines";
    }
    if (yscalable) {
        size_attribs.push("ry");
        unscaled_selection += ", .ygridlines";
    }

    root.selectAll(unscaled_selection)
        .forEach(function (element, i) {
            // circle need special help
            if (element.node.nodeName == "circle") {
                var cx = element.attribute("cx"),
                    cy = element.attribute("cy");
                unscale_t = new Snap.Matrix().scale(1/xscale, 1/yscale,
                                                        cx, cy);
                element.transform(unscale_t);
                return;
            }

            for (i in size_attribs) {
                var key = size_attribs[i];
                var val = parseFloat(element.attribute(key));
                if (val !== undefined && val != 0 && !isNaN(val)) {
                    element.attribute(key, val * old_scale / scale);
                }
            }
        });
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
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("path").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("text").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, scale) {
    var old_scale = root.data("scale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, and scale
    var x_min = -width * scale - (scale * width - width),
        x_max = width * scale,
        y_min = -height * scale - (scale * height - height),
        y_max = height * scale;

    var x0 = bounds.x0 - scale * bounds.x0,
        y0 = bounds.y0 - scale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale change, we may need to alter which set of
    // ticks is being displayed
    if (scale != old_scale) {
        update_tickscale(root, scale, "x");
        update_tickscale(root, scale, "y");
    }

    set_geometry_transform(root, tx, ty, scale);

    root.data("scale", scale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, scale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var scale0 = root.data("scale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - scale0) + (width * (1 - scale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - scale0) + (height * (1 - scale0)) / 2);

    // rescale offsets
    xoff = xoff * scale / scale0;
    yoff = yoff * scale / scale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - scale),
        y_edge_adjust = bounds.y0 * (1 - scale);

    return {
        x: xoff + x_edge_adjust + (width - width * scale) / 2,
        y: yoff + y_edge_adjust + (height - height * scale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

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
    root.selectAll(".xlabels > text, .ylabels > text")
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
    if (root.data("scale") === undefined) root.data("scale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("path").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("path").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("text").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("text").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
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
        xlabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("path").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("path").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("text").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("text").forEach(mark_inscale);

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
            .selectAll("path")
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
            .selectAll("path")
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

        set_plot_pan_zoom(root, tx, ty, root.data("scale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"), root.data("scale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, x, y, event) {
        var bounds = root.plotbounds();
        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var ratio = width / height;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "opacity": 0.25
        });
        zoom_box.data("ratio", ratio);
    },
    update: function(root, dx, dy, x, y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
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
        if (xscalable && yscalable) {
            var ratio = zoom_box.data("ratio");
            var width = Math.min(Math.abs(dx), ratio * Math.abs(dy));
            var height = Math.min(Math.abs(dy), Math.abs(dx) / ratio);
            dx = width * dx / Math.abs(dx);
            dy = height * dy / Math.abs(dy);
        }
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
        var zoom_factor = 1.0;
        if (yscalable) {
            zoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        } else {
            zoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * zoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * zoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty, root.data("scale") * zoom_factor);
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
        increase_zoom_by_position(this.plotroot(), 0.001 * event.wheelDelta);
        event.preventDefault();
    }
};


Gadfly.zoomslider_button_mouseover = function(event) {
    this.select(".button_logo")
         .animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_button_mouseout = function(event) {
     this.select(".button_logo")
         .animate({fill: this.data("mouseout_color")}, 100);
};


Gadfly.zoomslider_zoomout_click = function(event) {
    increase_zoom_by_position(this.plotroot(), -0.1, true);
};


Gadfly.zoomslider_zoomin_click = function(event) {
    increase_zoom_by_position(this.plotroot(), 0.1, true);
};


Gadfly.zoomslider_track_click = function(event) {
    // TODO
};


// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var scale = root.data("scale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var position = slider_position_from_scale(scale, min_scale, max_scale);
    position += delta_position;
    scale = scale_from_slider_position(position, min_scale, max_scale);
    set_zoom(root, scale, animate);
}

var set_zoom = function(root, scale, animate) {
    var min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("scale");
    var new_scale = Math.max(min_scale, Math.min(scale, max_scale));
    if (animate) {
        Snap.animate(
            old_scale,
            new_scale,
            function (new_scale) {
                update_plot_scale(root, new_scale);
            },
            200);
    } else {
        update_plot_scale(root, new_scale);
    }
}


var update_plot_scale = function(root, new_scale) {
    var trans = scale_centered_translation(root, new_scale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_scale);

    root.selectAll(".zoomslider_thumb")
        .forEach(function (element, i) {
            var min_pos = element.data("min_pos"),
                max_pos = element.data("max_pos"),
                min_scale = root.data("min_scale"),
                max_scale = root.data("max_scale");
            var xmid = (min_pos + max_pos) / 2;
            var xpos = slider_position_from_scale(new_scale, min_scale, max_scale);
            element.transform(new Snap.Matrix().translate(
                Math.max(min_pos, Math.min(
                         max_pos, min_pos + (max_pos - min_pos) * xpos)) - xmid, 0));
    });
};


Gadfly.zoomslider_thumb_dragmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var min_pos = this.data("min_pos"),
        max_pos = this.data("max_pos"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("old_scale");

    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var xmid = (min_pos + max_pos) / 2;
    var xpos = slider_position_from_scale(old_scale, min_scale, max_scale) +
                   dx / (max_pos - min_pos);

    // compute the new scale
    var new_scale = scale_from_slider_position(xpos, min_scale, max_scale);
    new_scale = Math.min(max_scale, Math.max(min_scale, new_scale));

    update_plot_scale(root, new_scale);
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragstart = function(x, y, event) {
    this.animate({fill: this.data("mouseover_color")}, 100);
    var root = this.plotroot();

    // keep track of what the scale was when we started dragging
    root.data("old_scale", root.data("scale"));
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragend = function(event) {
    this.animate({fill: this.data("mouseout_color")}, 100);
    event.stopPropagation();
};


var toggle_color_class = function(root, color_class, ison) {
    var guides = root.selectAll(".guide." + color_class + ",.guide ." + color_class);
    var geoms = root.selectAll(".geometry." + color_class + ",.geometry ." + color_class);
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
        root.selectAll(".colorkey text")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (other_color_class != color_class) {
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
    var fig = Snap("#img-6ade5fa2");
fig.select("#img-6ade5fa2-4")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-6ade5fa2-6")
   .data("color_class", "color_Source_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-7")
   .data("color_class", "color_Source_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-8")
   .data("color_class", "color_Source_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-10")
   .data("color_class", "color_Source_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-11")
   .data("color_class", "color_Source_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-12")
   .data("color_class", "color_Source_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-6ade5fa2-16")
   .init_gadfly();
fig.select("#img-6ade5fa2-19")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-6ade5fa2-19")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-6ade5fa2-139")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-6ade5fa2-139")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-6ade5fa2-253")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-6ade5fa2-253")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-6ade5fa2-253")
   .click(Gadfly.zoomslider_zoomin_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
fig.select("#img-6ade5fa2-257")
   .data("max_pos", 83.69)
;
fig.select("#img-6ade5fa2-257")
   .data("min_pos", 66.69)
;
fig.select("#img-6ade5fa2-257")
   .click(Gadfly.zoomslider_track_click);
fig.select("#img-6ade5fa2-259")
   .data("max_pos", 83.69)
;
fig.select("#img-6ade5fa2-259")
   .data("min_pos", 66.69)
;
fig.select("#img-6ade5fa2-259")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-6ade5fa2-259")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-6ade5fa2-259")
   .drag(Gadfly.zoomslider_thumb_dragmove,
     Gadfly.zoomslider_thumb_dragstart,
     Gadfly.zoomslider_thumb_dragend)
;
fig.select("#img-6ade5fa2-261")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-6ade5fa2-261")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-6ade5fa2-261")
   .click(Gadfly.zoomslider_zoomout_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
    });
]]> </script>
</svg>




## Reproduced signals


```julia
Mads.plotseries(Wipopt * Hipopt, title="Reproduced signals", name="Signal", combined=true)
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

     id="img-be239761">
<g class="plotroot xscalable yscalable" id="img-be239761-1">
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-be239761-2">
    <text x="59.54" y="89.28" text-anchor="middle" dy="0.6em">X</text>
  </g>
  <g class="guide xlabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-be239761-3">
    <text x="-112.48" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-150</text>
    <text x="-69.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-100</text>
    <text x="-26.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">-50</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="59.54" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">50</text>
    <text x="102.55" y="85.28" text-anchor="middle" visibility="visible" gadfly:scale="1.0">100</text>
    <text x="145.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">150</text>
    <text x="188.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">200</text>
    <text x="231.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="1.0">250</text>
    <text x="-69.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-100</text>
    <text x="-65.17" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-95</text>
    <text x="-60.87" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-90</text>
    <text x="-56.57" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-85</text>
    <text x="-52.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-80</text>
    <text x="-47.97" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-75</text>
    <text x="-43.67" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-70</text>
    <text x="-39.37" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-65</text>
    <text x="-35.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-60</text>
    <text x="-30.77" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-55</text>
    <text x="-26.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-50</text>
    <text x="-22.17" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-45</text>
    <text x="-17.87" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-40</text>
    <text x="-13.57" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-35</text>
    <text x="-9.26" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-30</text>
    <text x="-4.96" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-25</text>
    <text x="-0.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-20</text>
    <text x="3.64" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-15</text>
    <text x="7.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-10</text>
    <text x="12.24" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">-5</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">0</text>
    <text x="20.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">5</text>
    <text x="25.14" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">10</text>
    <text x="29.44" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">15</text>
    <text x="33.74" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">20</text>
    <text x="38.04" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">25</text>
    <text x="42.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">30</text>
    <text x="46.64" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">35</text>
    <text x="50.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">40</text>
    <text x="55.24" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">45</text>
    <text x="59.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">50</text>
    <text x="63.84" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">55</text>
    <text x="68.14" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">60</text>
    <text x="72.44" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">65</text>
    <text x="76.74" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">70</text>
    <text x="81.04" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">75</text>
    <text x="85.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">80</text>
    <text x="89.65" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">85</text>
    <text x="93.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">90</text>
    <text x="98.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">95</text>
    <text x="102.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">100</text>
    <text x="106.85" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">105</text>
    <text x="111.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">110</text>
    <text x="115.45" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">115</text>
    <text x="119.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">120</text>
    <text x="124.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">125</text>
    <text x="128.35" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">130</text>
    <text x="132.65" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">135</text>
    <text x="136.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">140</text>
    <text x="141.25" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">145</text>
    <text x="145.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">150</text>
    <text x="149.85" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">155</text>
    <text x="154.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">160</text>
    <text x="158.45" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">165</text>
    <text x="162.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">170</text>
    <text x="167.05" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">175</text>
    <text x="171.35" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">180</text>
    <text x="175.65" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">185</text>
    <text x="179.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">190</text>
    <text x="184.26" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">195</text>
    <text x="188.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="10.0">200</text>
    <text x="-69.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">-100</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="102.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">100</text>
    <text x="188.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="0.5">200</text>
    <text x="-69.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-100</text>
    <text x="-60.87" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-90</text>
    <text x="-52.27" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-80</text>
    <text x="-43.67" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-70</text>
    <text x="-35.07" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-60</text>
    <text x="-26.47" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-50</text>
    <text x="-17.87" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-40</text>
    <text x="-9.26" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-30</text>
    <text x="-0.66" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-20</text>
    <text x="7.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">-10</text>
    <text x="16.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">0</text>
    <text x="25.14" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">10</text>
    <text x="33.74" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">20</text>
    <text x="42.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">30</text>
    <text x="50.94" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">40</text>
    <text x="59.54" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">50</text>
    <text x="68.14" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">60</text>
    <text x="76.74" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">70</text>
    <text x="85.34" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">80</text>
    <text x="93.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">90</text>
    <text x="102.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">100</text>
    <text x="111.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">110</text>
    <text x="119.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">120</text>
    <text x="128.35" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">130</text>
    <text x="136.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">140</text>
    <text x="145.55" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">150</text>
    <text x="154.15" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">160</text>
    <text x="162.75" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">170</text>
    <text x="171.35" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">180</text>
    <text x="179.95" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">190</text>
    <text x="188.56" y="85.28" text-anchor="middle" visibility="hidden" gadfly:scale="5.0">200</text>
  </g>
  <g class="guide colorkey" id="img-be239761-4">
    <g fill="#4C404B" font-size="2.82" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" id="img-be239761-5">
      <text x="108.35" y="40.01" dy="0.35em" id="img-be239761-6" class="color_Signal_1">Signal 1</text>
      <text x="108.35" y="43.62" dy="0.35em" id="img-be239761-7" class="color_Signal_2">Signal 2</text>
      <text x="108.35" y="47.22" dy="0.35em" id="img-be239761-8" class="color_Signal_3">Signal 3</text>
      <text x="108.35" y="50.83" dy="0.35em" id="img-be239761-9" class="color_Signal_4">Signal 4</text>
    </g>
    <g stroke="#000000" stroke-opacity="0.000" id="img-be239761-10">
      <rect x="105.55" y="39.11" width="1.8" height="1.8" id="img-be239761-11" class="color_Signal_1" fill="#00BFFF"/>
      <rect x="105.55" y="42.72" width="1.8" height="1.8" id="img-be239761-12" class="color_Signal_2" fill="#D4CA3A"/>
      <rect x="105.55" y="46.32" width="1.8" height="1.8" id="img-be239761-13" class="color_Signal_3" fill="#FF6DAE"/>
      <rect x="105.55" y="49.93" width="1.8" height="1.8" id="img-be239761-14" class="color_Signal_4" fill="#00B78D"/>
    </g>
    <g fill="#362A35" font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" stroke="#000000" stroke-opacity="0.000" id="img-be239761-15">
      <text x="105.55" y="36.19" id="img-be239761-16">Reproduced signals</text>
    </g>
  </g>
<g clip-path="url(#img-be239761-17)">
  <g id="img-be239761-18">
    <g pointer-events="visible" opacity="1" fill="#000000" fill-opacity="0.000" stroke="#000000" stroke-opacity="0.000" class="guide background" id="img-be239761-19">
      <rect x="14.54" y="5" width="90.01" height="77.23" id="img-be239761-20"/>
    </g>
    <g class="guide ygridlines xfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-be239761-21">
      <path fill="none" d="M14.54,177.88 L 104.55 177.88" id="img-be239761-22" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,153.47 L 104.55 153.47" id="img-be239761-23" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,129.06 L 104.55 129.06" id="img-be239761-24" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,104.65 L 104.55 104.65" id="img-be239761-25" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,80.23 L 104.55 80.23" id="img-be239761-26" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,55.82 L 104.55 55.82" id="img-be239761-27" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,31.41 L 104.55 31.41" id="img-be239761-28" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,7 L 104.55 7" id="img-be239761-29" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-17.41 L 104.55 -17.41" id="img-be239761-30" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-41.82 L 104.55 -41.82" id="img-be239761-31" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-66.23 L 104.55 -66.23" id="img-be239761-32" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,-90.65 L 104.55 -90.65" id="img-be239761-33" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M14.54,153.47 L 104.55 153.47" id="img-be239761-34" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,151.03 L 104.55 151.03" id="img-be239761-35" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,148.59 L 104.55 148.59" id="img-be239761-36" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,146.15 L 104.55 146.15" id="img-be239761-37" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,143.7 L 104.55 143.7" id="img-be239761-38" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,141.26 L 104.55 141.26" id="img-be239761-39" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,138.82 L 104.55 138.82" id="img-be239761-40" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,136.38 L 104.55 136.38" id="img-be239761-41" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,133.94 L 104.55 133.94" id="img-be239761-42" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,131.5 L 104.55 131.5" id="img-be239761-43" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,129.06 L 104.55 129.06" id="img-be239761-44" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,126.62 L 104.55 126.62" id="img-be239761-45" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,124.18 L 104.55 124.18" id="img-be239761-46" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,121.73 L 104.55 121.73" id="img-be239761-47" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,119.29 L 104.55 119.29" id="img-be239761-48" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,116.85 L 104.55 116.85" id="img-be239761-49" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,114.41 L 104.55 114.41" id="img-be239761-50" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,111.97 L 104.55 111.97" id="img-be239761-51" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,109.53 L 104.55 109.53" id="img-be239761-52" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,107.09 L 104.55 107.09" id="img-be239761-53" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,104.65 L 104.55 104.65" id="img-be239761-54" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,102.2 L 104.55 102.2" id="img-be239761-55" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,99.76 L 104.55 99.76" id="img-be239761-56" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,97.32 L 104.55 97.32" id="img-be239761-57" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,94.88 L 104.55 94.88" id="img-be239761-58" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,92.44 L 104.55 92.44" id="img-be239761-59" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,90 L 104.55 90" id="img-be239761-60" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,87.56 L 104.55 87.56" id="img-be239761-61" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,85.12 L 104.55 85.12" id="img-be239761-62" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,82.68 L 104.55 82.68" id="img-be239761-63" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,80.23 L 104.55 80.23" id="img-be239761-64" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,77.79 L 104.55 77.79" id="img-be239761-65" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,75.35 L 104.55 75.35" id="img-be239761-66" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,72.91 L 104.55 72.91" id="img-be239761-67" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,70.47 L 104.55 70.47" id="img-be239761-68" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,68.03 L 104.55 68.03" id="img-be239761-69" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,65.59 L 104.55 65.59" id="img-be239761-70" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,63.15 L 104.55 63.15" id="img-be239761-71" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,60.71 L 104.55 60.71" id="img-be239761-72" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,58.26 L 104.55 58.26" id="img-be239761-73" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,55.82 L 104.55 55.82" id="img-be239761-74" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,53.38 L 104.55 53.38" id="img-be239761-75" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,50.94 L 104.55 50.94" id="img-be239761-76" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,48.5 L 104.55 48.5" id="img-be239761-77" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,46.06 L 104.55 46.06" id="img-be239761-78" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,43.62 L 104.55 43.62" id="img-be239761-79" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,41.18 L 104.55 41.18" id="img-be239761-80" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,38.73 L 104.55 38.73" id="img-be239761-81" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,36.29 L 104.55 36.29" id="img-be239761-82" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,33.85 L 104.55 33.85" id="img-be239761-83" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,31.41 L 104.55 31.41" id="img-be239761-84" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,28.97 L 104.55 28.97" id="img-be239761-85" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,26.53 L 104.55 26.53" id="img-be239761-86" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,24.09 L 104.55 24.09" id="img-be239761-87" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,21.65 L 104.55 21.65" id="img-be239761-88" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,19.21 L 104.55 19.21" id="img-be239761-89" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,16.76 L 104.55 16.76" id="img-be239761-90" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,14.32 L 104.55 14.32" id="img-be239761-91" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,11.88 L 104.55 11.88" id="img-be239761-92" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,9.44 L 104.55 9.44" id="img-be239761-93" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,7 L 104.55 7" id="img-be239761-94" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,4.56 L 104.55 4.56" id="img-be239761-95" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,2.12 L 104.55 2.12" id="img-be239761-96" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-0.32 L 104.55 -0.32" id="img-be239761-97" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-2.76 L 104.55 -2.76" id="img-be239761-98" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-5.21 L 104.55 -5.21" id="img-be239761-99" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-7.65 L 104.55 -7.65" id="img-be239761-100" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-10.09 L 104.55 -10.09" id="img-be239761-101" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-12.53 L 104.55 -12.53" id="img-be239761-102" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-14.97 L 104.55 -14.97" id="img-be239761-103" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-17.41 L 104.55 -17.41" id="img-be239761-104" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-19.85 L 104.55 -19.85" id="img-be239761-105" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-22.29 L 104.55 -22.29" id="img-be239761-106" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-24.73 L 104.55 -24.73" id="img-be239761-107" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-27.18 L 104.55 -27.18" id="img-be239761-108" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-29.62 L 104.55 -29.62" id="img-be239761-109" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-32.06 L 104.55 -32.06" id="img-be239761-110" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-34.5 L 104.55 -34.5" id="img-be239761-111" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-36.94 L 104.55 -36.94" id="img-be239761-112" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-39.38 L 104.55 -39.38" id="img-be239761-113" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-41.82 L 104.55 -41.82" id="img-be239761-114" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-44.26 L 104.55 -44.26" id="img-be239761-115" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-46.71 L 104.55 -46.71" id="img-be239761-116" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-49.15 L 104.55 -49.15" id="img-be239761-117" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-51.59 L 104.55 -51.59" id="img-be239761-118" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-54.03 L 104.55 -54.03" id="img-be239761-119" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-56.47 L 104.55 -56.47" id="img-be239761-120" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-58.91 L 104.55 -58.91" id="img-be239761-121" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-61.35 L 104.55 -61.35" id="img-be239761-122" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-63.79 L 104.55 -63.79" id="img-be239761-123" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,-66.23 L 104.55 -66.23" id="img-be239761-124" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M14.54,153.47 L 104.55 153.47" id="img-be239761-125" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,80.23 L 104.55 80.23" id="img-be239761-126" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,7 L 104.55 7" id="img-be239761-127" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,-66.23 L 104.55 -66.23" id="img-be239761-128" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M14.54,153.47 L 104.55 153.47" id="img-be239761-129" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,148.59 L 104.55 148.59" id="img-be239761-130" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,143.7 L 104.55 143.7" id="img-be239761-131" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,138.82 L 104.55 138.82" id="img-be239761-132" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,133.94 L 104.55 133.94" id="img-be239761-133" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,129.06 L 104.55 129.06" id="img-be239761-134" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,124.18 L 104.55 124.18" id="img-be239761-135" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,119.29 L 104.55 119.29" id="img-be239761-136" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,114.41 L 104.55 114.41" id="img-be239761-137" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,109.53 L 104.55 109.53" id="img-be239761-138" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,104.65 L 104.55 104.65" id="img-be239761-139" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,99.76 L 104.55 99.76" id="img-be239761-140" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,94.88 L 104.55 94.88" id="img-be239761-141" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,90 L 104.55 90" id="img-be239761-142" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,85.12 L 104.55 85.12" id="img-be239761-143" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,80.23 L 104.55 80.23" id="img-be239761-144" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,75.35 L 104.55 75.35" id="img-be239761-145" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,70.47 L 104.55 70.47" id="img-be239761-146" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,65.59 L 104.55 65.59" id="img-be239761-147" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,60.71 L 104.55 60.71" id="img-be239761-148" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,55.82 L 104.55 55.82" id="img-be239761-149" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,50.94 L 104.55 50.94" id="img-be239761-150" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,46.06 L 104.55 46.06" id="img-be239761-151" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,41.18 L 104.55 41.18" id="img-be239761-152" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,36.29 L 104.55 36.29" id="img-be239761-153" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,31.41 L 104.55 31.41" id="img-be239761-154" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,26.53 L 104.55 26.53" id="img-be239761-155" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,21.65 L 104.55 21.65" id="img-be239761-156" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,16.76 L 104.55 16.76" id="img-be239761-157" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,11.88 L 104.55 11.88" id="img-be239761-158" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,7 L 104.55 7" id="img-be239761-159" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,2.12 L 104.55 2.12" id="img-be239761-160" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-2.76 L 104.55 -2.76" id="img-be239761-161" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-7.65 L 104.55 -7.65" id="img-be239761-162" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-12.53 L 104.55 -12.53" id="img-be239761-163" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-17.41 L 104.55 -17.41" id="img-be239761-164" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-22.29 L 104.55 -22.29" id="img-be239761-165" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-27.18 L 104.55 -27.18" id="img-be239761-166" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-32.06 L 104.55 -32.06" id="img-be239761-167" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-36.94 L 104.55 -36.94" id="img-be239761-168" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-41.82 L 104.55 -41.82" id="img-be239761-169" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-46.71 L 104.55 -46.71" id="img-be239761-170" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-51.59 L 104.55 -51.59" id="img-be239761-171" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-56.47 L 104.55 -56.47" id="img-be239761-172" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-61.35 L 104.55 -61.35" id="img-be239761-173" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M14.54,-66.23 L 104.55 -66.23" id="img-be239761-174" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="guide xgridlines yfixed" stroke-dasharray="0.5,0.5" stroke-width="0.2" stroke="#D0D0E0" id="img-be239761-175">
      <path fill="none" d="M-112.48,5 L -112.48 82.23" id="img-be239761-176" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-69.47,5 L -69.47 82.23" id="img-be239761-177" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-26.47,5 L -26.47 82.23" id="img-be239761-178" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-be239761-179" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M59.54,5 L 59.54 82.23" id="img-be239761-180" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M102.55,5 L 102.55 82.23" id="img-be239761-181" visibility="visible" gadfly:scale="1.0"/>
      <path fill="none" d="M145.55,5 L 145.55 82.23" id="img-be239761-182" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M188.56,5 L 188.56 82.23" id="img-be239761-183" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M231.56,5 L 231.56 82.23" id="img-be239761-184" visibility="hidden" gadfly:scale="1.0"/>
      <path fill="none" d="M-69.47,5 L -69.47 82.23" id="img-be239761-185" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-65.17,5 L -65.17 82.23" id="img-be239761-186" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-60.87,5 L -60.87 82.23" id="img-be239761-187" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-56.57,5 L -56.57 82.23" id="img-be239761-188" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-52.27,5 L -52.27 82.23" id="img-be239761-189" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-47.97,5 L -47.97 82.23" id="img-be239761-190" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-43.67,5 L -43.67 82.23" id="img-be239761-191" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-39.37,5 L -39.37 82.23" id="img-be239761-192" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-35.07,5 L -35.07 82.23" id="img-be239761-193" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-30.77,5 L -30.77 82.23" id="img-be239761-194" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-26.47,5 L -26.47 82.23" id="img-be239761-195" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-22.17,5 L -22.17 82.23" id="img-be239761-196" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-17.87,5 L -17.87 82.23" id="img-be239761-197" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-13.57,5 L -13.57 82.23" id="img-be239761-198" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-9.26,5 L -9.26 82.23" id="img-be239761-199" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-4.96,5 L -4.96 82.23" id="img-be239761-200" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-0.66,5 L -0.66 82.23" id="img-be239761-201" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M3.64,5 L 3.64 82.23" id="img-be239761-202" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M7.94,5 L 7.94 82.23" id="img-be239761-203" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M12.24,5 L 12.24 82.23" id="img-be239761-204" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-be239761-205" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M20.84,5 L 20.84 82.23" id="img-be239761-206" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M25.14,5 L 25.14 82.23" id="img-be239761-207" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M29.44,5 L 29.44 82.23" id="img-be239761-208" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M33.74,5 L 33.74 82.23" id="img-be239761-209" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M38.04,5 L 38.04 82.23" id="img-be239761-210" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M42.34,5 L 42.34 82.23" id="img-be239761-211" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M46.64,5 L 46.64 82.23" id="img-be239761-212" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M50.94,5 L 50.94 82.23" id="img-be239761-213" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M55.24,5 L 55.24 82.23" id="img-be239761-214" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M59.54,5 L 59.54 82.23" id="img-be239761-215" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M63.84,5 L 63.84 82.23" id="img-be239761-216" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M68.14,5 L 68.14 82.23" id="img-be239761-217" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M72.44,5 L 72.44 82.23" id="img-be239761-218" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M76.74,5 L 76.74 82.23" id="img-be239761-219" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M81.04,5 L 81.04 82.23" id="img-be239761-220" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M85.34,5 L 85.34 82.23" id="img-be239761-221" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M89.65,5 L 89.65 82.23" id="img-be239761-222" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M93.95,5 L 93.95 82.23" id="img-be239761-223" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M98.25,5 L 98.25 82.23" id="img-be239761-224" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M102.55,5 L 102.55 82.23" id="img-be239761-225" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M106.85,5 L 106.85 82.23" id="img-be239761-226" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M111.15,5 L 111.15 82.23" id="img-be239761-227" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M115.45,5 L 115.45 82.23" id="img-be239761-228" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M119.75,5 L 119.75 82.23" id="img-be239761-229" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M124.05,5 L 124.05 82.23" id="img-be239761-230" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M128.35,5 L 128.35 82.23" id="img-be239761-231" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M132.65,5 L 132.65 82.23" id="img-be239761-232" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M136.95,5 L 136.95 82.23" id="img-be239761-233" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M141.25,5 L 141.25 82.23" id="img-be239761-234" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M145.55,5 L 145.55 82.23" id="img-be239761-235" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M149.85,5 L 149.85 82.23" id="img-be239761-236" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M154.15,5 L 154.15 82.23" id="img-be239761-237" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M158.45,5 L 158.45 82.23" id="img-be239761-238" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M162.75,5 L 162.75 82.23" id="img-be239761-239" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M167.05,5 L 167.05 82.23" id="img-be239761-240" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M171.35,5 L 171.35 82.23" id="img-be239761-241" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M175.65,5 L 175.65 82.23" id="img-be239761-242" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M179.95,5 L 179.95 82.23" id="img-be239761-243" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M184.26,5 L 184.26 82.23" id="img-be239761-244" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M188.56,5 L 188.56 82.23" id="img-be239761-245" visibility="hidden" gadfly:scale="10.0"/>
      <path fill="none" d="M-69.47,5 L -69.47 82.23" id="img-be239761-246" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-be239761-247" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M102.55,5 L 102.55 82.23" id="img-be239761-248" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M188.56,5 L 188.56 82.23" id="img-be239761-249" visibility="hidden" gadfly:scale="0.5"/>
      <path fill="none" d="M-69.47,5 L -69.47 82.23" id="img-be239761-250" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-60.87,5 L -60.87 82.23" id="img-be239761-251" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-52.27,5 L -52.27 82.23" id="img-be239761-252" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-43.67,5 L -43.67 82.23" id="img-be239761-253" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-35.07,5 L -35.07 82.23" id="img-be239761-254" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-26.47,5 L -26.47 82.23" id="img-be239761-255" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-17.87,5 L -17.87 82.23" id="img-be239761-256" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-9.26,5 L -9.26 82.23" id="img-be239761-257" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M-0.66,5 L -0.66 82.23" id="img-be239761-258" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M7.94,5 L 7.94 82.23" id="img-be239761-259" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M16.54,5 L 16.54 82.23" id="img-be239761-260" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M25.14,5 L 25.14 82.23" id="img-be239761-261" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M33.74,5 L 33.74 82.23" id="img-be239761-262" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M42.34,5 L 42.34 82.23" id="img-be239761-263" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M50.94,5 L 50.94 82.23" id="img-be239761-264" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M59.54,5 L 59.54 82.23" id="img-be239761-265" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M68.14,5 L 68.14 82.23" id="img-be239761-266" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M76.74,5 L 76.74 82.23" id="img-be239761-267" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M85.34,5 L 85.34 82.23" id="img-be239761-268" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M93.95,5 L 93.95 82.23" id="img-be239761-269" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M102.55,5 L 102.55 82.23" id="img-be239761-270" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M111.15,5 L 111.15 82.23" id="img-be239761-271" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M119.75,5 L 119.75 82.23" id="img-be239761-272" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M128.35,5 L 128.35 82.23" id="img-be239761-273" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M136.95,5 L 136.95 82.23" id="img-be239761-274" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M145.55,5 L 145.55 82.23" id="img-be239761-275" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M154.15,5 L 154.15 82.23" id="img-be239761-276" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M162.75,5 L 162.75 82.23" id="img-be239761-277" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M171.35,5 L 171.35 82.23" id="img-be239761-278" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M179.95,5 L 179.95 82.23" id="img-be239761-279" visibility="hidden" gadfly:scale="5.0"/>
      <path fill="none" d="M188.56,5 L 188.56 82.23" id="img-be239761-280" visibility="hidden" gadfly:scale="5.0"/>
    </g>
    <g class="plotpanel" id="img-be239761-281">
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_4" stroke-dasharray="none" stroke="#00B78D" id="img-be239761-282">
        <path fill="none" d="M17.4,35.79 L 18.26 28.61 19.12 22.67 19.98 18.44 20.84 16.25 21.7 16.24 22.56 18.36 23.42 22.38 24.28 27.88 25.14 34.32 26 41.09 26.86 47.53 27.72 53.02 28.58 57.03 29.44 59.16 30.3 59.18 31.16 57.05 32.02 52.92 32.88 47.13 33.74 40.17 34.6 32.62 35.46 25.13 36.32 18.36 37.18 12.87 38.04 9.14 38.9 7.48 39.76 8.03 40.62 10.73 41.48 15.32 42.34 21.38 43.2 28.38 44.06 35.67 44.92 42.62 45.78 48.6 46.64 53.08 47.5 55.68 48.36 56.16 49.22 54.51 50.08 50.88 50.94 45.62 51.8 39.21 52.66 32.26 53.52 25.41 54.38 19.3 55.24 14.5 56.1 11.48 56.96 10.54 57.82 11.8 58.68 15.19 59.54 20.44 60.4 27.13 61.26 34.69 62.12 42.51 62.98 49.93 63.84 56.33 64.7 61.2 65.56 64.13 66.42 64.93 67.28 63.57 68.14 60.23 69 55.25 69.86 49.14 70.72 42.49 71.58 35.95 72.44 30.16 73.3 25.68 74.16 22.97 75.02 22.33 75.88 23.86 76.74 27.47 77.6 32.9 78.46 39.71 79.32 47.34 80.18 55.15 81.04 62.49 81.9 68.75 82.76 73.41 83.62 76.1 84.48 76.62 85.34 74.96 86.2 71.3 87.07 66 87.93 59.57 88.79 52.61 89.65 45.78 90.51 39.69 91.37 34.93 92.23 31.94 93.09 30.99 93.95 32.2 94.81 35.47 95.67 40.5 96.53 46.87 97.39 54.01 98.25 61.28 99.11 68.03 99.97 73.65 100.83 77.64 101.69 79.63 102.55 79.44" id="img-be239761-283"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_3" stroke-dasharray="none" stroke="#FF6DAE" id="img-be239761-284">
        <path fill="none" d="M17.4,42.11 L 18.26 54.63 19.12 54.25 19.98 50.74 20.84 63.02 21.7 51.82 22.56 59.6 23.42 20.2 24.28 21.19 25.14 51.59 26 45.36 26.86 47.18 27.72 17.23 28.58 43.13 29.44 55.15 30.3 18.9 31.16 50.86 32.02 43.87 32.88 56.8 33.74 39.94 34.6 18.69 35.46 16.74 36.32 34.86 37.18 45.08 38.04 54.25 38.9 45.86 39.76 50.86 40.62 12.9 41.48 28.39 42.34 26.89 43.2 44.64 44.06 44.8 44.92 40.24 45.78 26.26 46.64 23 47.5 45.29 48.36 31.72 49.22 53.25 50.08 55.1 50.94 39.63 51.8 36.9 52.66 38.32 53.52 17.61 54.38 43.23 55.24 54.02 56.1 10.65 56.96 38.64 57.82 47.51 58.68 23.03 59.54 40.93 60.4 32.3 61.26 23.25 62.12 52.01 62.98 30.23 63.84 22.37 64.7 47.23 65.56 19.18 66.42 30.94 67.28 47.4 68.14 32.78 69 43.67 69.86 59.16 70.72 46.93 71.58 28.44 72.44 30.55 73.3 49.66 74.16 64.71 75.02 22.78 75.88 29.65 76.74 37.61 77.6 43.83 78.46 30.47 79.32 42.92 80.18 33.12 81.04 47.46 81.9 32.21 82.76 42.53 83.62 40.47 84.48 70.55 85.34 28.85 86.2 64.75 87.07 45.1 87.93 75.18 88.79 68.02 89.65 31.99 90.51 77.76 91.37 78.95 92.23 41.07 93.09 51.63 93.95 33.27 94.81 49.62 95.67 35.51 96.53 51.95 97.39 55.04 98.25 59.95 99.11 33.24 99.97 41.26 100.83 44.05 101.69 47.99 102.55 50.05" id="img-be239761-285"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_2" stroke-dasharray="none" stroke="#D4CA3A" id="img-be239761-286">
        <path fill="none" d="M17.4,35.95 L 18.26 35.95 19.12 30.73 19.98 25.64 20.84 30.48 21.7 25.75 22.56 32.63 23.42 17.79 24.28 24.63 25.14 47.08 26 51.53 26.86 59.65 27.72 50.9 28.58 68.58 29.44 77.41 30.3 59.96 31.16 74.42 32.02 67.39 32.88 68.62 33.74 53.73 34.6 36.04 35.46 28.01 36.32 30.69 37.18 30.66 38.04 31.83 38.9 26.24 39.76 29.52 40.62 13.41 41.48 25.88 42.34 31.28 43.2 47.19 44.06 54.56 44.92 59.18 45.78 58.08 46.64 60.79 47.5 74.34 48.36 67.81 49.22 76.65 50.08 73.63 50.94 60.27 51.8 52.1 52.66 45.42 53.52 27.73 54.38 33.9 55.24 33.95 56.1 8.65 56.96 21.08 57.82 26.11 58.68 16.57 59.54 30.05 60.4 31.68 61.26 33.95 62.12 55.35 62.98 51.06 63.84 52.7 64.7 69.14 65.56 57.17 66.42 62.97 67.28 68.95 68.14 57.39 69 56.95 69.86 57.67 70.72 43.99 71.58 27.29 72.44 21.64 73.3 25.81 74.16 29.73 75.02 7.23 75.88 11.32 76.74 18.05 77.6 25.74 78.46 25.03 79.32 38.08 80.18 40.2 81.04 53.94 81.9 51.84 82.76 60.95 83.62 61.94 84.48 76.85 85.34 53.72 86.2 67.43 87.07 51.76 87.93 59.87 88.79 48.86 89.65 23.58 90.51 39.99 91.37 35.48 92.23 13.24 93.09 17.32 93.95 9.13 94.81 20.4 95.67 18.26 96.53 32.77 97.39 41.41 98.25 51.15 99.11 44.6 99.97 54.33 100.83 59.87 101.69 64.03 102.55 65.1" id="img-be239761-287"/>
      </g>
      <g stroke-width="0.3" fill="#000000" fill-opacity="0.000" class="geometry color_Signal_1" stroke-dasharray="none" stroke="#00BFFF" id="img-be239761-288">
        <path fill="none" d="M17.4,38.95 L 18.26 41.62 19.12 38.46 19.98 34.59 20.84 39.63 21.7 34.03 22.56 38.98 23.42 21.29 24.28 24.53 25.14 42.96 26 43.22 26.86 47.36 27.72 35.12 28.58 50.08 29.44 57.16 30.3 39.04 31.16 53.95 32.02 48.39 32.88 51.97 33.74 40.05 34.6 25.66 35.46 20.94 36.32 26.61 37.18 28.97 38.04 31.69 38.9 26.67 39.76 29.45 40.62 11.81 41.48 21.85 42.34 24.13 43.2 36.51 44.06 40.24 44.92 41.43 45.78 37.43 46.64 38.04 47.5 50.49 48.36 43.94 49.22 53.88 50.08 52.99 50.94 42.62 51.8 38.06 52.66 35.29 53.52 21.51 54.38 31.26 55.24 34.26 56.1 11.06 56.96 24.59 57.82 29.65 58.68 19.11 59.54 30.68 60.4 29.71 61.26 28.97 62.12 47.26 62.98 40.08 63.84 39.35 64.7 54.21 65.56 41.65 66.42 47.94 67.28 55.49 68.14 46.5 69 49.46 69.86 54.15 70.72 44.71 71.58 32.19 72.44 30.35 73.3 37.67 74.16 43.84 75.02 22.56 75.88 26.75 76.74 32.54 77.6 38.37 78.46 35.09 79.32 45.13 80.18 44.13 81.04 54.97 81.9 50.48 82.76 57.97 83.62 58.29 84.48 73.58 85.34 51.91 86.2 68.03 87.07 55.55 87.93 67.38 88.79 60.32 89.65 38.88 90.51 58.72 91.37 56.94 92.23 36.5 93.09 41.31 93.95 32.74 94.81 42.55 95.67 38.01 96.53 49.41 97.39 54.53 98.25 60.61 99.11 50.63 99.97 57.45 100.83 60.85 101.69 63.81 102.55 64.75" id="img-be239761-289"/>
      </g>
    </g>
    <g opacity="0" class="guide zoomslider" stroke="#000000" stroke-opacity="0.000" id="img-be239761-290">
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-be239761-291">
        <rect x="97.55" y="8" width="4" height="4" id="img-be239761-292"/>
        <g class="button_logo" fill="#6A6A6A" id="img-be239761-293">
          <path d="M98.35,9.6 L 99.15 9.6 99.15 8.8 99.95 8.8 99.95 9.6 100.75 9.6 100.75 10.4 99.95 10.4 99.95 11.2 99.15 11.2 99.15 10.4 98.35 10.4 z" id="img-be239761-294"/>
        </g>
      </g>
      <g fill="#EAEAEA" id="img-be239761-295">
        <rect x="78.05" y="8" width="19" height="4" id="img-be239761-296"/>
      </g>
      <g class="zoomslider_thumb" fill="#6A6A6A" id="img-be239761-297">
        <rect x="86.55" y="8" width="2" height="4" id="img-be239761-298"/>
      </g>
      <g fill="#EAEAEA" stroke-width="0.3" stroke-opacity="0" stroke="#6A6A6A" id="img-be239761-299">
        <rect x="73.55" y="8" width="4" height="4" id="img-be239761-300"/>
        <g class="button_logo" fill="#6A6A6A" id="img-be239761-301">
          <path d="M74.35,9.6 L 76.75 9.6 76.75 10.4 74.35 10.4 z" id="img-be239761-302"/>
        </g>
      </g>
    </g>
  </g>
</g>
  <g class="guide ylabels" font-size="2.82" font-family="'PT Sans Caption','Helvetica Neue','Helvetica',sans-serif" fill="#6C606B" id="img-be239761-303">
    <text x="13.54" y="177.88" text-anchor="end" dy="0.35em" id="img-be239761-304" visibility="hidden" gadfly:scale="1.0">-4</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-be239761-305" visibility="hidden" gadfly:scale="1.0">-3</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-be239761-306" visibility="hidden" gadfly:scale="1.0">-2</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-be239761-307" visibility="hidden" gadfly:scale="1.0">-1</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-be239761-308" visibility="visible" gadfly:scale="1.0">0</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-be239761-309" visibility="visible" gadfly:scale="1.0">1</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-be239761-310" visibility="visible" gadfly:scale="1.0">2</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-be239761-311" visibility="visible" gadfly:scale="1.0">3</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-be239761-312" visibility="hidden" gadfly:scale="1.0">4</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-be239761-313" visibility="hidden" gadfly:scale="1.0">5</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-be239761-314" visibility="hidden" gadfly:scale="1.0">6</text>
    <text x="13.54" y="-90.65" text-anchor="end" dy="0.35em" id="img-be239761-315" visibility="hidden" gadfly:scale="1.0">7</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-be239761-316" visibility="hidden" gadfly:scale="10.0">-3.0</text>
    <text x="13.54" y="151.03" text-anchor="end" dy="0.35em" id="img-be239761-317" visibility="hidden" gadfly:scale="10.0">-2.9</text>
    <text x="13.54" y="148.59" text-anchor="end" dy="0.35em" id="img-be239761-318" visibility="hidden" gadfly:scale="10.0">-2.8</text>
    <text x="13.54" y="146.15" text-anchor="end" dy="0.35em" id="img-be239761-319" visibility="hidden" gadfly:scale="10.0">-2.7</text>
    <text x="13.54" y="143.7" text-anchor="end" dy="0.35em" id="img-be239761-320" visibility="hidden" gadfly:scale="10.0">-2.6</text>
    <text x="13.54" y="141.26" text-anchor="end" dy="0.35em" id="img-be239761-321" visibility="hidden" gadfly:scale="10.0">-2.5</text>
    <text x="13.54" y="138.82" text-anchor="end" dy="0.35em" id="img-be239761-322" visibility="hidden" gadfly:scale="10.0">-2.4</text>
    <text x="13.54" y="136.38" text-anchor="end" dy="0.35em" id="img-be239761-323" visibility="hidden" gadfly:scale="10.0">-2.3</text>
    <text x="13.54" y="133.94" text-anchor="end" dy="0.35em" id="img-be239761-324" visibility="hidden" gadfly:scale="10.0">-2.2</text>
    <text x="13.54" y="131.5" text-anchor="end" dy="0.35em" id="img-be239761-325" visibility="hidden" gadfly:scale="10.0">-2.1</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-be239761-326" visibility="hidden" gadfly:scale="10.0">-2.0</text>
    <text x="13.54" y="126.62" text-anchor="end" dy="0.35em" id="img-be239761-327" visibility="hidden" gadfly:scale="10.0">-1.9</text>
    <text x="13.54" y="124.18" text-anchor="end" dy="0.35em" id="img-be239761-328" visibility="hidden" gadfly:scale="10.0">-1.8</text>
    <text x="13.54" y="121.73" text-anchor="end" dy="0.35em" id="img-be239761-329" visibility="hidden" gadfly:scale="10.0">-1.7</text>
    <text x="13.54" y="119.29" text-anchor="end" dy="0.35em" id="img-be239761-330" visibility="hidden" gadfly:scale="10.0">-1.6</text>
    <text x="13.54" y="116.85" text-anchor="end" dy="0.35em" id="img-be239761-331" visibility="hidden" gadfly:scale="10.0">-1.5</text>
    <text x="13.54" y="114.41" text-anchor="end" dy="0.35em" id="img-be239761-332" visibility="hidden" gadfly:scale="10.0">-1.4</text>
    <text x="13.54" y="111.97" text-anchor="end" dy="0.35em" id="img-be239761-333" visibility="hidden" gadfly:scale="10.0">-1.3</text>
    <text x="13.54" y="109.53" text-anchor="end" dy="0.35em" id="img-be239761-334" visibility="hidden" gadfly:scale="10.0">-1.2</text>
    <text x="13.54" y="107.09" text-anchor="end" dy="0.35em" id="img-be239761-335" visibility="hidden" gadfly:scale="10.0">-1.1</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-be239761-336" visibility="hidden" gadfly:scale="10.0">-1.0</text>
    <text x="13.54" y="102.2" text-anchor="end" dy="0.35em" id="img-be239761-337" visibility="hidden" gadfly:scale="10.0">-0.9</text>
    <text x="13.54" y="99.76" text-anchor="end" dy="0.35em" id="img-be239761-338" visibility="hidden" gadfly:scale="10.0">-0.8</text>
    <text x="13.54" y="97.32" text-anchor="end" dy="0.35em" id="img-be239761-339" visibility="hidden" gadfly:scale="10.0">-0.7</text>
    <text x="13.54" y="94.88" text-anchor="end" dy="0.35em" id="img-be239761-340" visibility="hidden" gadfly:scale="10.0">-0.6</text>
    <text x="13.54" y="92.44" text-anchor="end" dy="0.35em" id="img-be239761-341" visibility="hidden" gadfly:scale="10.0">-0.5</text>
    <text x="13.54" y="90" text-anchor="end" dy="0.35em" id="img-be239761-342" visibility="hidden" gadfly:scale="10.0">-0.4</text>
    <text x="13.54" y="87.56" text-anchor="end" dy="0.35em" id="img-be239761-343" visibility="hidden" gadfly:scale="10.0">-0.3</text>
    <text x="13.54" y="85.12" text-anchor="end" dy="0.35em" id="img-be239761-344" visibility="hidden" gadfly:scale="10.0">-0.2</text>
    <text x="13.54" y="82.68" text-anchor="end" dy="0.35em" id="img-be239761-345" visibility="hidden" gadfly:scale="10.0">-0.1</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-be239761-346" visibility="hidden" gadfly:scale="10.0">0.0</text>
    <text x="13.54" y="77.79" text-anchor="end" dy="0.35em" id="img-be239761-347" visibility="hidden" gadfly:scale="10.0">0.1</text>
    <text x="13.54" y="75.35" text-anchor="end" dy="0.35em" id="img-be239761-348" visibility="hidden" gadfly:scale="10.0">0.2</text>
    <text x="13.54" y="72.91" text-anchor="end" dy="0.35em" id="img-be239761-349" visibility="hidden" gadfly:scale="10.0">0.3</text>
    <text x="13.54" y="70.47" text-anchor="end" dy="0.35em" id="img-be239761-350" visibility="hidden" gadfly:scale="10.0">0.4</text>
    <text x="13.54" y="68.03" text-anchor="end" dy="0.35em" id="img-be239761-351" visibility="hidden" gadfly:scale="10.0">0.5</text>
    <text x="13.54" y="65.59" text-anchor="end" dy="0.35em" id="img-be239761-352" visibility="hidden" gadfly:scale="10.0">0.6</text>
    <text x="13.54" y="63.15" text-anchor="end" dy="0.35em" id="img-be239761-353" visibility="hidden" gadfly:scale="10.0">0.7</text>
    <text x="13.54" y="60.71" text-anchor="end" dy="0.35em" id="img-be239761-354" visibility="hidden" gadfly:scale="10.0">0.8</text>
    <text x="13.54" y="58.26" text-anchor="end" dy="0.35em" id="img-be239761-355" visibility="hidden" gadfly:scale="10.0">0.9</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-be239761-356" visibility="hidden" gadfly:scale="10.0">1.0</text>
    <text x="13.54" y="53.38" text-anchor="end" dy="0.35em" id="img-be239761-357" visibility="hidden" gadfly:scale="10.0">1.1</text>
    <text x="13.54" y="50.94" text-anchor="end" dy="0.35em" id="img-be239761-358" visibility="hidden" gadfly:scale="10.0">1.2</text>
    <text x="13.54" y="48.5" text-anchor="end" dy="0.35em" id="img-be239761-359" visibility="hidden" gadfly:scale="10.0">1.3</text>
    <text x="13.54" y="46.06" text-anchor="end" dy="0.35em" id="img-be239761-360" visibility="hidden" gadfly:scale="10.0">1.4</text>
    <text x="13.54" y="43.62" text-anchor="end" dy="0.35em" id="img-be239761-361" visibility="hidden" gadfly:scale="10.0">1.5</text>
    <text x="13.54" y="41.18" text-anchor="end" dy="0.35em" id="img-be239761-362" visibility="hidden" gadfly:scale="10.0">1.6</text>
    <text x="13.54" y="38.73" text-anchor="end" dy="0.35em" id="img-be239761-363" visibility="hidden" gadfly:scale="10.0">1.7</text>
    <text x="13.54" y="36.29" text-anchor="end" dy="0.35em" id="img-be239761-364" visibility="hidden" gadfly:scale="10.0">1.8</text>
    <text x="13.54" y="33.85" text-anchor="end" dy="0.35em" id="img-be239761-365" visibility="hidden" gadfly:scale="10.0">1.9</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-be239761-366" visibility="hidden" gadfly:scale="10.0">2.0</text>
    <text x="13.54" y="28.97" text-anchor="end" dy="0.35em" id="img-be239761-367" visibility="hidden" gadfly:scale="10.0">2.1</text>
    <text x="13.54" y="26.53" text-anchor="end" dy="0.35em" id="img-be239761-368" visibility="hidden" gadfly:scale="10.0">2.2</text>
    <text x="13.54" y="24.09" text-anchor="end" dy="0.35em" id="img-be239761-369" visibility="hidden" gadfly:scale="10.0">2.3</text>
    <text x="13.54" y="21.65" text-anchor="end" dy="0.35em" id="img-be239761-370" visibility="hidden" gadfly:scale="10.0">2.4</text>
    <text x="13.54" y="19.21" text-anchor="end" dy="0.35em" id="img-be239761-371" visibility="hidden" gadfly:scale="10.0">2.5</text>
    <text x="13.54" y="16.76" text-anchor="end" dy="0.35em" id="img-be239761-372" visibility="hidden" gadfly:scale="10.0">2.6</text>
    <text x="13.54" y="14.32" text-anchor="end" dy="0.35em" id="img-be239761-373" visibility="hidden" gadfly:scale="10.0">2.7</text>
    <text x="13.54" y="11.88" text-anchor="end" dy="0.35em" id="img-be239761-374" visibility="hidden" gadfly:scale="10.0">2.8</text>
    <text x="13.54" y="9.44" text-anchor="end" dy="0.35em" id="img-be239761-375" visibility="hidden" gadfly:scale="10.0">2.9</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-be239761-376" visibility="hidden" gadfly:scale="10.0">3.0</text>
    <text x="13.54" y="4.56" text-anchor="end" dy="0.35em" id="img-be239761-377" visibility="hidden" gadfly:scale="10.0">3.1</text>
    <text x="13.54" y="2.12" text-anchor="end" dy="0.35em" id="img-be239761-378" visibility="hidden" gadfly:scale="10.0">3.2</text>
    <text x="13.54" y="-0.32" text-anchor="end" dy="0.35em" id="img-be239761-379" visibility="hidden" gadfly:scale="10.0">3.3</text>
    <text x="13.54" y="-2.76" text-anchor="end" dy="0.35em" id="img-be239761-380" visibility="hidden" gadfly:scale="10.0">3.4</text>
    <text x="13.54" y="-5.21" text-anchor="end" dy="0.35em" id="img-be239761-381" visibility="hidden" gadfly:scale="10.0">3.5</text>
    <text x="13.54" y="-7.65" text-anchor="end" dy="0.35em" id="img-be239761-382" visibility="hidden" gadfly:scale="10.0">3.6</text>
    <text x="13.54" y="-10.09" text-anchor="end" dy="0.35em" id="img-be239761-383" visibility="hidden" gadfly:scale="10.0">3.7</text>
    <text x="13.54" y="-12.53" text-anchor="end" dy="0.35em" id="img-be239761-384" visibility="hidden" gadfly:scale="10.0">3.8</text>
    <text x="13.54" y="-14.97" text-anchor="end" dy="0.35em" id="img-be239761-385" visibility="hidden" gadfly:scale="10.0">3.9</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-be239761-386" visibility="hidden" gadfly:scale="10.0">4.0</text>
    <text x="13.54" y="-19.85" text-anchor="end" dy="0.35em" id="img-be239761-387" visibility="hidden" gadfly:scale="10.0">4.1</text>
    <text x="13.54" y="-22.29" text-anchor="end" dy="0.35em" id="img-be239761-388" visibility="hidden" gadfly:scale="10.0">4.2</text>
    <text x="13.54" y="-24.73" text-anchor="end" dy="0.35em" id="img-be239761-389" visibility="hidden" gadfly:scale="10.0">4.3</text>
    <text x="13.54" y="-27.18" text-anchor="end" dy="0.35em" id="img-be239761-390" visibility="hidden" gadfly:scale="10.0">4.4</text>
    <text x="13.54" y="-29.62" text-anchor="end" dy="0.35em" id="img-be239761-391" visibility="hidden" gadfly:scale="10.0">4.5</text>
    <text x="13.54" y="-32.06" text-anchor="end" dy="0.35em" id="img-be239761-392" visibility="hidden" gadfly:scale="10.0">4.6</text>
    <text x="13.54" y="-34.5" text-anchor="end" dy="0.35em" id="img-be239761-393" visibility="hidden" gadfly:scale="10.0">4.7</text>
    <text x="13.54" y="-36.94" text-anchor="end" dy="0.35em" id="img-be239761-394" visibility="hidden" gadfly:scale="10.0">4.8</text>
    <text x="13.54" y="-39.38" text-anchor="end" dy="0.35em" id="img-be239761-395" visibility="hidden" gadfly:scale="10.0">4.9</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-be239761-396" visibility="hidden" gadfly:scale="10.0">5.0</text>
    <text x="13.54" y="-44.26" text-anchor="end" dy="0.35em" id="img-be239761-397" visibility="hidden" gadfly:scale="10.0">5.1</text>
    <text x="13.54" y="-46.71" text-anchor="end" dy="0.35em" id="img-be239761-398" visibility="hidden" gadfly:scale="10.0">5.2</text>
    <text x="13.54" y="-49.15" text-anchor="end" dy="0.35em" id="img-be239761-399" visibility="hidden" gadfly:scale="10.0">5.3</text>
    <text x="13.54" y="-51.59" text-anchor="end" dy="0.35em" id="img-be239761-400" visibility="hidden" gadfly:scale="10.0">5.4</text>
    <text x="13.54" y="-54.03" text-anchor="end" dy="0.35em" id="img-be239761-401" visibility="hidden" gadfly:scale="10.0">5.5</text>
    <text x="13.54" y="-56.47" text-anchor="end" dy="0.35em" id="img-be239761-402" visibility="hidden" gadfly:scale="10.0">5.6</text>
    <text x="13.54" y="-58.91" text-anchor="end" dy="0.35em" id="img-be239761-403" visibility="hidden" gadfly:scale="10.0">5.7</text>
    <text x="13.54" y="-61.35" text-anchor="end" dy="0.35em" id="img-be239761-404" visibility="hidden" gadfly:scale="10.0">5.8</text>
    <text x="13.54" y="-63.79" text-anchor="end" dy="0.35em" id="img-be239761-405" visibility="hidden" gadfly:scale="10.0">5.9</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-be239761-406" visibility="hidden" gadfly:scale="10.0">6.0</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-be239761-407" visibility="hidden" gadfly:scale="0.5">-3</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-be239761-408" visibility="hidden" gadfly:scale="0.5">0</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-be239761-409" visibility="hidden" gadfly:scale="0.5">3</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-be239761-410" visibility="hidden" gadfly:scale="0.5">6</text>
    <text x="13.54" y="153.47" text-anchor="end" dy="0.35em" id="img-be239761-411" visibility="hidden" gadfly:scale="5.0">-3.0</text>
    <text x="13.54" y="148.59" text-anchor="end" dy="0.35em" id="img-be239761-412" visibility="hidden" gadfly:scale="5.0">-2.8</text>
    <text x="13.54" y="143.7" text-anchor="end" dy="0.35em" id="img-be239761-413" visibility="hidden" gadfly:scale="5.0">-2.6</text>
    <text x="13.54" y="138.82" text-anchor="end" dy="0.35em" id="img-be239761-414" visibility="hidden" gadfly:scale="5.0">-2.4</text>
    <text x="13.54" y="133.94" text-anchor="end" dy="0.35em" id="img-be239761-415" visibility="hidden" gadfly:scale="5.0">-2.2</text>
    <text x="13.54" y="129.06" text-anchor="end" dy="0.35em" id="img-be239761-416" visibility="hidden" gadfly:scale="5.0">-2.0</text>
    <text x="13.54" y="124.18" text-anchor="end" dy="0.35em" id="img-be239761-417" visibility="hidden" gadfly:scale="5.0">-1.8</text>
    <text x="13.54" y="119.29" text-anchor="end" dy="0.35em" id="img-be239761-418" visibility="hidden" gadfly:scale="5.0">-1.6</text>
    <text x="13.54" y="114.41" text-anchor="end" dy="0.35em" id="img-be239761-419" visibility="hidden" gadfly:scale="5.0">-1.4</text>
    <text x="13.54" y="109.53" text-anchor="end" dy="0.35em" id="img-be239761-420" visibility="hidden" gadfly:scale="5.0">-1.2</text>
    <text x="13.54" y="104.65" text-anchor="end" dy="0.35em" id="img-be239761-421" visibility="hidden" gadfly:scale="5.0">-1.0</text>
    <text x="13.54" y="99.76" text-anchor="end" dy="0.35em" id="img-be239761-422" visibility="hidden" gadfly:scale="5.0">-0.8</text>
    <text x="13.54" y="94.88" text-anchor="end" dy="0.35em" id="img-be239761-423" visibility="hidden" gadfly:scale="5.0">-0.6</text>
    <text x="13.54" y="90" text-anchor="end" dy="0.35em" id="img-be239761-424" visibility="hidden" gadfly:scale="5.0">-0.4</text>
    <text x="13.54" y="85.12" text-anchor="end" dy="0.35em" id="img-be239761-425" visibility="hidden" gadfly:scale="5.0">-0.2</text>
    <text x="13.54" y="80.23" text-anchor="end" dy="0.35em" id="img-be239761-426" visibility="hidden" gadfly:scale="5.0">0.0</text>
    <text x="13.54" y="75.35" text-anchor="end" dy="0.35em" id="img-be239761-427" visibility="hidden" gadfly:scale="5.0">0.2</text>
    <text x="13.54" y="70.47" text-anchor="end" dy="0.35em" id="img-be239761-428" visibility="hidden" gadfly:scale="5.0">0.4</text>
    <text x="13.54" y="65.59" text-anchor="end" dy="0.35em" id="img-be239761-429" visibility="hidden" gadfly:scale="5.0">0.6</text>
    <text x="13.54" y="60.71" text-anchor="end" dy="0.35em" id="img-be239761-430" visibility="hidden" gadfly:scale="5.0">0.8</text>
    <text x="13.54" y="55.82" text-anchor="end" dy="0.35em" id="img-be239761-431" visibility="hidden" gadfly:scale="5.0">1.0</text>
    <text x="13.54" y="50.94" text-anchor="end" dy="0.35em" id="img-be239761-432" visibility="hidden" gadfly:scale="5.0">1.2</text>
    <text x="13.54" y="46.06" text-anchor="end" dy="0.35em" id="img-be239761-433" visibility="hidden" gadfly:scale="5.0">1.4</text>
    <text x="13.54" y="41.18" text-anchor="end" dy="0.35em" id="img-be239761-434" visibility="hidden" gadfly:scale="5.0">1.6</text>
    <text x="13.54" y="36.29" text-anchor="end" dy="0.35em" id="img-be239761-435" visibility="hidden" gadfly:scale="5.0">1.8</text>
    <text x="13.54" y="31.41" text-anchor="end" dy="0.35em" id="img-be239761-436" visibility="hidden" gadfly:scale="5.0">2.0</text>
    <text x="13.54" y="26.53" text-anchor="end" dy="0.35em" id="img-be239761-437" visibility="hidden" gadfly:scale="5.0">2.2</text>
    <text x="13.54" y="21.65" text-anchor="end" dy="0.35em" id="img-be239761-438" visibility="hidden" gadfly:scale="5.0">2.4</text>
    <text x="13.54" y="16.76" text-anchor="end" dy="0.35em" id="img-be239761-439" visibility="hidden" gadfly:scale="5.0">2.6</text>
    <text x="13.54" y="11.88" text-anchor="end" dy="0.35em" id="img-be239761-440" visibility="hidden" gadfly:scale="5.0">2.8</text>
    <text x="13.54" y="7" text-anchor="end" dy="0.35em" id="img-be239761-441" visibility="hidden" gadfly:scale="5.0">3.0</text>
    <text x="13.54" y="2.12" text-anchor="end" dy="0.35em" id="img-be239761-442" visibility="hidden" gadfly:scale="5.0">3.2</text>
    <text x="13.54" y="-2.76" text-anchor="end" dy="0.35em" id="img-be239761-443" visibility="hidden" gadfly:scale="5.0">3.4</text>
    <text x="13.54" y="-7.65" text-anchor="end" dy="0.35em" id="img-be239761-444" visibility="hidden" gadfly:scale="5.0">3.6</text>
    <text x="13.54" y="-12.53" text-anchor="end" dy="0.35em" id="img-be239761-445" visibility="hidden" gadfly:scale="5.0">3.8</text>
    <text x="13.54" y="-17.41" text-anchor="end" dy="0.35em" id="img-be239761-446" visibility="hidden" gadfly:scale="5.0">4.0</text>
    <text x="13.54" y="-22.29" text-anchor="end" dy="0.35em" id="img-be239761-447" visibility="hidden" gadfly:scale="5.0">4.2</text>
    <text x="13.54" y="-27.18" text-anchor="end" dy="0.35em" id="img-be239761-448" visibility="hidden" gadfly:scale="5.0">4.4</text>
    <text x="13.54" y="-32.06" text-anchor="end" dy="0.35em" id="img-be239761-449" visibility="hidden" gadfly:scale="5.0">4.6</text>
    <text x="13.54" y="-36.94" text-anchor="end" dy="0.35em" id="img-be239761-450" visibility="hidden" gadfly:scale="5.0">4.8</text>
    <text x="13.54" y="-41.82" text-anchor="end" dy="0.35em" id="img-be239761-451" visibility="hidden" gadfly:scale="5.0">5.0</text>
    <text x="13.54" y="-46.71" text-anchor="end" dy="0.35em" id="img-be239761-452" visibility="hidden" gadfly:scale="5.0">5.2</text>
    <text x="13.54" y="-51.59" text-anchor="end" dy="0.35em" id="img-be239761-453" visibility="hidden" gadfly:scale="5.0">5.4</text>
    <text x="13.54" y="-56.47" text-anchor="end" dy="0.35em" id="img-be239761-454" visibility="hidden" gadfly:scale="5.0">5.6</text>
    <text x="13.54" y="-61.35" text-anchor="end" dy="0.35em" id="img-be239761-455" visibility="hidden" gadfly:scale="5.0">5.8</text>
    <text x="13.54" y="-66.23" text-anchor="end" dy="0.35em" id="img-be239761-456" visibility="hidden" gadfly:scale="5.0">6.0</text>
  </g>
  <g font-size="3.88" font-family="'PT Sans','Helvetica Neue','Helvetica',sans-serif" fill="#564A55" stroke="#000000" stroke-opacity="0.000" id="img-be239761-457">
    <text x="9.11" y="43.62" text-anchor="end" dy="0.35em" id="img-be239761-458">Y</text>
  </g>
</g>
<defs>
  <clipPath id="img-be239761-17">
  <path d="M14.54,5 L 104.55 5 104.55 82.23 14.54 82.23" />
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

        this.node.addEventListener(
            /Firefox/i.test(navigator.userAgent) ? "DOMMouseScroll" : "mousewheel",
            fn2);

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


// When the plot is moused over, emphasize the grid lines.
Gadfly.plot_mouseover = function(event) {
    var root = this.plotroot();

    var keyboard_zoom = function(event) {
        if (event.which == 187) { // plus
            increase_zoom_by_position(root, 0.1, true);
        } else if (event.which == 189) { // minus
            increase_zoom_by_position(root, -0.1, true);
        }
    };
    root.data("keyboard_zoom", keyboard_zoom);
    window.addEventListener("keyup", keyboard_zoom);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    xgridlines.data("unfocused_strokedash",
                    xgridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));
    ygridlines.data("unfocused_strokedash",
                    ygridlines.attribute("stroke-dasharray").replace(/(\d)(,|$)/g, "$1mm$2"));

    // emphasize grid lines
    var destcolor = root.data("focused_xgrid_color");
    xgridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("focused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", "none")
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // reveal zoom slider
    root.select(".zoomslider")
        .animate({opacity: 1.0}, 250);
};

// Reset pan and zoom on double click
Gadfly.plot_dblclick = function(event) {
  set_plot_pan_zoom(this.plotroot(), 0.0, 0.0, 1.0);
};

// Unemphasize grid lines on mouse out.
Gadfly.plot_mouseout = function(event) {
    var root = this.plotroot();

    window.removeEventListener("keyup", root.data("keyboard_zoom"));
    root.data("keyboard_zoom", undefined);

    var xgridlines = root.select(".xgridlines"),
        ygridlines = root.select(".ygridlines");

    var destcolor = root.data("unfocused_xgrid_color");

    xgridlines.attribute("stroke-dasharray", xgridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    destcolor = root.data("unfocused_ygrid_color");
    ygridlines.attribute("stroke-dasharray", ygridlines.data("unfocused_strokedash"))
              .selectAll("path")
              .animate({stroke: destcolor}, 250);

    // hide zoom slider
    root.select(".zoomslider")
        .animate({opacity: 0.0}, 250);
};


var set_geometry_transform = function(root, tx, ty, scale) {
    var xscalable = root.hasClass("xscalable"),
        yscalable = root.hasClass("yscalable");

    var old_scale = root.data("scale");

    var xscale = xscalable ? scale : 1.0,
        yscale = yscalable ? scale : 1.0;

    tx = xscalable ? tx : 0.0;
    ty = yscalable ? ty : 0.0;

    var t = new Snap.Matrix().translate(tx, ty).scale(xscale, yscale);

    root.selectAll(".geometry, image")
        .forEach(function (element, i) {
            element.transform(t);
        });

    bounds = root.plotbounds();

    if (yscalable) {
        var xfixed_t = new Snap.Matrix().translate(0, ty).scale(1.0, yscale);
        root.selectAll(".xfixed")
            .forEach(function (element, i) {
                element.transform(xfixed_t);
            });

        root.select(".ylabels")
            .transform(xfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1, 1/scale, cx, cy).add(st);
                    element.transform(unscale_t);

                    var y = cy * scale + ty;
                    element.attr("visibility",
                        bounds.y0 <= y && y <= bounds.y1 ? "visible" : "hidden");
                }
            });
    }

    if (xscalable) {
        var yfixed_t = new Snap.Matrix().translate(tx, 0).scale(xscale, 1.0);
        var xtrans = new Snap.Matrix().translate(tx, 0);
        root.selectAll(".yfixed")
            .forEach(function (element, i) {
                element.transform(yfixed_t);
            });

        root.select(".xlabels")
            .transform(yfixed_t)
            .selectAll("text")
            .forEach(function (element, i) {
                if (element.attribute("gadfly:inscale") == "true") {
                    var cx = element.asPX("x"),
                        cy = element.asPX("y");
                    var st = element.data("static_transform");
                    unscale_t = new Snap.Matrix();
                    unscale_t.scale(1/scale, 1, cx, cy).add(st);

                    element.transform(unscale_t);

                    var x = cx * scale + tx;
                    element.attr("visibility",
                        bounds.x0 <= x && x <= bounds.x1 ? "visible" : "hidden");
                    }
            });
    }

    // we must unscale anything that is scale invariance: widths, raiduses, etc.
    var size_attribs = ["font-size"];
    var unscaled_selection = ".geometry, .geometry *";
    if (xscalable) {
        size_attribs.push("rx");
        unscaled_selection += ", .xgridlines";
    }
    if (yscalable) {
        size_attribs.push("ry");
        unscaled_selection += ", .ygridlines";
    }

    root.selectAll(unscaled_selection)
        .forEach(function (element, i) {
            // circle need special help
            if (element.node.nodeName == "circle") {
                var cx = element.attribute("cx"),
                    cy = element.attribute("cy");
                unscale_t = new Snap.Matrix().scale(1/xscale, 1/yscale,
                                                        cx, cy);
                element.transform(unscale_t);
                return;
            }

            for (i in size_attribs) {
                var key = size_attribs[i];
                var val = parseFloat(element.attribute(key));
                if (val !== undefined && val != 0 && !isNaN(val)) {
                    element.attribute(key, val * old_scale / scale);
                }
            }
        });
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
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        var mark_inscale_labels = function (element, i) {
            var inscale = element.attr("gadfly:scale") == best_tickscale;
            element.attribute("gadfly:inscale", inscale);
            element.attr("visibility", inscale ? "visible" : "hidden");
        };

        root.select("." + axis + "gridlines").selectAll("path").forEach(mark_inscale_gridlines);
        root.select("." + axis + "labels").selectAll("text").forEach(mark_inscale_labels);
    }
};


var set_plot_pan_zoom = function(root, tx, ty, scale) {
    var old_scale = root.data("scale");
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    // compute the viewport derived from tx, ty, and scale
    var x_min = -width * scale - (scale * width - width),
        x_max = width * scale,
        y_min = -height * scale - (scale * height - height),
        y_max = height * scale;

    var x0 = bounds.x0 - scale * bounds.x0,
        y0 = bounds.y0 - scale * bounds.y0;

    var tx = Math.max(Math.min(tx - x0, x_max), x_min),
        ty = Math.max(Math.min(ty - y0, y_max), y_min);

    tx += x0;
    ty += y0;

    // when the scale change, we may need to alter which set of
    // ticks is being displayed
    if (scale != old_scale) {
        update_tickscale(root, scale, "x");
        update_tickscale(root, scale, "y");
    }

    set_geometry_transform(root, tx, ty, scale);

    root.data("scale", scale);
    root.data("tx", tx);
    root.data("ty", ty);
};


var scale_centered_translation = function(root, scale) {
    var bounds = root.plotbounds();

    var width = bounds.x1 - bounds.x0,
        height = bounds.y1 - bounds.y0;

    var tx0 = root.data("tx"),
        ty0 = root.data("ty");

    var scale0 = root.data("scale");

    // how off from center the current view is
    var xoff = tx0 - (bounds.x0 * (1 - scale0) + (width * (1 - scale0)) / 2),
        yoff = ty0 - (bounds.y0 * (1 - scale0) + (height * (1 - scale0)) / 2);

    // rescale offsets
    xoff = xoff * scale / scale0;
    yoff = yoff * scale / scale0;

    // adjust for the panel position being scaled
    var x_edge_adjust = bounds.x0 * (1 - scale),
        y_edge_adjust = bounds.y0 * (1 - scale);

    return {
        x: xoff + x_edge_adjust + (width - width * scale) / 2,
        y: yoff + y_edge_adjust + (height - height * scale) / 2
    };
};


// Initialize data for panning zooming if it isn't already.
var init_pan_zoom = function(root) {
    if (root.data("zoompan-ready")) {
        return;
    }

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
    root.selectAll(".xlabels > text, .ylabels > text")
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
    if (root.data("scale") === undefined) root.data("scale", 1.0);
    if (root.data("xtickscales") === undefined) {

        // index all the tick scales that are listed
        var xtickscales = {};
        var ytickscales = {};
        var add_x_tick_scales = function (element, i) {
            xtickscales[element.attribute("gadfly:scale")] = true;
        };
        var add_y_tick_scales = function (element, i) {
            ytickscales[element.attribute("gadfly:scale")] = true;
        };

        if (xgridlines) xgridlines.selectAll("path").forEach(add_x_tick_scales);
        if (ygridlines) ygridlines.selectAll("path").forEach(add_y_tick_scales);
        if (xlabels) xlabels.selectAll("text").forEach(add_x_tick_scales);
        if (ylabels) ylabels.selectAll("text").forEach(add_y_tick_scales);

        root.data("xtickscales", xtickscales);
        root.data("ytickscales", ytickscales);
        root.data("xtickscale", 1.0);
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
        xlabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("x", element.asPX("x"));
               });
    }

    if (ylabels) {
        ylabels.selectAll("text")
               .forEach(function (element, i) {
                   element.data("y", element.asPX("y"));
               });
    }

    // mark grid lines and ticks as in or out of scale.
    var mark_inscale = function (element, i) {
        element.attribute("gadfly:inscale", element.attribute("gadfly:scale") == 1.0);
    };

    if (xgridlines) xgridlines.selectAll("path").forEach(mark_inscale);
    if (ygridlines) ygridlines.selectAll("path").forEach(mark_inscale);
    if (xlabels) xlabels.selectAll("text").forEach(mark_inscale);
    if (ylabels) ylabels.selectAll("text").forEach(mark_inscale);

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
            .selectAll("path")
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
            .selectAll("path")
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

        set_plot_pan_zoom(root, tx, ty, root.data("scale"));
    },
    end: function(root, event) {

    },
    cancel: function(root) {
        set_plot_pan_zoom(root, root.data("tx0"), root.data("ty0"), root.data("scale"));
    }
};

var zoom_box;
var zoom_action = {
    start: function(root, x, y, event) {
        var bounds = root.plotbounds();
        var width = bounds.x1 - bounds.x0,
            height = bounds.y1 - bounds.y0;
        var ratio = width / height;
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        x = xscalable ? x / px_per_mm : bounds.x0;
        y = yscalable ? y / px_per_mm : bounds.y0;
        var w = xscalable ? 0 : width;
        var h = yscalable ? 0 : height;
        zoom_box = root.rect(x, y, w, h).attr({
            "fill": "#000",
            "opacity": 0.25
        });
        zoom_box.data("ratio", ratio);
    },
    update: function(root, dx, dy, x, y, event) {
        var xscalable = root.hasClass("xscalable"),
            yscalable = root.hasClass("yscalable");
        var px_per_mm = root.data("px_per_mm");
        var bounds = root.plotbounds();
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
        if (xscalable && yscalable) {
            var ratio = zoom_box.data("ratio");
            var width = Math.min(Math.abs(dx), ratio * Math.abs(dy));
            var height = Math.min(Math.abs(dy), Math.abs(dx) / ratio);
            dx = width * dx / Math.abs(dx);
            dy = height * dy / Math.abs(dy);
        }
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
        var zoom_factor = 1.0;
        if (yscalable) {
            zoom_factor = (plot_bounds.y1 - plot_bounds.y0) / zoom_bounds.height;
        } else {
            zoom_factor = (plot_bounds.x1 - plot_bounds.x0) / zoom_bounds.width;
        }
        var tx = (root.data("tx") - zoom_bounds.x) * zoom_factor + plot_bounds.x0,
            ty = (root.data("ty") - zoom_bounds.y) * zoom_factor + plot_bounds.y0;
        set_plot_pan_zoom(root, tx, ty, root.data("scale") * zoom_factor);
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
        increase_zoom_by_position(this.plotroot(), 0.001 * event.wheelDelta);
        event.preventDefault();
    }
};


Gadfly.zoomslider_button_mouseover = function(event) {
    this.select(".button_logo")
         .animate({fill: this.data("mouseover_color")}, 100);
};


Gadfly.zoomslider_button_mouseout = function(event) {
     this.select(".button_logo")
         .animate({fill: this.data("mouseout_color")}, 100);
};


Gadfly.zoomslider_zoomout_click = function(event) {
    increase_zoom_by_position(this.plotroot(), -0.1, true);
};


Gadfly.zoomslider_zoomin_click = function(event) {
    increase_zoom_by_position(this.plotroot(), 0.1, true);
};


Gadfly.zoomslider_track_click = function(event) {
    // TODO
};


// Map slider position x to scale y using the function y = a*exp(b*x)+c.
// The constants a, b, and c are solved using the constraint that the function
// should go through the points (0; min_scale), (0.5; 1), and (1; max_scale).
var scale_from_slider_position = function(position, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return a * Math.exp(b * position) + c;
}

// inverse of scale_from_slider_position
var slider_position_from_scale = function(scale, min_scale, max_scale) {
    var a = (1 - 2 * min_scale + min_scale * min_scale) / (min_scale + max_scale - 2),
        b = 2 * Math.log((max_scale - 1) / (1 - min_scale)),
        c = (min_scale * max_scale - 1) / (min_scale + max_scale - 2);
    return 1 / b * Math.log((scale - c) / a);
}

var increase_zoom_by_position = function(root, delta_position, animate) {
    var scale = root.data("scale"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale");
    var position = slider_position_from_scale(scale, min_scale, max_scale);
    position += delta_position;
    scale = scale_from_slider_position(position, min_scale, max_scale);
    set_zoom(root, scale, animate);
}

var set_zoom = function(root, scale, animate) {
    var min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("scale");
    var new_scale = Math.max(min_scale, Math.min(scale, max_scale));
    if (animate) {
        Snap.animate(
            old_scale,
            new_scale,
            function (new_scale) {
                update_plot_scale(root, new_scale);
            },
            200);
    } else {
        update_plot_scale(root, new_scale);
    }
}


var update_plot_scale = function(root, new_scale) {
    var trans = scale_centered_translation(root, new_scale);
    set_plot_pan_zoom(root, trans.x, trans.y, new_scale);

    root.selectAll(".zoomslider_thumb")
        .forEach(function (element, i) {
            var min_pos = element.data("min_pos"),
                max_pos = element.data("max_pos"),
                min_scale = root.data("min_scale"),
                max_scale = root.data("max_scale");
            var xmid = (min_pos + max_pos) / 2;
            var xpos = slider_position_from_scale(new_scale, min_scale, max_scale);
            element.transform(new Snap.Matrix().translate(
                Math.max(min_pos, Math.min(
                         max_pos, min_pos + (max_pos - min_pos) * xpos)) - xmid, 0));
    });
};


Gadfly.zoomslider_thumb_dragmove = function(dx, dy, x, y, event) {
    var root = this.plotroot();
    var min_pos = this.data("min_pos"),
        max_pos = this.data("max_pos"),
        min_scale = root.data("min_scale"),
        max_scale = root.data("max_scale"),
        old_scale = root.data("old_scale");

    var px_per_mm = root.data("px_per_mm");
    dx /= px_per_mm;
    dy /= px_per_mm;

    var xmid = (min_pos + max_pos) / 2;
    var xpos = slider_position_from_scale(old_scale, min_scale, max_scale) +
                   dx / (max_pos - min_pos);

    // compute the new scale
    var new_scale = scale_from_slider_position(xpos, min_scale, max_scale);
    new_scale = Math.min(max_scale, Math.max(min_scale, new_scale));

    update_plot_scale(root, new_scale);
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragstart = function(x, y, event) {
    this.animate({fill: this.data("mouseover_color")}, 100);
    var root = this.plotroot();

    // keep track of what the scale was when we started dragging
    root.data("old_scale", root.data("scale"));
    event.stopPropagation();
};


Gadfly.zoomslider_thumb_dragend = function(event) {
    this.animate({fill: this.data("mouseout_color")}, 100);
    event.stopPropagation();
};


var toggle_color_class = function(root, color_class, ison) {
    var guides = root.selectAll(".guide." + color_class + ",.guide ." + color_class);
    var geoms = root.selectAll(".geometry." + color_class + ",.geometry ." + color_class);
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
        root.selectAll(".colorkey text")
            .forEach(function (element) {
                var other_color_class = element.data("color_class");
                if (other_color_class != color_class) {
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
    var fig = Snap("#img-be239761");
fig.select("#img-be239761-4")
   .drag(function() {}, function() {}, function() {});
fig.select("#img-be239761-6")
   .data("color_class", "color_Signal_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-7")
   .data("color_class", "color_Signal_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-8")
   .data("color_class", "color_Signal_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-9")
   .data("color_class", "color_Signal_4")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-11")
   .data("color_class", "color_Signal_1")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-12")
   .data("color_class", "color_Signal_2")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-13")
   .data("color_class", "color_Signal_3")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-14")
   .data("color_class", "color_Signal_4")
.click(Gadfly.colorkey_swatch_click)
;
fig.select("#img-be239761-18")
   .init_gadfly();
fig.select("#img-be239761-21")
   .plotroot().data("unfocused_ygrid_color", "#D0D0E0")
;
fig.select("#img-be239761-21")
   .plotroot().data("focused_ygrid_color", "#A0A0A0")
;
fig.select("#img-be239761-175")
   .plotroot().data("unfocused_xgrid_color", "#D0D0E0")
;
fig.select("#img-be239761-175")
   .plotroot().data("focused_xgrid_color", "#A0A0A0")
;
fig.select("#img-be239761-291")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-be239761-291")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-be239761-291")
   .click(Gadfly.zoomslider_zoomin_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
fig.select("#img-be239761-295")
   .data("max_pos", 88.55)
;
fig.select("#img-be239761-295")
   .data("min_pos", 71.55)
;
fig.select("#img-be239761-295")
   .click(Gadfly.zoomslider_track_click);
fig.select("#img-be239761-297")
   .data("max_pos", 88.55)
;
fig.select("#img-be239761-297")
   .data("min_pos", 71.55)
;
fig.select("#img-be239761-297")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-be239761-297")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-be239761-297")
   .drag(Gadfly.zoomslider_thumb_dragmove,
     Gadfly.zoomslider_thumb_dragstart,
     Gadfly.zoomslider_thumb_dragend)
;
fig.select("#img-be239761-299")
   .data("mouseover_color", "#CD5C5C")
;
fig.select("#img-be239761-299")
   .data("mouseout_color", "#6A6A6A")
;
fig.select("#img-be239761-299")
   .click(Gadfly.zoomslider_zoomout_click)
.mouseenter(Gadfly.zoomslider_button_mouseover)
.mouseleave(Gadfly.zoomslider_button_mouseout)
;
    });
]]> </script>
</svg>





```julia

```
