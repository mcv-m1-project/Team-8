function OutputImg = M1_Team8_Dilation (InputImg, structel, struCent)

[M,N]=size(InputImg);
[m,n]=size(structel);

structel=structel(end:-1:1,end:-1:1);

struCent = size(structel)-struCent+[1,1];

Padded=zeros(size(InputImg)+size(structel)-[1,1]);

OuputImgWithBorders = Padded;

Padded(struCent(1):(struCent(1)+M-1),struCent(2):(struCent(2)+N-1)) = InputImg;

for i=struCent(1):struCent(1)+M-1
  for j=struCent(2):struCent(2)+N-1
    CropCur=Padded((i-struCent(1)+1):(i+m-struCent(1)),(j-struCent(2)+1):(j+n-struCent(2)));
    OutputImgWithBorders(i,j)=max(max(CropCur.*structel));
  end
end

OutputImg=OutputImgWithBorders(struCent(1):(struCent(1)+M-1),struCent(2):(struCent(2)+N-1));
      
%     CropT=1-struCent(1)+i;
%     CropB=m-struCent(1)+i;
%     CropL=1-struCent(2)+j;
%     CropR=n-struCent(2)+j;
%     RegionArray=[];
%     for k=CropT:CropB
%       for l=CropL:CropR
%         if k<1 | l<1 | k>M | l>N
%           RegionArray=[RegionArray;0];
%         else
%           RegionArray=[RegionArray;(InputImg(k,l)*structel(k-CropT+1,l-CropL+1))];
%         end
%       end
%     end
%     OutputImg(i,j)=max(RegionArray);
%   end
% end