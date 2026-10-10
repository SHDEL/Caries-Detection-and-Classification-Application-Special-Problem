package middleware

import (
	"context"
	"net/http"
	"strings"

	"app-backend/internal/database"
	"app-backend/internal/models"

	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"github.com/gin-gonic/gin"
	"google.golang.org/api/option"
	"gorm.io/gorm"
)

var authClient *auth.Client

// InitFirebaseAuth เตรียมเชื่อมต่อ Firebase Admin SDK
func InitFirebaseAuth(keyPath string) error {
	opt := option.WithCredentialsFile(keyPath)
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		return err
	}

	client, err := app.Auth(context.Background())
	if err != nil {
		return err
	}

	authClient = client
	return nil
}

// AuthRequired Middleware สำหรับ Route ที่ต้องล็อกอิน
func AuthRequired() gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" || !strings.HasPrefix(authHeader, "Bearer ") {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{
				"error": "Missing or invalid Authorization header",
			})
			return
		}

		idToken := strings.TrimPrefix(authHeader, "Bearer ")

		// 1. ตรวจสอบความถูกต้องของ ID Token
		token, err := authClient.VerifyIDToken(context.Background(), idToken)
		if err != nil {
			c.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{
				"error": "Unauthorized: Invalid or expired token",
			})
			return
		}

		firebaseUID := token.UID

		// ดึง email จาก claims (ถ้ามี)
		email := ""
		if val, ok := token.Claims["email"].(string); ok {
			email = val
		}

		// 2. ตรวจสอบหรือสร้าง User ใน PostgreSQL อัตโนมัติ
		var user models.User
		result := database.DB.Where("uid = ?", firebaseUID).First(&user)
		if result.Error != nil {
			if result.Error == gorm.ErrRecordNotFound {
				// ยังไม่เคยมีใน DB ให้สร้างใหม่
				username := strings.Split(email, "@")[0]
				if username == "" {
					username = "user_" + firebaseUID[:6]
				}

				user = models.User{
					UID:      firebaseUID,
					Email:    email,
					Username: username,
				}
				if err := database.DB.Create(&user).Error; err != nil {
					c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
						"error": "Failed to create local user record",
					})
					return
				}
			} else {
				c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
					"error": "Database error",
				})
				return
			}
		}

		// 3. ฝากข้อมูล User ไว้ใน Context
		c.Set("currentUser", user)
		c.Set("firebaseUID", firebaseUID)
		c.Next()
	}
}
