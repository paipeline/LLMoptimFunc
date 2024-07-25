# Simple Quadratic Optimization for Maximizing Returns

## Introduction

Simple quadratic optimization focuses on maximizing returns through a quadratic function. This approach is useful for scenarios where the relationship between variables is nonlinear and can be modeled effectively with a quadratic function.

## Basic Convex Optimization Problem

A basic quadratic optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{x}{\text{minimize}}
& & f(x) \\
\end{aligned}
\]

where:
- \( f(x) \) is the objective function, which is convex.

## Example: Simple Quadratic Optimization

In a simple quadratic optimization scenario, we can maximize a quadratic function subject to a single constraint.

### Problem Formulation

Maximize the function:

\[
f(x) = ax^2 + bx + c
\]

Subject to the constraint:

\[
x \geq 0
\]

### Simple Optimization Function

The optimization function can be defined as follows:

```python
def simple_optimize(a, b):
    return -b / a  # Optimal x when a > 0
```

### Conclusion

This simple approach to convex optimization allows for quick decision-making with minimal data. It is particularly useful in scenarios where data is scarce or when a rapid analysis is required.
