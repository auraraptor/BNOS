function timercheck()
 t=10
startSecs = GetSecs
num2str(startSecs)
while (GetSecs - startSecs < t) % the t sets total time allotted per wav file        
    [ keyIsDown, timeSecs, keyCode ] = KbCheck;
    pause(1);
        %num2str(GetSecs)
        secs = num2str(timeSecs - startSecs);
        secs
end

end