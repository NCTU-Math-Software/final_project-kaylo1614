function project18(n,t)%n代表你想要給多大的範圍，t代表你想要放幾個成年人在圖上(t不可大於n的平方)
die=0; %(死人) 如果周圍有3個成年人則會產生小孩
child=50;%(活人) 剛出生的小孩
young=220; %(活人) 代表處於可繁殖狀態
adult=250;
old=350;%(活人) 代表即將自然死亡的老人
virus=1;
poison=2;
kill=0;
Y=zeros(n);%紀錄圖上每個位置活死人的狀態 預設都是死人
last=1;
axis([0 1 0 1]); %先將座標畫出
Z=zeros(n);
[A ,B ,BUTTON]=ginput(t);%點了t個點
for kk=1:t%設置成年人在滑鼠所點的那t個點的位置
    for ii=1:n
    for jj=1:n
        if  A(kk)>(ii-1)/n && A(kk)<ii/n && B(kk)>(jj-1)/n && B(kk)<jj/n %若該點x座標在ii-1跟ii之間，y座標在jj-1到jj之間則在矩陣相對應的位置紀錄
            Y(n-jj+1,ii)=young;%因為矩陣是由左上數到右下，而座標軸是由左下數到右下，所以(ii,jj)的狀態要存在Y(n-1-jj,ii)
        end
    end
    end
end

while last==1
image(uint8(Y))%映出圖形
last=0; %初始值last=0代表族群位置已經固定了，每個族群都有固定的位置，不會畫出變化圖，last=1，代表族群人有波動，將繼續列出族群的變化，
X=zeros(n);%初始畫周圍活人數量(預設值0代表沒有活人)
[X,Z]=arround(Y,X,young,1,n,virus,Z);
[X,Z]=arround(Y,X,adult,2,n,virus,Z);
[X,Z]=arround(Y,X,old,0.5,n,virus,Z);
for ii=1:n
    for jj=1:n
        if Z(ii,jj)==virus
            if poison>(n*2/3)^2||kill~=0
                Z(ii,jj)=0;
                Y(ii,jj)=die;
                kill=kill+1;
                poison=poison-1;
                if poison==0
                    kill=0;
                    poison=3;
                end
            elseif (ii~=1)&&(ii~=n)&&(jj~=1)&&(jj~=n)&&Y(ii,jj)~=die
                if rand(1)<0.5
                    if Z(ii+1,jj)~=virus
                        Z(ii+1,jj)=virus;
                        poison=poison+1;
                    end
                    if Z(ii-1,jj)~=virus
                        Z(ii-1,jj)=virus;
                        poison=poison+1;
                    end
                    if Z(ii,jj-1)~=virus
                        Z(ii,jj-1)=virus;
                        poison=poison+1;
                    end
                    if Z(ii,jj+1)~=virus
                        Z(ii,jj+1)=virus;
                        poison=poison+1;
                    end
                else
                    if Z(ii+1,jj+1)~=virus
                        Z(ii+1,jj+1)=virus;
                        poison=poison+1;
                    end
                    if Z(ii-1,jj+1)~=virus
                        Z(ii-1,jj+1)=virus;
                        poison=poison+1;
                    end
                    if Z(ii-1,jj-1)~=virus
                        Z(ii-1,jj-1)=virus;
                        poison=poison+1;
                    end
                    if Z(ii+1,jj-1)~=virus
                        Z(ii+1,jj-1)=virus;
                        poison=poison+1;
                    end
                end
            end
        end
        if Y(ii,jj)==young %討論有人的狀況
            if X(ii,jj)<6
                Y(ii,jj)=adult;
            else
                Y(ii,jj)=die;
            end
            last=1;
        elseif Y(ii,jj)==adult
            if X(ii,jj)<6
                Y(ii,jj)=old;
            else
                Y(ii,jj)=die;
            end
            last=1;
        elseif Y(ii,jj)==die %討論沒人的狀態
            if X(ii,jj)>=3
                Y(ii,jj)=child;
                last=1;
            end
        elseif Y(ii,jj)==child
            if X(ii,jj)>1&&X(ii,jj)<8
                Y(ii,jj)=young;
            else
                Y(ii,jj)=die;
                last=1;
            end
        elseif Y(ii,jj)==old
            Y(ii,jj)=die;
            last=1;
        end
    end
