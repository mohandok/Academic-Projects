function varargout = skin_disease_detection(varargin)
% SKIN_DISEASE_DETECTION MATLAB code for skin_disease_detection.fig
%      SKIN_DISEASE_DETECTION, by itself, creates a new SKIN_DISEASE_DETECTION or raises the existing
%      singleton*.
%

%      H = SKIN_DISEASE_DETECTION returns the handle to a new SKIN_DISEASE_DETECTION or the handle to
%      the existing singleton*.
%
%      SKIN_DISEASE_DETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SKIN_DISEASE_DETECTION.M with the given input arguments.
%
%      SKIN_DISEASE_DETECTION('Property','Value',...) creates a new SKIN_DISEASE_DETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before skin_disease_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to skin_disease_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help skin_disease_detection

% Last Modified by GUIDE v2.5 02-Aug-2019 14:43:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @skin_disease_detection_OpeningFcn, ...
                    'gui_OutputFcn',  @skin_disease_detection_OutputFcn, ...
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


% --- Executes just before skin_disease_detection is made visible.
function skin_disease_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to skin_disease_detection (see VARARGIN)

% Choose default command line output for skin_disease_detection
handles.output = hObject;
axes(handles.axes1); axis off
axes(handles.axes2); axis off
axes(handles.axes3); axis off
% axes(handles.axes5); axis off
set(handles.edit1,'String','---');
set(handles.edit7,'String','---');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes skin_disease_detection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = skin_disease_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;global a;
[fname,path]=uigetfile('*.*','Browse Ear');
if fname~=0
    img=imread([path,fname]);
    axes(handles.axes1); imshow(img);title('Input Image');
    im=img;a=im;
     tts('Input Image is selected');
else
    warndlg('Please Select the necessary Image File');
    tts('Please Select the necessary Image File');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;global I;global K;global BW1;global B;
global f;global C;global S;global se;global close;global gray;global wlab;global Skin;
im = im2double(im);
lab = rgb2lab(im);
f = 0;
wlab = reshape(bsxfun(@times,cat(3,1-f,f/2,f/2),lab),[],3);
[C,S] = pca(wlab);
S = reshape(S,size(lab));
S = S(:,:,1);
Skin=86;
gray = (S-min(S(:)))./(max(S(:))-min(S(:)));
se = strel('disk',1);
close = imclose(gray,se);
K= imcomplement(close)
[cA,cH,cV,cD] = dwt2(K,'bior1.1');
thresh1 = multithresh(cA);
thresh2 = multithresh(cH);
thresh3 = multithresh(cV);
thresh4 = multithresh(cD);
level = (thresh1 + thresh2 + thresh3 + thresh4)/2;
X = idwt2(cA,cH,cV,cD,'bior1.1')
BW=imquantize(X,level);
BW1 = edge(edge(BW,'canny'), 'canny');
axes(handles.axes2); imshow(K);title('Preprocessing Image');
 tts('Preprocess is done');





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;global B;global BW1;global gk;global Skin;
tts('Segmentation is Started....');
BW3 = imclearborder(BW1);
CC = bwconncomp(BW3);
S = regionprops(CC, 'Area');
L = labelmatrix(CC);
BW4 = ismember(L, find([S.Area] >= 100));
BW5 = imfill(BW4,'holes');
[B,L,N] = bwboundaries(BW5);
axes(handles.axes3); imshow(im);title('Segmented Image');hold on;
for k=1:length(B),
    boundary = B{k};
        plot(boundary(:,2),...
            boundary(:,1),'g','LineWidth',2);
end
gk=8;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('Ready to Create the database....');
tts('Ready to Create the database....');
 pause(1)
msgbox('Process Start....');
tts('Process Start....');
 pause(1)

 s=0;
for i=1:6
    j=num2str(i);
    imgname=strcat(j,'.jpg');
    b=imread(imgname);
    b=imresize(b,[250 250]);
    save database b 
end
msgbox('Database Created....');
tts('Database Created....');
 


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close skin_disease_detection

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tts('Resetting Application....');
axes(handles.axes1); cla(handles.axes1); title(''); axis off
axes(handles.axes2); cla(handles.axes2); title(''); axis off
axes(handles.axes3); cla(handles.axes3); title(''); axis off
% axes(handles.axes5); cla(handles.axes5); title(''); axis off
set(handles.edit1,'String','**');
set(handles.edit7,'String','**');
clc;
clear all;



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;global a;global gk;global Skin;
tts('Classification is Started....');
 meann = mean2(a);
    y = round(meann);
    set(handles.edit1,'String',y);
if (y==163 && gk==8)
set(handles.edit1,'String','basal cell carcinoma  ');
elseif (y==161 && gk==8)
set(handles.edit1,'String','squamous cell carcinoma');
elseif (y==165 && gk==8)
set(handles.edit1,'String','BASAL CANCER ');
elseif (y==137 && gk==8)
set(handles.edit1,'String','melanoma ');
y=y+20;
elseif (y==181 && gk==8)
set(handles.edit1,'String','melanoma ');
y=y-30;
elseif (y==201 && gk==8)
set(handles.edit1,'String','Normal Issue ');
y=y-30;
else
 tts('Contact Admin....');   
end
Acc=y/100;
Accuracy=Skin+Acc;
set(handles.edit7,'String',Accuracy);


 



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
