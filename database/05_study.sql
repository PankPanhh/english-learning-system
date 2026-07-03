/* =====================================================================
   FILE        : 05_study.sql
   MODULE      : Study Domain (Study Engine)
   PURPOSE     : Điều phối trung tâm — StudySession/StudySessionItem theo
                 dõi 1 phiên học, StudyProgress tổng hợp theo (User, Lesson),
                 ReviewSchedule là lịch ôn tập Spaced Repetition theo
                 (User, Vocabulary/Grammar).
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 6
   DEPENDS ON  : 01_lookup.sql, 02_identity.sql, 03_learning.sql
   DESIGN NOTE : ReviewSchedule dùng cùng "arc pattern" như LessonItem —
                 1 lịch ôn gắn với đúng 1 trong 2: Vocabulary hoặc Grammar,
                 KHÔNG gắn theo Lesson, vì một từ có thể xuất hiện ở nhiều
                 Lesson nhưng chỉ cần 1 lịch ôn duy nhất cho mỗi User.
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   study.StudySession — 1 phiên học (Daily Lesson / Review / AI Generate)
   --------------------------------------------------------------------- */
CREATE TABLE study.StudySession
(
    StudySessionId   INT             IDENTITY(1,1)   NOT NULL,
    UserId           INT                             NOT NULL,
    SessionStatusId  TINYINT                         NOT NULL,
    StartedAt        DATETIME2(3)   NOT NULL CONSTRAINT DF_StudySession_StartedAt DEFAULT (SYSUTCDATETIME()),
    CompletedAt      DATETIME2(3)   NULL,
    CreatedAt        DATETIME2(3)   NOT NULL CONSTRAINT DF_StudySession_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt        DATETIME2(3)   NULL,
    IsActive         BIT            NOT NULL CONSTRAINT DF_StudySession_IsActive DEFAULT (1),
    CONSTRAINT PK_StudySession PRIMARY KEY CLUSTERED (StudySessionId)
);
GO

/* ---------------------------------------------------------------------
   study.StudySessionItem — LessonItem nào được học trong session nào
   --------------------------------------------------------------------- */
CREATE TABLE study.StudySessionItem
(
    StudySessionItemId  INT            IDENTITY(1,1)   NOT NULL,
    StudySessionId       INT                           NOT NULL,
    LessonItemId         INT                           NOT NULL,
    SessionStatusId       TINYINT                       NOT NULL,
    DisplayOrder           SMALLINT                     NOT NULL,
    CompletedAt             DATETIME2(3)                NULL,
    CreatedAt               DATETIME2(3)  NOT NULL CONSTRAINT DF_StudySessionItem_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt                DATETIME2(3) NULL,
    CONSTRAINT PK_StudySessionItem PRIMARY KEY CLUSTERED (StudySessionItemId)
);
GO

/* ---------------------------------------------------------------------
   study.StudyProgress — Tiến độ tổng hợp theo (User, Lesson).
   Đây là bảng cache/denormalized có chủ đích cho Dashboard — xem đánh
   giá thiết kế ở tài liệu Phase 1, mục 12.3.
   --------------------------------------------------------------------- */
CREATE TABLE study.StudyProgress
(
    StudyProgressId  INT             IDENTITY(1,1)   NOT NULL,
    UserId           INT                             NOT NULL,
    LessonId         INT                             NOT NULL,
    ProgressPercent  DECIMAL(5,2)   NOT NULL CONSTRAINT DF_StudyProgress_ProgressPercent DEFAULT (0),
    LastStudiedAt    DATETIME2(3)   NULL,
    CreatedAt        DATETIME2(3)   NOT NULL CONSTRAINT DF_StudyProgress_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt        DATETIME2(3)   NULL,
    CONSTRAINT PK_StudyProgress PRIMARY KEY CLUSTERED (StudyProgressId),
    CONSTRAINT UQ_StudyProgress_User_Lesson UNIQUE (UserId, LessonId),
    CONSTRAINT CK_StudyProgress_ProgressPercent CHECK (ProgressPercent BETWEEN 0 AND 100)
);
GO

/* ---------------------------------------------------------------------
   study.ReviewSchedule — Lịch ôn tập Spaced Repetition (SM-2 style)
   --------------------------------------------------------------------- */
CREATE TABLE study.ReviewSchedule
(
    ReviewScheduleId    BIGINT        IDENTITY(1,1)   NOT NULL,
    UserId               INT                          NOT NULL,
    VocabularyId          INT                         NULL,
    GrammarId              INT                        NULL,
    NextReviewAt            DATETIME2(3)               NOT NULL,
    IntervalDays             INT           NOT NULL CONSTRAINT DF_ReviewSchedule_IntervalDays DEFAULT (1),
    EaseFactor                DECIMAL(4,2) NOT NULL CONSTRAINT DF_ReviewSchedule_EaseFactor DEFAULT (2.5),
    RepetitionCount             SMALLINT   NOT NULL CONSTRAINT DF_ReviewSchedule_RepetitionCount DEFAULT (0),
    LastReviewRatingId            TINYINT  NULL,
    CreatedAt                      DATETIME2(3) NOT NULL CONSTRAINT DF_ReviewSchedule_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt                       DATETIME2(3) NULL,
    CONSTRAINT PK_ReviewSchedule PRIMARY KEY CLUSTERED (ReviewScheduleId),
    CONSTRAINT CK_ReviewSchedule_TypeArc CHECK (
        (VocabularyId IS NOT NULL AND GrammarId IS NULL) OR
        (VocabularyId IS NULL AND GrammarId IS NOT NULL)
    ),
    CONSTRAINT CK_ReviewSchedule_EaseFactor CHECK (EaseFactor >= 1.3)
);
GO