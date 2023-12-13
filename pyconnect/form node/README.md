### Start Docker Compose

- sudo docker-compose up -d

---

### View running containers

- sudo docker ps

---

### Access the MySQL container

- sudo docker exec -it <container_id> bash

---

### Access MySQL from the command line

- mysql -u root -p

---

### Enter password: root

---

### Create a database and switch to it

- CREATE DATABASE practical;
- USE practical;

---

### Create a table named STUDENTS

- CREATE TABLE STUDENTS(
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  hno VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  taluka VARCHAR(255) NOT NULL
  );

---

### If the network name is already in use, disconnect and remove

- docker network ls
- docker network inspect swarada-network
- docker network disconnect swarada-network container_name_or_id
- docker network rm swarada-network

---

### To delete containers

- docker ps
- docker stop <container_id>
- docker rm <container_id>

---

### To delete an image

- docker images
- docker stop container_name_or_id
- docker rm container_name_or_id
- docker rmi my_image

---

### Kill a process using a port

- sudo lsof -i :3306
- sudo kill -9 <PID>
