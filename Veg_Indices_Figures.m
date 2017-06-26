%% Susan Meerdink
% 6/26/17
% This code is to generate figures for Hyperspectral Vegetation Indices
% Book Chapter (Chapter 14 in Hyperspectral Remote Sensing of Vegetation)
%% Load Data
% This chapter is being updated to include data from the COPR Paul Gader
% field collection that occured in 2016.
cd 'C:\Users\Susan\Documents\GitHub\Hyperspectral-Veg-Indices-Chapter'
load Veg_Indices_Data.mat
figDir = 'F:\Dropbox\Manuscript\Hyperspectral Vegetation Indices Book Chapter\Figures\';

%% Setting up Colors
color1 = [158 1 66] ./ 255; %Red
color2 = [213 62 79] ./ 255;
color3 = [244 109 67] ./ 255;
color4 = [253 174 97] ./ 255;
color5 = [254 224 139] ./ 255;
color6 = [255 255 191] ./ 255;
color7 = [230 245 152] ./ 255;
color8 = [171 221 164] ./ 255;
color9 = [102 194 165] ./ 255;
color10 = [50 136 189] ./ 255; %Blue
color = [color1;color2;color3;color4;color5;color6;color7;color8;color9;color10];

%% Spectra of Grass Plots
figure
hold on
for i = 1:10 %loop through dates
    h(i) = plot(wave(:,1:991),specGrass(i,1:991),'LineWidth',1,'Color',color(i,:));
    plot(wave(:,1111:1431),specGrass(i,1111:1431),'LineWidth',1,'Color',color(i,:))
    plot(wave(:,1571:end),specGrass(i,1571:end),'LineWidth',1,'Color',color(i,:))
end
axis([350 2500 0 50])
set(gca,'YTick',0:10:50,'YTickLabel',0:10:50)
set(gca,'XTick',500:500:2500)
set(gca,'XTickLabel',[500, 1000, 1500, 2000, 2500])
xlabel(gca,'Wavelength (nm)','FontSize',12)
ylabel(gca,'Reflectance (%)','FontSize',12)
legend([h(1),h(2),h(3),h(4),h(5),h(6),h(7),h(8),h(9),h(10)],{'JD 12','JD 25','JD 40','JD 51','JD 69','JD 75','JD 95','JD 108','JD 121','JD 146'},'Location','BestOutside')
text(2400,48,'a','FontWeight','bold','FontSize',14)
box on
hold off

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 5 2.5];
print(strcat(figDir,'spectra_grass'),'-dpng')

%% Spectra of BAPI
figure
hold on
for i = 1:10 %loop through dates
    h(i) = plot(wave(:,1:991),specBapi(i,1:991),'LineWidth',1,'Color',color(i,:));
    plot(wave(:,1111:1431),specBapi(i,1111:1431),'LineWidth',1,'Color',color(i,:))
    plot(wave(:,1571:end),specBapi(i,1571:end),'LineWidth',1,'Color',color(i,:))
end
axis([350 2500 0 50])
set(gca,'YTick',0:10:50,'YTickLabel',0:10:50)
set(gca,'XTick',500:500:2500)
set(gca,'XTickLabel',[500, 1000, 1500, 2000, 2500])
xlabel(gca,'Wavelength (nm)','FontSize',12)
ylabel(gca,'Reflectance (%)','FontSize',12)
legend([h(1),h(2),h(3),h(4),h(5),h(6),h(7),h(8),h(9),h(10)],{'JD 12','JD 25','JD 40','JD 51','JD 69','JD 75','JD 95','JD 108','JD 121','JD 146'},'Location','BestOutside')
text(2400,48,'b','FontWeight','bold','FontSize',14)
box on
hold off

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 5 2.5];
print(strcat(figDir,'spectra_BAPI'),'-dpng')

%% Spectra of ARCA
figure
hold on
for i = 1:10 %loop through dates
    h(i) = plot(wave(:,1:991),specArca(i,1:991),'LineWidth',1,'Color',color(i,:));
    plot(wave(:,1111:1431),specArca(i,1111:1431),'LineWidth',1,'Color',color(i,:))
    plot(wave(:,1571:end),specArca(i,1571:end),'LineWidth',1,'Color',color(i,:))
end
axis([350 2500 0 50])
set(gca,'YTick',0:10:50,'YTickLabel',0:10:50)
set(gca,'XTick',500:500:2500)
set(gca,'XTickLabel',[500, 1000, 1500, 2000, 2500])
xlabel(gca,'Wavelength (nm)','FontSize',12)
ylabel(gca,'Reflectance (%)','FontSize',12)
legend([h(1),h(2),h(3),h(4),h(5),h(6),h(7),h(8),h(9),h(10)],{'JD 12','JD 25','JD 40','JD 51','JD 69','JD 75','JD 95','JD 108','JD 121','JD 146'},'Location','BestOutside')
text(2400,48,'c','FontWeight','bold','FontSize',14)
box on
hold off

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 5 2.5];
print(strcat(figDir,'spectra_ARCA'),'-dpng')

