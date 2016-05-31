function cb = threshold(gb,th,bit1,bit2);
[m, n]=size(gb);                
for i=1:m,
    for j=1:n,
       x=gb(i,j);
       if(x>th)
            cb(i,j)=bit1;
       else
            cb(i,j)=bit2;
       end
    end
end

