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
setwd("D:/ROBOCZY/R/TutorialAK/01 Intro/")    ## set working directory
      ## this folder must already exist!
      ## you could use
      dir.create()
      ## but now it's better not to go into such details...

## now you can save an object to the wd (warking directory)
save("f",file="f")

list.files()  ## check it also in system browser
## We have created file without extension - not a good idea... It will work but no one knows what's the file about.
## removing the file
unlink("f")         ## remember that it works on working directory
list.files()

## create it again
save("f",file="f.RData")  ## .RData is usual extension for saving R objects (as binaries not as text)
                          ## BUT it is not default. It is up to the user to choose and give extension.
list.files()
save("a",file="a.RData")
list.files()

## clearing environment
rm(list=ls())  ## dangerous!!!  but sometimes you need to do it
ls()           ## environment is empty now

## BUT you have stored objects into the files hence you may restore them
load("a.RData")
ls()
a
load("f.RData")
ls()
f
f(a)

## you may save all the needed objects to one file
save(list=c("a","f"),file="af.RData")
rm(list=ls())
ls()
## restoring
load("af.RData")
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

## it's always better to give the file some name (not to rely on the default names)
save.image(file="envir.RData")
list.files()   ## envir.RData is not hidden now (doesn't begin with period ".")
rm(list=ls())
ls()

load(file="envir.RData")
ls()
f(a)
f(s)

###########################################################—•°
## Notice that file extension is set up by user.
## The convension is that
## • .R is for script files, i.e. they are text files — you may edit this files;
## • .RData is for binary files for storing R objects — you cannot edit such files.
## However you may do
save.image(file="envir.R")
## or even
save.image(file="envir.txt")
## or
save.image(file="envir.jpg")
## ... and so on.
list.files()
## You may even load data from such files:
load(file="envir.jpg")

## But if you try to open it from your system file browser... Ooops!
## So do not breach convensions!


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

## try it with the commands above

## if you don't remember exactly, try
#  ??command
??wd

###########################################################—•°
## THERE'S NO HOPE WITHOUT HELP.
## Never hesitate to ask for help and use it!!!
## Don't bother that you ask many times about the same thing! It's normal :)
###########################################################—•°


########################################################################################################################—•°
