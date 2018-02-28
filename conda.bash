#!/bin/bash

INSECURE=true

if [ $INSECURE ]; then conda config --set ssl_verify False; fi
conda install -y -c conda-forge jupyter_contrib_nbextensions
conda install -y -c damianavila82 rise
conda install -y -c conda-forgejupyter_cms

# pip install jupyter_cms
# jupyter cms quick-setup --sys-prefix
