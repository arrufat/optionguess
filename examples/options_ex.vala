// sources: src/optionguess.vala

using GLib;
using OG;

public const string version = "0.1.0";

public class Main : Object {
	private static bool display_version = false;
	private static int test = 0;
	private static bool fast = false;
	private static bool slow = false;
	private static string file = "";

	private const OptionEntry[] options = {
		{ "version", 0, 0, OptionArg.NONE, ref display_version, "Display version number", null },
		{ "int", 'i', 0, OptionArg.INT, ref test, "Parse an integer", "INT" },
		{ "file", 'n', 0, OptionArg.FILENAME, ref file, "Parse a file name", "FILENAME" },
		{ "fast", 'f', 0, OptionArg.NONE, ref fast, "Set fast mode", null },
		{ "slow", 's', 0, OptionArg.NONE, ref slow, "Set slow mode", null },
		{ null } // list terminator
	};

	public static int main (string[] args) {

		var args_length = args.length;
		string help;
		/* parse the command line */
		try {
			var opt_context = new OptionContext ("-  application description");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
			help = opt_context.get_help (true, null);
		} catch (OptionError e) {
			var opt_guess = new OptionGuess (options, e);
			opt_guess.print_message ();
			return 0;
		}

		/* display help if no arguments are passed */
		if (args_length == 1) {
			print (help + "\n");
			return 0;
		}

		if (display_version) {
			print ("%s - %s\n", args[0], version);
			return 0;
		}

		return 0;
	}
}
