
print "DuckDuckGo Search"
while 1
  print '<=== when cycle around need to isolate input promt
  input "(Just enter quits) Term? ", queryTerm
  if trim(queryTerm)="" then ? "Cheers!":end  '<=== need a way out
  url = "http://api.duckduckgo.com/?q=" + trim(queryTerm) + "&format=json"
  open url as #1
  if (eof(1)) then
    throw "Connection failed: " + url
  fi

  dim results
  tload #1, results
  json = array(results)
  num_results = len(json.RelatedTopics)
  for i = 0 to num_results - 1
    if (isarray(json.RelatedTopics(i).topics)) then
      num_topics = len(json.RelatedTopics(i).Topics)
      for t = 0 to num_topics - 1
        print cat(1); "  "; json.RelatedTopics(i).Topics(t).FirstURL; cat(0)
        print "  "; json.RelatedTopics(i).Topics(t).text
      next t
    else
      print cat(1); "  "; json.RelatedTopics(i).FirstURL; cat(0)
      print "  "; json.RelatedTopics(i).Text
    endif
  next i
  Close #1  '<===== oh this helps!
wend
