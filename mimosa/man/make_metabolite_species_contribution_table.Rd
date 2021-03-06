% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/postProcessing.R
\name{make_metabolite_species_contribution_table}
\alias{make_metabolite_species_contribution_table}
\title{Make table summarizing species contributions for each analyzed metabolite}
\usage{
make_metabolite_species_contribution_table(species_data, node_data, tax_ref,
  path_key)
}
\arguments{
\item{species_data}{Table from MIMOSA species contributor analysis ("_specContrib.txt")}

\item{node_data}{Table of core metabolite results}

\item{tax_ref}{Table of taxonomy assignments for each species}
}
\value{
Table describing species contributors for each metabolite along with its overall MIMOSA results
make_metabolite_species_contribution_table(species_data, node_data, tax_ref, path_key)
}
\description{
Make table summarizing species contributions for each analyzed metabolite
}
