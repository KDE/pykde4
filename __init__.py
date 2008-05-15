import sys, dl
# This is needed to ensure that dynamic_cast and RTTI works inside kdelibs.
sys.setdlopenflags(dl.RTLD_NOW|dl.RTLD_GLOBAL)
