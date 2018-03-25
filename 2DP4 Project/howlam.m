function varargout = moshiur(varargin)
% MOSHIUR MATLAB code for moshiur.fig
%      MOSHIUR, by itself, creates a new MOSHIUR or raises the existing
%      singleton*.
%
%      H = MOSHIUR returns the handle to a new MOSHIUR or the handle to
%      the existing singleton*.
%
%      MOSHIUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSHIUR.M with the given input arguments.
%
%      MOSHIUR('Property','Value',...) creates a new MOSHIUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before moshiur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to moshiur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help moshiur

% Last Modified by GUIDE v2.5 08-Apr-2015 14:14:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @moshiur_OpeningFcn, ...
                   'gui_OutputFcn',  @moshiur_OutputFcn, ...
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


% --- Executes just before moshiur is made visible.
function moshiur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to moshiur (see VARARGIN)

% Choose default command line output for moshiur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes moshiur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = moshiur_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

delete(instrfindall);
    
    data = serial('COM3'); %COM6 port on laptop
    data.BaudRate = 9600; %BaudRate
    data.Terminator = 'CR'; %terminator
    fopen(data);
    plot1 = plot(nan);
    hold on
    test = 1;
    numberofPoints = 0;
    resol = 10;
    tic; %Start

    while test ==  1
        numberofPoints = numberofPoints + 1;
        yVal(numberofPoints) = (5/(2^resol))*(str2double(fgets(data))); %step size, 5 is max voltage
        xVal(numberofPoints) = toc; %time value, time elapsed
        if mod(numberofPoints,10) == 0
            set(plot1,'YData',yVal,'XData',xVal);
            title('Output')
            ylabel('Voltage (V)')
            xlabel('Time(s)')
            axis([xVal(numberofPoints)-2 xVal(numberofPoints) 0 5]);
            pause(1e-16);
        end 
    end
    hold off
    fclose(data);
    delete (data);
    clear('data');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(instrfindall);
    
    data = serial('COM3'); %COM6 port on laptop
    data.BaudRate = 9600; %BaudRate
    data.Terminator = 'CR'; %terminator
    fopen(data);
    plot1 = plot(nan);
    hold on
    test = 1;
    numberofPoints = 0;
    resol = 10;
    tic; %Start

    while test ==  1
        numberofPoints = numberofPoints + 1;
        yVal(numberofPoints) = (5/(2^resol))*(str2double(fgets(data))); %step size, 5 is max voltage
        xVal(numberofPoints) = toc; %time value, time elapsed
        if mod(numberofPoints,10) == 0
            set(plot1,'YData',yVal,'XData',xVal);
            title('Output')
            ylabel('Voltage (V)')
            xlabel('Time(s)')
            axis([xVal(numberofPoints)-2 xVal(numberofPoints) 3 4]);
            pause(1e-16);
        end 
    end
    hold off
    fclose(data);
    delete (data);
    clear('data');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(instrfindall);
fclose(data);
delete (data);
clear('data');