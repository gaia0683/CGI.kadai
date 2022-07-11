require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
  })
  ['INT','TERM'].each{|signal|
    Signal.trap(signal){ server.shutdown }
  }

  server.mount('/test',WEBrick::HTTPServlet::ERBHandler,'test.html.erb')

  server.mount('/',WEBrick::HTTPServlet::ERBHandler,'goya.html.erb')

  server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

  server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

  server.mount('/goya_not_use_myself.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_not_use_myself.rb')

  server.mount('/goya_quality_is_bad.cgi',WEBrick::HTTPServlet::CGIHandler, 'goya_quality_is_bad.rb')

  server.start
