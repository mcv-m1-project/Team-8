function OutputImg = M1_Team8_DualTopHat (InputImg, structel, struCent, Times)

ClosedImg = M1_Team8_Closing(InputImg,structel,struCent,Times);

OutputImg = ones(size(InputImg)) - (ClosedImg - InputImg);