# Port Forwarding using Ruby

port-forward forwards(obviously) an incomming TCP connection on a specific port to another local/remote port

**Note:** Type 'exit' or 'quit' to exit the script safely (wont exit your netcat session)


## Usage
#### `ruby port-forward.rb <LPORT>:<RHOST>:<RPORT>`

## Example
```
$> ruby port-forward.rb 80:localhost:8080
```
or 
```
$> ruby port-forward.rb 4444:192.168.100.17:4444
```
