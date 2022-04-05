library(visNetwork)
library(igraph)
library(ggplot2)

nb <- 10
id <- 1:nb
set.seed(10)

edges <- data.frame(
  from = sample(id, 20, replace = TRUE), 
  to = sample(id, 20, replace = TRUE),
  value = rnorm(nb, 20)
  )

nodes <- data.frame(id=1:nb, 
                    label = paste("ID: ",1:nb), 
                    stringsAsFactors = FALSE)

nodes$title <- paste0("ID", nodes$id,'<br><p style="color:Tomato;">Tooltip !</p>')
edges$title <- paste0("ID receiver:",edges$to,"<br>ID sender:",edges$from,"<br> Minutes : ", round(edges$value, 2))


edges$row <- 1:20
edges$from <- as.character(edges$from)
edges$to <- as.character(edges$to)

ggplot(data = edges)+
  geom_point(size=3, aes(x= row, y = from, colour = "red")) +
  geom_segment(aes(x = row, xend = row, y = to, yend = from), size = 2, colour = "red", alpha = 0.7 ) + 
  coord_flip() +
  scale_x_discrete(limits = as.character(edges$row))+
  ylab("Value")


