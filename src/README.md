kaldi-dnn/src
=============
.
├── feat
│   ├── feature-spectralband.cc
│   ├── feature-spectralband.h
│   └── Makefile
└── featbin
    ├── compute-spectralband-feats.cc
    └── Makefile

This is the source code of spectralband, a new feature add by Beanocean.
Spectralband is the spectrum that compressed by meled triangular filters, acutally, it is commonly derived as follows(the first 3 steps of mfcc)[1]:
1). Take the Fourier transform of(a windowed excerpt of) a signal.
2). Map the powers of the spectrum obtained above noto the mel scale, using triangular overlapping windows.
3). Take the logs of the powers at each of the mel frequencies.

Reference:
[1] MFCC:http://en.wikipedia.org/wiki/Mel-frequency_cepstrum
