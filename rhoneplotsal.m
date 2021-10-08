function [] = rhoneplotsal(~)
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

sal = ncread('allsal.nc','vosaline');
salin = sal([110:230],[200:230],:,:);

lonlim = [min(longitude([110:230])) max(longitude([110:230]))];
latlim = [min(latitude([200:230])) max(latitude([200:230]))];


%Find maximum and minimum salinities in river delta
maxsal = ceil(max(salin, [], 'all'));
minsal = floor(min(salin, [], 'all'));

%plot salinity for every calendar month 
for i = 1:size(salin,1)
    for j = 1:size(salin,2)
        for k = 1:size(salin,3)
            for l = 268
                monthly_sal = sal([160:185],[200:220],:,l);
                
                %time iteration
                start_date = datetime('Jan/1987','InputFormat','MMM/yyyy');
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
                c.Ticks = linspace(minsal,maxsal,8);
                c.Label.String = 'Salinity /ppm' ;
                
                title(sprintf('Monthly Mean Salinity of the river Rhone \n %s', date_actual));
                
                %save figure as png
                saveas(figsal, fullfile('/Users/User/Desktop/Oceanography Project/Copernicus Data/SALINITY/rhone', sprintf('rhonesal%d.png',l)));
            end
            break
        end
        break
    end
    break
end

