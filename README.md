# Option Guess

Option Guess is a library that hooks on the [GLib.OptionEntry][optionentry] and displays colourful messages.

Moreover, if the user has specified an incorrect option, it will suggest the closest option available.

To use it, simply add this lines when catching the error from [OptionEntry]:

``` vala
...
} catch (OptionError e) {
	var opt_guess = new OptionGuess (options, e);
	opt_guess.print_message ();
	return 0;
}
...
```
where `options` is an OptionEntry[]`, declared somewhere above this snippet of code.

[optionentry]:https://valadoc.org/glib-2.0/GLib.OptionEntry.html