end
pause(1);
end
end
function [X,NZ]=arround(Y,X,life,consume,n,virus,Z)
    NZ=Z;
    if Y(1,1)==life
        X(2,1)=X(2,1)+consume;
        X(1,2)=X(1,2)+consume;
        X(2,2)=X(2,2)+consume;
        if Z(2,2)~=virus
            NZ(2,2)=virus;
        end
    end
    if Y(1,n)==life
        X(2,n)=X(2,n)+consume;
        X(1,n-1)=X(1,n-1)+consume;
        X(2,n-1)=X(2,n-1)+consume;
        if Z(2,n-1)~=virus
            NZ(2,n-1)=virus;
        end
    end
    if Y(n,1)==life
        X(n-1,1)=X(n-1,1)+consume;
        X(n,2)=X(n,2)+consume;
        X(n-1,2)=X(n-1,2)+consume;
        if Z(n-1,2)~=virus
            NZ(n-1,2)=virus;
        end
    end
    if Y(n,n)==life
        X(n,n-1)=X(n,n-1)+consume;
        X(n-1,n)=X(n-1,n)+consume;
        X(n-1,n--1)=X(n-1,n-1)+consume;
        if Z(n-1,n-1)~=virus
            NZ(n-1,n-1)=virus;
        end
    end
    for ii=2:n-1
        %對邊上做討論
        if Y(ii,1)==life
            X(ii-1,1)=X(ii-1,1)+consume;
            X(ii+1,1)=X(ii+1,1)+consume;
            X(ii,2)=X(ii,2)+consume;
            X(ii-1,2)=X(ii-1,2)+consume;
            X(ii+1,2)=X(ii+1,2)+consume;
        end
        if Y(ii,n)==life
            X(ii-1,n)=X(ii-1,n)+consume;
            X(ii+1,n)=X(ii+1,n)+consume;
            X(ii,n-1)=X(ii,n-1)+consume;
            X(ii-1,n-1)=X(ii-1,n-1)+consume;
            X(ii+1,n-1)=X(ii+1,n-1)+consume;
        end
        if Y(1,ii)==life
            X(1,ii-1)=X(1,ii-1)+consume;
            X(1,ii+1)=X(1,ii+1)+consume;
            X(2,ii)=X(2,ii)+consume;
            X(2,ii-1)=X(2,ii-1)+consume;
            X(2,ii+1)=X(2,ii+1)+consume;
        end
        if Y(n,ii)==life
            X(n,ii-1)=X(n,ii-1)+consume;
            X(n,ii+1)=X(n,ii+1)+consume;
            X(n-1,ii)=X(n-1,ii)+consume;
            X(n-1,ii-1)=X(n-1,ii-1)+consume;
            X(n-1,ii+1)=X(n-1,ii+1)+consume;
        end
        %對內部的點做討論:如果角落有活人，則使附近的點知道周圍有一個生物(用X來記錄，所以附近每個點的X矩陣值要加一)
        for jj=2:n-1
            if Y(ii,jj)==life
                X(ii-1,jj-1)=X(ii-1,jj-1)+consume;
                X(ii+1,jj-1)=X(ii+1,jj-1)+consume;
                X(ii-1,jj+1)=X(ii-1,jj+1)+consume;
                X(ii+1,jj+1)=X(ii+1,jj+1)+consume;
                X(ii,jj-1)=X(ii,jj-1)+consume;
                X(ii,jj+1)=X(ii,jj+1)+consume;
                X(ii-1,jj)=X(ii-1,jj)+consume;
                X(ii+1,jj)=X(ii+1,jj)+consume;
            end
        end
    end
end
