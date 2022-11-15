function function_write_corners(output_video_folder,video_name,frame)

%defining the tracking region by clicking the 4 corners of the rectangle
%the output is a .csv file with the relative coordinates of the 4 corners

%order of clicking:
% 1: TOP LEFT
% 2: BOTTOM LEFT
% 3: BOTTOM RIGHT
% 4: TOP RIGHT

%appearing message
msg_corners = 'Click on the four corners of the tracking region';
uiwait(msgbox(msg_corners)) %waiting for a response to resume the run

N_corners=4; % number of corners to get
corner=zeros(N_corners,2); % 2D matrix:
% 4 rows: four points
% 2 columns: x-y coordinate

figure('Name',video_name)

I= imread(strcat(output_video_folder,'\Frames\\frame',num2str(frame),'.jpg'));
I_text=insertText(I,[30 30], ...
    "Corner clicking order: 1:TOP-LEFT; 2:BOTTOM-LEFT; 3:BOTTOM-RIGHT; 4:TOP-RIGHT",...
    'BoxColor','white','FontSize',32);
imshow(I_text); % calling the image
corner(:,:)=ginput(N_corners); %with this command you are asked to click four times on the image
close

%converting into relative coordinates
corner(:,1)=corner(:,1)/size(I,2); %width
corner(:,2)=corner(:,2)/size(I,1); %height

%converting matrix into a table
corner_csv=array2table(corner,'VariableNames',{'relative_coordinates_X','relative_coordinates_Y'}); %converting matrix into a table

%writing .csv file
writetable(corner_csv,strcat(output_video_folder,'\CORNERS_',num2str(video_name(1:end-4)),'.csv'));


