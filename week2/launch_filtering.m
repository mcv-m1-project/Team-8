addpath(genpath('.'))
rocaccumulation_dil = TrafficSignFiltering('./dataset/validation/test', './dataset/validation');
figure;
plot (rocaccumulation(:,1), rocaccumulation(:,2),'r');
hold;
plot (rocaccumulation_dil(:,1), rocaccumulation_dil(:,2),'g');

%axis([0,1,0,1])
xlabel('Recall');
ylabel('Precision');
F1_dil = zeros(size(rocaccumulation_dil));

for i=1:size(rocaccumulation_dil(:,1))
    F1_dil(i) = 2*((rocaccumulation_dil(i,1) * rocaccumulation_dil(i,2))/(rocaccumulation_dil(i,1) + rocaccumulation_dil(i,2)));
end
figure;
plot(F1,'r');
hold;
plot(F1_dil,'g');
xlabel('Opening Structural Element Size');
ylabel('F1 Score');