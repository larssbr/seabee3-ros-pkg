function varargout = sonarSimulatorGui(varargin)
% SONARSIMULATORGUI MATLAB code for sonarSimulatorGui.fig
%      SONARSIMULATORGUI, by itself, creates a new SONARSIMULATORGUI or raises the existing
%      singleton*.
%
%      H = SONARSIMULATORGUI returns the handle to a new SONARSIMULATORGUI or the handle to
%      the existing singleton*.
%
%      SONARSIMULATORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SONARSIMULATORGUI.M with the given input arguments.
%
%      SONARSIMULATORGUI('Property','Value',...) creates a new SONARSIMULATORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sonarSimulatorGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sonarSimulatorGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sonarSimulatorGui

% Last Modified by GUIDE v2.5 27-Sep-2012 00:39:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sonarSimulatorGui_OpeningFcn, ...
                   'gui_OutputFcn',  @sonarSimulatorGui_OutputFcn, ...
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

% --- Executes just before sonarSimulatorGui is made visible.
function sonarSimulatorGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sonarSimulatorGui (see VARARGIN)

% Choose default command line output for sonarSimulatorGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Set up everything
initialize_gui(hObject, handles);

% UIWAIT makes sonarSimulatorGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sonarSimulatorGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function initialize_gui(hObject, handles)
% initializes all of the gui fields with science
    
% Possible pinger frequencies in hertz
available_pinger_frequency = [22000;23000;24000;25000;26000;27000;28000;29000;30000];

% Pinger frequency in use
pinger_frequency = available_pinger_frequency(1);

% Highest possible pinger frequency, used for hydrophone spacing
max_frequency = available_pinger_frequency(length(available_pinger_frequency));

% Sample rate in Hz
sample_frequency = 100000;

% Set arbitrary water temperature of 90F
water_temp = 90;

min_water_temp = 32;

% Get velocity of the pinger signal
handles.water_velocity = waterVelocityLookup(water_temp);

% Set hydrophone array side length to half wavelength of max pinger freq.
handles.hydrophone_spacing = waterVelocityLookup(min_water_temp)/max_frequency/2;

% Allowable error in cone intersection
intersection_sigma = 2;

% Max distance to a point in the pool
pool_size = 10;

% Size of the pinger in ft
pinger_radius = 1;

% Arbitrary pinger location.
phi= pi/2;
theta = pi/2;
rho = 10;

% Populate UI fields
set(handles.waterTempEdit, 'String', water_temp);
set(handles.poolSizeEdit, 'String', pool_size);
set(handles.pingerRhoEdit, 'String', rho);
set(handles.pingerPhiEdit, 'String', phi*180/pi);
set(handles.pingerThetaEdit, 'String', theta*180/pi);
set(handles.intersectionSigmaEdit, 'String', intersection_sigma);
set(handles.sampleRateEdit, 'String', sample_frequency/1000);


pinger_frequency_label = cell(1, length(available_pinger_frequency));

% Generate listbox labels
for i = 1:length(available_pinger_frequency)
    pinger_frequency_label{i} = sprintf('%d kHz', available_pinger_frequency(i)/1000);
end
set(handles.pingerFrequencyListBox, 'String', pinger_frequency_label);
guidata(handles.output, handles);


% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.conePlotAxes);
cla;

fprintf('Got button press\n');

% Run the simulation
simulateSonarGui(handles);




% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)

% --- Executes on selection change in pingerFrequencyListBox.
function pingerFrequencyListBox_Callback(hObject, eventdata, handles)
% hObject    handle to pingerFrequencyListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pingerFrequencyListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pingerFrequencyListBox


% --- Executes during object creation, after setting all properties.
function pingerFrequencyListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingerFrequencyListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% Possible pinger frequencies in hertz
%handles.output = hObject;


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function waterTempEdit_Callback(hObject, eventdata, handles)
% hObject    handle to waterTempEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of waterTempEdit as text
%        str2double(get(hObject,'String')) returns contents of waterTempEdit as a double


% --- Executes during object creation, after setting all properties.
function waterTempEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to waterTempEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poolSizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to poolSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poolSizeEdit as text
%        str2double(get(hObject,'String')) returns contents of poolSizeEdit as a double


% --- Executes during object creation, after setting all properties.
function poolSizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poolSizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pingerRhoEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pingerRhoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pingerRhoEdit as text
%        str2double(get(hObject,'String')) returns contents of pingerRhoEdit as a double


% --- Executes during object creation, after setting all properties.
function pingerRhoEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingerRhoEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pingerPhiEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pingerPhiEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pingerPhiEdit as text
%        str2double(get(hObject,'String')) returns contents of pingerPhiEdit as a double


% --- Executes during object creation, after setting all properties.
function pingerPhiEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingerPhiEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pingerThetaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pingerThetaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pingerThetaEdit as text
%        str2double(get(hObject,'String')) returns contents of pingerThetaEdit as a double


% --- Executes during object creation, after setting all properties.
function pingerThetaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingerThetaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intersectionSigmaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to intersectionSigmaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intersectionSigmaEdit as text
%        str2double(get(hObject,'String')) returns contents of intersectionSigmaEdit as a double


% --- Executes during object creation, after setting all properties.
function intersectionSigmaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intersectionSigmaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampleRateEdit_Callback(hObject, eventdata, handles)
% hObject    handle to sampleRateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampleRateEdit as text
%        str2double(get(hObject,'String')) returns contents of sampleRateEdit as a double


% --- Executes during object creation, after setting all properties.
function sampleRateEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampleRateEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pingerPeriodEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pingerPeriodEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pingerPeriodEdit as text
%        str2double(get(hObject,'String')) returns contents of pingerPeriodEdit as a double


% --- Executes during object creation, after setting all properties.
function pingerPeriodEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingerPeriodEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
