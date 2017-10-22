obj=VideoReader('llll.mp4');
get(obj);%bir nesneyi okuma için kullanýlýr
nFrame=obj.NumberOfFrames;%video akýþýndaki karelerin sayýsýný bulur

x=30;
y1=350;
y=19;
x1=465;
for i=1:nFrame
 res=read(obj,i);

    r=res(:,:,1);%resmin kýrmýzý bileþeni belirleniyor
    g=res(:,:,2);%resmin yeþil renk bileþeni belirleniyor
    b=res(:,:,3);%resmin mavi renk bileþeni belirleniyor
maske=(r>200)&(r<255)&(g<30)&(b<40);%kýrmýzý ýþýk bulunmasý için maske oluþturuluyor
sobelFiltresi=edge(maske,'sobel');%sobel ile kenar bulma iþlemi gerçekleþtiriliyor

diff=medfilt2(sobelFiltresi, [3 3]);%medyan ile resmin gürültüsü azaltýlýyor

diff_im = bwareaopen(diff,200);%200 ün altýndaki renk bileþenleri çýkarýlýyor
%d=imfill(diff,'holes'); %Resimde çukur diye nitelendirilen yerleri dolduruyoruz.
%di=bwmorph(d,'dilate');
  birlestirici1 = strel('disk',10);%strel: Morfolojik iþlemlerde uygulanan yapýsal filtre elemanýdýr. 
 %Morfolojik iþlemleri hangi þekil ve parametrelerle uygulayacaðýmýzý strel ile belirleyebiliriz. örnek=> se=strel('disk',R)  R: Yarýçap


di = imdilate(diff,birlestirici);%resime geniþletme uygular
for n=y:y1
    for j=x:x1
        sonuc((n-y+1),(j-x+1))=di(n,j);
    end 
end

subplot(1,3,1);
    imshow(res,[]);
    pause(0.00001);
  
 subplot(1,3,2);
 hold on;
 title(['Kýrmýzý Iþýk Tespiti']);
 imshow(sonuc,[]);
 pause(0.00001);
 
 resim=read(obj,i);
 image=ycbcr2rgb(resim);
 red=image(:,:,1);
 green=image(:,:,2);
 blue=image(:,:,3);
 maskeleme=(red>90)&(red<120)&(green<30);
 sobelF=edge(maskeleme,'sobel');

diff1=medfilt2(sobelF, [3 3]);
diff_im1 = bwareaopen(diff1,200);
 birlestirici = strel('disk',10);%strel: Morfolojik iþlemlerde uygulanan yapýsal filtre elemanýdýr. 
 %Morfolojik iþlemleri hangi þekil ve parametrelerle uygulayacaðýmýzý strel ile belirleyebiliriz. örnek=> se=strel('disk',R)  R: Yarýçap


bwl = imdilate(diff1,birlestirici);%resime geniþletme uygular
 subplot(1,3,3);
 hold on;
 title(['Yeþil Iþýk Tespiti']);
 imshow(bwl,[]);
 pause(0.00001);
 
 
end