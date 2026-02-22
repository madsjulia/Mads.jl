(function () {
	"use strict";

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

		document.body.appendChild(a);
	}

	if (document.readyState === "loading") {
		document.addEventListener("DOMContentLoaded", ensureHelpButton);
	} else {
		ensureHelpButton();
	}
})();
