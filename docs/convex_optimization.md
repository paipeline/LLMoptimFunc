# Convex Optimization Formula

## Introduction

Convex optimization is a subfield of optimization that studies the problem of minimizing convex functions over convex sets. Convex optimization problems are important because they can be solved efficiently and reliably, and they have a wide range of applications in various fields such as finance, engineering, and machine learning.

## Convex Optimization Problem

A convex optimization problem can be formulated as follows:

\[
\begin{aligned}
& \underset{x}{\text{minimize}}
& & f(x) \\
& \text{subject to}
& & g_i(x) \leq 0, \quad i = 1, \ldots, m \\
& & & h_j(x) = 0, \quad j = 1, \ldots, p
\end{aligned}
\]

where:
- \( f(x) \) is the objective function, which is convex.
- \( g_i(x) \) are the inequality constraint functions, which are convex.
- \( h_j(x) \) are the equality constraint functions, which are affine (i.e., linear).

## Example: Portfolio Optimization

In the context of portfolio optimization, we can define a convex optimization problem to minimize the risk of a portfolio while achieving a desired return. The problem can be formulated as follows:

\[
\begin{aligned}
& \underset{w}{\text{minimize}}
& & \frac{1}{2} w^T \Sigma w \\
& \text{subject to}
& & \mu^T w \geq R_d \\
& & & \mathbf{1}^T w = 1 \\
& & & w \geq 0
\end{aligned}
\]

where:
- \( w \) is the vector of portfolio weights.
- \( \Sigma \) is the covariance matrix of asset returns.
- \( \mu \) is the vector of expected returns.
- \( R_d \) is the desired return.
- \( \mathbf{1} \) is a vector of ones.

In this formulation:
- The objective function \( \frac{1}{2} w^T \Sigma w \) represents the portfolio risk (variance).
- The inequality constraint \( \mu^T w \geq R_d \) ensures that the portfolio achieves at least the desired return.
- The equality constraint \( \mathbf{1}^T w = 1 \) ensures that the sum of the portfolio weights is 1 (i.e., the portfolio is fully invested).
- The inequality constraint \( w \geq 0 \) ensures that there are no short positions in the portfolio.

## Conclusion

Convex optimization provides a powerful framework for solving a wide range of optimization problems efficiently and reliably. By formulating problems as convex optimization problems, we can leverage efficient algorithms and solvers to find optimal solutions in various applications.
