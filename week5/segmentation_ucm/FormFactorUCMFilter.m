function ok = FormFactorFilter (candidate, thr_max, thr_min)
% Check if candidate form factor is between limits
% Usage: ok = FormFactor_Filter (candidate, thr_max, thr_min)
%
% INPUT:
%    candidate     : region to be checked
%    thr_max : maximum form factor
%    thr_min : minimum form factor
% OUPUT
%    ok : 1 if candidate is valid, 0 if not

candFF = candidate.bBox.Width/candidate.bBox.Height;

if candFF < thr_min || candFF > thr_max  
  ok = false;  
else
  ok = true;
end