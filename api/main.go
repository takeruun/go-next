package main

import (
	"fmt"
	"time"
  "strconv"
  "os"

	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

type User struct {
  Name string `form:"name" json:"name"`
  Email string `form:"email" json:"email"`
  CreatedAt time.Time `json:"created_at"`
}

func main() {
	db := dbConnect()
	defer db.Close()

	r := gin.Default()
	r.Use(cors.New(cors.Config{
		// 許可したいHTTPメソッドの一覧
    AllowMethods: []string{
      "POST",
      "GET",
      "OPTIONS",
      "PUT",
      "DELETE",
    },
    // 許可したいHTTPリクエストヘッダの一覧
    AllowHeaders: []string{
      "Access-Control-Allow-Origin",
      "Content-Type",
      "Content-Length",
      "Accept-Encoding",
      "X-CSRF-Token",
      "Authorization",
    },
    // 許可したいアクセス元の一覧
    AllowOrigins: []string{
      "http://localhost:3000",
    },
	}))

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
    var req User
    c.BindJSON(&req)

    db := dbConnect()
    name := req.Name
    email := req.Email
    fmt.Println("create user " + name + " with email " + email)
    db.Create(&User{Name: name, Email: email})
    defer db.Close()

    c.JSON(200, gin.H{
      "message": "作成成功",
    })
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
	USER := os.Getenv("MYSQL_USER")
	PASS := os.Getenv("MYSQL_ROOT_PASSWORD")
	PROTOCOL := "tcp(" + os.Getenv("DB_HOST") + ":3306)"
	DBNAME := os.Getenv("DB_NAME")

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
