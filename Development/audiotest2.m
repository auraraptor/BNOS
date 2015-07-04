function audiotest2()
disp('audiotest');

%type of sequence.
type = menu('Select sequnce order:','1: white noise - reverse - sentences', ...
    '2: reverse - sentences - white noise','3: sentences - white noise - reverse');

sounddir = [ pwd filesep 'CMP_wav_files\' ];
% A wav files
A_infilenames = dir( [ sounddir 'A*.wav' ] );
for i=1:length(A_infilenames)
    A_wavfilenames{i} = [ sounddir A_infilenames(i).name ];
    A_wavfilenames{i};
end

% Randomize 
ix = randperm(length(A_infilenames));
A_shuffled = A_infilenames(ix);
for i=1:length(A_infilenames)
    A_shuffled(i).name;
end

% T wav files
T_infilenames = dir( [ sounddir 'T*.wav' ] );
for i=1:length(T_infilenames)
    T_wavfilenames{i} = [ sounddir T_infilenames(i).name ];
    T_wavfilenames{i};
end
% Randomize 
iz = randperm(length(T_infilenames));
T_shuffled = T_infilenames(iz);
for i=1:length(T_infilenames)
    T_shuffled(i).name;
end

% Combine As and Ts
AT_wavfilenames = {A_wavfilenames{:}, T_wavfilenames{:}};
% Randomize 
ix = randperm(length(AT_wavfilenames));
AT_shuffled = AT_wavfilenames(ix);
for i=1:length(AT_wavfilenames)
    AT_shuffled(i)
end


% N wav files
N_infilenames = dir( [ sounddir 'N*.wav' ] );
for i=1:length(N_infilenames)
    N_wavfilenames{i} = [ sounddir N_infilenames(i).name ];
    N_wavfilenames{i};
end
% Randomize 
iy = randperm(length(N_infilenames));
N_shuffled = N_infilenames(iy);
for i=1:length(A_infilenames)
    N_shuffled(i).name;
end

% load white noise 
WN_wavfilenames = dir( [ sounddir 'WhiteNoise.wav' ] );

switch type
    case 1
        disp('type 1') % white noise - reverse - sentences
        % white noise
        full_filename = fullfile(sounddir,WN_wavfilenames.name);
        s = wavread(full_filename); % sound(s,22050);
        % reverse
        for i=1:length(N_infilenames)
            N_wavfilenames{i} = [ sounddir N_infilenames(i).name ];
            N_wavfilenames{i};
        end
        % sentences
        
    case 2 % reverse - sentences - white noise
        disp('type 2')
    case 3 % sentences - white noise - reverse
        disp('type 3')
end



y = wavread('AF1.wav');
%y2 = wavread('AF2.wav');
sound(y,22050);
%sound(y2,22050);
disp('done');


