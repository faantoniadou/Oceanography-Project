function [] = monthlyavgsstpo(~)

sst = ncread('alltemp.nc','votemper');

monthlyavg_sst = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(sst,1)
    for j = 1:size(sst,2)
        for l = 1:size(sst,3)
            for l = 373:384
                temper = sst([290:318],[210:253],:,l);
                monthlyavg_sst = [monthlyavg_sst mean(temper,'all','omitnan')];
                
                %time iteration
                start_date = datetime('Jan-2018');
                end_date = datetime('Dec-2018');
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
scatter(date_actual,monthlyavg_sst,'x');
hold on
box on;
line((w),monthlyavg_sst)
ylabel('Mean Sea Surface Temperature / °C');
xlabel('Date');
sgtitle('Mean Monthly Sea Surface Temperature in the Po estuary region 1988, 1998, 2008 and 2018');

ww = datetime([start_date : hours(1) : end_date]);
polynomial = polyfit(datenum(w),monthlyavg_sst, 3);

yFit = polyval(polynomial, datenum(ww));
plot(ww, yFit, 'r-');



