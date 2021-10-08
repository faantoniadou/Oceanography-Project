function [] = rivermaps(~)
hold on
subplot(2,2,1);mapnile;
geobasemap colorterrain
subplot(2,2,2);mapevros;
geobasemap colorterrain
subplot(2,2,3);mappo;
geobasemap colorterrain
subplot(2,2,4);maprhone;
geobasemap colorterrain

