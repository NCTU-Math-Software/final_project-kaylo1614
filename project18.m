%{
這個程式是在一個平面上，模擬單一生物的繁衍，，當成年生物附近有超過3個生物時，由於附近人太多，會導致糧食不足，使該生物死亡，周圍人數少於2人時，由於沒人可以繁衍後代，該生物會自然死去
而對於沒有生物的的地方，如果周圍有三個成年生物，則會繁衍出生物
使用者須輸入:n 代表你想要給多大的範圍,t 代表你想要放幾個成年人在圖上 該圖最多只有平方個點，因此，t不可大於n平方
%}
function project18(n,t)%n代表你想要給多大的範圍，t代表你想要放幾個成年人在圖上(t不可大於n的平方)
die=0; %(死人) 如果周圍有3個成年人則會產生小孩
child=1;%(活人) 剛出生的小孩
young=2; %(活人) 代表處於可繁殖狀態
old=3;%(活人) 代表即將自然死亡的老人
Y=zeros(n);%紀錄圖上每個位置活死人的狀態 預設都是死人
last=1;
axis([0 1 0 1]) %先將座標畫出
[A ,B ,BUTTOM]=ginput(t);%點了t個點
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

    %對四個角落討論:如果角落有活人，則使附近的點知道周圍有一個生物(用X來記錄，所以附近每個點的X矩陣值要加一)
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
        %對邊上做討論
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
        %對內部的點做討論:如果角落有活人，則使附近的點知道周圍有一個生物(用X來記錄，所以附近每個點的X矩陣值要加一)
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
%用附近成年生物數據來改變該點狀態:如果該點有活人，則使附近的點知道周圍有一個生物(用X來記錄，所以附近每個點的X矩陣值要加一)
for ii=1:n
    for jj=1:n
        if Y(ii,jj)==young %討論有人的狀況
            if X(ii,jj)~=2&&X(ii,jj)~=3
                Y(ii,jj)=die;
                last=1;
            end
        end
        if Y(ii,jj)==die %討論沒人的狀態
            if X(ii,jj)==3
                Y(ii,jj)=young;
                last=1;
            end
        end
    end
end
pause(1);
end
end
