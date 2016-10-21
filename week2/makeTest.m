function makeTest(outFileName)

outFile=fopen(outFileName,'w');

TheImage=imread('cameraman.tif');

TheStructel= ones(3);

TheCenter=[2,2];

for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Dilation');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('D',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,num2str(timeCustom));

fprintf(outFile,' seconds\n');

for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Erosion');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('E',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,num2str(timeCustom));

fprintf(outFile,' seconds\n');


for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Opening');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('O',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,num2str(timeCustom));

fprintf(outFile,' seconds\n');

for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Closing');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('C',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,int2str(timeCustom));

fprintf(outFile,' seconds\n');


for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Top Hat');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('T',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,int2str(timeCustom));

fprintf(outFile,' seconds\n');


for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');
fprintf(outFile,'Dual Top Hat');
fprintf(outFile,'\n');
for i=1:40
    fprintf(outFile,'-');
end
fprintf(outFile,'\n');

[timeMatlab, timeCustom] = TestOperation('U',TheImage,TheStructel,TheCenter);

fprintf(outFile,'Matlab:');

fprintf(outFile,num2str(timeMatlab));

fprintf(outFile,' seconds\n');

fprintf(outFile,'Custom:');

fprintf(outFile,int2str(timeCustom));

fprintf(outFile,' seconds\n');