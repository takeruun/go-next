package main

import (
	"fmt"
	"time"
  "strconv"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

type User struct {
  gorm.Model
  name string
  email string
}

func main() {
	db := dbConnect()
	defer db.Close()

	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "hello",
		})
	})

  r.GET("/users", func(c *gin.Context) {
    db := dbConnect()
    var users []User
    db.Order("created_at asc").Find(&users)
    defer db.Close()

    c.JSON(200, gin.H{
      "users": users,
    })
  })

  r.POST("/users", func(c *gin.Context) {
    db := dbConnect()
    name := c.PostForm("name")
    email := c.PostForm("email")
    fmt.Println("create user " + name + " with email " + email)
    db.Create(&User{name: name, email: email})
    defer db.Close()

    c.Redirect(302, "/")
  })

  r.DELETE("/users/:id", func(c *gin.Context) {
    db := dbConnect()
    n := c.Param("id")
    id, err := strconv.Atoi(n)
    if err != nil {
      panic("id is not a number")
    }
    var user User
    db.First(&user, id)
    db.Delete(&user)
    defer db.Close()

    c.Redirect(302, "/")
  })


	r.Run()
}

func dbConnect() (database *gorm.DB) {
	DBMS := "mysql"
	USER := "root"
	PASS := "password"
	PROTOCOL := "tcp(db:3306)"
	DBNAME := "go-next_development"

	CONNECT := USER + ":" + PASS + "@" + PROTOCOL + "/" + DBNAME + "?charset=utf8mb4&collation=utf8mb4_general_ci&parseTime=true"

	count := 0
	db, err := gorm.Open(DBMS, CONNECT)
	if err != nil {
		for {
			if err == nil {
				fmt.Println("")
				break
			}
			fmt.Print(".")
			time.Sleep(time.Second)
			count++
			if count > 180 {
				fmt.Println("")
				fmt.Println("DB接続失敗")
				panic(err)
			}
			db, err = gorm.Open(DBMS, CONNECT)
		}
	}
	fmt.Println("DB接続成功")

	return db
}
