function project18(n,t)
die=0;
young=1;
old=2;%待做
last=1;
Y=zeros(n);

axis([0 1 0 1])
[A ,B ,BUTTOM]=ginput(t);
for kk=1:t
for ii=1:n
    for jj=1:n
        
        if  A(kk)>(ii-1)/n && A(kk)<ii/n && B(kk)>(jj-1)/n && B(kk)<jj/n
            Y(n-jj+1,ii)=young;
        end
    end
end
end
image(uint8(Y));


while last==1
disp(Y);
image(71*Y)
last=0;
X=zeros(n);


    if Y(1,1)==young
        X(2,1)=X(2,1)+1;
        X(1,2)=X(1,2)+1;
        X(2,2)=X(2,2)+1;
    end
    if Y(1,n)==young
        X(2,n)=X(2,n)+1;
        X(1,n-1)=X(1,n-1)+1;
        X(2,n-1)=X(2,n-1)+1;
    end
    if Y(n,1)==young
        X(n-1,1)=X(n-1,1)+1;
        X(n,2)=X(n,2)+1;
        X(n-1,2)=X(n-1,2)+1;
    end
    if Y(n,n)==young
        X(n,n-1)=X(n,n-1)+1;
        X(n-1,n)=X(n-1,n)+1;
        X(n-1,n--1)=X(n-1,n-1)+1;
    end
    for ii=2:n-1
        if Y(ii,1)==young
            X(ii-1,1)=X(ii-1,1)+1;
            X(ii+1,1)=X(ii+1,1)+1;
            X(ii,2)=X(ii,2)+1;
            X(ii-1,2)=X(ii-1,2)+1;
            X(ii+1,2)=X(ii+1,2)+1;
        end
        if Y(ii,n)==young
            X(ii-1,n)=X(ii-1,n)+1;
            X(ii+1,n)=X(ii+1,n)+1;
            X(ii,n-1)=X(ii,n-1)+1;
            X(ii-1,n-1)=X(ii-1,n-1)+1;
            X(ii+1,n-1)=X(ii+1,n-1)+1;
        end
        if Y(1,ii)==young
            X(1,ii-1)=X(1,ii-1)+1;
            X(1,ii+1)=X(1,ii+1)+1;
            X(2,ii)=X(2,ii)+1;
            X(2,ii-1)=X(2,ii-1)+1;
            X(2,ii+1)=X(2,ii+1)+1;
        end
        if Y(n,ii)==young
            X(n,ii-1)=X(n,ii-1)+1;
            X(n,ii+1)=X(n,ii+1)+1;
            X(n-1,ii)=X(n-1,ii)+1;
            X(n-1,ii-1)=X(n-1,ii-1)+1;
            X(n-1,ii+1)=X(n-1,ii+1)+1;
        end
        for jj=2:n-1
            if Y(ii,jj)==young
                X(ii-1,jj-1)=X(ii-1,jj-1)+1;
                X(ii+1,jj-1)=X(ii+1,jj-1)+1;
                X(ii-1,jj+1)=X(ii-1,jj+1)+1;
                X(ii+1,jj+1)=X(ii+1,jj+1)+1;
                X(ii,jj-1)=X(ii,jj-1)+1;
                X(ii,jj+1)=X(ii,jj+1)+1;
                X(ii-1,jj)=X(ii-1,jj)+1;
                X(ii+1,jj)=X(ii+1,jj)+1;
            end
        end
    end

for ii=1:n
    for jj=1:n
        if Y(ii,jj)==young
            if X(ii,jj)~=2&&X(ii,jj)~=3
                Y(ii,jj)=die;
                last=1;
            end
        end
        if Y(ii,jj)==die
            if X(ii,jj)==3
                Y(ii,jj)=young;
                last=1;
            end
        end
    end
end
pause(1);
end
