function [] = mapnile(~)

%obtain latitudes and longitudes
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

%set coordinate limits
latlim = [latitude(10) latitude(32)];
lonlim = [longitude(580) longitude(630)];

%plot map
geoplot(latlim,lonlim,'g-*');
geolimits(latlim,lonlim);
geobasemap colorterrain

title('River Nile Estuary Region');
