package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	// พยายามต่อ Database
	// database.InitDB()

	r := gin.Default()

	// ตั้งค่า CORS สำหรับเชื่อมต่อกับ Flutter Mobile
	r.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
			return
		}
		c.Next()
	})

	api := r.Group("/api/v1")
	{
		api.GET("/health", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{
				"status":  "ok",
				"message": "Dental Screening API is running!",
			})
		})
	}

	// รันเซิร์ฟเวอร์ที่ localhost:8080
	r.Run(":8080")
}
