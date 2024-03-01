function varargout = BrainTumorGUI(varargin)
% BRAINTUMORGUI MATLAB code for BrainTumorGUI.fig
%      BRAINTUMORGUI, by itself, creates a new BRAINTUMORGUI or raises the existing
%      singleton*.
%
%      H = BRAINTUMORGUI returns the handle to a new BRAINTUMORGUI or the handle to
%      the existing singleton*.
%
%      BRAINTUMORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAINTUMORGUI.M with the given input arguments.
%
%      BRAINTUMORGUI('Property','Value',...) creates a new BRAINTUMORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BrainTumorGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BrainTumorGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BrainTumorGUI

% Last Modified by GUIDE v2.5 10-Dec-2023 00:45:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BrainTumorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BrainTumorGUI_OutputFcn, ...
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

% --- Executes just before BrainTumorGUI is made visible.
function BrainTumorGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BrainTumorGUI (see VARARGIN)

% Choose default command line output for BrainTumorGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BrainTumorGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = BrainTumorGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load_image_button.
function load_image_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_image_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load image using uigetfile
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp;*.tif', 'Image Files'}, 'Select an Image File');
if isequal(filename,0) || isequal(pathname,0)
    % User pressed cancel or closed the dialog
    return;
end

% Read the image
fullpath = fullfile(pathname, filename);
handles.image = imread(fullpath);

% Display the image
axes(handles.image_axes);
imshow(handles.image);
title('Input Image');

% Save handles structure
guidata(hObject, handles);

% --- Executes on button press in detect_tumor_button.
function detect_tumor_button_Callback(hObject, eventdata, handles)
% hObject    handle to detect_tumor_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if image is loaded
if ~isfield(handles, 'image')
    msgbox('Please load an image first.', 'Error', 'error');
    return;
end

% Call your tumor detection function (modify this function as per your implementation)
result = detectTumor(handles.image);

% Display the result
axes(handles.result_axes);
imshow(result);
title('Detected Tumor');

% ... (Add any additional processing or analysis here)

% Save handles structure
guidata(hObject, handles);
