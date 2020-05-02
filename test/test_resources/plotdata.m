
% Load all the data from files
initialData = load("test_data.txt");
processedData = load("dropped_data.txt");
rotatedData = load("rotated_data.txt");
filteredData = load("filtered_data.txt");
downsampledData = load("downsampled_data.txt");
detrendedData = load("detrended_data.txt");

% Plot initial data
figure("name","Original Accelerometer Data","numbertitle","off");
hold on;
plot(initialData(:,1,1));
plot(initialData(:,2,1));
plot(initialData(:,3,1));
hold off;

% Plot all the steps
figure("name","","numbertitle","off");
subplot(2,2,1);
hold on;
plot(rotatedData(:,1,1));
plot(rotatedData(:,2,1));
hold off;
title("Axis Rotation");
subplot(2,2,2);
hold on;
plot(filteredData(:,1,1));
plot(filteredData(:,2,1));
hold off;
title("Filter");
subplot(2,2,3);
hold on;
plot(downsampledData(:,1,1));
plot(downsampledData(:,2,1));
hold off;
title("Downsample");
subplot(2,2,4);
hold on;
plot(detrendedData(:,1,1));
plot(detrendedData(:,2,1));
hold off;
title("Detrend");

% Plot computed data
figure("name","Processed COGv data","numbertitle","off");
subplot(2,1,1);
plot(processedData(:,1,1), processedData(:,2,1));
title("Ball of COGv data");
subplot(2,1,2);
hold on;
plot(processedData(:,1,1));
plot(processedData(:,2,1));
hold off;
title("COGvAP & COGvML");
