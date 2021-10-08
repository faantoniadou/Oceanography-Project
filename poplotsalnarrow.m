function [] = poplotsalnarrow(~)
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

sal = ncread('allsal.nc','vosaline');
salin = sal([290:318],[210:253],:,:);

lonlim = [min(longitude([290:318])) max(longitude([290:318]))];
latlim = [min(latitude([210:253])) max(latitude([210:253]))];

%outsidepo = til(sal([270:370],[160:200],:));

%Find maximum and minimum salinities in river delta
maxsal = 40;
minsal = 19;

%plot salinity for every calendar month 
for i = 1:size(salin,1)
    for j = 1:size(salin,2)
        for k = 1:size(salin,3)
            for l = 1
                monthly_sal = salin(:,:,:,l);
                
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
                c.Label.String = 'Salinity /psu' ;
                
                title(sprintf('Monthly Mean Salinity of the river Po \n %s', date_actual));
                
                %save figure as png
                saveas(figsal, fullfile('/Users/User/Desktop/Oceanography Project/Copernicus Data/SALINITY/po', sprintf('salpo%d.png',l)));
            end
            return
        end
        return
    end
    return
end
return




