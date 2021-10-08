function [] = monthlyavgsalpo(~)

sal = ncread('allsal.nc','vosaline');

monthlyavg_sal = [];
date_actual = [];
%plot sea surface salinity for every calendar month 
for i = 1:size(sal,1)
    for j = 1:size(sal,2)
        for l = 1:size(sal,3)
            for l = 373:384
                salin = sal([290:318],[210:253],:,l);
                monthlyavg_sal = [monthlyavg_sal mean(salin,'all','omitnan')];
                
                %time iteration
                start_date = datetime('Jan-1988');
                end_date = datetime('Dec-1988');
                time_period = [start_date : calmonths(1) : end_date];
                date_actual = ([date_actual, (time_period(l-372))]);
            end
            break
        end
        break
    end
    break
end

w = datetime([start_date : calmonths(1) : end_date]);
scatter(date_actual,monthlyavg_sal,'x');
hold on
box on;
line((w),monthlyavg_sal)
ylabel('Salinity / psu');
xlabel('Date');
sgtitle('Mean Monthly SSS of the river Po estuary in 1988, 1998, 2008 and 2018');

ww = datetime([start_date : caldays(1) : end_date]);
polynomial = polyfit(datenum(w),monthlyavg_sal, 3);

yFit = polyval(polynomial, datenum(ww));
plot(ww, yFit, 'r-');



