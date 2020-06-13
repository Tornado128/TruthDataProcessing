function [scilabdate] = ParseWFADate(instring)

// This function parses the date/time from a timestamp string in a WFA CSV file (column header 'ToD'), and puts it in Scilab's getdate() format
//
// Author: Dirk De Bruyker
// Rev: v0.1, June 9, 2014
// (c) NeoTek Energy
//instring='9/7/2015 09:15:04 PM'
slashes=strindex(instring,'/');
spaces=strindex(instring,' ');
colons=strindex(instring,':');


if slashes(1)==3 then mo=strtod(part(instring,1:2));
else mo=strtod(part(instring,1:1));
end;
 
if slashes(2)-slashes(1)==3 then da=strtod(part(instring,(slashes(1)+1):(slashes(1)+2)));
else da=strtod(part(instring,(slashes(1)+1):(slashes(1)+2)));
end;

ye=strtod('20' + part(instring,slashes(2)+3:slashes(2)+4));
hr=strtod(part(instring,spaces(1):colons(1)));

p=size(colons);
if (p(2) == 1) then
    f=1;
else
    f=2;
end
mi=strtod(part(instring,colons(1)+1:colons(1)+2));
AMPM=(part(instring,colons(f)+4:colons(f)+5));

//se=strtod(part(instring,colons(2)+1:colons(2)+2));

if ((AMPM=='PM') & (hr ~=12)) then
    hr=hr+12;
end
if (f==2) then
    se=strtod(part(instring,colons(f)+1:colons(f)+2));
else
    se=0;
end

//se=0;

scilabdate=[ye mo da hr mi se]
  
//endfunction

endfunction
