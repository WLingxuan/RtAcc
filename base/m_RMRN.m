function [RMh, clRNh, RNh] = m_RMRN(pos)
% Just for fast calculation(batch processing) if input pos 
% is a postion vector.
%
% See also  earth, pos2dxyz.

% Copyright(c) 2009-2014, by Gongmin Yan, All rights reserved.
% Northwestern Polytechnical University, Xi An, P.R.China
% 15/03/2014
global m_glv
	sl=sin(pos(:,1)); cl=cos(pos(:,1)); sl2=sl.*sl;
	sq = 1-m_glv.e2*sl2; sq2 = sqrt(sq);
	RMh = m_glv.Re*(1-m_glv.e2)./sq./sq2+pos(:,3);
	RNh = m_glv.Re./sq2+pos(:,3);    
    clRNh = cl.*RNh;
