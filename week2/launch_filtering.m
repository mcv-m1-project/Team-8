addpath(genpath('.'))
rocaccumulation = TrafficSignFiltering('./dataset/validation/test', './dataset/validation');
figure;
plot (rocaccumulation(:,1), rocaccumulation(:,2));
%axis([0,1,0,1])
xlabel('Recall');
ylabel('Precision');
F1 = zeros(size(rocaccumulation));

for i=1:size(rocaccumulation(:,1))
    F1(i) = 2*((rocaccumulation(i,1) * rocaccumulation(i,2))/(rocaccumulation(i,1) + rocaccumulation(i,2)));
end
figure;
plot(F1);
xlabel('Structural Element Size');
ylabel('F1 Score');