% clear the workspace and command window
clc
clear all

% SET INPUT PARAMETERS
% Here are all the settings for the tracking

video_folder='My_input_folder'; %folder with videos to track
output_folder='My_output_main_folder'; %folder with output data
video_name='My_video_name.mp4'; %full video name (with name.mp4)
n_object=1; %number of objects to track in each frame
track_start=30; % starting point to track [seconds]
track_end=60; % ending point to track [seconds]
track_fps=5; %sampling frequency [frames per seconds]

%from now on, the code should not be edited!
%---------------------------------------------------------------------------------------------------------
%% VARIABLE DEFINITION

addpath('Functions')
[output_video_folder,Video,frames]=function_variable_definition(output_folder,video_folder,video_name,track_start,track_end,track_fps,n_object);

% ------------------------------------------------------------------------------------------------------------------------
%% FRAMES EXTRACTION

function_frames_extraction(Video,output_video_folder,frames)

%------------------------------------------------------------------------------------------------------------------------------------
%% DELIMITING TRACKING REGION

% Corners clicking order= 1:TOP LEFT; 2: BOTTOM LEFT; 3: BOTTOM RIGHT; 4: TOP RIGHT
function_write_corners(output_video_folder,video_name,frames(1))

%--------------------------------------------------------------------------------------------------------------------------------------
%% MANUAL TRACKING

function_point_tracking(output_video_folder,video_name,frames,n_object)

%--------------------------------------------------------------------------------------------------------------------------
%% CONVERSION INTO THE NEW REFERENCE SYSTEM

function_reference_system_change(output_video_folder,video_name,n_object)

%---------------------------------------------------------------------------------------------------------------------