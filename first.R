getwd()

dir.create(path = 'data', showWarnings = FALSE)

dir.exists(paths = 'data')
dir.create('data/raw')
dir.create('results')
dir.create('scripts')

dirs <- c('data',
          'data/raw',
          'results',
          'scripts')

## loop

for (i in dirs) {
  
  dir.create(path = i,
             showWarnings = FALSE)
  
}

sapply(X = dirs,
       FUN = function(x){
         dir.create(path = dirs[i],
                    showWarnings = FALSE)
         
       })
