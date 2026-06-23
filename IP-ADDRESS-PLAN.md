# Ingenovis AI Matching Platform — IP Address Plan
# Locked in during build session — do not change without updating this file

## Shared Platform Hub (Flux CD runner, shared ACR, shared monitoring)
10.0.0.0/20        — vnet-ing-gbl-core (shared hub)

## Brand + Environment grid
## Second octet = environment, third octet = brand slot
## Each VNet is /20 (4096 addresses), zero overlap across the whole grid

|            | Trustaff (.16)     | Fastaff (.32)      | Vista (.48)        |
|------------|--------------------|---------------------|---------------------|
| Dev  (.20) | 10.20.16.0/20      | 10.20.32.0/20       | 10.20.48.0/20       |
| QA   (.21) | 10.21.16.0/20      | 10.21.32.0/20       | 10.21.48.0/20       |
| Prod (.22) | 10.22.16.0/20      | 10.22.32.0/20       | 10.22.48.0/20       |

## Within each /20 VNet, subnets are split by resource type:
##   - first /24 of the block  → AKS subnet
##   - second /24 of the block → storage subnet
##   - third /24 of the block  → private endpoints subnet
## e.g. for Trustaff Dev (10.20.16.0/20):
##   AKS subnet:               10.20.16.0/24
##   Storage subnet:           10.20.17.0/24
##   Private endpoints subnet: 10.20.18.0/24
