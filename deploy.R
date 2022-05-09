library("rsconnect")
rsconnect::setAccountInfo(name='jumabek',
                          token='F2376039BF98417DB6A5510460157DAB',
                          secret='c7QnTxeVTM9i6ZI37MEySFpaUjWZ9XUMTV5GLcIJ')

library("shiny")
deployApp("masjid", account = "jumabek")

