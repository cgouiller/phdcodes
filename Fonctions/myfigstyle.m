function myfigstyle(varargin)
%MYFIGSTYLE  Format the current figure for publication
%   MYFIGSTYLE formats the current figure according to the standards of
%   international journals (eg, Physical Reviews). The layout, colors,
%   fonts, aspect ratio, tick lengths of the current figure are modified.
%   Once the figure is formatted, use PRINT -DEPS MYFIG.EPS  to produce
%   a standard EPS file.
%
%   MYFIGSTYLE JOURNAL specifies the journal format:
%      pr      Physical Review (default):
%                 Width = 8.0 cm (3.15 in)
%                 Font size = 0.072 (normalized units)
%                 Aspect ratio = 4/3
%      pr2     Physical Review, 2 figures per colum:
%                 Width = 4.0 cm (1.55 in)
%                 Font size = 0.14 (normalized units)
%                 Aspect ratio = 4/3
%      jfm     Journal of Fluid Mechanics, normal (one single column)
%                 Width = 10-11 cm (4-4.3 in)
%                 Font size = 0.050 (normalized units)
%                 Aspect ratio = 6/5
%      jfm2    Journal of Fluid Mechanics, two figures per column
%                 Width = 6.6 cm (2.6 in)
%                 Font size = 0.076 (normalized units)
%                 Aspect ratio = 6/5
%
%   MYFIGSTYLE JOURNAL OPTION1 OPTION2 ... specifies additional parameters
%      notitle    deletes the title of the figure
%      v          forces the Y-Label to be vertical
%      ext        external ticks (default = internal ticks)
%
%   For other settings, change directly the M-File!
%
%   Note that the font size is expressed in normalized units, ie, it is
%   independent of the absolute size of the window (in pixels). However, the
%   figure symbols are in absolute units, so that their final size will
%   depend on the window size. To avoid changes in symbol size, MYFIGSTYLE
%   also forces the figure window to be 560x420 pixels (Matlab standard).
%
%   Example:
%      loglog(rand(5),rand(5),'o-');
%      xlabel('time (s)'); ylabel('quantity (ua)');
%      myfigstyle jfm v notitle
%      print -deps myfig.eps
%
%   F. Moisy
%   Revision: 1.10,  Date: 2006/04/25
%
%   See also PRINT.


% History:
% 2005/02/22: v1.00, first version.
% 2005/07/27: v1.01, cosmetics.
% 2005/10/31: v1.02, works also on objects attached to hidden axes
%                    (eg, annotation boxes)
% 2006/04/24: v1.10, new settings (tick length, title, aspect ratio...)

if nargin==0,
    journal = 'pr'; % default = physical review
else
    journal = varargin{1};
end;

% JOURNAL - GLOBAL SETTINGS:
switch lower(journal),
    case 'pr'           % Physical Review settings:
        fsize=0.072;         % font size, in normalized units
        rotation=90;         % vertical Y-Label
        ar=4/3;              % aspect ratio

    case 'pr2'          % Physical Review (2 figures per column):
        fsize=0.14;    
        rotation=90;    
        ar=4/3;         
        
    case 'jfm'          % J. Fluid Mech. settings:
        fsize=0.05;
        rotation=0;
        ar=6/5;

    case 'jfm2'          % J. Fluid Mech. (two-columns) settings:
        fsize=0.076;
        rotation=0;
        ar=6/5;
        
    otherwise
        error(['Unknown journal format ''' journal '''']);
end;

% OPTIONS:
if nargin>1
    if sum(strcmpi({varargin{2:end}},'notitle')),
        title('');
    end;
    if sum(strcmpi({varargin{2:end}},'v')),  % YLabel vertical
        rotation=90;
    end;
end;

fname='Times New Roman';   % fontname
%fname='Times';

% Window size:
ss=get(0,'ScreenSize'); ssy=ss(4); % vertical screen size
pos=get(gcf,'Position');
pos = [pos(1) min([pos(2) ssy-500]) 560 420];
set(gcf,'Position',pos);

% Aspect ratio:
set(gca,'PlotBoxAspectRatio',[ar 1 1]);
    
% Font of the labels, title, legends and other annotation text:
set(findall(gcf,'Type','text'),'FontUnits','normalized');
set(findall(gcf,'Type','text'),'FontName',fname);
set(findall(gcf,'Type','text'),'FontSize',fsize);

% Font of the axes ticks:
set(gca,'FontUnits','normalized');
set(gca,'FontName',fname);
set(gca,'FontSize',fsize);
    
% location of the figure in the window
set(gca,'Position',[.175 .15 .75 .75]);

% background color = white
set(gcf,'Color',[1 1 1]);

% all lines in black:
set(findall(gcf,'Type','line'),'Color',[0 0 0]);

% Tick Length (default is 0.01):
set(gca,'TickLength',[0.02; 0.025])

% XLabel location:
hxl = get(gca,'XLabel');
set(hxl, 'Units', 'normalized');
set(hxl, 'Position', [0.5 -0.125 0]);

% YLabel location:
hyl = get(gca,'YLabel');
set(hyl, 'Units', 'normalized');
set(hyl, 'Position', [-0.15 0.5 0]);

% YLabel orientation:
set(hyl, 'Rotation',rotation);

% OPTIONS:
if nargin>1
    if sum(strcmpi({varargin{2:end}},'ext')),
        set(gca,'TickLength',-get(gca,'TickLength'));
    end;
end;
