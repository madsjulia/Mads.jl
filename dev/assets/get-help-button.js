(function () {
	"use strict";

	var HELP_IDS = ["Getting-help", "Getting-help-1"];

	function findFirstExistingId(ids) {
		for (var i = 0; i < ids.length; i++) {
			var el = document.getElementById(ids[i]);
			if (el) return ids[i];
		}
		return null;
	}

	function scrollToId(id) {
		var el = document.getElementById(id);
		if (!el) return false;
		try {
			el.scrollIntoView({ block: "start" });
		} catch (e) {
			el.scrollIntoView(true);
		}
		return true;
	}

	function resyncHashScroll() {
		if (!document || !document.body) return;
		if (!window.location || !window.location.hash) return;
		var hash = window.location.hash.replace(/^#/, "");
		if (!hash) return;

		// Only force-scroll for our known section(s), so we don't fight Documenter.
		if (hash === "Getting-help" || hash === "Getting-help-1") {
			// Documenter may adjust layout/scroll after DOMContentLoaded; retry a few times.
			window.setTimeout(function () { scrollToId(hash); }, 0);
			window.setTimeout(function () { scrollToId(hash); }, 100);
			window.setTimeout(function () { scrollToId(hash); }, 400);
		}
	}

	function findVersionRootPathname() {
		// Examples:
		//   /Mads.jl/dev/Functions.html
		//   /Mads.jl/stable/index.html
		//   /Mads.jl/v1.4.3/Examples/Examples.html
		var parts = window.location.pathname.split("/");
		var versionIndex = -1;
		for (var i = 0; i < parts.length; i++) {
			var p = parts[i];
			if (p === "dev" || p === "stable" || /^v\d/.test(p)) {
				versionIndex = i;
				break;
			}
		}
		if (versionIndex === -1) {
			// Fallback: assume the docs root is the directory containing the page.
			return parts.slice(0, Math.max(1, parts.length - 1)).join("/") || "/";
		}
		return parts.slice(0, versionIndex + 1).join("/") || "/";
	}

	function ensureHelpButton() {
		if (!document || !document.body) return;
		if (document.querySelector("a.docs-help-fab")) return;

		var versionRoot = findVersionRootPathname();
		// Documenter keeps capitalization in heading ids (e.g. "Getting-help").
		var helpUrl = versionRoot.replace(/\/$/, "") + "/index.html#Getting-help";

		var a = document.createElement("a");
		a.className = "button is-success is-rounded docs-help-fab";
		a.href = helpUrl;
		a.setAttribute("aria-label", "Get help");
		a.setAttribute("title", "Get help");
		a.textContent = "Get help";

		// Inline positioning so it stays on the right even if CSS is overridden
		// or a stale build is missing the stylesheet.
		a.style.position = "fixed";
		// Negative right value intentionally creates the "clipped" edge look.
		a.style.right = "-1rem";
		a.style.left = "auto";
		a.style.bottom = "1rem";
		a.style.zIndex = "1000";

		a.addEventListener("click", function (ev) {
			// If we're already on index.html, a normal anchor navigation may not scroll
			// (e.g. hash already set). Force it.
			var pathname = window.location && window.location.pathname ? window.location.pathname : "";
			var onIndex = /\/index\.html$/.test(pathname) || /\/(dev|stable|v\d[^\/]*)\/?$/.test(pathname);
			if (!onIndex) return;

			var id = findFirstExistingId(HELP_IDS) || "Getting-help";
			ev.preventDefault();
			if (window.location.hash !== "#" + id) {
				window.location.hash = "#" + id;
			}
			scrollToId(id);
		});

		document.body.appendChild(a);
	}

	if (document.readyState === "loading") {
		document.addEventListener("DOMContentLoaded", ensureHelpButton);
		document.addEventListener("DOMContentLoaded", resyncHashScroll);
	} else {
		ensureHelpButton();
		resyncHashScroll();
	}
})();
