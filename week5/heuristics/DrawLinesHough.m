function DrawLinesHough(im,lines,accum,circen,cirrad,shape)

    switch shape
        case 'rect'
            figure, imshow(im), hold on
            max_len = 0;
            for k = 1:length(lines)
               xy = [lines(k).point1; lines(k).point2];
               plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

               % Plot beginnings and ends of lines
               plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
               plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

               % Determine the endpoints of the longest line segment
               len = norm(lines(k).point1 - lines(k).point2);
               if ( len > max_len)
                  max_len = len;
                  xy_long = xy;
               end
            end
            pause;
            
        case 'circ'
           figure(1); imagesc(accum); axis image;
           title('Accumulation Array from Circular Hough Transform');
           figure(2); imagesc(im); colormap('gray'); axis image;
           hold on;
           plot(circen(:,1), circen(:,2), 'r+');
           for k = 1 : size(circen, 1),
            DrawCircle(circen(k,1), circen(k,2), cirrad(k), 32, 'b-');
           end
           hold off;
          title(['Raw Image with Circles Detected ', ...
             '(center positions and radii marked)']);
          figure(3); surf(accum, 'EdgeColor', 'none'); axis ij;
          title('3-D View of the Accumulation Array');
          pause;   
    end
end
        