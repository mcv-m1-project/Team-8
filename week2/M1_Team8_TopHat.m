function OutputImg = M1_Team8_TopHat (InputImg, structel, struCent, Times)

OpenedImg = M1_Team8_Opening(InputImg,structel,struCent,Times);

OutputImg = double(InputImg) - OpenedImg;