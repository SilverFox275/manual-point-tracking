function frames_extraction(Video,output_folder,frames)
%this funciton reads the video and export the selected frames in format
%.jpg in the created folder "Frames" inside the output folder

mkdir(output_folder,'Frames') %creates a directory for selected frames
for img = frames
    filename = strcat(output_folder,'\Frames\\frame',num2str(img),'.jpg');
    b = read(Video, img);
    imwrite(b, filename);
end