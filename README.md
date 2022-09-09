# manual-point-tracking
Matlab script for object tracking from videos
The code reads a video (or a series of videos) and divides it into the desired number of frames.
The user can click with the mouse on such frames to save the coordinates of the objects that need to be tracked.
THe code provides the possibility to convert the coordinates into the reference system defined by the user (by clicking on the four corners of the tracking region, assuming it is rectangular).

manual_point_tracking.m is the main file that has to be run. The other functions execute specific commands.

The input parameters are the following:

1. the folder that contatins the videos;
2.  number of objects to track in each frame
3.  starting point (seconds)
4.  sampling size (frames)
5.  sampling frequency (frames/seconds)
