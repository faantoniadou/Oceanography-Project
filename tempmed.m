function [rate,change] = tempmed(~)

sst = ncread('alltemp.nc','votemper');

monthlyavg_sst = [];
date_actual = [];

%plot sea surface temperature for every calendar month 
for i = 1:size(sst,1)
    for j = 1:size(sst,2)
        for k = 1:size(sst,3)
            for l = 1:size(sst,4)
                sstemp = sst(:,:,:,l);
                monthlyavg_sst = [monthlyavg_sst mean(sstemp,'all','omitnan')];
                
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

%find yearly mean temperature
yearlyavg_sst = [];
for m = [1 12:12:size(sst,4)-12]
    if m == 1 
        yearlyavg_sst = [yearlyavg_sst mean(monthlyavg_sst(m:(m+11)))];
    elseif m > 1
        yearlyavg_sst = [yearlyavg_sst mean(monthlyavg_sst(m:(m+12)))];
    end
    
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
    
end

w = datetime([start_date : calyears(1) : end_date]);

plot(year,yearlyavg_sst,'r-x')
hold on
ylabel('Mean Sea Surface Temperature / °C');
xlabel('Date');
xticks([start_year : calyears(1) : (end_year)]);
xtickangle(45);
xlim([datetime('1987','InputFormat','yyyy') datetime('2018','InputFormat','yyyy')]);
%title('Annual Mean Sea Surface Temperature in the Mediterranean Sea');

%plot best fit straight line
ww = datetime([start_date : hours(1) : end_date]);

polynomial = polyfit(datenum(w),yearlyavg_sst, 1);
yFit = polyval(polynomial, datenum(ww));
%plot(ww, yFit, 'r-');

polynomial2 = polyfit(datenum(w),yearlyavg_sst, 5);
yFit2 = polyval(polynomial2, datenum(ww));
plot(ww, yFit2, 'g-');

%find rate of change of average temperature change
gradient = 365.25 * (max(yFit) - min(yFit))/(max(datenum(w))-min(datenum(w)));
disp(gradient)

diff = max(yFit) - min(yFit);
disp(diff)
