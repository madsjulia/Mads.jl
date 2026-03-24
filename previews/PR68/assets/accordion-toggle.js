// Ensure Documenter sidebar "accordion" items toggle closed when clicking an
// already-open section header.
//
// Documenter renders collapsible menu nodes as:
//   <input id="menuitem-..." class="collapse-toggle" type="checkbox" checked>
//   <label class="tocitem" for="menuitem-..."> ... </label>
//
// Normally the browser toggles the checkbox when clicking the label, but on
// some setups users report that open items don't close when clicking the title.
// This handler makes the toggle explicit.
(function () {
  function setupAccordionToggle() {
    var root = document.getElementById('documenter');
    if (!root) return;

    var labels = root.querySelectorAll('.docs-menu label.tocitem[for]');
    for (var i = 0; i < labels.length; i++) {
      (function (label) {
        label.addEventListener('click', function (ev) {
          var targetId = label.getAttribute('for');
          if (!targetId) return;
          var checkbox = document.getElementById(targetId);
          if (!checkbox) return;
          if (checkbox.type !== 'checkbox') return;

          ev.preventDefault();
          ev.stopPropagation();
          checkbox.checked = !checkbox.checked;
        });
      })(labels[i]);
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', setupAccordionToggle);
  } else {
    setupAccordionToggle();
  }
})();