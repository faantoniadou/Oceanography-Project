function [] = mappo(~)

%obtain latitudes and longitudes
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

%set coordinate limits
latlim = [latitude(210) latitude(253)];
lonlim = [longitude(290) longitude(318)];
disp(latlim)
disp(lonlim)
%plot map
geoplot(latlim,lonlim,'g-*');
geolimits(latlim,lonlim);
title('River Po Estuary Region');

geobasemap colorterrain