%% Spectra of Grass, BAPI, ARCA
% ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%   in:  Nh      number of axes in height (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins
figure('units','normalized','outerposition',[0 0 1 1])
ha = tight_subplot(2,2,[.06 .05],[.1 .03],[.06 .02]);
for ii = 1:4
    axes(ha(ii));
    
    if ii == 1
        hold on
        for i = 1:10 %loop through dates
            plot(wave(:,1:991),specGrass(i,1:991),'LineWidth',1,'Color',color(i,:));
            plot(wave(:,1111:1431),specGrass(i,1111:1431),'LineWidth',1,'Color',color(i,:))
            plot(wave(:,1571:end),specGrass(i,1571:end),'LineWidth',1,'Color',color(i,:))
        end
        axis([350 2500 0 50])
        set(ha(ii),'YTick',0:10:50,'YTickLabel',0:10:50)
        set(ha(ii),'XTick',400:500:2400)
        set(ha(ii),'XTickLabel',[400, 900, 1400, 1900, 2400])
        %xlabel(ha(ii),'Wavelength (nm)','FontSize',12)
        ylabel(ha(ii),'Reflectance (%)','FontSize',12)
        text(2400,47,'a','FontWeight','bold','FontSize',14)
        box on
        hold off
    elseif ii == 2
        hold on
        for i = 1:10 %loop through dates
            plot(wave(:,1:991),specBapi(i,1:991),'LineWidth',1,'Color',color(i,:));
            plot(wave(:,1111:1431),specBapi(i,1111:1431),'LineWidth',1,'Color',color(i,:))
            plot(wave(:,1571:end),specBapi(i,1571:end),'LineWidth',1,'Color',color(i,:))
        end
        axis([350 2500 0 50])
        set(ha(ii),'YTick',0:10:50,'YTickLabel',0:10:50)
        set(ha(ii),'XTick',400:500:2400)
        set(ha(ii),'XTickLabel',[400, 900, 1400, 1900, 2400])
        %xlabel(ha(ii),'Wavelength (nm)','FontSize',12)
        %ylabel(ha(ii),'Reflectance (%)','FontSize',12)
        text(2400,47,'b','FontWeight','bold','FontSize',14)
        box on
        hold off
    elseif ii == 3
        hold on
        for i = 1:10 %loop through dates
            plot(wave(:,1:991),specArca(i,1:991),'LineWidth',1,'Color',color(i,:));
            plot(wave(:,1111:1431),specArca(i,1111:1431),'LineWidth',1,'Color',color(i,:))
            plot(wave(:,1571:end),specArca(i,1571:end),'LineWidth',1,'Color',color(i,:))
        end
        axis([350 2500 0 50])
        set(ha(ii),'YTick',0:10:50,'YTickLabel',0:10:50)
        set(ha(ii),'XTick',400:500:2400)
        set(ha(ii),'XTickLabel',[400, 900, 1400, 1900, 2400])
        xlabel(ha(ii),'Wavelength (nm)','FontSize',12)
        ylabel(ha(ii),'Reflectance (%)','FontSize',12)
        text(2400,47,'c','FontWeight','bold','FontSize',14)
        box on
        hold off
    else
        hold on
        for i = 1:10 %loop through dates
            h(i)= plot(wave(:,1:991),specArca(i,1:991),'LineWidth',1,'Color',color(i,:));
        end
        legend([h(1),h(2),h(3),h(4),h(5),h(6),h(7),h(8),h(9),h(10)],{'JD 12','JD 25','JD 40','JD 51','JD 69','JD 75','JD 95','JD 108','JD 121','JD 146'},'Location','West');
        for i = 1:10 %loop through dates
            h(i)= plot(wave(:,1:991),specArca(i,1:991),'LineWidth',1,'Color',get(gcf,'color'));
        end
        set(ha(ii),'visible','off')
        hold off
    end
end

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 8 5];
print(strcat(figDir,'spectra_Grass_BAPI_ARCA'),'-dpng')

%% Index Grass
% ha = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%   in:  Nh      number of axes in height (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins
figure('units','normalized','outerposition',[0 0 1 1])
ha = tight_subplot(3,1,[.06 .05],[.1 .05],[.25 .05]);
xname = cell2mat(metaGrass(:,3));
for ii = 1:3
    axes(ha(ii));
    
    if ii == 1
        plot(xname,indexGrass(:,8),'k')
        axis([10 150 0 2.5])
        set(ha(ii),'YTick',0:0.5:2.5,'YTickLabel',0:0.5:2.5)
        set(ha(ii),'XTick',20:20:140)
        ylabel('CI Rededge')
        title('MAGF')
    elseif ii == 2
        plot(xname,indexGrass(:,32),'k')
        axis([10 150 0.9 1])
        set(ha(ii),'YTick',0.9:0.02:1,'YTickLabel',0.9:0.02:1)
        set(ha(ii),'XTick',20:20:140)
        ylabel('WBI')
    else
        plot(xname,indexGrass(:,23),'k')
        axis([10 150 -0.02 0])
        set(ha(ii),'YTick',-0.02:0.004:0,'YTickLabel',-0.02:0.004:0)
        set(ha(ii),'XTick',20:20:140)
        ylabel('RVSI')
        xlabel('Julian Day')
    end
end

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 3 5];
print(strcat(figDir,'index_Grass'),'-dpng')