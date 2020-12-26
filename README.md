# special life game
使用者須輸入:空間大小(N)(代表空間最多只有NxN個生物)、起始人口數(t)(之後要在塗上點t個點，會將那些點變成青年)
這個程式是在一個NxN的平面上，在地圖上放置t個某物種的青年(使用者點擊)，之後模擬單一物種的繁衍，而該物種分為幼年(child)，青年(young)，壯年(adult)，跟老年(old)狀態，只要周圍沒有太多人競爭糧食，該物種就會進入下一個時期，且有機會繁衍。
補充:此程式是用wihle迴圈跑，只要有任何參數有改變，程式就會繼續執行，換言之，直到全部死光，程式才會停下來;在點的時候如果太開或太密都不利於繁衍，使用者須注意

作法:用矩陣Y來記錄每個位置生命狀態，紀錄初始生命狀態時，先顯示一個x,y座標軸都是從0到1的平面，用ginput取t個點，再將座標軸評分成N等分，就可以看到要的點的x,y座標，在Y矩陣對應的位置紀錄。

作法:用X矩陣來記錄每個點周圍的消耗，當一個點是青年時，將該點周圍的消耗都+1、壯年則加二、老年則加0.5(除了邊界以外的點會得到周圍八個點的值相加，角落會得到三個點相加，邊會得到五個點相加)

先說死亡機制，小孩不消耗糧食，青年消耗一份糧食，壯年消耗兩份糧食，老年消耗半分糧食，小孩需要照顧，所以周圍個體的總消耗至少要超過一糧食，而小孩的糧食消耗不大，當周圍物種的糧食消耗超過7時，下一個時段小孩會餓死，而青年消耗較大，當周圍物種的糧食消耗超過4時，下一個時段青年會餓死，壯年消耗較大，當周圍物種的糧食消耗超過3時，下一個時段壯年會餓死，而老年人不論如何，下一個時段都會老死亡。接著是繁衍機制，消耗越大的物種，越有能力生小孩，只要周圍的消耗超過三，原本死亡的位置就會生出小孩。

作法:用前面記錄下的X矩陣來判斷，如果X矩陣的值是在我們要的繁衍範圍，改變Y矩陣到下一個階段(死->小孩->壯年->老年->死)，如果沒有達到生存門檻，一律將該點Y的值轉為死亡。

做完這些後，我發現只要族群達到一定的數量，族群就會無限制的生長，直到占滿整個空間，因此，我設置了病毒機制，在四個編的中央和四個角落還有中央各放置感染源，一旦在感染源所在區域產生生命，該區域就會產生病毒，病毒有兩種傳播方式，且只有在活體上會開始傳播（但仍會擴散到沒人的區域）一種是擴散到上下左右，另一種是向左上,右上,左下,右下等四個方向傳播，且傳播機率各是0.5（用以增加病毒擴散位置的多樣性），而當超過1/4的位置有病毒感染時，所有病毒都會爆炸，如果病毒所在位置有生物，就會被炸死。）

作法:用Z矩陣紀錄病毒的分布，如果感染源的位置不是死亡狀態，則在我們想要的位置放置病毒，病毒在傳播前先確定病毒所在位置有活體，如果有，則取randi(1,1)，值小於0.5則執行第一種，否則執行第二種傳播法，而每當有一個生物受感染，感染人數(poison)加一，如果場上有超過1/4的位置有病毒，將死亡參數調為1，只要死亡參數(kill)不為零，病毒所在位置就會變成死亡且感染人數減一，該位置病毒消失(Z矩陣的該位置改為0)，直到每個病毒都死光，重設死亡參數與感染人數。

我才設計一次直接爆炸是因為不希望強烈的病毒直接影響生物的繁衍，如果爆炸後不讓病毒數量從零開始，受過損害的生物將無法重新復興；
而病毒所運行的方式其實還有很多種可能，如果寒假有空，我或許會嘗試做其他進一步的模型模擬更多生物的繁殖，到時不只是一個物種，也可能有不只一種病毒，更可能有能免疫病毒的生命。

這個程式沒有用到高級的程式碼，但確需要較複雜的數學模型，像是要用矩陣去紀錄一個點周圍的生物消耗就需要些巧思，還要有很多方式去修正平衡性，才不會太快死光又或者輕易站滿整張地圖。
