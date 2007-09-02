print "\nTesting PyKDE module imports\n"
try:
    import PyKDE4.pykdeconfig
except:
    print "Can't find PyKDE4.pykdeconfig.py - please check installation"
    raise    

pykdecfg = PyKDE4.pykdeconfig.Configuration ()

print "Modules built:"
print " ",pykdecfg.pykde_modules
print
print "Importing:"
print

for mod in pykdecfg.pykde_modules.split():
    print mod
    exec ("import PyKDE4." + mod)

print
