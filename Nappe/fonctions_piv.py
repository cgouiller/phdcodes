# -*- coding: utf-8 -*-
"""
Created on Wed Oct 28 09:49:24 2020

@author: clement.gouiller
"""
import numpy as np
import matplotlib.pyplot as plt
from astropy.convolution import Gaussian2DKernel
from astropy.convolution import convolve
from scipy.ndimage import gaussian_filter #Filtrage gaussien
from numpy.linalg import pinv as nppinv
from matplotlib.colors import Normalize #Pour l'utilisation des couleurs dans quiver
from scipy.interpolate import griddata
import matplotlib.tri as tri
import matplotlib.cm as cm #colormaps

# Definition des fonctions
def PIV(prof,manips): 
    """retourne les données des plans pour la bonne profondeur"""
    
    if prof==5:
        piv=manips['piv5']
    elif prof==10:
        piv=manips['piv10']
    elif prof==15:
        piv=manips['piv15']
    else:
        return("prof n'a pas une valeur acceptable")   
    return(piv)

def donnees(n,piv):
    """Retourne les tableaux de données pour le plan choisi de la profondeur donnée"""
    size=len(np.array(piv[0]['u']))

    u=np.zeros((n,size,size))
    v=np.zeros((n,size,size))
    x=np.zeros((n,size,size))
    y=np.zeros((n,size,size))
    z=np.zeros((n))

    for plan in range(n): 
            u[plan]=np.array(piv[plan]['u'])
            v[plan]=np.array(piv[plan]['v'])
            x[plan]=np.array(piv[plan]['x'])
            y[plan]=np.array(piv[plan]['y'])
            z[plan]=np.array(piv[plan]['prof'])

    return(u,v,x,y,z)

    
def donnees_tot(n,piv,size):
    "Charge les données pour la profondeur donnée"
    size=len(np.array(piv[0]['umoy']))

    umo=np.zeros((n,size,size))
    vmo=np.zeros((n,size,size))
    ume=np.zeros((n,size,size))
    vme=np.zeros((n,size,size))
    uva=np.zeros((n,size,size))
    vva=np.zeros((n,size,size))
    cu=np.zeros((n,size,size))
    cv=np.zeros((n,size,size))
    x=np.zeros((n,size,size))
    y=np.zeros((n,size,size))
    z=np.zeros((n))

    for plan in range(n): 
            umo[plan]=np.array(piv[plan]['umoy'])
            vmo[plan]=np.array(piv[plan]['vmoy'])
            ume[plan]=np.array(piv[plan]['umed'])
            vme[plan]=np.array(piv[plan]['vmed'])
            uva[plan]=np.array(piv[plan]['uvar'])
            vva[plan]=np.array(piv[plan]['vvar'])
            cu[plan]=np.array(piv[plan]['cu'])
            cv[plan]=np.array(piv[plan]['cv'])
            x[plan]=np.array(piv[plan]['x'])
            y[plan]=np.array(piv[plan]['y'])
            z[plan]=np.array(piv[plan]['prof'])
    return(umo,vmo,ume,vme,uva,vva,cu,cv,x,y,z)



def deriv(y,x,axis):
    """Dérive un tableau 2D y par rapport à x suivant un axe donné"""
    if axis==0:
        return((y[1:,:]-y[:-1,:])/(x[1:,:]-x[:-1,:]))#Donc là le tableau est de taille (n-1,n)
    if axis==1:
        return((y[:,1:]-y[:,:-1])/(x[:,1:]-x[:,:-1]))#Donc là le tableau est de taille (n,n-1)
    return("deriv ne fonctionne que pour des tableaux 2D")
    
def deriv_sym(y,x,axis):
    """Dérive un tableau 2D y par rapport à x suivant un axe donné"""
    if axis==0:
        return((y[2:,:]-y[:-2,:])/(x[2:,:]-x[:-2,:]))#Donc là le tableau est de taille (n-1,n)
    if axis==1:
        return((y[:,2:]-y[:,:-2])/(x[:,2:]-x[:,:-2]))#Donc là le tableau est de taille (n,n-1)
    return("deriv ne fonctionne que pour des tableaux 2D")
    

