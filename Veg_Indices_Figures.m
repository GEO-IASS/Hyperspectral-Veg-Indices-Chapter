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

grayLt = [189 189 189] ./ 255;
grayDk = [99 99 99] ./ 255;

%% Figure 14.4 Environmental Variables
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
ha = tight_subplot(2,2,[.03 .07],[.03 .03],[.07 .02]);

for ii = 1:4
    axes(ha(ii));
    
    if ii == 1 % Precipitation (mm)
        hold on
        bar(cell2mat(table2cell(envirData(:,11))),'facecolor',[1 1 1])
        bar(cell2mat(table2cell(envirData(:,11))),'k')
        axis([0 150 0 50])
        set(ha(ii),'YTick',0:10:50,'YTickLabel',0:10:50)
        set(ha(ii),'XTick',0:20:140,'XTickLabel',0:20:140)
        xlabel(ha(ii),'Julian Day','FontSize',12)
        ylabel(ha(ii),'Precipitation (mm)','FontSize',12)
        text(140,46,'a','FontWeight','bold','FontSize',14)
        legend({''},'Location','southoutside','Orientation','horizontal')

        box on
        hold off
    elseif ii == 2 % Percent Green
        hold on
        plot(cell2mat(metaBapi(:,3)),fracGrass(:,3),':k','LineWidth',1.5)
        plot(cell2mat(metaBapi(:,3)),fracArca(:,3),'--','color',grayDk,'LineWidth',1.5)
        plot(cell2mat(metaBapi(:,3)),fracBapi(:,3),'color',grayLt,'LineWidth',1.5)
        axis([0 150 0 0.8])
        set(ha(ii),'YTick',0:0.2:0.8,'YTickLabel',0:0.2:0.8)
        set(ha(ii),'XTick',0:20:140,'XTickLabel',0:20:140)
        xlabel(ha(ii),'Julian Day','FontSize',12)
        ylabel(ha(ii),'Percent Green','FontSize',12)
        text(140,0.76,'b','FontWeight','bold','FontSize',14)
        legend({'MAGR','ARCA','BAPI'},'Location','southoutside','Orientation','horizontal')
        box on
        hold off
    elseif ii == 3 % Volumetric Moisture Content
        hold on
        plot(cell2mat(table2cell(envirData(:,6))),':k','LineWidth',1.5)
        plot(cell2mat(table2cell(envirData(:,7))),'--','color',grayDk,'LineWidth',1.5)
        plot(cell2mat(table2cell(envirData(:,8))),'color',grayLt,'LineWidth',1.5)
        axis([0 150 0 0.6])
        set(ha(ii),'YTick',0:0.2:0.6,'YTickLabel',0:0.2:0.6)
        set(ha(ii),'XTick',0:20:140,'XTickLabel',0:20:140)
        xlabel(ha(ii),'Julian Day','FontSize',12)
        ylabel(ha(ii),'Volumetric Moisture Content','FontSize',12)
        text(140,0.56,'c','FontWeight','bold','FontSize',14)
        legend({'VMC10','VMC20','VMC50'},'Location','southoutside','Orientation','horizontal')
        box on
        hold off
    else % PET, AET
        hold on
        plot(cell2mat(table2cell(envirData(:,13))),'color',grayLt,'LineWidth',1.5) % AET
        plot(cell2mat(table2cell(envirData(:,15))),'-k','LineWidth',1.25)% PET
        axis([0 150 0 8])
        set(ha(ii),'YTick',0:2:8,'YTickLabel',0:2:8)
        set(ha(ii),'XTick',0:20:140,'XTickLabel',0:20:140)
        xlabel(ha(ii),'Julian Day','FontSize',12)
        ylabel(ha(ii),'Evapotranspiration (mm)','FontSize',12)
        legend({'AET','PET','AET/PET'},'Location','southoutside','Orientation','horizontal')
        text(140,7.6,'d','FontWeight','bold','FontSize',14)
        box on
        hold off
    end
end

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 8 6];
print(strcat(figDir,'figure_14-4'),'-dpng')

%% Figure 14.5 Spectra of Grass, BAPI, ARCA
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
print(strcat(figDir,'figure_14-5'),'-dpng')

%% Calculate Indices
indexArca = zeros(10,32);
indexBapi = zeros(10,32);

%CI Rededge index #8
%nir/rededge - 1
%indexArca(:,8) = specArca(:,)/specArca(:,) - 1;
%indexBapi(:,8) = [];

