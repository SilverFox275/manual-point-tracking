function function_point_tracking(output_video_folder,video_name,frames,n_object)

%function for tracking the objects in the frames by clicking on them
%output is a .csv folder with the relative coordinates of the objects

%appearing message
msg_tracking = 'Click on the object to track';
uiwait(msgbox(msg_tracking)) %waiting for a response to resume the run

n_frames=size(frames,2);
xy=zeros(n_frames,2*n_object+1); % coordinates of the fish
% column: x - y coordinates
% rows: numebr of frames
column_names=cell(1,2*n_object+1);
column_names(1)={'Frame_id'};
for j=1:n_object
column_names(2*j)=cellstr(strcat('relative_coordinates_X_',num2str(j)));
column_names(2*j+1)=cellstr(strcat('relative_coordinates_Y_',num2str(j)));
end
for i=1:n_frames

    figure('Name',strcat(num2str(i),'/',num2str(n_frames)))

    I= imread(strcat(output_video_folder,'\Frames\\frame',num2str(frames(i)),'.jpg'));

    imshow(I);
    coord=ginput(n_object);
    xy(i,1)=frames(i);
    for j=1:n_object
        xy(i,2*j)=coord(j,1)/size(I,2); %relative coordinates x
        xy(i,2*j+1)=coord(j,2)/size(I,1); %relative coordinates y
    end
    close

end
xy_csv=array2table(xy,'VariableNames',column_names);
%after finish tracking an entire video, save a .csv file
writetable(xy_csv,strcat(output_video_folder,'\TRACKED_RAW_',video_name(1:end-4),'.csv'))