def abcisse(x,axis):
    """somme discrète x[i+1]+x[i]/2 suivant un axe donné"""
    if axis==0:
        return((x[1:,:]+x[:-1,:])/2)
    if axis==1:
        return((x[:,1:]+x[:,:-1])/2)
    return("abcisse ne fonctionne que pour des tableaux 2D")
        
def abcisse_sym(x,axis):
    """somme discrète x[i+1]+x[i]/2 suivant un axe donné"""
    if axis==0:
        return(x[1:-1,:])
    if axis==1:
        return(x[:,1:-1])
    return("abcisse ne fonctionne que pour des tableaux 2D")
           
def good_shape(a):
    "remise à la bonne shape des tableaux a et b pour pouvoir ensuite les sommer"
    "Ne fonctionne que dans ce cas précis avec des tableaux (n,n-1) et (n-1,n) et donne un tableau (n-1,n-1)"
    n=np.max(np.shape(a))
    if np.shape(a)[0]==n:
        return(a[:-1,:])
    if np.shape(a)[1]==n:
        return(a[:,:-1])
    return("les dimensions des array ne conviennent pas pour l'usage de good_shape, ou problème avec n")
 
def good_shape_sym(a):
    "remise à la bonne shape des tableaux a et b pour pouvoir ensuite les sommer"
    "Ne fonctionne que dans ce cas précis avec des tableaux (n,n-1) et (n-1,n) et donne un tableau (n-1,n-1)"
    n=np.max(np.shape(a))
    if np.shape(a)[0]==n:
        return(a[1:-1,:])
    if np.shape(a)[1]==n:
        return(a[:,1:-1])
    return("les dimensions des array ne conviennent pas pour l'usage de good_shape, ou problème avec n")
 
 
def somme(a,b):
    "juste somme d'array"
    if np.shape(a)==np.shape(b):
        return(a+b)
    return("les array n'ont pas la bonne shape")


def masque(a,x,y):
    "applique un masque rond"
    smax=len(x)
    b=np.copy(a)
    r=np.sqrt(x**2+y**2)
    shape=np.shape(b)
    if np.size(shape)==2:
        if shape[0]==(smax-1):
            return(np.where(r>6,b,0))
        elif shape[0]==smax:
            r=np.sqrt(x**2+y**2)
            return(np.where(r>6,b,0))
    elif np.size(shape)==3:#pour gérer cas divergence/filtrage/masque
        l=shape[0]
        if shape[1]==(smax-1):
            for i in range(l):
                b[i,:,:]=np.where(r[i,:,:]>6,b[i,:,:],0)
            return(b)
        elif shape[1]==smax:
            r=np.sqrt(x**2+y**2)
            for i in range(l):
                b[i,:,:]=np.where(r[i,:,:]>6,b[i,:,:],0)
            return(b)
        

     

def vitesse_nageur(prof):
    "donne la vitesse du nageur pour une profondeur. Elle est suivant ey"
    if prof==5:
        return(60)
    elif prof==10:
        return(59)
    elif prof==15:
        return(62)
    


def dUfiltre(Ufiltre,x,axis):
    "Dérive et remet à la bonne taille donne un tableau (l,n-1,n-1)"
    l=np.shape(Ufiltre)[0]
    n=np.shape(Ufiltre)[1]
    dU=np.zeros((l,n-1,n-1))
    for i in range(l):
        dU[i]=good_shape(deriv(Ufiltre[i], x, axis))
    return(dU)


def somme3D(a,b):
    "somme les tableaux a et b suivant le premier axe"
    S=np.zeros(np.shape(a))
    if np.shape(a)==np.shape(b):
        l=np.shape(a)[0]
        for i in range(l):
            S[i]=a[i]+b[i]
        return(S)
    else:
        return("a et b n'ont pas la même shape")
 



def nb_plan(prof):
    "Détermine le nombre de plan pour une profondeur donnée"
    if prof==5:
        return(16)
    if prof==10:
        return(32)
    if prof==15:
        return(49)
    else:
        return("prof n'a pas une valeur acceptable")
    
def ext(L):#crée une liste ordonnée de l'ensemble des éléments dans une série pandas
    return sorted(list(set(L)))

def closest(lst, K): 
     lst = np.asarray(lst) 
     idx = (np.abs(lst - K)).argmin() 
     return lst[idx] 

