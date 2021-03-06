mnamka <- function(){
  url_mnamka <- "https://restauracie.sme.sk/restauracia/bistro-mnamka_9954-stare-mesto_2949/denne-menu"
  download.file(url_mnamka, destfile = "scrapedpage.html", quiet=TRUE)
  raw <- read_html("scrapedpage.html")
  jedlo <- 
    raw %>%
    html_nodes(".dnesne_menu .jedlo_polozka .left") %>%
    html_text() %>% 
    str_trim() %>%
    .[1:5] #vip menu not included
  
  jedlo[2:5] <- 
    jedlo[2:5] %>% 
    str_extract("g(.*)") %>% 
    str_sub(start = 2) %>%
    str_trim()
  
  jedlo[1] <- jedlo[1] %>% str_sub(start = 16) %>% str_trim()
  jedlo <- str_replace_all(jedlo, "([\n\t])", "")
  return(c("Bistro Mnamka", jedlo))
}