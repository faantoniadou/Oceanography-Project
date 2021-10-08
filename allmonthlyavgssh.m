function [] = allmonthlyavgssh(~)
%latitude = ncread('ssh1.nc','lat');
%longitude = ncread('ssh1.nc','lon');
ssh = ncread('ssh1.nc','sossheig');

monthlyavg_ssh = [];
date_actual = [];
%plot sea surface height for every calendar month 
for i = 1:size(ssh,1)
    for j = 1:size(ssh,2)
        for l = 1:size(ssh,3)
            sosh = ssh(:,:,l);
            monthlyavg_ssh = [monthlyavg_ssh mean(sosh,'all','omitnan')];
                
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
disp(monthlyavg_ssh);
scatter(date_actual,monthlyavg_ssh,'x')
hold on
line(date_actual,monthlyavg_ssh)
ylabel('Sea Surface Height / m');
xlabel('Date');
title('Monthly average sea surface height');



