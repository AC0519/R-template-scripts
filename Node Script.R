library(igraph)

J2 <- graph(c("Anthony","Ralph", "Dave","Gyasi", "Gyasi","Ralph", "Dan","Dan"))
plot(J2, 
vertex.size = 30, 
edge.label = c("Hates", "Sunsets", "Pity", "Sugar Free"), 
vertex.label.dist=.5,
vertex.color = 'lightblue',
edge.label.dist= 10)
