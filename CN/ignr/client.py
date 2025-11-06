import socket
client_socket = socket.socket()
host = socket.gethostname()

port = 12345

client_socket.connect((host,port))

client_socket.send("Hello from client !".encode())

msg = client_socket.recv(1024).decode()
print("Server :" , msg)

filename = "sample.txt"

with open(filename,"rb") as f :
    data = f.read(1024)
    while data :
        client_socket.send(data)
        data = f.send(1024)
    print("succesfully file sent")

client_socket.close()