#%% Fonctions de plot
def plot_vfield(x,y,u,v,vmax,svect,hide):
    if svect==0:
        svect=10
    velocity=np.sqrt(u**2+v**2)
    if vmax==0:
        vmax=np.mean(velocity)+np.std(velocity)#norme maximale représentée sur la colormap borne sup arbitraire
    
    colors = np.copy(velocity)
    colors[velocity>vmax]=vmax
    if hide==1:
        u[velocity<np.nanmax(colors)*0.2]=np.nan
        v[velocity<np.nanmax(colors)*0.2]=np.nan
    colors[0,0]=vmax
    norm = Normalize()
    norm.autoscale(colors)
    plt.quiver(x,y,u/velocity,v/velocity,colors,scale=svect)
    plt.xlabel("x [mm]")
    plt.ylabel("y [mm]")
    plt.gca().set_aspect('equal')        
    plt.clim([0,vmax])
    plt.colorbar()    
    
def plot_dvg(x,y,z,dvg,v,param):
    if v==0:
        v=3*np.std(dvg)    
    
    if param==2:    
        plt.imshow(dvg,vmin=-v,vmax=v,extent=[x[0,0],x[0,-1],y[0,0],y[-1,0]])
    else:
        triang = tri.Triangulation(x, y)
        plt.tripcolor(triang, dvg, shading='gouraud',cmap=cm.PiYG,vmin=-v,vmax=v)

        
    plt.gca().invert_yaxis()
    plt.xlabel("x [mm]")
    plt.ylabel("y [mm]")
    plt.title("prof="+str(z)+"mm")
    plt.gca().set_aspect('equal')        
    plt.colorbar()
    plt.show()

#%% Calculs de divergences
def divergence2Dsym(u,v,x,y):
    
    #dérivation
    du_filtre,dv_filtre=deriv_sym(u,x,1),deriv_sym(v,y,0)

    dx=abcisse_sym(x,1)
    dy=abcisse_sym(y,0)
    #shape
    du_filtre,dv_filtre=good_shape_sym(du_filtre),good_shape_sym(dv_filtre)

    dx,dy=good_shape_sym(dx),good_shape_sym(dy)
    #somme
    div = somme(du_filtre,dv_filtre)
    #masque
    div_masque=masque(div,dx,dy)
    return(div_masque,dx,dy)

def calc_dvg_sym(x,y,u,v,P):
    size=len(u[0])
    div_2D=np.zeros((P,size-2,size-2))
    dx=np.zeros((P,size-2,size-2))
    dy=np.zeros((P,size-2,size-2))
    
    for plan in range(P):
        div_2D[plan],dx[plan],dy[plan]=divergence2Dsym(u[plan],v[plan],x[plan],y[plan])
    return(div_2D,dx,dy)

def calc_dvg(x,y,u,v,P):
    size=len(u[0])
    div_2D=np.zeros((P,size-1,size-1))
    dx=np.zeros((P,size-1,size-1))
    dy=np.zeros((P,size-1,size-1))
    
    for plan in range(P):
        div_2D[plan],dx[plan],dy[plan]=divergence2D(u[plan],v[plan],x[plan],y[plan])
    return(div_2D,dx,dy)

def divergence2D(u,v,x,y):
    "Applique le programme de divergence2D sans filtre"
    #Dérivation
    du,dv=deriv(u,x,1),deriv(v,y,0)
    dx,dy=abcisse(x,1),abcisse(y,0)
    #Remise à la bonne taille
    du,dv=good_shape(du),good_shape(dv)
    dx,dy=good_shape(dx),good_shape(dy)
    #somme des tableaux
    div = somme(du,dv)
    #masque
    div_masque=masque(div,dx,dy)
    return(div_masque,dx,dy)

