function [] = allyearlymintemp(~)
%latitude = ncread('alltemp.nc','lat');
%longitude = ncread('alltemp.nc','lon');
temperature = ncread('alltemp.nc','votemper');

monthlymin_temp = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(temperature,1)
    for j = 1:size(temperature,2)
        for k = 1:size(temperature,3)
            for l = 1:size(temperature,4)
                temp = temperature(:,:,:,l);
                monthlymin_temp = [monthlymin_temp min(temp,[],'all')];
                
                %time iteration
                start_date = datetime('Jan-1987');
                end_date = datetime('Dec-2018');
                time_period = [start_date : calmonths(1) : end_date];
                date_actual = ([date_actual, (time_period(l))]);

            end
            continue
        end
        break
    end
    break
end

%find yearly maximum temperature

yearlymin_temp = [];
for m = [1 12:12:372]
    yearlymin_temp = [yearlymin_temp min(monthlymin_temp(m:(m+11)))];
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
end
%disp(year)
%disp(yearlymax_temp)
scatter(year,yearlymin_temp,'x')
hold on
line(year,yearlymin_temp)
ylabel('Temperature / deg C');
xlabel('Date');
title('Yearly minimum temperature');



