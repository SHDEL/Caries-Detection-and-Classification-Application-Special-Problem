package models

import (
	"time"
)

// SeverityEnum กำหนดตามรูปภาพ ER-Diagram (initial, moderate, advance)
type SeverityEnum string

const (
	SeverityInitial  SeverityEnum = "initial"
	SeverityModerate SeverityEnum = "moderate"
	SeverityAdvance  SeverityEnum = "advance"
)

// User ผู้ใช้งานระบบ (ผูกกับ Firebase Auth ผ่าน uid)
type User struct {
	ID        uint      `gorm:"primaryKey;autoIncrement" json:"id"`
	UID       string    `gorm:"column:uid;size:128;uniqueIndex;not null" json:"uid"`
	Email     string    `gorm:"column:email;size:255;not null" json:"email"`
	Username  string    `gorm:"column:username;size:100;not null" json:"username"`
	CreatedAt time.Time `gorm:"column:created_at;autoCreateTime" json:"createdAt"`

	// Relationships: 1 User Scan ได้ M Records
	Records []Record `gorm:"foreignKey:UserID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"records,omitempty"`
}

// Record ผลการสแกน/ตรวจคัดกรองแต่ละรอบ
type Record struct {
	ID            uint      `gorm:"primaryKey;autoIncrement" json:"id"`
	UserID        uint      `gorm:"column:user_id;index;not null" json:"userId"`
	TotalInitial  int       `gorm:"column:total_initial;default:0" json:"total_initial"`
	TotalModerate int       `gorm:"column:total_moderate;default:0" json:"total_moderate"`
	TotalAdvance  int       `gorm:"column:total_advance;default:0" json:"total_advance"`
	Score         int       `gorm:"column:score;default:0" json:"score"`
	CreatedAt     time.Time `gorm:"column:created_at;autoCreateTime" json:"createdAt"`

	// Relationships
	User             *User             `gorm:"foreignKey:UserID" json:"user,omitempty"`
	RecordImages     []RecordImage     `gorm:"foreignKey:RecordID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"recordImages,omitempty"`
	ToothAssessments []ToothAssessment `gorm:"foreignKey:RecordID;constraint:OnUpdate:CASCADE,OnDelete:CASCADE;" json:"toothAssessments,omitempty"`
	ExportedRecord   *ExportedRecord   `gorm:"foreignKey:RecordID;constraint:OnUpdate:CASCADE,OnDelete:SET NULL;" json:"exportedRecord,omitempty"`
}

// RecordImage รูปถ่ายฟันในแต่ละ Record
type RecordImage struct {
	ID        uint      `gorm:"primaryKey;autoIncrement" json:"id"`
	RecordID  uint      `gorm:"column:record_id;index;not null" json:"recordId"`
	ImageURL  string    `gorm:"column:image_url;type:text;not null" json:"imageUrl"`
	CreatedAt time.Time `gorm:"column:created_at;autoCreateTime" json:"createdAt"`

	Record *Record `gorm:"foreignKey:RecordID" json:"record,omitempty"`
}

// ToothAssessment ผลตรวจรายซี่ของ Record
type ToothAssessment struct {
	ID        uint         `gorm:"primaryKey;autoIncrement" json:"id"`
	RecordID  uint         `gorm:"column:record_id;index;not null" json:"recordId"`
	Number    int          `gorm:"column:number;not null" json:"number"` // หมายเลขซี่ฟัน
	Severity  SeverityEnum `gorm:"column:severity;type:varchar(20);not null" json:"severity"`
	CreatedAt time.Time    `gorm:"column:created_at;autoCreateTime" json:"createdAt"`

	Record *Record `gorm:"foreignKey:RecordID" json:"record,omitempty"`
}

// ExportedRecord ข้อมูลการส่งออกรายงาน (1:1 กับ Record)
type ExportedRecord struct {
	ID        uint      `gorm:"primaryKey;autoIncrement" json:"id"`
	RecordID  uint      `gorm:"column:record_id;uniqueIndex;not null" json:"recordId"` // uniqueIndex เพื่อทำ 1:1
	Type      string    `gorm:"column:type;size:50;not null" json:"type"`             // เช่น pdf, link
	PdfURL    string    `gorm:"column:pdf_url;type:text;not null" json:"pdfUrl"`
	ExpiresAt time.Time `gorm:"column:expires_at;not null" json:"expiresAt"`
	CreatedAt time.Time `gorm:"column:created_at;autoCreateTime" json:"createdAt"`

	Record *Record `gorm:"foreignKey:RecordID" json:"record,omitempty"`
}
