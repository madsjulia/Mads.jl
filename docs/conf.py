import os
on_rtd = os.environ.get('READTHEDOCS') == 'True'
if on_rtd:
    html_theme = 'mkdocs-material'
else:
    html_theme = 'mkdocs-material'