function [] = plottempcop(~)
%latitude = ncread('temp.nc','lat');
%longitude = ncread('temp.nc','lon');
temperature = ncread('alltemp.nc','votemper');

%Find maximum and minimum temperatures in all of time
maxtemp = ceil(max(temperature, [], 'all'));
mintemp = floor(min(temperature, [], 'all'));

%set dates
start_date = datetime('Dec/1987','InputFormat','MMM/yyyy');
end_date = datetime('Dec/2018','InputFormat','MMM/yyyy');
time_period = [start_date : calmonths(1) : end_date];

for l = 1:size(temperature,4)

    monthly_temp = temperature(:,:,:,l);

    %time iteration
    date_actual = datestr(time_period(l),'mmmm yyyy');

    %plot graph
    figtemp = pcolor(((monthly_temp)'));
    set(figtemp, 'EdgeColor', 'none');
    set(gca,'color',0*[1 1 1]);

    set(gca,'DataAspectRatio', [4 3 4]);
    set(gca,'XTick',[])
    set(gca,'YTick',[])

    c = colorbar;
    colormap jet
    c.Location = 'southoutside';
    caxis manual
    caxis([mintemp maxtemp]);
    c.Ticks = linspace(mintemp,maxtemp,14);
    c.Label.String = 'Temperature /°C' ;

    title(sprintf('Monthly Mean SST \n %s', date_actual));

    %save figure as png
    saveas(figtemp, fullfile('/Users/User/Desktop/Oceanography Project/Copernicus Data/SST/alltemps', sprintf('fig%d.png',l)));
end