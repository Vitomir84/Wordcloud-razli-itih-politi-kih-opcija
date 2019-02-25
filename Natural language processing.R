#Natural language processing in twitter
#Otvaranje naloga na http://apps.twitter.com.
#Uzima se api, secret api, access token, secret token

ckey <- HJIAUkCJkRYuvr7G354aFUsPJ
skey <- e1yHRCElXgNMO3d9vVwh4MTdylALl9rIRgkpPNhZaWGfqzc2xU
token <- 464636983-ZXEtDfTD9NekqmbqKMoqpts6Tn5AORK1pNE00Pf6
sectoken <- FxyZCv5kNl1ZtlBU7OSOzNulUYCUEAt7ssr0rnE3vCXT9

install.packages('tm',repos='http://cran.us.r-project.org')
install.packages('twitteR',repos='http://cran.us.r-project.org')
install.packages('wordcloud',repos='http://cran.us.r-project.org')
install.packages('RColorBrewer',repos='http://cran.us.r-project.org')
install.packages('e1017',repos='http://cran.us.r-project.org')
install.packages('class',repos='http://cran.us.r-project.org')

library(tm)
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library(e1071)
library(class)

#Povezivanje na twitter

setup_twitter_oauth("HJIAUkCJkRYuvr7G354aFUsPJ", "e1yHRCElXgNMO3d9vVwh4MTdylALl9rIRgkpPNhZaWGfqzc2xU", access_token = "464636983-ZXEtDfTD9NekqmbqKMoqpts6Tn5AORK1pNE00Pf6", access_secret =  "FxyZCv5kNl1ZtlBU7OSOzNulUYCUEAt7ssr0rnE3vCXT9")

#Pretraživanje određene reči na tw - može da se bira broj tweetova i jezik

poezija <- searchTwitter("sns", n=1000, lang = "sr")
head(poezija)

#protestall <- searchTwitter("protest", n=1000)
#head(protestall)



#Uzimanje tekstualnih podataka iz tvitova

poezija.tekst <- sapply(poezija, function(x) x$getText())
poezija.tekst

#Čišćenje podataka, brisanje emotikona, čuvanje samo u UTF formatu

poezija.tekst <- iconv(poezija.tekst, 'UTF-8', 'latini')

#Kreiranje korpusa
poezija.korpus <- Corpus(VectorSource(poezija.tekst))

#Dokument term matrica
term.doc.matrix <- TermDocumentMatrix(poezija.korpus,
                                      control = list(removePunctuation = TRUE,
                                                     stopwords = c("je","http", "je", "да", "за", "httpstconprvxivlb", stopwords("serbian")),
                                                     removeNumbers = TRUE,tolower = TRUE))

term.doc.matrix <- as.matrix(term.doc.matrix)
head(term.doc.matrix)

#Brojimo reči
word.freq <- sort(rowSums(term.doc.matrix), decreasing = TRUE)
dm <- data.frame(word=names(word.freq), freq = word.freq)

#Create wordcloud
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

#wordcloud(dm$word, dm$freq, max.words =100, min.freq=1, scale=c(3,1), random.order=FALSE, colors=brewer.pal(8, "Dark2"))


