function ok = Area_Filter (candidate, thr_max, thr_min)
% Check if candidate area is between limits
% Usage: ok = Area_Filter (candidate, thr_max, thr_min)
%
% INPUT:
%    candidate     : region to be checked
%    thr_max : maximum area
%    thr_min : minimum area
% OUPUT
%    ok : 1 if candidate is valid, 0 if not

candArea = candidate.height * candidate.width;

if candArea < thr_min | candArea > thr_max  
  ok = false;  
else
  ok = true;
end