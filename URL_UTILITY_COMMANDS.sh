--url_enc()/url_dec()/url_parser()/url_compare()

when HTTP_REQUEST {
--url encoder
url = "http://foor bar/@!";
enc = url_enc(url);
debug("encoded url is %s\n", enc);

--url decoder
url = "@http%3A%2F%2ffoor+bar%2F@!";
dec = url_dec(url);
debug("decoded url is %s\n", dec);

--url parser: the extracted scheme and host are converted to lower case letters.
url = "http://www.example.com:890/url/path/data?name=forest#nose"
	--The below formats of url are also supported:
	--url = "http://foo:bar@w1.superman.com/very/long/path.html?p1=v1&p2=v2#more-details"
	--url = "//www.example.com:890/url/path/data?name=forest#nose"
	--url = "/url/path/data?name=forest#nose"
	--url = "https://www.example.com/"
	--url = "https://www.example.com"
	--url = "://www.example.com/"
	--url = "https://www.example.com:/"
	--url = "ftp://[2001:db8::7]/c=GB?objectClass=one&objectClass=two" 
purl = url_parser(url); 
	--note that the returned element will be nil if not exist. 
if purl then
	debug("parsed url scheme %s, host %s, port %s, path %s, query %s, fragment %s, username %s, passowrd %s\n", purl["scheme"], purl["host"], purl["port"],purl["path"], purl["query"], purl["fragment"], purl["username"], purl["password"]);
end


--url compare: compare two url string.
	--default path is "/"
	--default port is: 80 for http, 443 for https, 21 for ftp, 23 for telnet, 69 for tftp. Don't support others.
url1 = "http://www.example.com/url/path/data?name=forest#nose"
url2 = "httP://WWW.example.com:80/url/path/data?name=forest#nose"
if url_compare(url1, url2) then
	debug("url match\n");
else
	debug("url not match\n");
end

url1 = "https://www.example.com/"
url2 = "HTTPs://www.example.com"
if url_compare(url1, url2) then
	debug("url match\n");
else
	debug("url not match\n");
end

url1 = "http://www.example.com:80/~smith"
url2 = "http://www.example.com:/%7esmith"
if url_compare(url1, url_dec(url2)) then
	debug("url match\n");
else
	debug("url not match\n");
end

}

