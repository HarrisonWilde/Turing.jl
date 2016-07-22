# Test file for dDistribution wrapper w.r.t to the pdf function and gradient returned by AD.

using Turing, DualNumbers, Distributions, Base.Test, ForwardDiff

# Bernoulli
ddB = dBernoulli(0.3)
@test pdf(ddB, 1) ≈ realpart(pdf(ddB, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcBernoulli(0.3)(x[1]), [1])[1] ≈ gradient(ddB, 1)

# Normal
ddN = dNormal(0, 1)
@test pdf(ddN, 1) ≈ realpart(pdf(ddN, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcNormal(0, 1)(x[1]), [1])[1] ≈ gradient(ddN, 1)

# MvNormal
μ = [1, 1]
Σ = [1 0; 0 1]
ddMN = dMvNormal(μ, Σ)
@test pdf(ddMN, [2, 1]) ≈ realpart(pdf(ddMN, Dual[2, 1]))
@test ForwardDiff.gradient(x::Vector -> hmcMvNormal(μ, Σ)(x), [2, 1]) ≈ gradient(ddMN, [2, 1])
rand(ddMN)

# StudentT
ddT = dTDist(1)
@test pdf(ddT, 1) ≈ realpart(pdf(ddT, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcTDist(1)(x[1]), [1])[1] ≈ gradient(ddT, 1)

# Exponential
ddE = dExponential(1)
@test pdf(ddE, 1) ≈ realpart(pdf(ddE, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcExponential(1)(x[1]), [1])[1] ≈ gradient(ddE, 1)

# Gamma
ddG = dGamma(2, 3)
@test pdf(ddG, 1) ≈ realpart(pdf(ddG, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcGamma(2.0, 3.0)(x[1]), [1])[1] ≈ gradient(ddG, 1)

# InverseGamma
ddIG = dInverseGamma(2, 3)
@test pdf(ddIG, 1) ≈ realpart(pdf(ddIG, Dual(1)))
@test ForwardDiff.gradient(x::Vector -> hmcInverseGamma(2.0, 3.0)(x[1]), [1])[1] ≈ gradient(ddIG, 1)
