# sitemap_scanner
shell script that scans all URLs in a sitemap to test if they work

# usage
`$ ./sitemap_scanner.sh sitemap.xml output.txt`

Make sure to remove the namespace in the xml:
Change `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">` to just `<urlset>`

# notes
The scanner sends a `cURL` request to each URL in the sitemap. If the HTTP result is `200` then the request is regarded as a success.
Anything but a `200` response is regarded as a failure and it counts towards the failure count.

The results file contains all the results along with their URLs, so it should be easy to find the offending URL.

The scanner sends out requests in batches of 10 and then waits for them to complete before continuing. This number can be increased to make it run faster, but there is a risk of the host machine being bogged down and the server might start blocking the requests if it has anti-DDOS countermeasures in place.