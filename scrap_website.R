library(rvest)

#grab from website
es <- read_html("https://www.covid19.act.gov.au/act-status-and-response/act-covid-19-exposure-locations", )

#check webpage for certain entries (either html tags or css)
ll <- es %>%
	html_nodes("strong") %>%
	html_text()

#ll <- es %>%
#	html_nodes(xpath="/html/body/main/div[3]/div[2]/h4/strong") #%>%
#	html_text()

index <- grep("Page last updated:",ll)
dummy <- ll[index]
lup <- dummy
lu <- substr(strsplit(dummy,"updated:")[[1]][2],2,100)
lu <- gsub(" ", "_",lu)
lu <- gsub(":","",lu)
lu
