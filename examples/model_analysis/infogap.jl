import Mads
import Gadfly

# md = Mads.loadmadsfile("models/internal-polynomial.mads")

Mads.mkdir("infogap_results")

@info("Information Gap analysis")

h = [0.001, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1]
lmin = Vector{Any}(undef, 4)
lmax = Vector{Any}(undef, 4)
colors = ["blue", "red", "green", "orange"]
models = ["y = a * t + c", "y = a * t^(1.1) + b * t + c", "y = a * t^n + b * t + c", "y = a * exp(t * n) + b * t + c"]
for i = 1:4
	min, max = Mads.infogap_jump_polinomial(model=i, plot=true, horizons=h, retries=10, maxiter=1000, verbosity=0, seed=2015)
	lmin[i] = Gadfly.layer(x=min, y=h, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[i])))
	lmax[i] = Gadfly.layer(x=max, y=h, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[i])))
end
f = Gadfly.plot(lmin..., lmax..., Gadfly.Guide.xlabel("o5"), Gadfly.Guide.ylabel("Horizon of uncertainty"), Gadfly.Guide.title("Opportuneness vs. Robustness"), Gadfly.Guide.manual_color_key("Models", models, colors))
Gadfly.draw(Gadfly.PNG("infogap_results/opportuneness_vs_robustness.png", 6Gadfly.inch, 4Gadfly.inch), f)
Mads.display("infogap_results/opportuneness_vs_robustness.png")