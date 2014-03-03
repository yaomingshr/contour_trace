function varargout = MainUI(varargin)
% MAINUI MATLAB code for MainUI.fig
%      MAINUI, by itself, creates a new MAINUI or raises the existing
%      singleton*.
%
%      H = MAINUI returns the handle to a new MAINUI or the handle to
%      the existing singleton*.
%
%      MAINUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINUI.M with the given input arguments.
%
%      MAINUI('Property','Value',...) creates a new MAINUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainUI

% Last Modified by GUIDE v2.5 06-Jun-2013 08:43:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MainUI_OutputFcn, ...
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


% --- Executes just before MainUI is made visible.
function MainUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainUI (see VARARGIN)

% Choose default command line output for MainUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global seedNum;
seedNum = 0;

% UIWAIT makes MainUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_OrgImg.
function pushbutton_OrgImg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OrgImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
strDicom = get(handles.edit_OrgImg,'String');
% strLoc = 'D:\百度云\毕业设计\dicom\';
% strPath = [strLoc strDicom];
strPath = strDicom;
global DCM;
DCM = dicomread(strPath);
figure,imshow(DCM,[]);


% --- Executes on button press in pushbutton_GradImg.
function pushbutton_GradImg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_GradImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DCM;
global res_grad;
global res_grac;
res_grad = grad_magnitude(DCM);
res_grac = grad_magnitudc(DCM);
figure,imshow(res_grad,[]);



function edit_X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X as text
%        str2double(get(hObject,'String')) returns contents of edit_X as a double


% --- Executes during object creation, after setting all properties.
function edit_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Y as text
%        str2double(get(hObject,'String')) returns contents of edit_Y as a double


% --- Executes during object creation, after setting all properties.
function edit_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_AddSeed.
function pushbutton_AddSeed_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_AddSeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seedNum;
global seedX;
global seedY;
seedNum = seedNum + 1;
set(handles.edit_seedNum,'String',seedNum);
seedX(seedNum) = str2double(get(handles.edit_Y,'String'));
seedY(seedNum) = str2double(get(handles.edit_X,'String'));






function edit_OrgImg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OrgImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OrgImg as text
%        str2double(get(hObject,'String')) returns contents of edit_OrgImg as a double


% --- Executes during object creation, after setting all properties.
function edit_OrgImg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OrgImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ConRes.
function pushbutton_ConRes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ConRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global res_grad;
global res_grac;
global res_con;
global seedX;
global seedY;
global seedNum;
global res_consp;
global DCM;
global flag;
res_con = zeros(size(res_grad,1),size(res_grad,2));
flag = false;
for i = 1 : seedNum
    tempseed = [seedX(i) seedY(i)];
    if tempseed(1) == 215 & tempseed(2) == 238
        res_consp = contour_trace(res_grad,tempseed);
        flag = true;
    else
        res_temp = contour_trace(res_grac,tempseed);
        res_con = res_con + res_temp;
    end
end
if flag
    res_c = res_consp + res_con;
else
    res_c = res_con;
end
combineShow(DCM,res_c);
    
        




function edit_CX_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CX as text
%        str2double(get(hObject,'String')) returns contents of edit_CX as a double


% --- Executes during object creation, after setting all properties.
function edit_CX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_CY_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CY as text
%        str2double(get(hObject,'String')) returns contents of edit_CY as a double


% --- Executes during object creation, after setting all properties.
function edit_CY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_PlotS2S.
function pushbutton_PlotS2S_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PlotS2S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DCM;
px = str2double(get(handles.edit_CY,'String'));
py = str2double(get(handles.edit_CX,'String'));
P = [px py];
plot_s2s(DCM,P)


% --- Executes on button press in pushbutton_FinalRes.
function pushbutton_FinalRes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FinalRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q;
global gauSita;
global conSita;
global finalSita;
global res_con;
global res_consp;
global res_grad;
global res_grac;
global res_fsp;
global res_f;
global DCM;
global flag;
r = 0.72;
finalSita = r * q .* gauSita + (1 - r * q) .* conSita;
res_f = edge_detection2(res_grac,res_con,finalSita);
if flag
    res_fsp = edge_detection2(res_grad,res_consp,finalSita);
    %res_fsp = edge_detection(DCM,res_consp,finalSita,sigma);
    res_a = res_fsp + res_f;
else
    res_a = res_f;
end

combineShow(DCM,res_a);


% --- Executes on button press in pushbutton_CorRes.
function pushbutton_CorRes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CorRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q;
global gauSita;
global conSita;
global finalSita;
global res_con;
global res_consp;
global res_grad;
global res_grac;
global res_fsp;
global res_f;
global DCM;
global flag;

r = 0.72;
finalSita = r * q .* gauSita + (1 - r * q) .* conSita;
res_f = edge_detection2(res_grac,res_con,finalSita);
if flag
    res_fsp = edge_detection2(res_grad,res_consp,finalSita);
    %res_fsp = edge_detection(DCM,res_consp,finalSita,sigma);
    res_a = res_fsp + res_f;
else
    res_a = res_f;
end

if flag
    res_cr1 = final_correct(res_grac,res_fsp);
    res_cra = res_cr1 + res_f;
else
    res_cra = final_correct(res_grac,res_f);
end
combineShow(DCM,res_cra);



% --- Executes on button press in pushbutton_GauSita.
function pushbutton_GauSita_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_GauSita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gauSita;
global q;
global DCM;
global sigma;
[gauSita,q,sigma] = myGaussian(DCM);
msgbox('高斯计算完毕!', '完成');



function edit_seedNum_Callback(hObject, eventdata, handles)
% hObject    handle to edit_seedNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_seedNum as text
%        str2double(get(hObject,'String')) returns contents of edit_seedNum as a double


% --- Executes during object creation, after setting all properties.
function edit_seedNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_seedNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ConSita.
function pushbutton_ConSita_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ConSita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global conSita;
global res_con;
global res_consp;
global flag;
if flag
    res_temp = res_con + res_consp;
else
    res_temp = res_con;
end
conSita = contour_sita(res_temp);
msgbox('轮廓跟踪计算完毕!', '完成');


% --- Executes on button press in pushbutton_Clear.
function pushbutton_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global seedNum;
global flag;
set(handles.edit_seedNum,'String','0');
set(handles.edit_X,'String','238');
set(handles.edit_Y,'String','215');
set(handles.edit_CX,'String','238');
set(handles.edit_CY,'String','215');
set(handles.edit_OrgImg,'String','IM144.dcm');
seedNum = 0;
flag = false;


% --- Executes on button press in pushbutton_Canny.
function pushbutton_Canny_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DCM;
bw = edge(DCM,'Canny');
figure,imshow(bw)