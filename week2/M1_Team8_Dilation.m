function OutputImg = M1_Team8_Dilation (InputImg, structel, struCent)

[M,N]=size(InputImg);
[m,n]=size(structel);

for i=1:M
  for j=1:N
    CropT=1-struCent(1)+i;
    CropB=m-struCent(1)+i;
    CropL=1-struCent(2)+j;
    CropR=n-struCent(2)+j;
    RegionArray=[];
    for k=CropT:CropB
      for l=CropL:CropR
        if k<1 | l<1 | k>M | l>N
          RegionArray=[RegionArray;0];
        else
          RegionArray=[RegionArray;(InputImg(k,l)*structel(k-CropT+1,l-CropL+1))];
        end
      end
    end
    OutputImg(i,j)=max(RegionArray);
  end
end