function OutputImg = M1_Team8_Erosion (InputImg, structel, struCent)

[M,N]=size(InputImg);
[m,n]=size(structel);

structel=structel(end:-1:1,end:-1:1);

struCent = size(structel)-struCent+[1,1];

Padded=255*ones(size(InputImg)+size(structel)-[1,1]);

OuputImgWithBorders = Padded;

Padded(struCent(1):(struCent(1)+M-1),struCent(2):(struCent(2)+N-1)) = InputImg;

for i=struCent(1):struCent(1)+M-1
  for j=struCent(2):struCent(2)+N-1
    CropCur=Padded((i-struCent(1)+1):(i+m-struCent(1)),(j-struCent(2)+1):(j+n-struCent(2)));
    OutputImgWithBorders(i,j)=min(min(CropCur.*structel));
  end
end

OutputImg=OutputImgWithBorders(struCent(1):(struCent(1)+M-1),struCent(2):(struCent(2)+N-1));