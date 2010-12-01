#!/usr/bin/env python
# Cameron Ketcham
# 11/30/10
# will scrape a url for new author tags to be put in your css
# looks for things like: a.author[href$="/your_username"]:after {content: " (year_brand_model)"}
# almost guaranteed not to be bug free!
import urllib2
import re

# This is the url of the page to scrape
url = "http://www.reddit.com/r/motorcycles/comments/ee30s/if_you_want_your_bike_info_next_to_your_username/"

# This is the url of the css where the authors will be added
cssurl = "http://www.reddit.com/r/motorcycles/stylesheet.css"

# username regex
username_regex = r"a\.author\[href\$=\"/?(.+)\"]:after {"
full_css_regex = r"a\.author\[href\$=\"/?(.+)\"]:after {content: \" \((.*)\)\"}"

# get all the .author css that is on the page
html = urllib2.urlopen(url).read()
authorcss = re.findall(full_css_regex,html)

# find the users which have already been added
csshtml = urllib2.urlopen(cssurl).read()
users = set(re.findall(username_regex,csshtml))
users.add('your_username')

# this checks for duplicates
newauthors = set()

# print out new authors
for author in authorcss:
	if not author[0] in users and not author[0] in newauthors:
		print 'a.author[href$="/'+author[0]+'"]:after {\n    content: " ('+author[1]+')"\n    }'
		newauthors.add(author[0])