function [] = rhoneplotssh(~)
latitude = ncread('allssh.nc','lat');
longitude = ncread('allssh.nc','lon');

ssh = ncread('allssh.nc','sossheig');
ssho = ssh([110:230],[160:230],:);

%Find maximum and minimum ssh in river delta
maxssh = ceil(max(ssho, [], 'all'));
minssh = floor(min(ssho, [], 'all'));

monthlyavg_ssh = [];
date_actual = [];

%plot ssh for every calendar month 
for i = 1:size(ssh,1)
    for j = 1:size(ssh,2)
        for l = 1:size(ssh,3)
            ssho = ssh([110:230],[160:230],l);
            monthlyavg_ssh = [monthlyavg_ssh mean(ssho,'all','omitnan')];
                
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
%find yearly mean ssh

yearlyavg_ssh = [];
for m = [1 12:12:size(ssh,3)-12]
    if m == 1 
        yearlyavg_ssh = [yearlyavg_ssh mean(monthlyavg_ssh(m:(m+11)))];
    elseif m > 1
        yearlyavg_ssh = [yearlyavg_ssh mean(monthlyavg_ssh(m:(m+12)))];
    end
    
    start_year = datetime('1987','InputFormat','yyyy');
    end_year = datetime('2018','InputFormat','yyyy');
    year = [start_year : calyears(1) : (end_year)];
end

scatter(year,yearlyavg_ssh,'x')
hold on
line(year,yearlyavg_ssh)
ylabel('Mean Sea Surface Height/m');
xlabel('Date');
xticks([start_year : calyears(1) : (end_year)]);
xtickangle(45);
title('Yearly Mean Sea Surface Height of the Rhone river delta');

%Plot best fit straight line
w = 1987:2018;
coefficients = polyfit(w,yearlyavg_ssh, 1);
yFit = polyval(coefficients, w);
plot(year, yFit, 'r-');

p = polyfit(w,yearlyavg_ssh,1);
b = p(2);
y = b.* m.*w;

%find the rate of sea surface height change
gradient = (max(yFit) - min(yFit))/(max(w)-min(w));
disp(gradient)

plot(w,y);