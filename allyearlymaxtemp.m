function [] = allyearlymaxtemp(~)
%latitude = ncread('alltemp.nc','lat');
%longitude = ncread('alltemp.nc','lon');
temperature = ncread('alltemp.nc','votemper');

monthlymax_temp = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(temperature,1)
    for j = 1:size(temperature,2)
        for k = 1:size(temperature,3)
            for l = 1:size(temperature,4)
                temp = temperature(:,:,:,l);
                monthlymax_temp = [monthlymax_temp max(temp,[],'all')];
                
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

yearlymax_temp = [];
for m = [1 12:12:372]
    yearlymax_temp = [yearlymax_temp max(monthlymax_temp(m:(m+11)))];
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
end
%disp(year)
%disp(yearlymax_temp)
scatter(year,yearlymax_temp,'x')
hold on
line(year,yearlymax_temp)
ylabel('Temperature / deg C');
xlabel('Date');
title('Yearly maximum temperature');



