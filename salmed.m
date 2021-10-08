function [] = salmed(~)

%obtain salinity matrix
sal = ncread('allsal.nc','vosaline');

%create empty lists for dates & salinities
monthlyavg_sal = [];
date_actual = [];

%calculate mean salinity for every month
for i = 1:size(sal,1)
    for j = 1:size(sal,2)
        for k = 1:size(sal,3)
            for l = 1:size(sal,4)
                salin = sal(:,:,l);
                monthlyavg_sal = [monthlyavg_sal mean(salin,'all','omitnan')];
                
                %time iteration
                start_date = datetime('Jan-1987');
                end_date = datetime('Dec-2018');
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
        yearlyavg_sal = [yearlyavg_sal mean(monthlyavg_sal(m:(m+11)))];
    elseif m > 1
        yearlyavg_sal = [yearlyavg_sal mean(monthlyavg_sal(m:(m+12)))];
    end
    
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
end

plot(year,yearlyavg_sal,'r--x')
hold on;
box on;
ylabel('Mean Salinity /psu');
xlabel('Date');
xticks([start_year : calyears(1) : (end_year)]);
xtickangle(45);
xlim([datetime('1987','InputFormat','yyyy') datetime('2018','InputFormat','yyyy')])
title('Annual Mean Salinity in the Mediterranean Sea');

%Plot best fit straight line
w = datetime([start_date : calyears(1) : end_date]);
ww = datetime([start_date : hours(1) : end_date]);

polynomial = polyfit(datenum(w),yearlyavg_sal, 1);
yFit = polyval(polynomial, datenum(ww));
%plot(ww, yFit, 'r-');

polynomial2 = polyfit(datenum(w),yearlyavg_sal, 5);
yFit2 = polyval(polynomial2, datenum(ww));
plot(ww, yFit2, 'g-');

%find the rate of salinity change
gradient = 365.25*(max(yFit) - min(yFit))/(max(datenum(w))-min(datenum(w)));
disp(gradient)

