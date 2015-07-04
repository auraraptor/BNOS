function boxcheck()
pause (1);
t = 500;
startSecs = GetSecs;
num2str(startSecs)
iteration = 0;
lastsecs = GetSecs;
while (GetSecs - startSecs < t)   
    [ keyIsDown, timeSecs, keyCode ] = KbCheck(-1);
    if keyIsDown
        secs = num2str(lastsecs - timeSecs );
        secs
        iteration=iteration+1
        lastsecs = timeSecs;
        pause (.1)
    end
   % pause (1);

end

secs = num2str(lastsecs - startSecs );
secs

end