%WBI index #32
%b900/b970;
indexArca(:,32) = specArca(:,551)./specArca(:,621);
indexBapi(:,32) = specBapi(:,551)./specBapi(:,621);

%RVSI index #23
%(b714+b752)/2 - b733;
indexArca(:,23) = ((specArca(:,365) + specArca(:,403))/2 - specArca(:,384))/100;
indexBapi(:,23) = ((specBapi(:,365) + specBapi(:,403))/2 - specBapi(:,384))/100;

%% Figure 14.6: Index, Plant Available Water, and AET/PET
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
ha = tight_subplot(3,2,[.05 .07],[.05 .05],[.12 .03]);
xname = cell2mat(metaGrass(:,3));
for ii = 1:6
    axes(ha(ii));
    
    if ii == 1
        hold on
        plot(xname,indexGrass(:,32),':k','LineWidth',1.5)
        plot(xname,indexArca(:,32),'--','color',grayDk,'LineWidth',1.5)
        plot(xname,indexBapi(:,32),'color',grayLt,'LineWidth',1.5)
        axis([10 150 0.9 1.1])
        set(ha(ii),'YTick',0.9:0.05:1.1,'YTickLabel',0.9:0.05:1.1)
        set(ha(ii),'XTick',20:20:140,'XTickLabel',20:20:140)
        ytickformat('%.2f')
        ylabel('WBI')
        hold off

    elseif ii == 2
        hold on
        plot(xname,indexGrass(:,8),':k','LineWidth',1.5)
        plot(xname,indexArca(:,8),'--','color',grayDk,'LineWidth',1.5)
        plot(xname,indexBapi(:,8),'color',grayLt,'LineWidth',1.5)
        axis([10 150 0 2.5])
        set(ha(ii),'YTick',0:0.5:2.5,'YTickLabel',0:0.5:2.5)
        set(ha(ii),'XTick',20:20:140,'XTickLabel',20:20:140)
        ytickformat('%.1f')
        ylabel('CI Rededge')
        hold off
    elseif ii == 3
        hold on
        plot(xname,indexGrass(:,23),':k','LineWidth',1.5)
        plot(xname,indexArca(:,23),'--','color',grayDk,'LineWidth',1.5)
        plot(xname,indexBapi(:,23),'color',grayLt,'LineWidth',1.5)
        axis([10 150 -0.04 0])
        set(ha(ii),'YTick',-0.04:0.01:0,'YTickLabel',-0.04:0.01:0)
        set(ha(ii),'XTick',20:20:140,'XTickLabel',20:20:140)
        ytickformat('%.2f')
        ylabel('RVSI')
        hold off
    elseif ii  == 4
        hold on
        plot(xname,indexGrass(:,23),':k','LineWidth',1.5)
        plot(xname,indexArca(:,23),'--','color',grayDk,'LineWidth',1.5)
        plot(xname,indexBapi(:,23),'color',grayLt,'LineWidth',1.5)
        legend({'MAGF','ARCA','BAPI'},'FontSize',12,'Position',[0.75 0.5 0.05 0.05])%,'Orientation','horizontal'
        plot(xname,indexGrass(:,23),'-','Color',get(gcf,'color'),'LineWidth',1.5)
        plot(xname,indexArca(:,23),'-','Color',get(gcf,'color'),'LineWidth',1.5)
        plot(xname,indexBapi(:,23),'-','Color',get(gcf,'color'),'LineWidth',1.5)
        set(ha(ii),'visible','off')
        hold off
    elseif ii == 5
        set(ha(ii),'XTick',20:20:140,'XTickLabel',20:20:140)
        ylabel('Plant Available Water')
        xlabel('Julian Day')
    else
        hold on
        plot(xname,aetpet,'-k','LineWidth',1)% AET/PET
        axis([0 150 0 1.2])
        set(ha(ii),'XTick',20:20:140,'XTickLabel',20:20:140)
        set(ha(ii),'YTick',0:.2:1.2,'YTickLabel',0:.2:1.2)
        ytickformat('%.1f')
        ylabel('AET/PET')
        xlabel('Julian Day')
        hold off
    end
end

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 8 7];
print(strcat(figDir,'figure_14-6'),'-dpng')
%% Figure 14.7 Scatterplots
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
ha = tight_subplot(3,2,[.05 .08],[.07 .03],[.08 .03]);

