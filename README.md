# processing-pso-algorithm

I chose to refactor a particle swarm optimization algorithm I had written in MATLAB into a language/visualization library called Processing. The original algorithm was applied to the problem of sizing an offshore Tension Leg Platform (TLP) to maximize performance while minimizing cost. In order to create the Processing code, I chose to minimize a simple function in the form y = x^2 to start. You can differentiate this function directly, and it is unnecessary to perform numerical methods to minimize, but this provides an easy example to graph output and watch the population variables converge toward the global minimum (0,0) to verify that the code is functioning.

The name particle swarm stems from the way that the population variables influence each other’s movements, similar to a flock of birds or a school of fish. This method works well in numerically minimizing multivariate, nonlinear objective functions with multiple constraints, like the TLP design problem that I previously used this for.

This was a great way to learn some new syntax (Processing uses Java, with some modifications), and refactor some of my code!
