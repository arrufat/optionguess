project('Option Guess', ['vala', 'c'],
    version: '0.1.0')

glib = dependency('glib-2.0')
gobject = dependency('gobject-2.0')

deps = [glib, gobject]

srcs = ['src/levenshtein.vala', 'src/optionguess.vala', 'src/termcolors.vala']

if get_option('shared_lib')
  libtype = 'shared_library'
else
  libtype = 'static_library'
endif

liboptionguess = build_target('optionguess',
    sources: srcs,
    dependencies: deps,
    target_type: libtype,
    vala_header: 'optionguess.h',
    vala_vapi: 'optionguess.vapi',
    install_dir: [true, true, true],
    install: true)

optionguess_dep = declare_dependency(
    include_directories: include_directories('.'),
    link_with: liboptionguess)

pkg = import('pkgconfig')
pkg.generate(
    libraries: liboptionguess,
    version: meson.project_version(),
    name: 'optionguess',
    description: 'Guess the closest command line option')

if get_option('enable_examples')
    options_ex = executable('options_ex',
        sources: ['examples/options_ex.vala', srcs],
        dependencies: deps,
        install: false)
endif
