########################################################################################################################—•°
## R for complete beginners (by A.K.)
## start:2017-02-18; last:2017-02-19
########################################################################################################################—•°
########################################################################################################################—•°

########################################################################################################################—•°
## 01. Saving and loading
########################################################################################################################—•°
ls() ## what is in the current environment (the default space in memory you work in and on)
## nothing...

## crate something
a <- 1
ls()
a
## and something more
f <- function(x){2*x}   ## a function
f(a)  ## it works :)

ls()        ## ...and we can see it in the environment
ls.str()    ## lists all elements in the environment together with their properties (structure)

## what is the default directory for writing results and reading data
getwd()     ## get working directory
## it's better to choose and set it manually to your choice
setwd("D:/ROBOCZY/R/TutorialAK/01 Basics/")    ## set working directory
      ## this folder must already exist!
      ## you could use
      dir.create()
      ## but now it's better not to go into such details...

## now you can save an object to the wd (warking directory)
save("f",file="f")

list.files()  ## check it also in system browser
## we have created file without extension - not a good idea... It will work but no one knows what's the file about.
## removing the file
unlink("f")         ## remember that it works on working directory
list.files()

## create it again
save("f",file="f.RData")  ## .RData is usual extension for saving R objects (as binaries not as text)
                          ## BUT it is not default. It is up to the user to give and choose extension.
list.files()
save("a",file="a.RData")
list.files()

## clearing environment
rm(list=ls())  ## dangerous!!!  but sometimes you need to do it
ls()           ## nothing

## BUT you have stored objects into the files hence you may restore them
load("a.R")
ls()
a
load("f.R")
ls()
f
f(a)

## you may save all the needed objects to one file
save(list=c("a","f"),file="af.R")
rm(list=ls())
ls()
## restoring
load("af.R")
ls()
f(a)

## create another object
s <- 10

## saving the whole environment
save.image()
rm(list=ls())
ls()
list.files()  ## ??? what is the file to which the environment was written ???
## it is hidden file:
list.files(all=T)    ## shows all files, together with hidden
## hidden files begin with period "." (but . means current directory and .. means parent directory);
## save.image() writes the whole environment to the .RData (unless you specify a different file name)
load(".RData")
ls()
f(a)
f(s)

save.image(file="envir.R")
rm(list=ls())
ls()

load(file="envir.R")
ls()
f(a)
f(s)

###########################################################—•°
## Now you are ready to work!
## You may safely break your work at any time without danger of losing your data —
## you can save and restore any object or the whole environment whenever it is needed.
## Do it frequently!
###########################################################—•°

###############################################################################—•°
## Using help
#  help(command)
#  ?command
help(ls)
?ls

## try it with tne commands above

## if you don't remember exactly, try
#  ??command
??wd

###########################################################—•°
## THERE'S NO HOPE WITHOUT HELP.
## Never hesitate to ask for help and use it!!!
## Don't bother that you ask many times about the same thing! It's normal :)
###########################################################—•°


########################################################################################################################—•°
