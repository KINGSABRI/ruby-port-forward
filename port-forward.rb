# 
# port-forward forwards(obviously) an incomming TCP connection
#   on a specific port to another local/remote port
# Note: Type 'exit' or 'quit' to exit the script safely (wont exit your netcat session)
# 
# @Author: KING SABRI | @KINGSABRI
# 
# Usage: 
#   ruby port-forward.rb <LPORT>:<RHOST>:<RPORT>
# example: 
# ruby port-forward.rb 80:localhost:8080
# ruby port-forward.rb 4444:192.168.100.17:4444
# 
require 'socket'
require 'readline'

def server(lport, rhost, rport)
  begin
    rport_server = TCPServer.new('0.0.0.0', rport)
    while true 
      Thread.new { wanna_exit }

      rport_client = rport_server.accept
      lport_server = TCPSocket.new(rhost, lport)
      Thread.new { forward(rport_client, lport_server) }
      Thread.new { forward(lport_server, rport_client) }

      chost  = rport_client.peeraddr[3]
      clport = rport_client.addr[1]
      crhost = lport_server.peeraddr[3]
      crport = lport_server.peeraddr[1]
      puts "#{chost}(#{clport}) --> #{crhost}(#{crport})" # comment this line to stop verbose output
    end
  rescue Exception => exception
    rport_server.close  if rport_server
    lport_server.close  if lport_server
  end  
end

def forward(src, dst)
  while true 
    begin
      data = src.recv(1024)
      dst.send(data, 0) unless data.empty?
    rescue Exception => e
      src.close
      dst.close
    end
  end
end

def wanna_exit
  wanna = Readline.readline
  exit! if wanna =~ /exit|quit/i
end

begin
  settings = ARGV[0].split(':')
  lport, rhost, rport = settings
  puts "[+] Type 'exit' or 'quit' or exit safely (wont terminate your netcat session)"
  server(lport, rhost, rport)
  rescue
    puts "Usage:"
    puts "ruby port-forward.rb <LPORT>:<RHOST>:<RPORT>"
end

