package main

import (
	"app-backend/internal/database"
	"app-backend/internal/middleware"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {

	err := godotenv.Load()
	if err != nil {
		log.Println("Notice: ไม่พบไฟล์ .env ระบบจะใช้ Environment Variable ของระบบแทน")
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080" // กำหนด Default fallback หากไม่ได้ตั้งค่าไว้
	}

	firebaseKeyPath := os.Getenv("FIREBASE_CREDENTIALS")
	if firebaseKeyPath == "" {
		firebaseKeyPath = "firebaseServiceAccountKey.json"
	}

	// พยายามต่อ Database
	database.InitDB()

	if err := middleware.InitFirebaseAuth(firebaseKeyPath); err != nil {
		log.Fatalf("Init Firebase Auth failed: %v", err)
	}

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

	// Public route
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	r.GET("/api/v1/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	// Protected Routes (need token)
	api := r.Group("/api/v1")
	api.Use(middleware.AuthRequired())
	{
		api.GET("/remote-control", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{
				"status":  "success",
				"message": "Remote Control Test Success",
			})
		})

		// เช็กโปรไฟล์ตนเอง
		api.GET("/me", func(c *gin.Context) {
			user, exists := c.Get("currentUser")
			if !exists {
				c.JSON(http.StatusInternalServerError, gin.H{"error": "User not found"})
				return
			}
			c.JSON(http.StatusOK, gin.H{
				"message": "Authenticated successfully",
				"user":    user,
			})
		})
	}

	// รันเซิร์ฟเวอร์ที่ localhost:8080
	r.Run(":" + port)
}
