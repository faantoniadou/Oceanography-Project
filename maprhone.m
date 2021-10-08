function [] = maprhone(~)

%obtain latitudes and longitudes
latitude = ncread('allsal.nc','lat');
longitude = ncread('allsal.nc','lon');

%salin = sal([110:230],[200:230],:,:);
%set coordinate limits
latlim = [latitude(200) latitude(230)];
lonlim = [longitude(110) longitude(230)];
disp(latlim)
disp(lonlim)
%plot map
geoplot(latlim,lonlim,'g-*');
geolimits(latlim,lonlim);
title('River Rhone Estuary Region');
