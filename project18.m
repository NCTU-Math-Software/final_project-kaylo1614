function project18(n)
Y=randi(2,n)-ones(n);
last=1;
while last==1
image(100*Y)
last=0;
X=zeros(n);
X(1,1)=X(1,1)+5;
X(1,n)=X(1,n)+5;
X(n,1)=X(n,1)+5;
X(n,n)=X(n,n)+5;
    for ii=2:n-1
        X(ii,1)=X(ii,1)+3;
        X(ii,n)=X(ii,n)+3;
        X(1,ii)=X(1,ii)+3;
        X(n,ii)=X(n,ii)+3;
    end
    if Y(1,1)==1
        X(2,1)=X(2,1)+1;
        X(1,2)=X(1,2)+1;
        X(2,2)=X(2,2)+1;
    end
    if Y(1,n)==1
        X(2,n)=X(2,n)+1;
        X(1,n-1)=X(1,n-1)+1;
        X(2,n-1)=X(2,n-1)+1;
    end
    if Y(n,1)==1
        X(n-1,1)=X(n-1,1)+1;
        X(n,2)=X(n,2)+1;
        X(n-1,2)=X(n-1,2)+1;
    end
    if Y(n,n)==1
        X(n,n-1)=X(n,n-1)+1;
        X(n-1,n)=X(n-1,n)+1;
        X(n-1,n--1)=X(n-1,n-1)+1;
    end
    for ii=2:n-1
        if Y(ii,1)==1
            X(ii-1,1)=X(ii-1,1)+1;
            X(ii+1,1)=X(ii+1,1)+1;
            X(ii,2)=X(ii,2)+1;
            X(ii-1,2)=X(ii-1,2)+1;
            X(ii+1,2)=X(ii+1,2)+1;
        end
        if Y(ii,n)==1
            X(ii-1,n)=X(ii-1,n)+1;
            X(ii+1,n)=X(ii+1,n)+1;
            X(ii,n-1)=X(ii,n-1)+1;
            X(ii-1,n-1)=X(ii-1,n-1)+1;
            X(ii+1,n-1)=X(ii+1,n-1)+1;
        end
        if Y(1,ii)==1
            X(1,ii-1)=X(1,ii-1)+1;
            X(1,ii+1)=X(1,ii+1)+1;
            X(2,ii)=X(2,ii)+1;
            X(2,ii-1)=X(2,ii-1)+1;
            X(2,ii+1)=X(2,ii+1)+1;
        end
        if Y(n,ii)==1
            X(n,ii-1)=X(n,ii-1)+1;
            X(n,ii+1)=X(n,ii+1)+1;
            X(n-1,ii)=X(n-1,ii)+1;
            X(n-1,ii-1)=X(n-1,ii-1)+1;
            X(n-1,ii+1)=X(n-1,ii+1)+1;
        end
        for jj=2:n-1
            if Y(ii,jj)==1
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
        if X(ii,jj)>6
            if Y(ii,jj)==0
                last=1;
            end
            Y(ii,jj)=1;
        end
    end
end
pause(1);
end
