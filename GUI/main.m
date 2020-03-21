function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 24-Sep-2019 11:48:08

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global model

load(fullfile('..','models','model.mat'));

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
% hObject    handle to autoWB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
% hObject    handle to manualWB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of status as text
%        str2double(get(hObject,'String')) returns contents of status as a double


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
