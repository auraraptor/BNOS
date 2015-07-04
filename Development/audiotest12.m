function audiotest12()
disp('audiotest');

%type of sequence.
type = menu('Select sequnce order:','1: white noise - reverse - sentences', ...
    '2: reverse - sentences - white noise','3: sentences - white noise - reverse');

% load matrix for sentences
AT_sentences = { 'TT1','baby','cuddly'
'TT2','bed','silky'
'TT3','bomb','heavy'
'TT4','brake','stuck'
'TT5','bush','prickly'
'TT6','carrot','moist'
'TT7','cave','wet'
'TT8','chick','soft'
'TT9','child','warm'
'TT10','cloth','velvety'
'TT11','coffee','hot'
'TT12','elephant','leathery'
'TT13','floor','freezing'
'TT14','flute','oily'
'TT15','foot','numb'
'TT16','frog','bumpy'
'TT17','glass','cool'
'TT18','ground','soggy'
'TT19','gun','weighty'
'TT20','hammer','heavy'
'TT21','house','cold'
'TT22','ice','numbing'
'TT23','light','hot'
'TT24','room','cool'
'TT25','rooster','soft'
'TT26','shirt','itchy'
'TT27','snake','leathery'
'TT28','snow','powdery'
'TT29','soda','cold'
'TT30','tea','warm'
'TT31','throat','dry'
'TT32','train','chilly'
'TT33','tree','smooth'
'TT34','valley','humid'
'TT35','wave','wet'
'TT36','wind','stinging'
'TT37','zoo','humid'
'TF1','alarm','shaggy'
'TF2','banjo','limp'
'TF3','bat','misty'
'TF4','brake','shaggy'
'TF5','branch','spongy'
'TF6','coffee','cuddly'
'TF7','cricket','soggy'
'TF8','dove','elastic'
'TF9','gate','puffy'
'TF10','horn','foamy'
'TF11','light','flaky'
'TF12','pig','stringy'
'TF13','wheel','spongy'
'AT1','alarm','blaring'
'AT2','baby','crying'
'AT3','bear','growling'
'AT4','bee','buzzing'
'AT5','bird','singing'
'AT6','bush','rustling'
'AT7','car','humming'
'AT8','cat','hissing'
'AT9','cave','echoing'
'AT10','chain','rattling'
'AT11','chick','chirping'
'AT12','child','screaming'
'AT13','cricket','chirping'
'AT14','dog','barking'
'AT15','door','banging'
'AT16','dove','singing'
'AT17','duck','quacking'
'AT18','elephant','trumpeting'
'AT19','gate','banging'
'AT20','gun','loud'
'AT21','hall','quiet'
'AT22','hammer','pounding'
'AT23','house','noisy'
'AT24','man','whistling'
'AT25','plane','roaring'
'AT26','radio','loud'
'AT27','rain','pounding'
'AT28','room','silent'
'AT29','rooster','calling'
'AT30','snake','hissing'
'AT31','storm','rumbling'
'AT32','tiger','roaring'
'AT33','toilet','flushing'
'AT34','truck','rattling'
'AT35','valley','silent'
'AT36','violin','resonant'
'AT37','wind','howling'
'AF1','bear','flushing'
'AF2','creek','grunting'
'AF3','duck','drumming'
'AF4','fan','barking'
'AF5','foot','rambling'
'AF6','gun','sucking'
'AF7','ice','digging'
'AF8','phone','storming'
'AF9','piano','drilling'
'AF10','plane','weeping'
'AF11','room','sucking'
'AF12','tiger','blasting'
'AF13','zoo','drilling' };

% Randomize
ix = randperm(length(AT_sentences));
AT_shuffled = AT_sentences(ix,:);

% N wav files
% load matrix for nonsense sounds
N_sentences = { 'N1','N14','N19','N23','N28','N32','N37','N41','N46','N50',...
    'N10','N15','N2','N24','N29','N33','N38','N42','N47','N6',...
    'N11','N16','N20','N25','N3','N34','N39','N43','N48','N7',...
    'N12','N17','N21','N26','N30','N35','N4','N44','N49','N8',...
    'N13','N18','N22','N27','N31','N36','N40','N45','N5','N9'};
