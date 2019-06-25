function varargout = Tampilan(varargin)
% TAMPILAN MATLAB code for Tampilan.fig
%      TAMPILAN, by itself, creates a new TAMPILAN or raises the existing
%      singleton*.
%
%      H = TAMPILAN returns the handle to a new TAMPILAN or the handle to
%      the existing singleton*.
%
%      TAMPILAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TAMPILAN.M with the given input arguments.
%
%      TAMPILAN('Property','Value',...) creates a new TAMPILAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tampilan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tampilan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tampilan

% Last Modified by GUIDE v2.5 24-Jun-2019 19:07:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tampilan_OpeningFcn, ...
                   'gui_OutputFcn',  @Tampilan_OutputFcn, ...
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


% --- Executes just before Tampilan is made visible.
function Tampilan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tampilan (see VARARGIN)

% Choose default command line output for Tampilan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tampilan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tampilan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

[namafile, formatfile] = uigetfile({'*.jpg'}, 'membuka gambar'); %memilih gambar
image = imread([formatfile, namafile]); %membaca gambar
x=[];
y=[];

guidata(hObject, handles);
axes(handles.axes1); %memilih axes1 sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar

BW=im2bw(image); %preprocessing

%%Pengambilan Fitur
verticalProfile = sum(BW, 2); %fitur 1
horizontalProfile = sum(BW, 1); %fitur 2
meanV=mean(mean(verticalProfile)); %fitur 1
meanH=mean(mean(horizontalProfile)); %fitur 2

x=[x;meanV];
x2=transpose(x);
y=[y;meanH];
y2=transpose(y);

input=[x2;y2]; %input pada jst 

load 'D:\Aldian\Irwandani\net.mat'
output = round(sim(net,input))

if (output==1)
    x='A'
    set(handles.edit2,'string',x)
end

if (output==2)
    x2='I'
    set(handles.edit2,'string',x2)
end

if (output==3)
    x3='U'
    set(handles.edit2,'string',x3)
end
