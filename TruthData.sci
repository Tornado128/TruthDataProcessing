function [MatrixTruth] = TruthData(M)


SIZE=size(M);

i=1;
while (isnum(M(i,2)) == %F & isnum(M(i,11)) == %F)
    i=i+1;
end


l=0;
for j=i:1:SIZE(1)
    for k=[3 4 6 7 11 12 13]
        if (isalphanum(M(j,k)) == %F) then
            l=l+1
            P(l)=j;
            break;
        end
    end
end
//M = M(i:1:SIZE(1),1:1:SIZE(2));
S=cat(2, 1:1:i-1, P')

M(S,:)=[]

MatrixTruth = M;

endfunction




