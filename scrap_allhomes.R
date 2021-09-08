

#scrap allhomes (number of listings in evatt)
es <- read_html("https://www.allhomes.com.au/sale/evatt-act-2617")

#es <- read_html("https://www.allhomes.com.au/sale/crace-act-2911")

#find the css class you are interested in
ll <- es %>%
	html_nodes(".css-in3yi3") %>%
	html_text()

gsub("([0-9]+) properties","\\1", ll)
