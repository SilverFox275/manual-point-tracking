function [output_video_folder,Video,frames]=function_variable_definition(output_folder,video_folder,video_name,track_start,track_end,track_fps,n_object)

%this function creates all variables needed for the script,
%and saves a .txt file in which all input tracking parameters are stored

%WARNING dialog for .mp4 extention
if ~endsWith(video_name,'.mp4') && ~endsWith(video_name,'.MP4')
    warndlg('ADD THE ".mp4" TO YOUR video_name OBJECT')
end

%creating a subfolder for all video outputs
output_video_folder=strcat(output_folder,'\Tracking_',video_name(1:end-4)); %subfolder for the video information
mkdir(output_video_folder)

Video = VideoReader(strcat(video_folder,'\',video_name)); %reading the video file
fps=Video.FrameRate; %frame rate of the video
frames=track_start:track_fps:track_end; %specify the frames to track
msg = sprintf('You are going to track %d frame images', size(frames,2));
msgbox(msg)

%WRITING OF A METADATA FILE WITH INPUT TRACKING PARAMETERS
text_file=fopen(strcat(output_video_folder,'\','input_parameters.txt'),'w');
fprintf(text_file, '-----INPUT TRACKING PARAMETERS----\n');
fprintf(text_file, 'video_folder = "%s"\n',video_folder);
fprintf(text_file, 'output_folder = "%s"\n',output_folder);
fprintf(text_file, 'video_name = "%s"\n',video_name);
fprintf(text_file, 'n_object = %d\n',n_object);
fprintf(text_file, 'track_start = %d seconds\n',track_start);
fprintf(text_file, 'track_end = %d seconds\n',track_end);
fprintf(text_file, 'track_fps = %d fps\n\n',track_fps);
fprintf(text_file, '-----READ ONLY PARAMETERS----\n');
fprintf(text_file, 'Video duration = %.2f seconds\n', Video.Duration);
fprintf(text_file, 'Video sampling rate = %d fps\n', fps);
fprintf(text_file, 'Video resolution = %dx%d\n', Video.Width,Video.Height);
fprintf(text_file, 'Images tracked = %d\n', size(frames,2));
fprintf(text_file, 'Percentage of video tracked = %.2f %% \n\n', (Video.Duration-track_end+track_start)/Video.Duration*100);
fprintf(text_file, '----%s----\n', datetime);
fclose(text_file);