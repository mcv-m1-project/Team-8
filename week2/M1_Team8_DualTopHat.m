function OutputImg = M1_Team8_DualTopHat (InputImg, structel, struCent, Times)

ClosedImg = M1_Team8_Closing(InputImg,structel,struCent,Times);

OutputImg = 255*ones(size(InputImg)) - (ClosedImg - double(InputImg));