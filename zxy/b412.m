for xuhao=1:9
str=strcat('0',int2str(xuhao),'_test.tif');
A=imread(str);
A(:,:,2) = A(:,:,2);
A(:,:,1) = 0;
A(:,:,3) = 0;
A= rgb2gray(A);

angle_t=9;
SUM=0;
for i=1:angle_t
    B{i}=strel('line',13,180/angle_t*(i-1));
    E{i}=imopen(A,B{i});
    F{i}=imclose(A,B{i});
    %G{i}=F{i}-E{i};
    G{i}=F{i}-A;
    %figure,imshow(E{i});
    SUM=SUM+G{i}/9;
end
SUM=imadjust(SUM,[0 0.1],[0 1]);
%figure,imshow(SUM);
[SUMsizex,SUMsizey]=size(SUM);
for i=1:SUMsizex
    for j=1:SUMsizey
        if SUM(i,j)<10
            SUM(i,j)=255;
        else
            SUM(i,j)=0;
        end
    end
end
%figure,imshow(SUM);
SUM=255-SUM;
imlabel=bwlabel(SUM);
stats=regionprops(imlabel,'Area');
area=cat(1,stats.Area);
index=find(area>200);
img=ismember(imlabel,index);
%figure,imshowpair(255-SUM,255-255*img,'montage');
%imwrite(255-SUM,strcat(int2str(xuhao),'-tiqu.jpg'));
%imwrite(255-255*img,strcat(int2str(xuhao),'-quzao.jpg'));
A=255-255*img;
angle_t=12;
SUM=0;
for i=1:angle_t
    B{i}=strel('line',5,180/angle_t*(i-1));
    E{i}=imerode(A,B{i});
    %F{i}=imclose(A,B{i});
    %G{i}=F{i}-E{i};
    SUM=SUM+E{i}/12;
end
figure,imshow(SUM,'border','tight','initialmagnification','fit');
%set (gcf,'Position',[0,0,SUMsizex,SUMsizey]);
%axis normal;
%imwrite(SUM,strcat(int2str(xuhao),'-3.jpg'));
%imwrite(SUM,strcat(int2str(xuhao),'-×îÖÕ½á¹û','.jpg'));
A=imread(strcat('0',int2str(xuhao),'_manual1.gif'));
A=255-A;
%SUM=255-SUM;
for i=1:SUMsizex
    for j=1:SUMsizey
        if SUM(i,j)==0&&A(i,j)~=0
            f(i,j,1)=255;f(i,j,2)=0;f(i,j,3)=0;
        end
        if A(i,j)==0&&SUM(i,j)~=0
            f(i,j,1)=0;f(i,j,2)=255;f(i,j,3)=0;
        end
        if SUM(i,j)==0&&A(i,j)==0
            f(i,j,1)=255;f(i,j,2)=255;f(i,j,3)=255;
        end
    end
end
figure,imshow(f);
%imwrite(f,strcat(int2str(xuhao),'-9','.jpg'));
clearvars -except xuhao minconsize maxconsize;
end