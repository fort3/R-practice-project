

download.file(url = 'https://climexp.knmi.nl/data/rhrh290.dat',
              destfile = './data/raw/precip_station_1.dat')


urls <- c('https://climexp.knmi.nl/data/rhrh235.dat','https://climexp.knmi.nl/data/rhrh310.dat','https://climexp.knmi.nl/data/rhrh290.dat')

install.packages("data.table")

library(data.table)

dta.raw <- lapply(X = urls,
                  FUN = function(x){
                    fread(input = x,
                          skip = 12)
                  })
#do.call(what = rbind,
#          args = dta.raw)

names(dta.raw) <- paste('station',
                        seq_along(dta.raw),
                        sep = '_')
dta <- rbindlist(l = dta.raw,
                     idcol = 'ID')
dta

setnames(x = dta,
         old = c('#', 'last','updated', '2019-10-16'),
         new = c('year', 'month', 'day', 'value'))

saveRDS(object = dta,
        file = 'data/raw/precip_station_3.rds')
write.csv(x = dta,
          file = 'data/raw/precip_station_3.csv')




