---
title: Graphical Models
author: Ke Alexander Wang
---

## Bayesian networks

A Bayesian network is a directed graph \(G\) that represents the factorization of a probability distribution \(p\) into conditional probability distributions.
The direction of the edges encode our assumption about how samples are generated in \(p\).

### Explaining away

Explaining-away is mnemonic for the common effect situation. Both a flat tire and a napping driver will cause a car to be stopped on the side of the road as a common effect.
A priori, if we don't observe anything about the car, then the two causes are independent.
However, once we observe that the car is stopped, the two become dependent. Knowing that the driver is napping tells us that the tire is likely not flat, and vice versa.

### d-separation

Two sets of nodes \(X, Y\) in a directed graph are d-connected conditioned on a set of nodes \(Z\) if there exists an undirected path \(\Pcal\) between a node in \(X\) and a node in \(Y\) such that

1. for any vertex \(v\) along \(\Pcal\) that is a v-structure, either \(v \in Z\) or one of its directed descendents is in \(Z\)
2. for every vertex \(v\) along \(\Pcal\) that is not a v-structure, \(v\) is not in \(Z\)

We say that \(X\) and \(Y\) are d-separated by \(Z\) if \(X\) and \(Y\) are not d-connected.

If \(X, Y\) are d-separated by \(Z\), then \(X \perp Y \mid Z\). However, the converse is not necessarily true.

### Parameter estimation

Maximum-likelihood is the most common way of parameter estimation, i.e. learning the parameters of the distributions we used to model the data. Given a set of observations \(x_1, \ldots, x_N\), we maximize the likelihood \(\log p(x_1, \ldots, x_N) = \sum_{i=1}^N \log p(x_i)\).

## Markov networks

A Markov network, also known as a Markov random field, is an undirected graphical model where the random variables are grouped into cliques, where each clique has a potential function, or factor, that is a function of the variables in the clique.
Each clique is interpreted as a specification of which variables interact with each other.

A Bayesian network is a special case of a MRF where the potential functions are conditional probability densities. Independence in an MRF is also easy to check, \(X \perp Y \mid Z\) if there exists a path between a node in \(X\) and a node in \(Y\) that does not pass through \(Z\).

### Partition function

A MRF over \(x_1, \ldots, x_N\) is defined by
\begin{equation}
p(x_1, \ldots, x_N) = \frac{1}{Z} \prod_{c\in C} \phi_c(X_c)
\end{equation}
where each \(c\) is a clique and \(X_c\) is the list of variables in clique \(c\).

\(Z\) is the partition function, or normalizing constant
\begin{equation}
Z = \sum_{x_1, \ldots, x_N} \prod_{c\in C} \phi_c(X_c)
\end{equation}
which may be exponentially hard to compute given \(p\).

### Parameter estimation

## Loopy belief propagation

## Bethe free energy

## Mean-field variational inference

Mean-field VI assumes that the variational posterior \(q\) factorizes:
\[q(z_1, \ldots, z_D) = \prod_{i=1}^D q_i(z_i)\]
and represents one extreme simplifying assumption. You can also assume that it factorizes according to groups of variables, an approach known as structured mean-field.

This assumption allows one to derive coordinate ascent variational inference (CAVI), which optimizes the evidence lower bound (ELBO) by iteratively updating the variational parameters of each factor \(q_i\).

The derivation is short:
\begin{align}
\text{ELBO}(q) &= \ev[q]{\log p(x, z) - \log q(z)} \\
&= \ev[q_i]{\ev[q_{\neg i}]{\log p(x, z_{\neg i}, z_i)}} - \ev[q_i]{\log q_i(z_i)} + \constant \\
&= \kldiv{q_i}{\constant \cdot \exp{\ev[q_{\neg i}]{\log p(x, z_{\neg i}, z_i)}}}
\end{align}
which is maximized with respect to \(q_i\) when
\begin{equation}
q_i^*(z_i) \propto \exp{\ev[q_{\neg i}]{\log p(x, z_{\neg i}, z_i)}}.
\end{equation}

## Sampling

### Monte Carlo integration

### Gibbs sampling

### Metropolis-Hastings and detailed balance

## Sequential Monte Carlo

## Chow-Liu trees
