function xls_text2()
CSV = { 'Subject', 'Sentence Order', 'Noun', 'Adjective', 'Stimulus File Name', 'Button press?', 'Reaction Time' };
header = ('Subject,Sentence Order,Noun,Adjective,Stimulus File Name,Button press?,Reaction Time');

CSV(size(CSV,1)+1,3) = { 'R'} ;
CSV(size(CSV,1),6) =  {'yes for beginning of reverse' };
ix=cellfun('isempty',CSV);
CSV(ix)={' '};

fid = fopen('data.csv','wt');
fprintf(fid, '%s\r\n',header);
for j=2:size(CSV,1)
    for k=1:size(CSV,2)
       fprintf(fid, '%s', char(CSV(j,k)),',');
    end
    fprintf(fid, '\r\n');
end
fclose(fid);