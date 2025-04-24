# Integrated Path Stability Selection (IPSS) for R

A lightweight R wrapper for the Python implementation of IPSS ([https://github.com/omelikechi/ipss](https://github.com/omelikechi/ipss)) that enables users to run IPSS in R without writing the algorithm from scratch.

## Associated papers

**IPSSL:** [https://arxiv.org/abs/2403.15877](https://arxiv.org/abs/2403.15877) <br>
**IPSSGB and IPSSRF:** [https://arxiv.org/abs/2410.02208v1](https://arxiv.org/abs/2410.02208v1)

## Installation

Install the Python IPSS package via pip:
```
pip install ipss
```

Then, in R:
```
install.packages("reticulate")
library(reticulate)
```

Install this R package:
```
devtools::install_github("omelikechi/ipssR")
library(ipss)
```

## Usage

```r
library(ipss)

# Load n-by-p numeric matrix X (features) and numeric response vector y of length n

# run ipss:
ipss_output <- ipss(X,y)

# select features based on target FDR
target_fdr <- 0.1
q_values <- ipss_output$q_values
selected_features <- as.integer(names(q_values))[q_values <= target_fdr]
cat(sprintf("Selected features (target FDR = %.1f): %s\n", target_fdr, toString(selected_features)))
```

### Output
`ipss_output <- ipss(X,y)` is a list containing:
- `efp_scores`: Named vector whose names are feature indices and values are efp scores (named numeric vector of length `p`).
- `q_values`: Named vector whose names are feature indices and values are q-values (named numeric vector of length `p`).
- `runtime`: Runtime of the algorithm in seconds (numeric).
- `selected_features`: Indices of features selected by IPSS; empty if `target_fp` and `target_fdr` are not specified (integer vector).
- `stability_paths`: Estimated selection probabilities at each regularization value (matrix of shape `(n_lambdas, p)`).


## Documentation

See the full Python documentation:
- https://github.com/omelikechi/ipss  
- https://pypi.org/project/ipss
