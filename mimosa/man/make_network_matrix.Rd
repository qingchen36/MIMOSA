% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_helper_functions.R, R/shuffle_network.R
\name{make_network_matrix}
\alias{make_network_matrix}
\alias{make_network_matrix}
\title{Convert edge list network format to matrix format, including row normalization.}
\usage{
make_network_matrix(rxn_table)

make_network_matrix(rxn_table)
}
\arguments{
\item{rxn_table}{Edge list format of network, as from 3rd output of generate_genomic_network}

\item{rxn_table}{edge list network}
}
\value{
list of two matrices, one with NAs filled in with zeros, one without, as first two outputs of generate_genomic_network

list of two matrices of compounds x genes, one with NAs to indicate lack of relationship vs. neutral and one with all zeros
}
\description{
Convert edge list network format to matrix format, including row normalization.

Convert network edge list to stoichiometric matrix
}
\examples{
make_network_matrix(randomized_edge_list)
make_network_matrix(ko_net[[3]])
}
