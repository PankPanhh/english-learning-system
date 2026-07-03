/* =====================================================================
   FILE        : 03_learning.sql
   MODULE      : Learning Domain
   PURPOSE     : Lesson (vỏ bài học), LessonItem (hạt nhân nội dung),
                 Vocabulary & Grammar (master data, tái sử dụng được).
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 4
   DEPENDS ON  : 01_lookup.sql — FK thực tế được thêm ở 08_constraints.sql
   DESIGN NOTE : LessonItem KHÔNG nhúng dữ liệu Vocabulary/Grammar trực
                 tiếp mà chỉ tham chiếu (FK nullable — "arc pattern"),
                 để một từ/một điểm ngữ pháp có thể dùng lại ở nhiều Lesson
                 và ReviewSchedule tính SRS đúng theo đơn vị kiến thức.
                 CK_LessonItem_TypeArc đảm bảo đúng 1 trong 2 FK được set.
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   learning.Lesson — Vỏ ngoài của 1 bài học
   --------------------------------------------------------------------- */
CREATE TABLE learning.Lesson
(
    LessonId        INT             IDENTITY(1,1)   NOT NULL,
    Title           NVARCHAR(200)                   NOT NULL,
    TopicId         SMALLINT                        NULL,
    LevelId         TINYINT                         NOT NULL,
    LessonTypeId    TINYINT                         NOT NULL,
    IsAIGenerated   BIT             NOT NULL CONSTRAINT DF_Lesson_IsAIGenerated DEFAULT (0),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Lesson_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Lesson_IsActive DEFAULT (1),
    CONSTRAINT PK_Lesson PRIMARY KEY CLUSTERED (LessonId)
);
GO

/* ---------------------------------------------------------------------
   learning.Vocabulary — Từ vựng gốc (master data, dùng lại được)
   --------------------------------------------------------------------- */
CREATE TABLE learning.Vocabulary
(
    VocabularyId    INT             IDENTITY(1,1)   NOT NULL,
    Word            NVARCHAR(100)                   NOT NULL,
    IPA             NVARCHAR(100)                   NULL,
    Meaning         NVARCHAR(500)                   NOT NULL,
    PartOfSpeechId  TINYINT                         NULL,
    ExampleSentence NVARCHAR(500)                   NULL,
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Vocabulary_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Vocabulary_IsActive DEFAULT (1),
    CONSTRAINT PK_Vocabulary PRIMARY KEY CLUSTERED (VocabularyId),
    CONSTRAINT UQ_Vocabulary_Word_PartOfSpeech UNIQUE (Word, PartOfSpeechId)
);
GO

/* ---------------------------------------------------------------------
   learning.Grammar — Điểm ngữ pháp gốc (master data, dùng lại được)
   --------------------------------------------------------------------- */
CREATE TABLE learning.Grammar
(
    GrammarId       INT             IDENTITY(1,1)   NOT NULL,
    Title           NVARCHAR(200)                   NOT NULL,
    Structure       NVARCHAR(500)                   NOT NULL,
    Explanation     NVARCHAR(1000)                  NULL,
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_Grammar_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_Grammar_IsActive DEFAULT (1),
    CONSTRAINT PK_Grammar PRIMARY KEY CLUSTERED (GrammarId)
);
GO

/* ---------------------------------------------------------------------
   learning.LessonItem — Hạt nhân nội dung, có thứ tự hiển thị.
   Frontend chỉ cần đọc danh sách LessonItem theo DisplayOrder để render;
   AI chỉ cần sinh JSON theo LessonItemType.
   --------------------------------------------------------------------- */
CREATE TABLE learning.LessonItem
(
    LessonItemId        INT             IDENTITY(1,1)   NOT NULL,
    LessonId             INT                            NOT NULL,
    LessonItemTypeId     TINYINT                        NOT NULL,
    VocabularyId         INT                            NULL,
    GrammarId            INT                            NULL,
    DisplayOrder          SMALLINT                       NOT NULL,
    CreatedAt             DATETIME2(3)   NOT NULL CONSTRAINT DF_LessonItem_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt             DATETIME2(3)   NULL,
    IsActive              BIT            NOT NULL CONSTRAINT DF_LessonItem_IsActive DEFAULT (1),
    CONSTRAINT PK_LessonItem PRIMARY KEY CLUSTERED (LessonItemId),
    CONSTRAINT CK_LessonItem_TypeArc CHECK (
        (VocabularyId IS NOT NULL AND GrammarId IS NULL) OR
        (VocabularyId IS NULL AND GrammarId IS NOT NULL)
    ),
    CONSTRAINT CK_LessonItem_DisplayOrder CHECK (DisplayOrder >= 0)
);
GO