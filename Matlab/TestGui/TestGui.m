function varargout = TestGui(varargin)
%TESTGUI MATLAB code file for TestGui.fig
%      TESTGUI, by itself, creates a new TESTGUI or raises the existing
%      singleton*.
%
%      H = TESTGUI returns the handle to a new TESTGUI or the handle to
%      the existing singleton*.
%
%      TESTGUI('Property','Value',...) creates a new TESTGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to TestGui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TESTGUI('CALLBACK') and TESTGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TESTGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestGui

% Last Modified by GUIDE v2.5 29-Jun-2017 08:44:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestGui_OpeningFcn, ...
                   'gui_OutputFcn',  @TestGui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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
end

% --- Executes just before TestGui is made visible.
function TestGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for TestGui
handles.output = hObject;
movegui(hObject, 'northwest')
handles.testRunner = TestRunner(hObject);
% handles.els{1} = addlistener(handles.testRunner,'stopEvent', @pushbutton1_Callback);
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes TestGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = TestGui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;
end
