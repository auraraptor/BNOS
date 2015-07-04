function lightTest()
% Created by Richard Zorger, 
% Penn Vision Research Center
% zorger@mail.med.upenn.edu 
% 9//9/10

% Makes 6 cycles of a 5 Hz flashing light stimuli for 30 seconds followed
% by 30 seconds of black display. 
% Pessing the escape key during the flashing will exit (not during the
% black screen though)
try % This is for fullscreen display
    screens=Screen('Screens');
    screenNumber=max(screens);
    w=Screen('OpenWindow', screenNumber);
    Screen('FillRect', w);
    Screen('TextFont',w, 'Courier New');
    Screen('TextSize',w, 50);
    Screen('TextStyle', w, 1+2);
    Screen('DrawText', w, 'Waiting for "t"', 200, 300, [255, 0, 0, 255]);
    Screen('Flip',w);
    x=1;
    while x==1
    [ keyIsDown, timeSecs, keyCode ] = KbCheck(-1);
        if (keyIsDown)
            if strcmpi(KbName(keyCode),'t')
                x=0;
                break;
            end
        end       
    end
end    
for i=1:6
    [ keyIsDown, timeSecs, keyCode ] = KbCheck(-1); % KbCheck(-1) scans all ketboard inputs
    if strcmp(KbName(keyCode),'ESCAPE') %if keyCode('ESCAPE')
        break;
    end
    disp(i);
    press = flash(w); 
    if strcmp(press, 'ESCAPE')
        break;
    end    
    blackScreen(w);
end
Screen('CloseAll');
end
%%%%%%%%%%%%%%%%%%%%
function press = flash(w)
press = 'go';
startSecs = GetSecs;
for i=1:3000
    secs = (GetSecs - startSecs);
    if secs > 30 %30
        return;
    end
    [ keyIsDown, timeSecs, keyCode ] = KbCheck(-1); % KbCheck(-1) scans all ketboard inputs
    if strcmp(KbName(keyCode),'ESCAPE') %if keyCode('ESCAPE')
        press = 'ESCAPE';
        break;
    end
    if mod(i,2)==0
        Screen('FillRect', w, [0,0,0]);
    else
        Screen('FillRect', w, [255,255,255]);
    end
    Screen('Flip',w);
    pause(.1);

end
end

function blackScreen(w)
    Screen('FillRect', w, [0,0,0]);
    Screen('Flip',w);
    pause(30); %30 seconds!
    
end