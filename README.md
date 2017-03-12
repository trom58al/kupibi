# 
# Kupibi
URL Shortener

## Dependencies
* Redis

## Running
* Edit redic settings in `config.yml`
* Run api and em servers
```bash
ruby server.web.rb
ruby server.em.rb
```

##Using

    $ curl localhost:4567/?url="http://ya.ru"
    {"url":"http://localhost:4567/3VGFJbA"}

    $ curl -I localhost:4567/3VGFJbA
    
    HTTP/1.1 301 Moved Permanently
    Content-Type: text/html;charset=utf-8
    Location: http://ya.ru
    Content-Length: 0
    X-XSS-Protection: 1; mode=block
    X-Content-Type-Options: nosniff
    X-Frame-Options: SAMEORIGIN
    Connection: keep-alive
    Server: thin



