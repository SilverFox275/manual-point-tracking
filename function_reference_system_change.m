function function_reference_system_change(output_video_folder,video_name,n_object)

%this function transforms the xy coordinates (originally referred in the
%image reference system) to the new coordinates referenced within the
%tracking region defined by clicking on the corners

%the transformations considered are: translation, rotation and scaling
%(independently on x-y)

%order of conrers' clicking:
% 1: TOP LEFT
% 2: BOTTOM LEFT
% 3: BOTTOM RIGHT
% 4: TOP RIGHT

%Uploading corners coordinate
corner_csv_name=strcat('CORNERS_',num2str(video_name(1:end-4)),'.csv');
corners=table2array(readtable(strcat(output_video_folder,'\',corner_csv_name)));

%Uploading raw tracking coordinates
xy=table2array(readtable(strcat(output_video_folder,'\TRACKED_RAW',video_name(1:end-4),'.csv')));

%Creating a new object for the new referenced coordinates
new_xy=zeros(size(xy)); %coorditates in the new reference system
new_xy(:,1)=xy(:,1);

% column: x - y coordinates
% rows: numebr of frames
column_names=cell(1,2*n_object+1);
column_names(1)={'Frame_id'};
for j=1:n_object
column_names(2*j)=cellstr(strcat('relative_coordinates_X_',num2str(j)));
column_names(2*j+1)=cellstr(strcat('relative_coordinates_Y_',num2str(j)));
end


top(1)=(corners(1,1)+corners(4,1))/2;
top(2)=(corners(1,2)+corners(4,2))/2;
left(1)=(corners(1,1)+corners(2,1))/2;
left(2)=(corners(1,2)+corners(2,2))/2;
bottom(1)=(corners(2,1)+corners(3,1))/2;
bottom(2)=(corners(2,2)+corners(3,2))/2;
right(1)=(corners(3,1)+corners(4,1))/2;
right(2)=(corners(3,2)+corners(4,2))/2;

m_H=(right(2)-left(2))/(right(1)-left(1));
b_H=right(2)-m_H*right(1);
m_V=(bottom(2)-top(2))/(bottom(1)-top(1));
b_V=bottom(2)-m_V*bottom(1);

centre(1)=-(b_H-b_V)/(m_H-m_V);
centre(2)=m_H*centre(1)+b_H;

Area=polyarea(corners(:,1),corners(:,2));
Width=sqrt(Area*norm(right-left)/norm(top-bottom));
Height=Area/Width;

alpha1=atan(m_H);
alpha2=atan(m_V);
rot_angle=alpha1+pi()/2-abs(alpha1-alpha2);

%origin for translation
o(1)=centre(1)+(Height*sin(rot_angle)-Width*cos(rot_angle))/2;
o(2)=centre(2)-(Height*cos(rot_angle)+Width*sin(rot_angle))/2;

%rotation matrix 
R=[cos(rot_angle),-sin(rot_angle);sin(rot_angle),cos(rot_angle)];

%stretching on x and y
S=[1/Width,0;0,1/Height];

for i=1:size(xy,1)
    for j=1:n_object
%translation
new_xy(i,2*j)=xy(i,2*j)-o(1);
new_xy(i,2*j+1)=xy(i,2*j+1)-o(2);

new_xy(i,2*j:2*j+1)=new_xy(i,2*j:2*j+1)*R*S;
    end
end
xy_csv=array2table(new_xy,'VariableNames',column_names);

%saving the file
writetable(xy_csv,strcat(output_video_folder,'\TRACKED_REFERENCED_',video_name(1:end-4),'.csv'))