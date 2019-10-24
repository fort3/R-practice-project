source('scripts/data_import.R')
getwd()
library(data.table)
dta <- readRDS(file = 'data/raw/precip_station_3.rds')

dta

dta[, ID := as.factor(ID)]

str(dta)

decade <- dta[between(x = year,
            lower = 1980,
            upper = 1990)]

summary(decade)

decade[, mean(x=value,
              na.rm = TRUE),
       by = .(ID, month)]

#when using the '.' be careful because in some situations it creates a hidden variable


#--ran
#rm(ran)

#date <- dta[,year+month+day]
#rm(date)
#ran <- dta[,.(ID,value)]
#rm(ran)

clean.dta <- dta[, .(ID = ID,
                     date = as.Date(
                       x=paste(year,
                               month,
                               day,
                               sep = '-'),
                       format= '%Y-%m-%d'),
                     value=value)]
clean.dta

wide <- dcast(data = dta,
              formula = year + month + day ~ ID,
              value.var = 'value')
wide

long <- melt(data = wide,
             id.vars = c('year',
                         'month',
                         'day'),
             variable.name = 'ID')
long

plot(x=clean.dta[ID == 'station_1', date],
     y=clean.dta[ID == 'station_1', value],
     type = 'h',
     col = 'red',
     xlab = 'Time [days]',
     ylab = 'Prec. totals [mm]',
     main = 'Random plot nr. 1')

grid()
abline(h = quantile(x = clean.dta[(ID == 'station_1') &
                                    (value > 0), value],
                    probs = .80),
       col = 'royalblue4')
legend(x = 'topright',
       legend = c('Prec. total',
                  '80% Quantile'),
       lty = c(1,
               1),
       col = c('red',
               'blue'))
library(ggplot2)
ggplot(data = clean.dta) +
  geom_line(mapping = aes(x = date,
                          y = value)) +
  facet_wrap(facets = ~ ID,
             ncol = 1)
