function [] = mapevros(~)

%obtain latitudes and longitudes
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

%set coordinate limits
latlim = [latitude(140) latitude(180)];
lonlim = [longitude(462) longitude(530)];

%plot map
geoplot(latlim,lonlim,'g--*');
geolimits(latlim,lonlim);
geobasemap colorterrain
title('River Maritsa Estuary Region');