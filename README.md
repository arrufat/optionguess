# Option Guess

Option Guess is a library that hooks on the [GLib.OptionEntry][optionentry] and displays colourful messages.

Moreover, if the user has specified an incorrect option, it will suggest the closest option available.
I have wanted this feature since I saw the amazing command line parser for [Rust][rust], [clap][clap].

To use it, simply add this lines when catching the error from [OptionEntry][optionentry]:

``` vala
...
} catch (OptionError e) {
	var opt_guess = new OptionGuess (options, e);
	opt_guess.print_message ();
	return 0;
}
...
```

where `options` is an `OptionEntry[]`, declared somewhere above this snippet of code.

You can play with the provided example:

``` bash
meson build -Dwith-examples=true
ninja -C build
./build/options_ex --help    # correct
./build/options_ex --hlp     # incorrect, will show suggestion
./build/options_ex --int 10  # correct
./build/options_ex --int i2  # incorrect, will display error
```

[optionentry]:https://valadoc.org/glib-2.0/GLib.OptionEntry.html
[rust]:https://www.rust-lang.org/
[clap]:https://clap.rs/
