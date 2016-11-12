function ok = FillingRatioFilter (candidate, thr_max, thr_min)
% Check if candidate filling ratio is between limits
% Usage: ok = FillingRatio_Filter (candidate, thr_max, thr_min)
%
% INPUT:
%    candidate     : region to be checked
%    thr_max : maximum filling ratio
%    thr_min : minimum filling ratio
% OUPUT
%    ok : 1 if candidate is valid, 0 if not

candArea = candidate.bBox.Height * candidate.bBox.Width;
candSumWhite = sum(sum(candidate.maskcrop));

candFR = candSumWhite/candArea;

if candFR < thr_min || candFR > thr_max  
  ok = false;  
else
  ok = true;
end