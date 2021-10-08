function [] = medplotsshspec(~)
ssh = ncread('allssh.nc','sossheig');

ssh = ssh(:,:,[217:384]);
monthlyavg_ssh = [];
date_actual = [];

%plot sea surface height for every calendar month 
for i = 1:size(ssh,1)
    for j = 1:size(ssh,2)
        for l = 1:size(ssh,3)
            ssho = ssh(:,:,l);
            monthlyavg_ssh = [monthlyavg_ssh mean(ssho,'all','omitnan')];
                
            %time iteration
            start_date = datetime('Jan-2005');
            end_date = datetime('Dec-2018');
            time_period = [start_date : calmonths(1) : end_date];
            date_actual = ([date_actual, (time_period(l))]);
        end
        break
    end
    break
end

%find yearly maximum ssh
yearlyavg_ssh = [];
for m = [1 12:12:size(ssh,3)-11]
    if m == 1 
        yearlyavg_ssh = [yearlyavg_ssh mean(monthlyavg_ssh(m:(m+11)))];
    elseif m > 1
        yearlyavg_ssh = [yearlyavg_ssh mean(monthlyavg_ssh(m:(m+12)))];
    end
    
    start_year = datetime('2005','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
    
end

plot(year,yearlyavg_ssh,'k-x')
hold on
box on;
ylabel('Mean Sea Surface Height / m');
xlabel('Date');
xticks([start_year : calyears(1) : (end_year)]);
xtickangle(45);
xlim([datetime('2005','InputFormat','yyyy') datetime('2018','InputFormat','yyyy')]);
title('Annual Mean Sea Surface Height in the Mediterranean Sea from 2005');
%plot best fit straight line
w = datetime([start_date : calmonths(1) : end_date]);

plot(year, yFit, 'r-');
ww = datetime([start_date : caldays(1) : end_date]);

polynomial = polyfit(datenum(w),monthlyavg_ssh, 1);
yFit = polyval(polynomial, datenum(ww));
plot(ww, yFit, 'r-');

polynomial2 = polyfit(datenum(w),monthlyavg_ssh,3);
yFit2 = polyval(polynomial2, datenum(ww));
plot(ww, yFit2, 'g-');

gradient = (max(yFit) - min(yFit))/(2018-2005);
disp(gradient)