for ii = 1:6
    axes(ha(ii));
    
    if ii == 1 %WBI vs Plant Available Water
        hold on
        scatter(apw,indexGrass(:,32),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(apw,indexArca(:,32),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(apw,indexBapi(:,32),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        ylabel('WBI')
        axis([0 1 0.9 1.15])
        set(ha(ii),'YTick',0.9:0.05:1.15,'YTickLabel',0.9:0.05:1.15)
        set(ha(ii),'XTick',0:0.2:1,'XTickLabel',0:0.2:1)
        text(0.95,1.13,'a','FontWeight','bold','FontSize',14)
        ytickformat('%.2f')
        box on
        hold off

    elseif ii == 2 %WBI vs AET/PET
        hold on
        scatter(aetpet,indexGrass(:,32),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(aetpet,indexArca(:,32),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(aetpet,indexBapi(:,32),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        axis([0 0.8 0.9 1.15])
        set(ha(ii),'YTick',0.9:0.05:1.15,'YTickLabel',0.9:0.05:1.15)
        set(ha(ii),'XTick',0:0.2:0.8,'XTickLabel',0:0.2:0.8)
        ytickformat('%.2f')
        text(0.76,1.13,'b','FontWeight','bold','FontSize',14)
        box on
        hold off        

    elseif ii == 3 %CI Rededge vs Plant Available Water
        hold on
        scatter(apw,indexGrass(:,8),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(apw,indexArca(:,8),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(apw,indexBapi(:,8),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        set(ha(ii),'YTick',0:0.5:2.5,'YTickLabel',0:0.5:2.5)
        set(ha(ii),'XTick',0:0.2:1,'XTickLabel',0:0.2:1)
        axis([0 1 0 2.5])
        ytickformat('%.1f')
        text(0.95,2.35,'c','FontWeight','bold','FontSize',14)
        box on
        ylabel('CI Rededge')
        hold off

    elseif ii  == 4 %CI Rededge vs AET/PET
        hold on
        scatter(aetpet,indexGrass(:,8),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(aetpet,indexArca(:,8),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(aetpet,indexBapi(:,8),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        axis([0 0.8 0 2.5])
        set(ha(ii),'YTick',0:0.5:2.5,'YTickLabel',0:0.5:2.5)
        set(ha(ii),'XTick',0:0.2:0.8,'XTickLabel',0:0.2:0.8)
        text(0.76,2.35,'d','FontWeight','bold','FontSize',14)
        ytickformat('%.2f')
        box on
        hold off
        
    elseif ii == 5 %RVSI vs Plant Available Water
        hold on 
        scatter(apw,indexGrass(:,23),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(apw,indexArca(:,23),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(apw,indexBapi(:,23),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        set(ha(ii),'YTick',-0.04:0.01:0,'YTickLabel',-0.04:0.01:0)
        set(ha(ii),'XTick',0:0.2:1,'XTickLabel',0:0.2:1)
        axis([0 1 -0.04 0])
        ytickformat('%.2f')
        text(0.95,-0.003,'e','FontWeight','bold','FontSize',14)
        box on
        ylabel('RVSI')
        xlabel('Plant Available Water')
        hold off
        
    else %RVSI vs AET/PET
        hold on
        scatter(aetpet,indexGrass(:,23),'s','filled','MarkerEdgeColor','k','MarkerFaceColor','k')
        scatter(aetpet,indexArca(:,23),'^','filled','MarkerEdgeColor','k','MarkerFaceColor','w')
        scatter(aetpet,indexBapi(:,23),'o','filled','MarkerEdgeColor',grayDk,'MarkerFaceColor',grayLt)
        h = lsline;
        set(h,'color','k')
        axis([0 0.8 -0.04 0])
        set(ha(ii),'YTick',-0.04:0.01:0,'YTickLabel',-0.04:0.01:0)
        set(ha(ii),'XTick',0:0.2:0.8,'XTickLabel',0:0.2:0.8)
        ytickformat('%.2f')
        text(0.76,-0.003,'f','FontWeight','bold','FontSize',14)
        box on
        xlabel('AET/PET')
        hold off
    end
end

% Save Image
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 8 7];
print(strcat(figDir,'figure_14-7'),'-dpng')

%% Other Figures (BACKUP)
% Spectra of Grass Plots
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

% Spectra of BAPI
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

% Spectra of ARCA
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