% Randomize
iy = randperm(length(N_sentences));
N_shuffled = N_sentences(iy);

% load white noise
sounddir = [ pwd filesep 'CMP_wav_files\' ];
WN_wavfilenames = dir( [ sounddir 'WhiteNoise.wav' ] );

CSV = { 'Subject' 'Sentence Order' 'Noun' 'Adjective' 'Stimulus File Name' 'Button press?' 'Reaction Time' };

% subject dialog pop up: 
prompt = {'Please enter the subject number: '};
dlg_title = 'Input for subject id';
num_lines = 1;
subject_num = inputdlg(prompt,dlg_title,num_lines); 

% Press space bar to begin
try % This is for fullscreen display
    screens=Screen('Screens');
    screenNumber=max(screens);
    w=Screen('OpenWindow', screenNumber);
    Screen('FillRect', w);
    Screen('TextFont',w, 'Courier New');
    Screen('TextSize',w, 50);
    Screen('TextStyle', w, 1+2);
    Screen('DrawText', w, 'Press space bar to begin.', 200, 300, [255, 0, 0, 255]);
    Screen('Flip',w);
    KbWait;

% Main player loop
switch type
    case 1
        disp('type 1') % white noise - reverse - sentences
        CSV(size(CSV,1),2) = { 'WRS' };
        % Block loop, range 0 to 150 at increments of 10.
        for block_num=0:10:150
            
            % white noise
            full_filename = fullfile(sounddir,WN_wavfilenames.name);
            s = wavread(full_filename); % 
            sound(s,22050);
            Screen('DrawText', w, 'white noise', 300, 300, [255, 0, 0, 255]);
            Screen('Flip',w);
            [secs, press] = KbTime(); % does this need to wait for 30 secs? YES!
            CSV(size(CSV,1)+1,3) = { 'W' };
            CSV(size(CSV,1),6) = { press };
            pause(30); % wait for white noise to play before displaying next wav filename.
            
            % reverse
            for i=1+block_num:10+block_num
                full_filename = fullfile(sounddir,[ N_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);
                Screen('DrawText', w, N_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (i == 1+block_num)
                    CSV(size(CSV,1)+1,3) = { 'R' };
                    CSV(size(CSV,1),6) = { 'yes for beginning of reverse' };
                    if (isa(secs, 'numeric'))
                        CSV(size(CSV,1),7) = num2cell(secs);
                    else
                        CSV(size(CSV,1),7) = { secs };
                    end
                end
            end
            
            % sentences
            for i=1+block_num:10+block_num
                CSV(size(CSV,1)+1,3) = AT_shuffled(i,2);
                CSV(size(CSV,1),4) = AT_shuffled(i,3);
                CSV(size(CSV,1),5) = AT_shuffled(i);
                full_filename = fullfile(sounddir,[ AT_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);
                Screen('DrawText', w, AT_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (isa(secs, 'numeric'))
                    CSV(size(CSV,1),7) = num2cell(secs);
                else
                    CSV(size(CSV,1),7) = { secs };
                end
                CSV(size(CSV,1),6) = { press };
            end
        end
    case 2 % reverse - sentences - white noise
        disp('type 2')
        CSV(size(CSV,1),2) = { 'RSW' };
        for block_num=0:10:150
            
            % reverse
            for i=1+block_num:10+block_num
                full_filename = fullfile(sounddir,[ N_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);                
                Screen('DrawText', w, N_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (i == 1+block_num)
                    CSV(size(CSV,1)+1,3) = { 'R' };
                    CSV(size(CSV,1),6) = { 'yes for beginning of reverse' };
                    if (isa(secs, 'numeric'))
                        CSV(size(CSV,1),7) = num2cell(secs);
                    else
                        CSV(size(CSV,1),7) = { secs };
                    end
                end
            end
            
            % sentences
            for i=1+block_num:10+block_num
                CSV(size(CSV,1)+1,3) = AT_shuffled(i,2);
                CSV(size(CSV,1),4) = AT_shuffled(i,3);
                CSV(size(CSV,1),5) = AT_shuffled(i);
                full_filename = fullfile(sounddir,[ AT_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);
                Screen('DrawText', w, AT_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (isa(secs, 'numeric'))
                    CSV(size(CSV,1),7) = num2cell(secs);
                else
                    CSV(size(CSV,1),7) = { secs };
                end
                CSV(size(CSV,1),6) = { press };
            end
            
            % white noise
            full_filename = fullfile(sounddir,WN_wavfilenames.name);
            s = wavread(full_filename); % 
            sound(s,22050);
            Screen('DrawText', w, 'white noise', 300, 300, [255, 0, 0, 255]);
            Screen('Flip',w);
            [secs, press] = KbTime(); % does this need to wait for 30 secs?
            CSV(size(CSV,1)+1,3) = { 'W' };
            CSV(size(CSV,1),6) = { press };
            pause(30); % wait for white noise to play before displaying next wav filename.
        end        
        
    case 3 % sentences - white noise - reverse
        disp('type 3')
        CSV(size(CSV,1),2) = { 'SWR' };
        for block_num=0:10:150
            
            % sentences
            for i=1+block_num:10+block_num
                CSV(size(CSV,1)+1,3) = AT_shuffled(i,2);
                CSV(size(CSV,1),4) = AT_shuffled(i,3);
                CSV(size(CSV,1),5) = AT_shuffled(i);
                full_filename = fullfile(sounddir,[ AT_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);
                Screen('DrawText', w, AT_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (isa(secs, 'numeric'))
                    CSV(size(CSV,1),7) = num2cell(secs);
                else
                    CSV(size(CSV,1),7) = { secs };
                end
                CSV(size(CSV,1),6) = { press };
            end
            
            % white noise
            full_filename = fullfile(sounddir,WN_wavfilenames.name);
            s = wavread(full_filename); % 
            sound(s,22050);
            Screen('DrawText', w, 'white noise', 300, 300, [255, 0, 0, 255]);
            Screen('Flip',w);
            [secs, press] = KbTime(); % does this need to wait for 30 secs?
            CSV(size(CSV,1)+1,3) = { 'W' };
            CSV(size(CSV,1),6) = { press };
            pause(30); % wait for white noise to play before displaying next wav filename.            
            
            % reverse
            for i=1+block_num:10+block_num
                full_filename = fullfile(sounddir,[ N_shuffled{i} '.wav']);
                s = wavread(full_filename);
                % comment out for testing speed: 
                sound(s,22050);                
                Screen('DrawText', w, N_shuffled{i}, 350, 300, [255, 0, 0, 255]);
                Screen('Flip',w);
                [secs, press] = KbTime();
                if (i == 1+block_num)
                    CSV(size(CSV,1)+1,3) = { 'R' };
                    CSV(size(CSV,1),6) = { 'yes for beginning of reverse' };
                    if (isa(secs, 'numeric'))
                        CSV(size(CSV,1),7) = num2cell(secs);
                    else
                        CSV(size(CSV,1),7) = { secs };
                    end
                end
            end            
        end        
end

Screen('CloseAll');
catch scr_err
    % This "catch" closes the onscreen window if it's open.
    Screen('CloseAll'); 
   % psychrethrow(psychlasterror);
end

CSV(2,1) = ( subject_num ); % enter subject number into matrix.
% Write data to Excel
if (size(char(subject_num),2)>0)
    sub_file = char(subject_num);
else
    sub_file = num2str(now);
end
xlswrite(strcat('data_',sub_file,'.xls'),CSV)
disp('done');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [secs, press] = KbTime()
% set keys
KbName('UnifyKeyNames');
escapeKey = KbName('t'); % use t character to sync with mri
secs =''; % initialize
press = 'no';
startSecs = GetSecs;
while (GetSecs - startSecs < 3.100) % the 3.100 sets total time allotted per sentence
    [ keyIsDown, timeSecs, keyCode ] = KbCheck;
    if (keyIsDown && strcmp(press, 'no'))
        secs = (timeSecs - startSecs);
        press = 'yes';
        if keyCode(escapeKey)
            break;
        end
    end
end

% function   press_space()
% % set keys
% KbName('UnifyKeyNames');
% escapeKey = KbName('space');
% disp('Press the space bar when ready to begin scan');
% while 1
%     [ keyIsDown, timeSecs, keyCode ] = KbCheck;
%     if (keyIsDown)
%         if keyCode(escapeKey)
%             break;
%         end
%     end
% end


