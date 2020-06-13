clc
clear
cd C:\Users\ybozorgi.NEOTEKENERGYDAL\Desktop\Yaser\codes\TruthData
M = read_csv("WeeklyReport 12-20-16.csv");

exec('C:\Users\ybozorgi.NEOTEKENERGYDAL\Desktop\Yaser\codes\TruthData\TruthDataAnalysis\TruthData.sci', -1)
M = TruthData(M); //parsing and organizing the data
s=size(M);
StartDAYY=M(1,3); StartTIMEE=M(1,4)
StopDAYY=M(s(1),6); StopTIMEE=M(s(1),7)
//start=strcat([StartDAYY ' ' StartTIMEE]);
start=strcat([StartDAYY+' '+StartTIMEE]); 
//stop=strcat([StopDAYY ' ' StopTIMEE]);
stop=strcat([StopDAYY+' '+StopTIMEE]);


exec('C:\Users\ybozorgi.NEOTEKENERGYDAL\Desktop\Yaser\codes\TruthData\TruthDataAnalysis\ParseWFADate.sci', -1)
on= ParseWFADate(start);
initialTime=on;
off = ParseWFADate(stop);
elapsedDAY=abs(etime(on,off))/60/60/24;  //based on truth data

for i=1:1:s(1)
    StartDAY(i)=M(i,3); StartTIME(i)=M(i,4)
    StopDAY(i)=M(i,6); StopTIME(i)=M(i,7)
    //start=strcat([StartDAY(i) ' ' StartTIME(i)]);
    start=strcat([StartDAY+' '+StartTIME]);
    //stop=strcat([StopDAY(i) ' ' StopTIME(i)]);
    stop=strcat([StopDAY+' '+StopTIME]);

    on= ParseWFADate(start);
    off = ParseWFADate(stop);
    dur(i)=etime(off,initialTime)/60/60/24;    //startime is based on traces (it is one number) //on is beased on truth data

    x(i)=dur(i)
    oil(i)=strtod(M(i,11)); water(i)=strtod(M(i,12)); gas(i)=strtod(M(i,13))
end

PP=tabul(M(:,2));
Wells=PP(1);                    //tabulate all the wells
FrequencyOfWells=PP(2);         //how many times each well is repeated
L=size(PP(2));                  //number of wells

for i=1:1:L(1)
    J=grep(M(:,2),Wells(i));
    S(i,1:1:FrequencyOfWells(i))=J;
end

j=0
for i=1:1:L(1)
    for k=1:1:max(PP(2))
        if (S(i,k) ~=0) then
            j=j+1;
            N(1,j) = S(i,k);  //organizing the ID of wells in order
        end
    end
end
x=0
for i=1:1:L(1)
    x=FrequencyOfWells(i)+x
    X(i)=x;
end
    disp ("Number of Wells is: ")
    disp( L(1))
    plot(1:1:j,(oil(N)./(oil(N)+water(N)))','-o')
    title('Oil Fraction in Liquid');
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(oil(N)./(oil(N)+water(N)))]','k-.')
    scf()
    
    plot(1:1:j,(oil(N)./(1000*.178*gas(N)+oil(N)+water(N)))','-o')
    title('Oil Fraction in Total')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(oil(N)./(1000*.178*gas(N)+oil(N)+water(N)))]','k-.')
    scf()
    
    plot(1:1:j,(oil(N)+water(N))','-o')
    title('Total Liquid Production')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(oil(N)+water(N))]','k-.')
    scf()
    
    plot(1:1:j,oil(N)','-o')
    title('Oil Production')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(oil(N))]','k-.')
    scf()
    
    plot(1:1:j,water(N)','-o')
    title('Water Production')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(water(N))]','k-.')
    //plot([10 10]', [-100 100000]','k-.')
    scf()
    
    plot(1:1:j,gas(N)','-o')
    title('gas Production')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 max(gas(N))]','k-.')
    scf()
    
    plot(1:1:j,(gas(N)./oil(N))','-o')
    title('gas/oil Production')
    a=get("current_axes")//get the handle of the newly created axes
    a.axes_visible="on"; // makes the axes visible
    a.font_size=4; //set the tics label font size
    plot([X X]', [0 200]','k-.')
