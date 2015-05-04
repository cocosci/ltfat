function h=pconv(f,g,varargin)
%PCONV  Periodic convolution
%   Usage:  h=pconv(f,g)
%           h=pconv(f,g, ftype); 
%
%   `pconv(f,g)` computes the periodic convolution of *f* and *g*. The convolution
%   is given by
%
%   ..          L-1
%      h(l+1) = sum f(k+1) * g(l-k+1)
%               k=0
%
%   .. math:: h\left(l+1\right)=\sum_{k=0}^{L-1}f\left(k+1\right)g\left(l-k+1\right)
% 
%   `pconv(f,g,'r')` computes the convolution where *g* is reversed
%   (involuted) given by
%
%   ..          L-1
%      h(l+1) = sum f(k+1) * conj(g(k-l+1))
%               k=0
%
%   .. math:: h\left(l+1\right)=\sum_{k=0}^{L-1}f\left(k+1\right)\overline{g\left(k-l+1\right)}
%
%   This type of convolution is also known as cross-correlation.
%
%   `pconv(f,g,'rr')` computes the alternative where both *f* and *g* are
%   reversed given by
%
%   ..          L-1
%      h(l+1) = sum conj(f(-k+1)) * conj(g(k-l+1))
%               k=0
%     
%   .. math:: h\left(l+1\right)=\sum_{k=0}^{L-1}f\left(-k+1\right)g\left(l-k+1\right)
%
%   In the above formulas, $l-k$, $k-l$ and $-k$ are computed modulo $L$.
%
%   See also: dft, involute

%   AUTHOR: Peter L. Søndergaard, Jordy van Velthoven
%   TESTING: TEST_PCONV
%   REFERENCE: REF_PCONV


complainif_notenoughargs(nargin, 2, 'PCONV');

if ~all(size(f)==size(g))
    error('%s: f and g must have the same size.',upper(mfilename));
end;

definput.flags.type={'default','r','rr'};

flags = ltfatarghelper({},definput,varargin);

if isreal(f) && isreal(g)
    fftfunc = @(x) fftreal(x);
    ifftfunc = @(x) ifftreal(x, size(f,1));
else
    fftfunc = @(x) fft(x);
    ifftfunc = @(x) ifft(x);
end;

if flags.do_default
    h=ifftfunc(fftfunc(f).*fftfunc(g));
end;

if flags.do_r
  h=ifftfunc(fftfunc(f).*conj(fftfunc(g)));
end;

if flags.do_rr
  h=ifftfunc(conj(fftfunc(f)).*conj(fftfunc(g)));
end;
