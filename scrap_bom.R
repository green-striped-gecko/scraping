library(rvest)
library(tidyverse)

#DOES NOT WORK ON BOM (web scraping is against the policy, so not recommended)
es <- read_html("http://www.bom.gov.au/act/forecasts/canberra.shtml")

library(RSelenium)
rD <- rsDriver(browser="firefox", port=4545L, verbose=TRUE)
remDr <- rD[["client"]]


#goto a website
remDr$navigate("http://www.bom.gov.au/act/forecasts/canberra.shtml")
Sys.sleep(5) # give the page time to fully load

html <- remDr$getPageSource()[[1]]

#close everything thoroughly
remDr$close()
rD$server$stop()
rm(rD)
gc()
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
es<- read_html(html)


#FIND MAX TEMPERATURES	
maxtemps <- es %>%
	html_nodes(css=".max") %>%
	html_text()

mintemps <- es %>%
	html_nodes(css=".min") %>%
	html_text()


days <- es %>%
	html_nodes(css=".day") %>%
	html_text()

dayvalues <- as.numeric(gsub(".* ([0-9]+) September.*","\\1",days))
dayvalues[1] <- dayvalues[2]-1

plot(dayvalues, maxtemps, type="b", col="red", ylim=c(0,30))
points(dayvalues[-1], mintemps, type="b", col="blue")

