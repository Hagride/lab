import socket 

# create socket 
server_socket = socket.socket()
host = socket.gethostname()
port = 12345

server_socket.bind(host,port)


server_socket.listen(1)
print(f"listening to {port}")

conn, addr = server_socket.accept()
print(f"listening to {addr}")

msg = conn.recv(1024).decode()
print("clinet : ", msg)
conn.send("hello from server".encode())


filename = "recived_file.txt"

with open(filename ,"wb") as f :
    print("reciving file ...")  
    data = conn.recv(1024)

    while data :
        f.write(data)
        data = conn.recv(1024)
    print("data has been recived succefully !!")


conn.close()