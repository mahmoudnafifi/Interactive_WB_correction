%%
% Copyright (c) 2020-present, Mahmoud Afifi
% 
% Please, cite the following paper if you use this code:
%
% Mahmoud Afifi and Michael S. Brown. Interactive White Balancing for
% Camera-Rendered Images. In Color and Imaging Conference (CIC), 2020.
%
% Email: mafifi@eecs.yorku.ca | m.3afifi@gmail.com
%%

function varargout = main(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @main_OpeningFcn, ...
    'gui_OutputFcn',  @main_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end



% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global model

load(fullfile('..','models','model.mat'));


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
global Path_Name
global File_Name
global I temp

[File_Name, Path_Name] = uigetfile({'*.jpg';'*.png';'*.jpeg'},'Select input image','examples');


I = im2double(imread(fullfile(Path_Name,File_Name)));
temp = I;
handles.status.String = 'Loading image...';pause(0.001);

axes(handles.image);
imshow(I);

handles.status.String = '';pause(0.001);

handles.autoWB.Enable = 'On';
handles.manualWB.Enable = 'On';
handles.save.Enable = 'On';
handles.undo.Enable = 'Off';
 handles.undo.String = 'Undo';

% --- Executes on button press in autoWB.
function autoWB_Callback(hObject, eventdata, handles)
global I temp
global model

handles.status.String = 'White balancing...';pause(0.001);

sz = size(I);
ill = illumgray(I); ill = ill./norm(ill);
D = ill(2)./ill;
if ill(1) == 0 || ill(2) == 0 || ill(3) == 0
    ill = [1 1 1];
end
d = pdist2(ill,model.C,'cosine');
[~,cids] = sort(d); cid = cids(1);
M = reshape(D * reshape(model.B(cid,:),[3,33]),[11,3]);
temp = I;
[I,ingamut]= out_of_gamut_clipping(...
reshape(PHI(reshape(I,[],3)) * M,[sz(1),sz(2),sz(3)]));
if sum(ingamut(:)) < 0.4 * size(I,1) * size(I,2)
    I = temp;
end
axes(handles.image);
imshow(I);

handles.undo.Enable = 'On';
   
handles.status.String = '';pause(0.001);


% --- Executes on button press in manualWB.
function manualWB_Callback(hObject, eventdata, handles)

global I temp
global model
handles.status.String = 'Select achromatic point, then press enter';pause(0.001);

sz = size(I);
ill = impixel;

handles.status.String = 'White balancing...';pause(0.001);

ill = ill./norm(ill);
if ill(1) == 0 || ill(2) == 0 || ill(3) == 0
    ill = [1 1 1];
end 
D = ill(2)./ill;
d = pdist2(ill,model.C,'cosine');
[~,cids] = sort(d); cid = cids(1);
M = reshape(D * reshape(model.B(cid,:),[3,33]),[11,3]);
temp = I;

[I,ingamut] = out_of_gamut_clipping(...
reshape(PHI(reshape(I,[],3)) * M,[sz(1),sz(2),sz(3)]));

if sum(ingamut(:)) < 0.4 * size(I,1) * size(I,2)
    I = temp;
end

axes(handles.image);
imshow(I);

handles.undo.Enable = 'On';

handles.status.String = '';pause(0.001);


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)

global Path_Name
global File_Name
global I
[~,name,ext] = fileparts(File_Name);
outFile_Name = [name '_WB' ext];
[file,path,~] = uiputfile({'*.jpg';'*.png';'*.jpeg';'*.*'},'Save Image',fullfile(Path_Name,outFile_Name));
if file ~=0
    handles.status.String = 'Processing...';pause(0.001);
    imwrite(I, fullfile(path,file));
    handles.status.String = 'Done!';
    pause(0.01); handles.status.String = '';
end

function status_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)

global I temp

if strcmp(handles.undo.String,'Undo')
    handles.undo.String = 'Redo';
else
    handles.undo.String = 'Undo';
end
handles.status.String = 'Processing...';pause(0.001);
I = temp + I;
temp = I - temp;
I = I - temp;
axes(handles.image);
imshow(I);
handles.status.String = '';pause(0.001);
