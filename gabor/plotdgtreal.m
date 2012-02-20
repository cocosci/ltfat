function plotdgtreal(coef,a,M,varargin)
%PLOTDGTREAL  Plot DGTREAL coefficients
%   Usage: plotdgtreal(coef,a,M);
%          plotdgtreal(coef,a,M,fs);
%          plotdgtreal(coef,a,M,fs,dynrange);
%
%   `plotdgtreal(coef,a,M)` plots Gabor coefficient from |dgtreal|_. The
%   parameters *a* and *M* must match those from the call to |dgtreal|_.
%
%   `plotdgtreal(coef,a,M,fs)` does the same assuming a sampling rate of *fs*
%   Hz of the original signal.
%
%   `plotdgtreal(coef,a,M,fs,dynrange)` additionally limits the dynamic
%   range.
%   
%   `plotdgtreal` supports all the optional parameters of |tfplot|_. Please
%   see the help of |tfplot|_ for an exhaustive list.
%
%   See also:  dgtreal, tfplot, sgram, plotdgt

%   AUTHOR : Peter Soendergaard.
%   TESTING: NA
%   REFERENCE: NA

if nargin<3
  error('%s: Too few input parameters.',upper(mfilename));
end;

definput.import={'ltfattranslate','tfplot'};

[flags,kv,fs]=ltfatarghelper({'fs','dynrange'},definput,varargin);

if rem(M,2)==0
  yr=[0,1];
else
  yr=[0,1-2/M];
end;

tfplot(coef,a,yr,'argimport',flags,kv);

