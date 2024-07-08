Project Segway
This README contains information about the Segway project along with the necessary files and instructions to install and use it.
Contents
Project introduction
prerequisites
Installation
Use
Folder structure
participation
license
Project introduction
The Segway project contains MATLAB code for modeling, simulating and controlling a Segway system. This project is presented in three main sections including codes, report and slides.

prerequisites
You need MATLAB software to run this project. Make sure that the version of MATLAB you are using supports the functions and tools needed for this project.

Installation
First, download or clone the project files from the GitHub repository.
Add the project folder to the MATLAB working path.
git clone https://github.com/username/repository.git
cd repository

Use
examples
To run any of the MATLAB files, you can use the following commands. For example, to run the sustainability.m file:
run('2-Code/4/sustainability.m')

Description of the codes
sustainability.m: Contains the codes related to system sustainability.
realization.m: including codes related to system implementation.
conversion_function.m: Contains conversion functions required for the system.
LQR.m: Contains codes related to linear optimal control (LQR).
PID.m: Contains codes related to PID control.
Mode_feedback.m: Contains codes related to mode feedback.
Jordan_form.m: Contains codes related to Jordan's form.
visibility.m: Contains the codes related to visibility.
control-ability.m: Contains controllability codes.
Full_rank_viewer.m: Contains the codes related to displaying the full rank matrix.
State_transition_matrix.m: Contains the codes related to the state transition matrix.
System_response.m: Contains codes related to system response.
ZahraArabi40007173_MC4022Prj/
│
├── 1-Report/
│   └── ZahraArabi_40007173_Project.pdf
│
├── 2-Code/
│   ├── 2/
│   │   ├── State_transition_matrix.m
│   │   └── System_response.m
│   ├── 3/
│   │   ├── Jordan_form.m
│   │   ├── visibility.m
│   │   └── control-ability.m
│   ├── 4/
│   │   ├── sustainability.m
│   │   ├── realization.m
│   │   └── conversion_function.m
│   ├── 5/
│   │   ├── LQR.m
│   │   ├── PID.m
│   │   └── Mode_feedback.m
│   └── 6/
│       ├── Full_rank_viewer.m
│       └── Full_rank_viewer - Copy.m
│
└── 3-Slides/
    └── ZahraArabi40007173.pdf
participation
To participate in this project, follow the steps below:

Fork this repository.
Create a new branch (git checkout -b feature/AmazingFeature).
Commit your changes (git commit -m 'Add some AmazingFeature').
Push to the origin branch (git push origin feature/AmazingFeature).
Create a Pull Request.
Thank you for using the Segway Project! If you have any questions or need help, please contact me. ​
