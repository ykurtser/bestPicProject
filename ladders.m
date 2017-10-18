function [ freq2 ] = ladders( i )
%% return c-major ladder in i octave
notes={'C' 'C#' 'D' 'Eb' 'E' 'F' 'F#' 'G' 'G#' 'A' 'Bb' 'B' }
freq=[ 16.3500   17.3250   18.3562   19.4438   20.6000   21.8250   23.1250   24.5000   25.9563   27.5000   29.1375   30.8687 ]
freq2=freq*(2^i)
Cmajor={'C' 'D' 'E' 'F' 'G' 'A' 'B'  }  % your song
a=[]
for k=1:numel(Cmajor)
   note_value=0:0.000125:0.5 % You can change the note duration
  a=[a sin(2*pi* freq2(strcmp(notes,Cmajor{k}))*note_value)];
end
sound(a)
end