#%% Champs de vitesses
def vfield_gdata(xl,yl,ul,vl,P):
    us=np.zeros([P,300,300])
    vs=np.copy(us)
    xs=np.copy(us)
    ys=np.copy(vs)
    grid_x, grid_y = np.mgrid[np.min(xl):np.max(xl):300j, np.min(xl):np.max(xl):300j]
    grid_x=np.transpose(grid_x)
    grid_y=np.transpose(grid_y)
    for i in range(P):
        u=np.copy(ul[i])
        v=np.copy(vl[i])
        x=np.copy(xl[i])
        y=np.copy(yl[i])
        u[u==0]=np.nan
        v[v==0]=np.nan
        test=np.isfinite(u)
        u=u[test]
        v=v[test]
        x=np.transpose(x[test])
        y=np.transpose(y[test])
        us[i]=griddata(np.transpose([x,y]), u, (grid_x, grid_y), method='cubic')
        vs[i]=griddata(np.transpose([x,y]), v, (grid_x, grid_y), method='cubic')
        xs[i]=grid_x
        ys[i]=grid_y
    return(xs,ys,us,vs)

def vfield_ast(u,v,P,sigma):
    us=np.zeros(np.shape(u))
    vs=np.copy(us)
    for i in range(P):
        unan=np.copy(u[i])
        vnan=np.copy(v[i])
        unan[u[i]==0]=np.nan
        vnan[v[i]==0]=np.nan
        #Filtrage
        # We smooth with a Gaussian kernel with x_stddev=1 (and y_stddev=1)
        # It is a 9x9 array
        kernel = Gaussian2DKernel(x_stddev=sigma,y_stddev=sigma)
    
        # astropy's convolution replaces the NaN pixels with a kernel-weighted
        # interpolation from their neighbors
        us[i] = convolve(unan, kernel)
        vs[i] = convolve(vnan, kernel)
    return(us,vs)

def vfield_gauss(ul,vl,P,sigma):
    us=np.zeros(np.shape(ul))
    vs=np.copy(us)
    for i in range(P):
        u=np.copy(ul[i])
        v=np.copy(vl[i])
        u[u==0]=np.nan
        v[v==0]=np.nan
        us[i]=gaussian_filter(u,sigma)
        vs[i]=gaussian_filter(v,sigma)
    return(us,vs)

def vfield_sym(u,v,P):
    us=np.zeros(np.shape(u))
    vs=np.copy(us)
    for i in range(P):
        up=np.copy(u[i])
        vp=np.copy(v[i])
        up[up==0]=np.nan
        vp[vp==0]=np.nan
        mid=int(len(up)/2)
        usym=np.zeros(np.shape(up))
        vsym=np.zeros(np.shape(vp))
        usym[:,0:mid]=(up[:,0:mid]-np.fliplr(up[:,mid:len(up)]))/2
        usym[:,mid:len(up)]=-np.fliplr(usym[:,0:mid])
        vsym[:,0:mid]=(vp[:,0:mid]+np.fliplr(vp[:,mid:len(vp)]))/2
        vsym[:,mid:len(vp)]=np.fliplr(vsym[:,0:mid])
        us[i]=usym
        vs[i]=vsym
    return(us,vs)

#%% Méthode de Galerkine
    
def Galerkine(div_2D,dx,dy,x,z,P,m,h):
    "Galerkine en ignorant les valeurs nulles"
    #divergence bidimensionelle
    size=len(x[0])
    vz=np.zeros((P,size-1,size-1))
    dvz=np.zeros((P,size-1,size-1))

    
    for i in range(size-1):
        for j in range(size-1):
            divij=div_2D[:,i,j]
            zcor=z[divij==divij] #False pour un NaN, True sinon
            divijcor=divij[divij==divij]
            pinv=nppinv(np.transpose(np.array([n*np.pi/h*np.cos(n*np.pi/h*zcor) for n in range(1,m+1)])))
            a=np.matmul(pinv,divijcor)
            sin=np.transpose(np.array([np.sin(n*np.pi*z/h) for n in range(1,m+1)]))
            dsin=np.transpose(np.array([n*np.pi/h*np.cos(n*np.pi*z/h) for n in range(1,m+1)]))

            a=np.reshape(a,(np.shape(a)[-1]))
            sin=np.reshape(sin,(np.shape(sin)[-2],np.shape(sin)[-1]))
            dsin=np.reshape(dsin,(np.shape(dsin)[-2],np.shape(dsin)[-1]))

            if len(zcor)>2*m:
                vz[:,i,j]=np.matmul(sin,a)
                dvz[:,i,j]=np.matmul(dsin,a)
    return(vz,dvz)
