function [] = plotsal(~)

sal = ncread('allsal.nc','vosaline');

%Set maximum and minimum limits in all of time
%maxsal = ceil(max(sal, [], 'all'));
%minsal = floor(min(sal, [], 'all'));
minsal = 32;
maxsal = 40;

%plot salinity for every calendar month 
for l = 1:size(sal,4)
    monthly_sal = sal(:,:,1,l);

    %time iteration
    start_date = datetime('Dec/1987','InputFormat','MMM/yyyy');
    end_date = datetime('Dec/2018','InputFormat','MMM/yyyy');
    time_period = [start_date : calmonths(1) : end_date];
    date_actual = datestr(time_period(l),'mmmm yyyy');

    %plot graph
    figsal = pcolor(((monthly_sal)'));
    set(figsal, 'EdgeColor', 'none');
    set(gca,'color',0*[1 1 1]);                
    set(gca,'DataAspectRatio', [4 3 4]);
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    c = colorbar;
    colormap jet
    c.Location = 'southoutside';
    caxis manual
    caxis([minsal maxsal])
    c.Ticks = linspace(minsal,maxsal,9);
    c.Label.String = 'Salinity /psu' ;

    title(sprintf('Monthly Mean SSS\n %s', date_actual));

    %save figure as png
    saveas(figsal, fullfile('/Users/User/Desktop/Oceanography Project/Copernicus Data/SALINITY', sprintf('figsal%d.png',l)));
end
            

