obj=VideoReader('llll.mp4');
get(obj);%bir nesneyi okuma i�in kullan�l�r
nFrame=obj.NumberOfFrames;%video ak���ndaki karelerin say�s�n� bulur

x=30;
y1=350;
y=19;
x1=465;
for i=1:nFrame
 res=read(obj,i);

    r=res(:,:,1);%resmin k�rm�z� bile�eni belirleniyor
    g=res(:,:,2);%resmin ye�il renk bile�eni belirleniyor
    b=res(:,:,3);%resmin mavi renk bile�eni belirleniyor
maske=(r>200)&(r<255)&(g<30)&(b<40);%k�rm�z� ���k bulunmas� i�in maske olu�turuluyor
sobelFiltresi=edge(maske,'sobel');%sobel ile kenar bulma i�lemi ger�ekle�tiriliyor

diff=medfilt2(sobelFiltresi, [3 3]);%medyan ile resmin g�r�lt�s� azalt�l�yor

diff_im = bwareaopen(diff,200);%200 �n alt�ndaki renk bile�enleri ��kar�l�yor
%d=imfill(diff,'holes'); %Resimde �ukur diye nitelendirilen yerleri dolduruyoruz.
%di=bwmorph(d,'dilate');
  birlestirici1 = strel('disk',10);%strel: Morfolojik i�lemlerde uygulanan yap�sal filtre eleman�d�r. 
 %Morfolojik i�lemleri hangi �ekil ve parametrelerle uygulayaca��m�z� strel ile belirleyebiliriz. �rnek=> se=strel('disk',R)  R: Yar��ap


di = imdilate(diff,birlestirici);%resime geni�letme uygular
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
 title(['K�rm�z� I��k Tespiti']);
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
 birlestirici = strel('disk',10);%strel: Morfolojik i�lemlerde uygulanan yap�sal filtre eleman�d�r. 
 %Morfolojik i�lemleri hangi �ekil ve parametrelerle uygulayaca��m�z� strel ile belirleyebiliriz. �rnek=> se=strel('disk',R)  R: Yar��ap


bwl = imdilate(diff1,birlestirici);%resime geni�letme uygular
 subplot(1,3,3);
 hold on;
 title(['Ye�il I��k Tespiti']);
 imshow(bwl,[]);
 pause(0.00001);
 
 
end