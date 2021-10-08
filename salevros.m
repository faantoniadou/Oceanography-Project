function [] = salevros(~)
%latitude = ncread('allsal.nc','lat');
%longitude = ncread('allsal.nc','lon');
sal = ncread('allsal.nc','vosaline');

monthlyavg_sal = [];
date_actual = [];
%plot sea surface salinity for every calendar month 
for i = 1:size(sal,1)
    for j = 1:size(sal,2)
        for k = 1:size(sal,3)
            for l = 1:size(sal,4)
                salin = sal([462:530],[140:180],:,l);
                monthlyavg_sal = [monthlyavg_sal mean(salin,'all','omitnan')];
                
                %time iteration
                start_date = datetime('January-1987');
                end_date = datetime('December-2018');
                time_period = [start_date : calmonths(1) : end_date];
                date_actual = ([date_actual, (time_period(l))]);
            end
            break
        end
        break
    end
    break
end


%find yearly mean salinity
yearlyavg_sal = [];
for m = [1 12:12:size(sal,4)-12]
    if m == 1 
        yearlyavg_sal = [yearlyavg_sal; mean(monthlyavg_sal(m:(m+11)))];
    elseif m > 1
        yearlyavg_sal = [yearlyavg_sal mean(monthlyavg_sal(m:(m+12)))];
    end
    
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
    
end

w = datetime([start_date : calyears(1) : end_date]);

plot(year,yearlyavg_sal,'k-x')
hold on
box on;
ylabel('Mean Salinity /psu');
xlabel('Date');
xticks([start_year : calyears(1) : (end_year)]);
yticks([36.6:0.1:37.8]);
xtickangle(45);
xlim([datetime('1987','InputFormat','yyyy') datetime('2018','InputFormat','yyyy')])
title('Annual Mean Salinity in the river Evros estuary region');

%plot best fit straight line
ww = datetime([start_date : hours(1) : end_date]);

polynomial = polyfit(datenum(w),yearlyavg_sal, 1);
yFit = polyval(polynomial, datenum(ww));
plot(ww, yFit, 'r-');

polynomial2 = polyfit(datenum(w),yearlyavg_sal, 5);
yFit2 = polyval(polynomial2, datenum(ww));
plot(ww, yFit2, 'g-');

%find rate of change of average salinity change
gradient = 365.25 * (max(yFit) - min(yFit))/(max(datenum(ww))-min(datenum(ww)));
disp(gradient)



