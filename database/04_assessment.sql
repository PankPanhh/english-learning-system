/* =====================================================================
   FILE        : 04_assessment.sql
   MODULE      : Assessment Domain
   PURPOSE     : Quiz gắn với LessonItem (không gắn Lesson) để AI có thể
                 sinh câu hỏi cho từng phần nhỏ của bài học.
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 5
   DEPENDS ON  : 01_lookup.sql, 03_learning.sql, 02_identity.sql,
                 05_study.sql (StudySession — FK forward reference,
                 xem ghi chú bên dưới)
   NOTE        : QuizAttempt.StudySessionId tham chiếu study.StudySession,
                 bảng này được TẠO SAU (05_study.sql). Đây chính là lý do
                 toàn bộ Foreign Key được tách riêng ra 08_constraints.sql
                 thay vì khai báo inline — tránh lỗi thứ tự phụ thuộc.
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   assessment.Quiz — Câu hỏi kiểm tra, gắn 1 LessonItem
   --------------------------------------------------------------------- */
CREATE TABLE assessment.Quiz
(
    QuizId          INT             IDENTITY(1,1)   NOT NULL,
    LessonItemId    INT                             NOT NULL,
    QuizTypeId      TINYINT                         NOT NULL,
    QuestionText    NVARCHAR(500)                   NOT NULL,
    DifficultyId    TINYINT                         NULL,
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Quiz_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Quiz_IsActive DEFAULT (1),
    CONSTRAINT PK_Quiz PRIMARY KEY CLUSTERED (QuizId)
);
GO

/* ---------------------------------------------------------------------
   assessment.QuizOption — Đáp án của Quiz (dạng trắc nghiệm)
   --------------------------------------------------------------------- */
CREATE TABLE assessment.QuizOption
(
    QuizOptionId    INT             IDENTITY(1,1)   NOT NULL,
    QuizId          INT                             NOT NULL,
    OptionText      NVARCHAR(300)                   NOT NULL,
    IsCorrect       BIT             NOT NULL CONSTRAINT DF_QuizOption_IsCorrect DEFAULT (0),
    DisplayOrder    SMALLINT                        NOT NULL,
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_QuizOption_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_QuizOption_IsActive DEFAULT (1),
    CONSTRAINT PK_QuizOption PRIMARY KEY CLUSTERED (QuizOptionId)
);
GO

/* ---------------------------------------------------------------------
   assessment.QuizAttempt — Lượt làm bài của User
   (không giới hạn số lần làm lại 1 Quiz ở tầng DB — xử lý ở tầng ứng dụng
   nếu nghiệp vụ cần giới hạn)
   --------------------------------------------------------------------- */
CREATE TABLE assessment.QuizAttempt
(
    QuizAttemptId    BIGINT         IDENTITY(1,1)   NOT NULL,
    QuizId           INT                            NOT NULL,
    UserId           INT                            NOT NULL,
    StudySessionId   INT                            NULL,
    SelectedOptionId INT                             NULL,
    IsCorrect        BIT                            NOT NULL,
    AttemptedAt      DATETIME2(3)   NOT NULL CONSTRAINT DF_QuizAttempt_AttemptedAt DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_QuizAttempt PRIMARY KEY CLUSTERED (QuizAttemptId)
);
GO