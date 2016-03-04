#!/usr/bin/python

import os, sys, scss;

vars = {};
opts = {'debug_info': False};
base = '';

for f in sys.argv:
    if f == '-c':
        opts['style'] = 'compressed';
    if f == '-d':
        opts['debug_info'] = True;
    if os.path.isdir(f):
        base = f;
if not base:
    print 'Valid directory required.';
    exit();

compiler = scss.Scss(
    scss_vars = vars,
    scss_opts = opts
);

print 'Compiling stylesheets';
for root, dirs, files in os.walk(base):
    for file in files:
        if file.endswith('.scss'):
            name = os.path.splitext(file)[0];
            
            scss_file = os.path.join(root, file);
            scss_mtime = os.path.getmtime(scss_file);
            
            css_file = os.path.join(root, name + '.css');
            css_mtime = 0.0;
            if os.path.isfile(css_file) == True:
                css_mtime = os.path.getmtime(css_file);
            
            modified = True if scss_mtime > css_mtime else False;
            if modified:
                f = open(css_file, 'w');
                try:
                    compiled = compiler.compile(scss_file = scss_file);
                    f.write(compiled);
                    print '- Successfully compiled {0}.'.format(scss_file);
                except scss.errors.SassError as e:
                    f.write(str(e));
                    print '- Could not compile {0} - see {1} for more details.'.format(scss_file, css_file);
                except ValueError:
                    f.write(str(ValueError));
                    print '- Warning in {0} - see {1} for more details.'.format(scss_file, css_file);
                f.close();
            else:
                print '- Skipped {0} - up to date.'.format(scss_file);
print 'Done';