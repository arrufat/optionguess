project('Option Guess', ['vala', 'c'],
    default_options: ['buildtype=release', 'default_library=shared'],
    version: '0.1.0')

if get_option('buildtype') == 'release'
    if meson.get_compiler('c').has_argument('-march=native')
        add_global_arguments('-march=native', language: 'c')
    endif
endif

glib = dependency('glib-2.0')
gobject = dependency('gobject-2.0')

deps = [glib, gobject]

srcs = ['src/levenshtein.vala', 'src/optionguess.vala', 'src/termcolors.vala']

liboptionguesser = library('optionguess',
    sources: srcs,
    dependencies: deps,
    vala_header: 'optionguess.h',
    vala_vapi: 'optionguess.vapi',
    install_dir: [true, true, true],
    install: true)

pkg = import('pkgconfig')
pkg.generate(
    libraries: liboptionguesser,
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
