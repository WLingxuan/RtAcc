function glv1 = m_glvf(Re, f, wie)
% PSINS Toolbox global variable structure initialization.
%
% Prototype: glv = glvf(Re, f, wie)
% Inputs: Re - the Earth's semi-major axis
%         f - flattening
%         wie - the Earth's angular rate
% Output: glv1 - output global variable structure array
%
% See also  psinsinit.

% Copyright(c) 2009-2014, by Gongmin Yan, All rights reserved.
% Northwestern Polytechnical University, Xi An, P.R.China
% 14/08/2011, 10/09/2013, 09/03/2014
global m_glv
    if ~exist('Re', 'var'),  Re = [];  end
    if ~exist('f', 'var'),   f = [];  end
    if ~exist('wie', 'var'), wie = [];  end
    if isempty(Re),  Re = 6378137;  end
    if isempty(f),   f = 1/298.257;  end
    if isempty(wie), wie = 7.2921151467e-5;  end
    m_glv.Re = Re;                    % the Earth's semi-major axis
    m_glv.f = f;                      % flattening
    m_glv.Rp = (1-m_glv.f)*m_glv.Re;      % semi-minor axis
    m_glv.e = sqrt(2*m_glv.f-m_glv.f^2); m_glv.e2 = m_glv.e^2; % 1st eccentricity
    m_glv.ep = sqrt(m_glv.Re^2-m_glv.Rp^2)/m_glv.Rp; m_glv.ep2 = m_glv.ep^2; % 2nd eccentricity
    m_glv.wie = wie;                  % the Earth's angular rate
    m_glv.meru = m_glv.wie/1000;        % milli earth rate unit
    m_glv.g0 = 9.7803267714;          % gravitational force
    m_glv.mg = 1.0e-3*m_glv.g0;         % milli g
    m_glv.ug = 1.0e-6*m_glv.g0;         % micro g
    m_glv.mGal = 1.0e-3*0.01;         % milli Gal = 1cm/s^2 ~= 1.0E-6*g0
    m_glv.ugpg2 = m_glv.ug/m_glv.g0^2;    % ug/g^2
    m_glv.ws = 1/sqrt(m_glv.Re/m_glv.g0); % Schuler frequency
    m_glv.ppm = 1.0e-6;               % parts per million
    m_glv.deg = pi/180;               % arcdeg
    m_glv.min = m_glv.deg/60;           % arcmin
    m_glv.sec = m_glv.min/60;           % arcsec
    m_glv.hur = 3600;                 % time hour (1hur=3600second)
    m_glv.dps = pi/180/1;             % arcdeg / second
    m_glv.dph = m_glv.deg/m_glv.hur;      % arcdeg / hour
    m_glv.dpss = m_glv.deg/sqrt(1);     % arcdeg / sqrt(second)
    m_glv.dpsh = m_glv.deg/sqrt(m_glv.hur);  % arcdeg / sqrt(hour)
    m_glv.dphpsh = m_glv.dph/sqrt(m_glv.hur); % (arcdeg/hour) / sqrt(hour)
    m_glv.Hz = 1/1;                   % Hertz
    m_glv.dphpsHz = m_glv.dph/m_glv.Hz;   % (arcdeg/hour) / sqrt(Hz)
    m_glv.ugpsHz = m_glv.ug/sqrt(m_glv.Hz);  % ug / sqrt(Hz)
    m_glv.ugpsh = m_glv.ug/sqrt(m_glv.hur); % ug / sqrt(hour)
    m_glv.mpsh = 1/sqrt(m_glv.hur);     % m / sqrt(hour)
    m_glv.mpspsh = 1/1/sqrt(m_glv.hur); % (m/s) / sqrt(hour), 1*mpspsh~=1700*ugpsHz
    m_glv.ppmpsh = m_glv.ppm/sqrt(m_glv.hur); % ppm / sqrt(hour)
    m_glv.mil = 2*pi/6000;            % mil
    m_glv.nm = 1853;                  % nautical mile
    m_glv.kn = m_glv.nm/m_glv.hur;        % knot
    %%
    m_glv.wm_1 = [0,0,0]; m_glv.vm_1 = [0,0,0];   % the init of previous gyro & acc sample
    m_glv.cs = [                      % coning & sculling compensation coefficients
        [2,    0,    0,    0,    0    ]/3
        [9,    27,   0,    0,    0    ]/20
        [54,   92,   214,  0,    0    ]/105
        [250,  525,  650,  1375, 0    ]/504 
        [2315, 4558, 7296, 7834, 15797]/4620 ];
    m_glv.csmax = size(m_glv.cs,1)+1;  % max subsample number
    m_glv.v0 = [0;0;0];    % 3x1 zero-vector
    m_glv.qI = [1;0;0;0];  % identity quaternion
    m_glv.I33 = eye(3); m_glv.o33 = zeros(3);  % identity & zero 3x3 matrices
    m_glv.pos0 = [34.246048*m_glv.deg; 108.909664*m_glv.deg; 380]; % position of INS Lab@NWPU
    m_glv.eth = []; m_glv.eth = m_earth(m_glv.pos0);
    %%
    %[glv.rootpath, glv.datapath, glv.mytestflag] = psinsenvi;
    glv1 = m_glv;

