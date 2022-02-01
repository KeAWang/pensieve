---
title: Causality
author: Ke Alexander Wang
toc-title: Contents
summary: "**tl;dr**: You can't observe counterfactual potential outcomes, but you can estimate it"

---

## Potential outcomes framework

The potential outcomes framework is also known as the Neyman-Rubin causal model.
It is the most common causal framework for causal inference in social sciences.

Setup:

* We have a *binary treatment* random variable \(\trv\), e.g. to treat a patient or not to treat a patient.
* Each treatment has an associated *potential outcome* random variable, either \(\yrv(1)\) or \(\yrv(0)\).
* We wish to estimate the *causal effect* of the treatment on the individual, \[\Delta = \yrv(1) - \yrv(0)\].

It is important to note that both \(\yrv(1)\) and \(\yrv(0)\) are marginal random variables.
\(\yrv(w)\) is the distribution of outcomes after applying treatment \(w\), including both observable outcomes *and* counterfactual outcomes.
In other words, \(\yrv(w) = \yrv(w)\trv + \yrv(w)(1 - \trv)\).
See [Causal models on probability spaces](https://arxiv.org/abs/1907.01672) for a clear visualization of potential outcomes and treatmentas random variables.

### Average treatment effect

Since for any particular individual, we can only apply either treatment 1 or 0, we cannot observe the causal effect on an individual directly.
Instead, we can use randomized experiments to estimate the *average treatment effect*
\begin{equation}
\tau = \ev{\yrv(1) - \yrv(0)}.
\end{equation}

Suppose that we observe \(n\) i.i.d. samples of \(\{\yrv, \trv\}\) with \(n_1\) treated and \(n_0 = n - n_1\) untreated patients.
Note that here \(\yrv\) is the random variable of observed outcomes, which is different from \(\yrv(w)\) from before.
A way to think about \(\yrv\) is by writing it as
\begin{equation}
\yrv = \yrv(1)\trv + \yrv(0) (1 - \trv).
\end{equation}
We assume

* \(\yrv \ind{\tau = t} = \yrv(t) \ind{\tau = t}\)
* \((\yrv(1), \yrv(0)) \perp \trv\), that treatment is randomized so that both the treated population and the untreated population have the same distribution of people.

Then we have
\begin{align}
\ev{\frac{1}{n_t} \sum_{i:\ \trv = t} \yrv_i} &= \ev{\yrv \mid \trv = t} &\\
    &= \ev{\yrv(t) \mid \trv = t} & \text{by first assumption}\\
    &= \ev{\yrv(t)} & \text{by randomization}.
\end{align}
Thus under the above assumptions, we can estimate the average treatment effect via the difference in means estimator
\begin{equation}
\hat \tau = \frac{1}{n_1} \sum_{i:\ \trv = 1} \yrv_i - \frac{1}{n_0} \sum_{i:\ \trv = 0} \yrv_i.
\end{equation}

## Propensity score matching

Suppose each patient also has a covariate \(\xrv\), e.g. age.
The *propensity score* is the probability of treatment given the covariate value: 
\begin{equation}
e(x) := \prob{\trv = 1 \mid \xrv = x}.
\end{equation}
We can estimate the propensity score using parameteric estimators like logistic regression on the dataset to arrive at an estimate \(\hat e\).

When randomized experiments are not available, we can try to account for confounding by using the estimated propensity scores.

Assume:

* \((\yrv(1), \yrv(0)) \perp \trv \mid e(X)\), that we choose the right covariate to capture any dependence bewteen \(\trv\) and the potential outcomes.
Then we have
\begin{align}
\ev{\yrv \mid \trv = \tau} &= \ev{ \ev{\yrv \mid \trv=\tau, e(X)} } \\
    &= \ev{ \ev{\yrv(\tau) \mid \trv=\tau, e(X)}} \\
    &= \ev{ \ev{\yrv(\tau) \mid  e(X)} } \\
    &= \ev{\yrv(\tau)}.
\end{align}
From this, we see that
\begin{equation}
\ev{ \ev{\yrv \mid \trv=\tau, e(X)} } = \ev{\yrv(\tau)},
\end{equation}
allowing us to estimate the average treatment effect by averaging over groups with different propensity scores.

Thus we can estimate the average treatment effect from \(N\) observations as follows:

1. Group the observation by ther estimated propensity score into \(S\) stata, each with \(N_s\) observations
2. Estimate the average treatment effect within each strata: \(\hat \tau_s\)
3. Estimate the average treatment effect by a weighted average across the strata: \(\hat \tau = \sum_{s=1}^S \frac{N_s}{N} \hat \tau_s\)

## Counterfactual inference and off policy batch RL

