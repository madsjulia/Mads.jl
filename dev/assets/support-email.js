(function () {
	"use strict";

	function initObfuscatedEmailLinks() {
		var links = document.querySelectorAll("a.js-obfuscated-email[data-u][data-d]");
		for (var i = 0; i < links.length; i++) {
			( function (a) {
				a.addEventListener("click", function (ev) {
					ev.preventDefault();
					var user = a.getAttribute("data-u") || "";
					var domain = a.getAttribute("data-d") || "";
					if (!user || !domain) return;
					// Build at click time to avoid a plain mailto: in HTML.
					var email = user + "@" + domain;
					window.location.href = "mailto:" + email;
				});
			} )(links[i]);
		}
	}

	if (document.readyState === "loading") {
		document.addEventListener("DOMContentLoaded", initObfuscatedEmailLinks);
	} else {
		initObfuscatedEmailLinks();
	}
})();
