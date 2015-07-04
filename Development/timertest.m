function timertest()

pause(.1); % Stop registering stray key strokes
% load white noise
sounddir = [ pwd filesep 'CMP_wav_files' filesep ];
WN_wavfilenames = dir( [ sounddir 'WhiteNoise.wav' ] );
CSV = { 'Subject' 'Sentence Order' 'Noun' 'Adjective' 'Stimulus File Name' 'Button press?' 'Reaction Time' };

white_noise();

function  [secs, press] = KbTime(t)
% set keys
KbName('UnifyKeyNames');
escapeKey = KbName('t'); % use t character to sync with mri
secs =''; % initialize
press = 'no';
flag=0;
startSecs = GetSecs;
while (GetSecs - startSecs < t) % the t sets total time allotted per wav file        
    [ keyIsDown, timeSecs, keyCode ] = KbCheck;
    num2str(timeSecs - startSecs);
    if (keyIsDown && strcmp(press, 'no'))
        find(keyCode)
        secs = num2str(timeSecs - startSecs)
        press = 'yes';
        if keyCode(escapeKey)
            break;
        end
    end
end
end

function white_noise()
full_filename = fullfile(sounddir,WN_wavfilenames.name);
s = wavread(full_filename); 

player = audioplayer(s,22050);
play(player);

[secs, press] = KbTime(5); % does this need to wait for 30 secs? YES!
CSV(size(CSV,1)+1,3) = { 'W' };
CSV(size(CSV,1),6) = { press };
press
secs
%pause(30); % wait for white noise to play before displaying next wav filename.
end

end
