function write_corners(output_folder,video_name,frame)
%defining the tracking region by clicking the 4 corners of the rectangle
%the output is a .csv file with the relative coordinates of the 4 corners 
N_corners=4; % number of corners to get
corner=zeros(N_corners,2); % 2D matrix:
% 4 rows: four points
% 2 columns: x-y coordinate

figure('Name',video_name)

I= imread(strcat(output_folder,'\Frames\\frame',num2str(frame),'.jpg'));
imshow(I); % calling the image
corner(:,:)=ginput(N_corners); %with this command you are asked to click four times on the image
close

%converting into relative coordinates
corner(:,1)=corner(:,1)/size(I,2); %width
corner(:,2)=corner(:,2)/size(I,1); %height

%converting matrix into a table
corner_csv=array2table(corner,'VariableNames',{'relative_coordinates_X','relative_coordinates_Y'}); %converting matrix into a table

%writing .csv file
writetable(corner_csv,strcat(output_folder,'\corners_',num2str(video_name(1:end-4)),'.csv'));
