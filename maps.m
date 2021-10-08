function [] = maps(~)

%obtain latitudes and longitudes
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

%set coordinate limits
latlim = [min(latitude) max(latitude)];
lonlim = [min(longitude) max(longitude)];

%plot map
geoplot(latlim,lonlim,'g-*');
geolimits(latlim,lonlim);
geobasemap colorterrain

title('The Mediterranean Sea');