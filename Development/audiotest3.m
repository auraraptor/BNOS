function audiotest3()
disp('audiotest');

%type of sequence.
type = menu('Select sequnce order:','1: white noise - reverse - sentences', ...
    '2: reverse - sentences - white noise','3: sentences - white noise - reverse');

sounddir = [ pwd filesep 'CMP_wav_files\' ];
% A wav files
A_infilenames = dir( [ sounddir 'A*.wav' ] );
for i=1:length(A_infilenames)
    A_wavfilenames{i} = [ sounddir A_infilenames(i).name ];
end

% T wav files
T_infilenames = dir( [ sounddir 'T*.wav' ] );
for i=1:length(T_infilenames)
    T_wavfilenames{i} = [ sounddir T_infilenames(i).name ];
end

% Combine As and Ts
AT_wavfilenames = {A_wavfilenames{:}, T_wavfilenames{:}};
%A_infilenames.name
%AT_infilenames.name = {A_infilenames.name, T_infilenames.name}
for i=1:length(A_wavfilenames)
    AT_infilenames{i} = [A_infilenames(i).name];
end
for i=1:length(T_wavfilenames)
    AT_infilenames{i+length(A_wavfilenames)} = [T_infilenames(i).name];
end
% Randomize 
ix = randperm(length(AT_wavfilenames));
AT_shuffled = AT_wavfilenames(ix);
% for i=1:length(AT_wavfilenames)
%     AT_shuffled(i);
% end

% N wav files
N_infilenames = dir( [ sounddir 'N*.wav' ] );
for i=1:length(N_infilenames)
    N_wavfilenames{i} = [ sounddir N_infilenames(i).name ];
end
% Randomize 
iy = randperm(length(N_infilenames));
N_shuffled = N_infilenames(iy);
% for i=1:length(A_infilenames)
%     N_shuffled(i).name;
% end

% load white noise 
WN_wavfilenames = dir( [ sounddir 'WhiteNoise.wav' ] );

%CSV = cell(1,7);
CSV = { 'Weight'	'Nested'	'Procedure'	'Filename'	'Noun'	'Adjective' };


% Main player loop
switch type
    case 1
        disp('type 1') % white noise - reverse - sentences
        % Block loop is to be added here.
        block_num = 0; % range 0 to 20 at increments of 10
        % white noise
        full_filename = fullfile(sounddir,WN_wavfilenames.name);
        s = wavread(full_filename); % sound(s,22050);
        % reverse
        for i=1+block_num:10+block_num
            CSV(size(CSV,1)+1,4) = { N_shuffled(i).name };
            % play N_shuffled(i).name
        end
        % sentences
        for i=1+block_num:10+block_num
            %[pathstr, name, ext, versn] = fileparts(AT_shuffled(i));
            CSV(size(CSV,1)+1,4) = {AT_infilenames{i}}
            % play AT_shuffled(i).name
        end
        
    case 2 % reverse - sentences - white noise
        disp('type 2')
    case 3 % sentences - white noise - reverse
        disp('type 3')
end
CSV
xlswrite('data.xls',CSV);

y = wavread('AF1.wav');
%y2 = wavread('AF2.wav');
sound(y,22050);
%sound(y2,22050);
disp('done');


