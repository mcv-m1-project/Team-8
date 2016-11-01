%PrintSummary: Prints the feature data contained in TheSummary to the file
%in ThePath.
%
%Input:
%   -TheSummary: Struct -> Summary given at the ouput of
%   SummarizeSignalFeatures, containing the feature information on the
%   specified dataset
%   -ThePath: String -> File to write, including its path
%   -Classes: Array of Strings -> label of the class of each signal in
%   TheSummary

function PrintSummary(TheSummary, ThePath, Classes)

OutputFile = fopen(ThePath,'w');

for TheClass=1:length(Classes)    
    for i=1:30        
        fprintf(OutputFile,'-');
    end
    fprintf(OutputFile,'\n');
    fprintf(OutputFile,Classes(TheClass));
    fprintf(OutputFile,'\n');
    for i=1:30        
        fprintf(OutputFile,'-');
    end
    for i=1:3
        fprintf(OutputFile,'\n');
    end 
    fprintf(OutputFile,strcat(strcat('Height Values of ',Classes(TheClass)),': '));
    fprintf(OutputFile,strcat(strcat('Min: ',num2str(TheSummary.height(TheClass,1))),'; '));
    fprintf(OutputFile,strcat(strcat('Max: ',num2str(TheSummary.height(TheClass,2))),'; '));
    fprintf(OutputFile,strcat(strcat('Mean: ',num2str(TheSummary.height(TheClass,3))),'; '));
    fprintf(OutputFile,strcat(strcat('Stdv: ',num2str(TheSummary.height(TheClass,4))),'; '));
    fprintf(OutputFile,'\n');
    fprintf(OutputFile,strcat(strcat('Width Values of ',Classes(TheClass)),': '));
    fprintf(OutputFile,strcat(strcat('Min: ',num2str(TheSummary.width(TheClass,1))),'; '));
    fprintf(OutputFile,strcat(strcat('Max: ',num2str(TheSummary.width(TheClass,2))),'; '));
    fprintf(OutputFile,strcat(strcat('Mean: ',num2str(TheSummary.width(TheClass,3))),'; '));
    fprintf(OutputFile,strcat(strcat('Stdv: ',num2str(TheSummary.width(TheClass,4))),'; '));
    fprintf(OutputFile,'\n');
    fprintf(OutputFile,strcat(strcat('Form factor Values of ',Classes(TheClass)),': '));
    fprintf(OutputFile,strcat(strcat('Min: ',num2str(TheSummary.form_factor(TheClass,1))),'; '));
    fprintf(OutputFile,strcat(strcat('Max: ',num2str(TheSummary.form_factor(TheClass,2))),'; '));
    fprintf(OutputFile,strcat(strcat('Mean: ',num2str(TheSummary.form_factor(TheClass,3))),'; '));
    fprintf(OutputFile,strcat(strcat('Stdv: ',num2str(TheSummary.form_factor(TheClass,4))),'; '));
    fprintf(OutputFile,'\n');
    fprintf(OutputFile,strcat(strcat('Filling ratio Values of ',Classes(TheClass)),': '));
    fprintf(OutputFile,strcat(strcat('Min: ',num2str(TheSummary.filling_ratio(TheClass,1))),'; '));
    fprintf(OutputFile,strcat(strcat('Max: ',num2str(TheSummary.filling_ratio(TheClass,2))),'; '));
    fprintf(OutputFile,strcat(strcat('Mean: ',num2str(TheSummary.filling_ratio(TheClass,3))),'; '));
    fprintf(OutputFile,strcat(strcat('Stdv: ',num2str(TheSummary.filling_ratio(TheClass,4))),'; '));
    fprintf(OutputFile,'\n');
    fprintf(OutputFile,strcat(strcat('Frequency of ',Classes(TheClass)),': '));
    fprintf(OutputFile,strcat(num2str(TheSummary.frequency(TheClass,1)),'; '));
    for i=1:3
        fprintf(OutputFile,'\n');
    end  
end

fclose(OutputFile);