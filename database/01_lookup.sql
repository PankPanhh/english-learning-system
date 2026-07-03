/* =====================================================================
   FILE        : 01_lookup.sql
   MODULE      : Lookup Tables
   PURPOSE     : Tạo toàn bộ bảng danh mục (Lookup) dùng chung cho hệ thống.
                 Mọi giá trị "cố định lặp lại" đều được đưa vào đây thay vì
                 lưu text trực tiếp trong bảng nghiệp vụ (chuẩn hoá 3NF).
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 2
   PATTERN     : Toàn bộ bảng lookup dùng chung cấu trúc:
                 {Ten}Id (PK), Code (UQ), Name, Description, DisplayOrder,
                 IsActive, CreatedAt, UpdatedAt
   NOTE        : Không tạo Foreign Key trong file này (lookup không phụ
                 thuộc bảng nào khác). Unique/Default/Check tự chứa được
                 khai báo inline; Foreign Key liên bảng để ở 08_constraints.sql.
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   lookup.Level — Trình độ CEFR (A1 - C2)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.Level
(
    LevelId         TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(10)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Level_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Level_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_Level PRIMARY KEY CLUSTERED (LevelId),
    CONSTRAINT UQ_Level_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.LessonType — Loại bài học (Vocabulary/Grammar/Mixed/Reading...)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.LessonType
(
    LessonTypeId    TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(30)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_LessonType_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_LessonType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_LessonType PRIMARY KEY CLUSTERED (LessonTypeId),
    CONSTRAINT UQ_LessonType_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.LessonItemType — Loại nội dung của 1 LessonItem
   (Vocabulary/Grammar hiện tại; mở rộng Reading/Listening... sau này)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.LessonItemType
(
    LessonItemTypeId TINYINT        IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(30)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_LessonItemType_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_LessonItemType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_LessonItemType PRIMARY KEY CLUSTERED (LessonItemTypeId),
    CONSTRAINT UQ_LessonItemType_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.PartOfSpeech — Từ loại (Noun, Verb, Adjective...)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.PartOfSpeech
(
    PartOfSpeechId  TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(20)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_PartOfSpeech_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_PartOfSpeech_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_PartOfSpeech PRIMARY KEY CLUSTERED (PartOfSpeechId),
    CONSTRAINT UQ_PartOfSpeech_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.Topic — Chủ đề bài học (Travel, Business, Daily Life...)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.Topic
(
    TopicId         SMALLINT        IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(30)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Topic_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Topic_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_Topic PRIMARY KEY CLUSTERED (TopicId),
    CONSTRAINT UQ_Topic_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.QuizType — Loại câu hỏi (MultipleChoice, FillBlank...)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.QuizType
(
    QuizTypeId      TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(30)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_QuizType_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_QuizType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_QuizType PRIMARY KEY CLUSTERED (QuizTypeId),
    CONSTRAINT UQ_QuizType_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.Difficulty — Độ khó (Easy/Medium/Hard)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.Difficulty
(
    DifficultyId    TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(20)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Difficulty_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Difficulty_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_Difficulty PRIMARY KEY CLUSTERED (DifficultyId),
    CONSTRAINT UQ_Difficulty_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.SessionStatus — Trạng thái StudySession / StudySessionItem
   --------------------------------------------------------------------- */
CREATE TABLE lookup.SessionStatus
(
    SessionStatusId TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(20)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_SessionStatus_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_SessionStatus_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_SessionStatus PRIMARY KEY CLUSTERED (SessionStatusId),
    CONSTRAINT UQ_SessionStatus_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.ReviewRating — Đánh giá SRS (Again/Hard/Good/Easy — SM-2 style)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.ReviewRating
(
    ReviewRatingId  TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(20)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_ReviewRating_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_ReviewRating_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_ReviewRating PRIMARY KEY CLUSTERED (ReviewRatingId),
    CONSTRAINT UQ_ReviewRating_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.AIContentStatus — Trạng thái duyệt nội dung AI sinh ra
   --------------------------------------------------------------------- */
CREATE TABLE lookup.AIContentStatus
(
    AIContentStatusId TINYINT       IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(20)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_AIContentStatus_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_AIContentStatus_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_AIContentStatus PRIMARY KEY CLUSTERED (AIContentStatusId),
    CONSTRAINT UQ_AIContentStatus_Code UNIQUE (Code)
);
GO

/* ---------------------------------------------------------------------
   lookup.LogEventType — Loại sự kiện log (SessionStarted, ItemCompleted...)
   --------------------------------------------------------------------- */
CREATE TABLE lookup.LogEventType
(
    LogEventTypeId  TINYINT         IDENTITY(1,1)   NOT NULL,
    Code            VARCHAR(30)                     NOT NULL,
    Name            NVARCHAR(100)                   NOT NULL,
    Description     NVARCHAR(255)                   NULL,
    DisplayOrder    SMALLINT                        NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_LogEventType_IsActive DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_LogEventType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    CONSTRAINT PK_LogEventType PRIMARY KEY CLUSTERED (LogEventTypeId),
    CONSTRAINT UQ_LogEventType_Code UNIQUE (Code)
);
GO