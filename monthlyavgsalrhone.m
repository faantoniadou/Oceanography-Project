function [] = monthlyavgsalrhone(~)

sal = ncread('allsal.nc','vosaline');

monthlyavg_sal = [];
date_actual = [];
%plot sea surface salinity for every calendar month 

for l = 373:384
    salin = sal([110:230],[200:230],:,l);
    monthlyavg_sal = [monthlyavg_sal mean(salin,'all','omitnan')];

    %time iteration
    start_date = datetime('Jan-2018');
    end_date = datetime('Dec-2018');
    time_period = [start_date : calmonths(1) : end_date];
    date_actual = ([date_actual, (time_period(l-372))]);
end

subplot(2,2,4);
w = datetime([start_date : calmonths(1) : end_date]);
scatter(date_actual,monthlyavg_sal,'x');
hold on
box on;
line((w),monthlyavg_sal)
ylabel('Salinity / psu');
xlabel('Date');
%title('Mean Monthly Salinity of the river Rhone estuary');

ww = datetime([start_date : hours(1) : end_date]);
%polynomial = polyfit(datenum(w),monthlyavg_sal, 2);

%yFit = polyval(polynomial, datenum(ww));
plot(ww, 'r-');



