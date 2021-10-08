function [] = plotssh(~)
%latitude = ncread('allssh.nc','lat');
%longitude = ncread('temp.nc','lon');
height = ncread('allssh.nc','sossheig');

%Find maximum and minimum ssh in all of time
maxssh = 0.1;
minssh = -0.6;

%set dates
start_date = datetime('Dec/1987','InputFormat','MMM/yyyy');
end_date = datetime('Dec/2018','InputFormat','MMM/yyyy');
time_period = [start_date : calmonths(1) : end_date];

%plot sea surface ssh for every calendar month 
for i = 1:size(height,1)
    for j = 1:size(height,2)
        for l = 1:size(height,3)

            monthly_ssh = height(:,:,l);

            %time iteration
            date_actual = datestr(time_period(l),'mmmm yyyy');

            %plot graph
            figssh = pcolor(((monthly_ssh)'));
            set(figssh, 'EdgeColor', 'none');
            set(gca,'color',[1 0 0]);

            set(gca,'DataAspectRatio', [4 3 4]);
            set(gca,'XTick',[])
            set(gca,'YTick',[])

            c = colorbar;
            colormap jet
            c.Location = 'southoutside';
            caxis manual
            caxis([minssh maxssh]);
            c.Ticks = linspace(minssh,maxssh,8);
            c.Label.String = 'Sea Surface Height / m ' ;

            title(sprintf('Monthly Mean Sea Surface Height \n %s', date_actual));

            %save figure as png
            saveas(figssh, fullfile('/Users/User/Desktop/Oceanography Project/Copernicus Data/SSH/allssh', sprintf('ssh%d.png',l)));
           
        end
        break
    end
    break
end


