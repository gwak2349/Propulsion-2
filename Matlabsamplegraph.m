function Matlabsamplegraph(x,y,id,txt)
%% define colours
% some of the default matlab colours are quite bad so I decided to overwrite them
% the new scheme on the recent matlab versions is a lot better but I still prefer to start
% off with black, then blue or red, ...
% especially if you only have one set of data it can save you a lot in colour printing

myred           = [216 30 49]/255;
myblue          = [27 99 157]/255;
myblack         = [0 0 0]/255;
mygreen         = [0 128 0]/255;
mycyan          = [2 169 226]/255;
myyellow        = [251 194 13]/255;
mygray          = [89 89 89]/255;

% if you want to keep using the standard matlab color remove this
set(groot,'defaultAxesColorOrder',[myblack;myblue;myred;mygreen;myyellow;mycyan;mygray]);

%% define some general plot parameters
alw             = 1;                        % AxesLineWidth
fsz             = 22;                       % Fontsize
lw              = 2.5;                        % LineWidth
msz             = 40;                       % MarkerSize

set(0,'defaultLineLineWidth',lw);           % set the default line width to lw
set(0,'defaultLineMarkerSize',msz);         % set the default line marker size to msz
set(0,'defaultLineLineWidth',lw);           % set the default line width to lw
set(0,'defaultLineMarkerSize',msz);         % set the default line marker size to msz


%% the actual plot
hFig            = figure(1); clf;
set(gcf, 'Color', [1 1 1]);                 % Sets figure background
set(gca, 'Color', [1 1 1]);                 % Sets axes background
hold on
grid on
grid minor
figure
plot(x,y)


if id==0
    xlabel("$$ \frac{r}{R} $$", "Interpreter", "latex")
    if txt=="chordvec"
        ylabel("Chord (m)")
    elseif txt=="pitchvec"
        ylabel("Pitch (radians)")
    end
    grid
elseif id==1
    xlabel("$$\alpha$$ ($$^{\circ}$$)", "Interpreter", "latex")
    [hleg] = legend('Re=0.65e6','Re=0.85e6','Re=1e6');

    set(hleg,'EdgeColor',hleg.Color);
    set(hleg,'Location','best');
    if txt=="lift"
        ylabel("$$C_L$$", "Interpreter", "latex")
    elseif txt=="drag"
        ylabel("$$C_D$$", "Interpreter", "latex")
    end
    grid
box on
set(gca,'GridLineStyle','-')                            % set gridline and font properties
set(gca,'MinorGridLineStyle','-')
set(gca,'GridColor','k')
set(gca,'MinorGridColor','k')
set(findall(hFig, '-property', 'FontSize'), 'FontSize', fsz)







%% to print it into a file

print -depsc -r300 figurename
print -dpng -r300 figurename2

% set the colours back
set(groot,'defaultAxesColorOrder','remove')






end



%% alternative printing command - my current preferred option
% you do need to download export_fig from the matlab fileexchange and place it into your
% matlab path (or anywhere where matlab can find it, so for instance the current folder)

%export_fig('figurename', '-png','-r600','-nocrop');
% note that a resolution of 600 dpi might be overkill and could result in large files. On
% a mac the files are generally not too big and are good in resolution.
% No testing has been done on ANY windows platform so you are on your own