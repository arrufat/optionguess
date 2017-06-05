project('Option Guess', ['vala', 'c'],
    default_options: ['buildtype=release', 'default_library=shared'],
    version: '0.1.0')

glib = dependency('glib-2.0')
gobject = dependency('gobject-2.0')

deps = [glib, gobject]

srcs = ['src/levenshtein.vala', 'src/optionguess.vala', 'src/termcolors.vala']

liboptionguess = library('optionguess',
    sources: srcs,
    dependencies: deps,
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
    name: 'optionguesser',
    description: 'Guess the closest command line option',
    )

if get_option('enable-examples')
    options_ex = executable('options_ex',
        sources: ['examples/options_ex.vala', srcs],
        dependencies: deps,
        install: false)
endif
