#notes taken from "Getting Started with httr"

library(httr)

r <- GET("http://httpbin.org/get")

####################
######### The Response
######################


#Check the status of the request (the two below do effectively the same thing)
http_status(r)
r$status_code

#to automatically throw a warning or raise an error if the request does not succeed when inside a function
warn_for_status(r)
stop_for_status(r)


####Thee ways to access the body of a request

#Access as a charachter vector
content(r, 'text')

#For non-text request you can access as a raw vector
content(r, 'raw')

#JSON automatically parsed into named list
str(content(r, 'parsed'))


###access response headers
headers(r)

###############
###The Request
############

#URL query string
 r<- GET('http://httpbin.org/get',
         query = list(key1 = 'value1', key2 = 'value2'))

content(r)$args

#add custom headers to a request

r<- GET('http://httpbin.org/get', add_headers(Name = 'Hadley'))
str(content(r)$headers)
              #note: content(r)$header retireves the headers that httpbin received. headers(r) gives the 
              #headers that it sent back in its response



















