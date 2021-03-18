# syntax=docker/dockerfile:experimental

FROM jupyter/r-notebook

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN R -e \"install.packages(c('ggplot2', 'dplyr', 'genie3', 'edgeR', 'Rtsne',\
                             'matrixStats', 'Hmisc', 'splines', \
                             'foreach', 'doParallel', 'fastcluster', \
                             'dynamicTreeCut', 'survival', \
                             'enrichR', 'tidyverse'))" 

RUN R -e \"source('https://bioconductor.org/biocLite.R'); \
          biocLite(c('GO.db', 'preprocessCore', 'imput', \
                     'WGCNA', 'SummarizedExperiment'))"

EXPOSE 8888
USER $NB_UID

CMD [\"sh\",\"-c\", \"jupyter notebook --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.
