const mysql = require('mysql2')
const express = require('express')
const app = express()
const path = require('path')
const pool = mysql.createPool({
  host: 'mysql-server',
  user: 'root',
  password: 'root',
  database: 'practical',
})

app.use(express.urlencoded({ extended: false }))
app.use(express.json())
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))

app.get('/', (req, res) => {
  res.render('index')
})

app.post('/submit', (req, res) => {
  console.log(req.body)
  const { name, email, hno, city, taluka } = req.body
  pool.query(
    'INSERT INTO STUDENTS(name,email,hno,city,taluka) VALUES(?,?,?,?,?)',
    [name, email, hno, city, taluka],
    (err, results) => {
      if (err) {
        console.log(err)
        return res.send('error')
      }
      return res.send('Data inserted successfully')
    }
  )
})

app.listen(5000, () => {
  console.log(`server is listening at port 5000`)
})

/*
CREATE TABLE STUDENTS(id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, hno VARCHAR(255) NOT
NULL, city VARCHAR(255) NOT NULL, taluka VARCHAR(255) NOT NULL);
*/
