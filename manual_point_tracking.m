% clear the workspace and command window
clc
clear all

% SET INPUT PARAMETERS
% Here are all the settings for the tracking

video_folder="C:\Users\d067879\Videos\1C"; %folder with (!ONLY!) the videos to track
video_name='Example.mp4'; %video name
n_object=6; %number of objects to track in each frame
track_start=30; % starting point to track [seconds]
track_n=2; % sampling size [frames]
track_fps=10; %sampling frequency [frames per seconds]

%from now on, the code should not be touched!
%---------------------------------------------------------------------------------------------------------
%% VARIABLE DEFINITION

Video = VideoReader(strcat(video_folder,'\',video_name)); %reading of the video
fps=Video.FrameRate; %frame rate of the video
frames=int16(linspace(track_start*fps,(track_start+(track_n-1)/track_fps)*fps,track_n));

output_folder=strcat(video_name(1:end-4),'_track');

% ------------------------------------------------------------------------------------------------------------------------
%% FRAMES EXTRACTION

function_frames_extraction(Video,output_folder,frames)

%------------------------------------------------------------------------------------------------------------------------------------
%% DELIMITING TRACKING REGION

% IDENTIFYING THE CORNERS
%order of clicking:
% 1: TOP LEFT
% 2: BOTTOM LEFT
% 3: BOTTOM RIGHT
% 4: TOP RIGHT

function_write_corners(output_folder,video_name,frames(1))

%--------------------------------------------------------------------------------------------------------------------------------------
%% MANUAL TRACKING

function_point_tracking(output_folder,video_name,frames,n_object)

%--------------------------------------------------------------------------------------------------------------------------
%% CONVERSION INTO THE NEW REFERENCE SYSTEM

corner_csv_name=strcat('corners_',num2str(video_name(1:end-4)),'.csv');
corners=table2array(readtable(strcat(output_folder,'\',corner_csv_name)));
xy=table2array(readtable(strcat(output_folder,'\tracking_',video_name(1:end-4),'.csv')));

function_reference_system_change(xy,output_folder,video_name,corners,n_object)

%---------------------------------------------------------------------------------------------------------------------