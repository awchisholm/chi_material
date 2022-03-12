library(XML)
library(jsonlite)
library(dplyr)
urls = c(
  'https://www.zizzi.com/find-my-restaurant/results/south-east',
  'https://www.zizzi.com/find-my-restaurant/results/south-west',
  'https://www.zizzi.com/find-my-restaurant/results/greater-london',
  'https://www.zizzi.com/find-my-restaurant/results/east-anglia',
  'https://www.zizzi.com/find-my-restaurant/results/wales',
  'https://www.zizzi.com/find-my-restaurant/results/midlands',
  'https://www.zizzi.com/find-my-restaurant/results/north-west',
  'https://www.zizzi.com/find-my-restaurant/results/north-east',
  'https://www.zizzi.com/find-my-restaurant/results/scotland',
  'https://www.zizzi.com/find-my-restaurant/results/northern-ireland')

address_list = list()
for (url in urls) {
  source <- readLines(url, encoding = "UTF-8")
  parsed_doc <- htmlParse(source, encoding = "UTF-8")
  addresses = xpathSApply(parsed_doc, path = '//address/p', xmlValue)

  addresses = gsub('\n', ', ', addresses)
  addresses = gsub('\t', '', addresses)
  addresses = gsub("’", '', addresses)
  address_list = append(address_list, addresses)
}

address_list = unlist(address_list)

latlons = tibble()
for (address in address_list) {
  query = gsub(' ', '%20', address)
  positionstack = 'http://api.positionstack.com/v1/forward?access_key=82bf52d3d05f4e2fb514a4ea92f6a159&query='
  limit = '&limit=1'
  url = paste0(positionstack, query, limit)
  geo = readLines(url, encoding='UTF-8')
  latlon = fromJSON(geo)
  latitude = latlon$data$latitude
  longitude = latlon$data$longitude
  result = tibble(address, latitude, longitude)
  print(result)
  latlons = latlons %>% dplyr::bind_rows(result)
}
#geocodeurl = 'http://api.positionstack.com/v1/forward?access_key=82bf52d3d05f4e2fb514a4ea92f6a159&query=Meadowhall,%20Sheffield,%20S9%201EP&limit=1'
#geo = readLines(geocodeurl, encoding='UTF-8')
#latlon = fromJSON(geo)
#latitude = latlon$data$latitude
#longitude = latlon$data$longitude
