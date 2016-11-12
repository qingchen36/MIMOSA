# MIMOSA
Model-based Integration of Metabolite Observations and Species Abundances

A pipeline for joint metabolic model-based analysis of metabolomics measurements and taxonomic composition from microbial communities. Includes an R package that implements the core integrative analysis functions as well as example pre-processing and analysis scripts. MIMOSA is under active development. See http://elbo.gs.washington.edu/download.html for a previous version of the code, used to produce the results in (Noecker et al, 2016).

## Contents

- **mimosa**: An R package to generate community-specific metabolic network model, use the model to make metabolite predictions and identify consistent and contrasting metabolite variation, 
identify potential taxonomic and gene contributors to metabolite variation, and shuffle the community metabolic network for comparison of results with a null model. 
The core analysis uses the file `reaction_mapformula.lst` from the KEGG database (Kanehisa and Goto, 2000) to link genes to reactions. If you do not have access to this file, you can email `elbo [at] uw.edu` for access to an older version. 

You can install **mimosa** using the `devtools` package in R:
```R
devtools::install_github("borenstein-lab/MIMOSA/mimosa")
```

- **runMimosa.R**: Script used to run main MIMOSA analyses from the command line (see "Using MIMOSA").

- **run_all.sh**: example usage of `runMimosa.R` to regenerate results from one of the datasets described in Noecker et al, 2016. You can download these files from [here](http://elbo.gs.washington.edu/download.html). This script uses the Python modules [`picrust`](http://picrust.github.io/picrust/)(Langille et al, 2013) and [`MUSiCC`](http://elbo.gs.washington.edu/software_musicc.html)(Manor and Borenstein, 2015) to process and prepare the datasets. 

## Using MIMOSA

You can run a full MIMOSA analysis by running the script runMimosa.R from the command line with additional arguments and the output will be saved to multiple files. You can also run any of the individual steps in R. 
You can see example file formatting in the `tests/testthat` directory.


### Required arguments for runMimosa.R

- **-g,--genefile**: file path to gene (KO) abundances (total across all species), preferably normalized with MUSiCC. Example: `tests/testthat/test_genes.txt`
- **-m,--metfile**: file path to metabolite abundances (with KEGG compound IDs), preferably unscaled peak abundances or absolute concentrations. Example: `tests/testthat/test_mets.txt`
- **-o,--contribs_file**: file path to metagenome contributions (species-specific gene abundances), formatted like the output of the PICRUSt `metagenome_contributions.py` script. Example: `tests/testthat/test_contributions.txt`
- **-e,--mapformula_file**: File path to KEGG reaction_mapformula.lst file (included in FTP download of KEGG database), containing information on reactions annotated in KEGG pathways. Example: `tests/testthat/test_mapformula.txt`
- **-p,--file_prefix**: file path prefix where output files will be written


### Optional arguments for runMimosa.R

The following two files are required for full reaction information and stoichiometry, if you are using a downloaded version of KEGG. If they are not provided, MIMOSA will try to use the KEGGREST package to get the same information from the KEGG API.
- **-r,--ko_rxn_file** File path to links between KO gene families and reactions (called ko_reaction.list and found in xxx)
- **-x,--rxn_annots_file** File path to full KEGG Reaction annotations (called reaction and found in xxx)

Other optional arguments:

- **-b,--keggFile**: file path to pre-computed generic community network template (output of the function `generate_network_template_kegg`), if you have already generated that information
- **-u,--num_permute**: Number of permutations to perform for the Mantel test comparison (default: 20000)
- **-c,--cor_method**: Whether to use Spearman or Pearson correlations for the Mantel test (default and recommended: Spearman)
- **-f,--degree_filter**: Connectivity threshold filter. Metabolites connected in the community network model to this number of KOs or higher are considered currency metabolites and are filtered from the analysis (default: 30).
- **-z,--nonzero_filt**: Metabolites found to have a nonzero concentration or nonzero metabolic potential scores in this number of samples or fewer are filtered from the analysis (default: 3)


### Example usage of runMimosa.R

**Option 1: Using downloaded KEGG files to build community network**
```bash
Rscript runMimosa.R --genefile="Dataset2_picrust_musicc.txt" --metfile="Dataset2_mets.txt" --contribs_file="Dataset2_metagenome_contributions.txt" --file_prefix="Dataset2_bv" --mapformula_file="keggPath/reaction_mapformula.lst" --ko_rxn_file="keggPath/ko_reaction.list" --rxn_annots_file="keggPath/reaction" --nonzero_filt=4 
```

**Option 2: Using the KEGGREST package to build the community metabolic network template (can be slow depending on network connection)**
```bash
Rscript runMimosa.R --genefile="Dataset2_picrust_musicc.txt" -m "Dataset2_mets.txt" --contribs_file="Dataset2_metagenome_contributions.txt" --file_prefix="Dataset2_bv" --mapformula_file="keggPath/reaction_mapformula.lst" --nonzero_filt=4 
```

### Output of runMimosa.R

Core comparison analysis:
- **file_prefix_nodes.txt**: A table of all successfully analyzed metabolites, their Mantel correlation between metabolic potential scores and concentrations, and the associated p-values and q-values (FDR corrected).
- **file_prefix_edges.txt**: The full community network model for that dataset, with gene, reaction, product, and stoichiometry information.
- **file_prefix_signifPos.txt/file_prefix_signifNeg.txt**: subsets of the "nodes" file that were significant at an FDR of 0.1.
- **file_prefix_cmpAll.txt**: Table of metabolic potential scores across all samples and metabolites.
- **file_prefix_out.rda**: all of output of the run_all_metabolites for the core comparison analysis that can be loaded into an R session.

Potential taxonomic contributor analysis:
- **file_prefix_specContrib.txt**: Table of results of analysis of potential taxonomic contributors for each metabolite (correlations of single-species scores with full community score).
- **file_prefix__allKOAbundsByOTU.rda, file_prefix_allCMPsAloneByOTU.rda**: Rdata files with gene abundances and metabolic potential scores for each species alone.


Potential gene/species contributor analysis:
- **file_prefix_geneContribAnalysis.txt**: Table of results of contribution analysis of most relevant potential gene and reaction contributors for each metabolite (correlations indicate how much removing the reactions associated with that gene affected metabolite potential scores).
- **file_prefix_geneContribCompoundSummary.txt**: Table summarizing gene contribution results by compound - number of relevant synthesizing and degrading genes for each metabolite and whether it was primarily predicted based on synthesis, degradation, or a combination.
- **file_prefix_geneContribs.rda**: full output of gene contribution analysis.


## Citation

Noecker, C., Eng, A., Srinivasan, S., Theriot, C.M., Young, V.B., Jansson, J.K., Fredricks, D.N., and Borenstein, E. (2016). Metabolic Model-Based Integration of Microbiome Taxonomic and Metabolomic Profiles Elucidates Mechanistic Links between Ecological and Metabolic Variation. mSystems 1, e00013–15, doi:[10.1128/mSystems.00013-15](http://msystems.asm.org/content/1/1/e00013-15).
