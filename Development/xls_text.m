function xls_text()
CSV = { 'Subject', 'Sentence Order', 'Noun', 'Adjective', 'Stimulus File Name', 'Button press?', 'Reaction Time' };

CSV(size(CSV,1)+1,3) = { 'R'} ;
CSV(size(CSV,1),6) =  {'yes for beginning of reverse' };
ix=cellfun('isempty',CSV);
CSV(ix)={' '};
%xlswrite(strcat('data_','.xls'),char(CSV)) %does not work for cell arrays on Macs!'

data_str = CSV(1,1);
%data_str = 'test';
for j=2:size(CSV,1)
    for k=1:size(CSV,2)
       data_str = strcat(data_str,',',CSV(j,k))
%         data_str = strcat(data_str,',')
    end
    data_str = strcat(data_str,'\x0A');
end

fid = fopen('data.csv','wt');
fprintf(fid, '%s', char(data_str))
fclose(fid);