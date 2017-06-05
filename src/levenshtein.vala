namespace OG {
	public static int levenshtein_distance (string s, string t, bool case_sensitive = false) {
		var n = s.length;
		var m = t.length;
		var d = new int[n + 1, m + 1];
		var s_norm = s;
		var t_norm = t;
		if (case_sensitive == false) {
			s_norm = s.down ();
			t_norm = t.down ();
		}
		if (n == 0) {
			return m;
		}
		if (m == 0) {
			return n;
		}
		for (var i = 0; i <= n; d[i, 0] = i++) {}
		for (var j = 0; j <= m; d[0, j] = j++) {}
		for (var i = 1; i <= n; i++) {
			for (var j = 1; j <= m; j++) {
				var cost = (t_norm[j - 1] == s_norm[i - 1]) ? 0 : 1;
				d[i, j] = int.min (int.min (d[i - 1, j] + 1, d[i, j - 1] + 1), d[i - 1, j - 1] + cost);
			}
		}
		return d[n, m];
	}
}
