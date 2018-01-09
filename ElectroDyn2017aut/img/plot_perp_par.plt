set term lua tikz standalone nobitmap mono
set output "perp_par.pgf"
set polar
unset xtics
unset ytics
set border 0
beta=0.75
f(t) = 1/(1-beta*cos(t))**5*sin(t)**2
g(t) = 1/(1-beta*cos(t))**3*(1 - (1-beta**2)*sin(t)**2/(1-beta*cos(t))**2)
set label
set xrange[-10:65]
set yrange[-30:30]
set grid
set samples 500 
plot f(t) title '$\mathcal W_\parallel(\theta)$', g(t) title '$\mathcal W_\perp(\theta)$'

