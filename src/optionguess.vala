// sources: src/levenshtein.vala src/termcolors.vala

using GLib;
using TermColors;

namespace OG {
	public class OptionGuess {
		private string option;
		private OptionEntry[] options;
		private OptionError error;
		private Regex regex_long;
		private Regex regex_short;
		private Regex regex_shorts;
		private Regex regex_quotes;

		public OptionGuess (OptionEntry[] options, OptionError error) {
			this.options = options;
			this.error = error;
			try {
				this.regex_long = new Regex("(--[a-zA-Z0-9_-]+$)");
				this.regex_short = new Regex (" (-[a-zA-Z0-9]$)");
				this.regex_shorts = new Regex (" (-[a-zA-Z0-9]+$)");
				this.regex_quotes = new Regex("(“([a-zA-Z0-9_-]+)”)");
			} catch (RegexError e) {
				stdout.printf (e.message + "\n");
			}
		}

		private List<string> compute_possibilities () {
			var possibilities = new List<string> ();
			MatchInfo match_info = null;
			if (this.error is OptionError.UNKNOWN_OPTION &&
				(regex_long.match (this.error.message, 0, out match_info) ||
				 regex_shorts.match (this.error.message, 0, out match_info))) {

				/* get the passed option */
				this.option = match_info.fetch (1);

				/* append each available option with its distance to the passed option */
				foreach (var o in options) {
					if (o.long_name != null) {
						var ldist = levenshtein_distance (o.long_name, option);
						possibilities.append (o.long_name + " " + ldist.to_string ());
					}
					/* always append help at the end */
					var hdist = levenshtein_distance ("help", option);
					possibilities.append ("help " + hdist.to_string ());
				}

				/* a function to compare strings assuming the second word is an int */
				CompareFunc<string> distcmp = (a, b) => {
					var dist1 = int.parse (a.split (" ")[1]);
					var dist2 = int.parse (b.split (" ")[1]);
					return (int) (dist1 > dist2);
				};

				/* sort the list according to distances */
				possibilities.sort (distcmp);
			}
			return possibilities;
		}

		public void print_message () {
			var possibilities = compute_possibilities ();
			var message = this.error.message;
			MatchInfo match_info;
			MatchInfo quotes_info;
			string match = "";
			if (regex_long.match (message, 0, out match_info)) {
				match = match_info.fetch (1);
			} else if (regex_short.match (message, 0, out match_info)) {
				match = match_info.fetch (1);
			} else if (regex_shorts.match (message, 0, out match_info)) {
				match = match_info.fetch (1);
			}
			if (regex_quotes.match (message, 0, out quotes_info)) {
				var quotes_outer = quotes_info.fetch (1);
				var quotes_inner = quotes_info.fetch (2);
				var parse = quotes_outer.replace (quotes_inner, FCYN + quotes_inner + RESET);
				message = message.replace (quotes_outer, parse);
			}
			message = message.replace (match, "'" + FYEL + match + RESET + "'");
			stdout.printf (FRED + "Error" + RESET + ": %s" + "\n", message);
			if (possibilities.length () > 0) {
				var closest = possibilities.nth_data (0).split(" ")[0];
				if (levenshtein_distance (this.option, closest) < closest.length) {
					stdout.printf ("\tDid you mean " + FGRN + "--" + closest + RESET + "?\n", closest);
				}
			}
			stdout.printf ("\nFor more information try " + FGRN + "--help" + RESET + "\n");
		}
	}
}
