package database

import (
	"fmt"
	"log"
	"os"

	"app-backend/internal/models"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var DB *gorm.DB

func InitDB() *gorm.DB {
	host := getEnv("DB_HOST", "localhost")
	port := getEnv("DB_PORT", "5432")
	user := getEnv("DB_USER", "dev_user")
	password := getEnv("DB_PASSWORD", "dev_password")
	dbname := getEnv("DB_NAME", "dental_caries_db")

	dsn := fmt.Sprintf(
		"host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=Asia/Bangkok",
		host, user, password, dbname, port,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})
	if err != nil {
		log.Fatalf("เชื่อมต่อ PostgreSQL ล้มเหลว: %v", err)
	}

	// ทำ AutoMigrate สร้างตารางตาม ER-Diagram
	err = db.AutoMigrate(
		&models.User{},
		&models.Record{},
		&models.RecordImage{},
		&models.ToothAssessment{},
		&models.ExportedRecord{},
	)
	if err != nil {
		log.Fatalf("AutoMigrate ล้มเหลว: %v", err)
	}

	DB = db
	fmt.Println(" เชื่อมต่อ PostgreSQL และ Migrate ตารางตาม ER-Diagram สำเร็จเรียบร้อย")
	return db
}

func getEnv(key, fallback string) string {
	if val, ok := os.LookupEnv(key); ok {
		return val
	}
	return fallback
}
