


library(rvest)
library(tidyverse)

library(RSelenium)
rD <- rsDriver(browser="firefox", port=4545L, verbose=TRUE)
remDr <- rD[["client"]]


#goto a website
remDr$navigate("https://www.covid19.act.gov.au/act-status-and-response/act-covid-19-exposure-locations")
Sys.sleep(5) # give the page time to fully load


#find the archived box using webtools
arch <-remDr$findElement("id","chkArchived1822887")
arch$clickElement()


#fill in keywords
textbox <- remDr$findElement(using = "id", value="inputFilterKeyword1822887")
textbox$sendKeysToElement(sendKeys = list("Civic"))
 
#now get the page
html <- remDr$getPageSource()[[1]]

#close everything thoroughly
remDr$close()
rD$server$stop()
rm(rD)
gc()
system("taskkill /im java.exe /f", intern=FALSE, ignore.stdout=FALSE)
signals <- read_html(html)


tbls <- signals %>%
	html_nodes("table") %>%
	html_table(fill = TRUE)

tt <- data.frame(tbls)

