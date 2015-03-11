con <- url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlcode <- readLines(con)
close(con)
nchar(htmlcode[c(10,20,30,100)])


# [1] 45 31  7 25
 