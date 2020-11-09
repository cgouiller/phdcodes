# -*- coding: utf-8 -*-
"""
Created on Wed Oct 28 10:17:11 2020

@author: clement.gouiller
"""


 # Importation des librairies
from mat4py import loadmat #pour charger des .mat
import matplotlib.pyplot as plt # pour tracer les figures
import numpy as np # pour travailler avec des array
from matplotlib import rc #Les trois prochaines lignes pour que Ã§a ressemble Ã  latex
rc('font', size=16)
rc('text', usetex=True)
plt.rcParams['figure.figsize'] = [8,4.5] # taille par défaut des figures qu'on trace

import matplotlib.cm as cm #colormaps
from matplotlib.colors import Normalize #Pour l'utilisation des couleurs dans quiver
import matplotlib.tri as tri

import scipy as sc #pour l'analyse
from matplotlib.ticker import MaxNLocator #pour les courbes de niveau
from scipy.ndimage import gaussian_filter #Filtrage gaussien
from numpy.linalg import pinv as nppinv

from astropy.convolution import Gaussian2DKernel
from astropy.convolution import convolve

import matplotlib.tri as tri
import pandas as pd