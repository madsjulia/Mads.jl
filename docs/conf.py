import os
on_rtd = os.environ.get('READTHEDOCS') == 'True'
if on_rtd:
	html_theme = 'material'
	html_context = {                                                             
	'css_files': [                                                           
	'https://media.readthedocs.org/css/sphinx_rtd_theme.css',            
	'https://media.readthedocs.org/css/readthedocs-doc-embed.css',       
	'_static/theme_overrides.css',                                       
	],                                                                       
	}
else:
	html_theme = 'material'