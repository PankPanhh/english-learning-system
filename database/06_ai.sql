/* =====================================================================
   FILE        : 06_ai.sql
   MODULE      : AI Domain
   PURPOSE     : Lưu prompt template dùng để sinh nội dung (AIPrompt) và
                 kết quả thô AI trả về, chờ duyệt trước khi chuyển hoá
                 thành Lesson/LessonItem chính thức (AIContent).
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 7
   DEPENDS ON  : 01_lookup.sql, 03_learning.sql
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   ai.AIPrompt — Prompt template dùng để gọi AI sinh bài học
   --------------------------------------------------------------------- */
CREATE TABLE ai.AIPrompt
(
    AIPromptId      INT             IDENTITY(1,1)   NOT NULL,
    Name            NVARCHAR(150)                   NOT NULL,
    PromptTemplate  NVARCHAR(MAX)                   NOT NULL,
    Version         INT             NOT NULL CONSTRAINT DF_AIPrompt_Version DEFAULT (1),
    CreatedAt       DATETIME2(3)    NOT NULL CONSTRAINT DF_AIPrompt_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt       DATETIME2(3)    NULL,
    IsActive        BIT             NOT NULL CONSTRAINT DF_AIPrompt_IsActive DEFAULT (1),
    CONSTRAINT PK_AIPrompt PRIMARY KEY CLUSTERED (AIPromptId)
);
GO

/* ---------------------------------------------------------------------
   ai.AIContent — Nội dung thô AI trả về, chờ duyệt trước khi publish.
   LessonId NULL nếu nội dung chưa được chuyển hoá thành Lesson chính thức.
   --------------------------------------------------------------------- */
CREATE TABLE ai.AIContent
(
    AIContentId        BIGINT        IDENTITY(1,1)   NOT NULL,
    AIPromptId         INT                           NOT NULL,
    LessonId           INT                           NULL,
    RawResponse        NVARCHAR(MAX)                 NOT NULL,
    AIContentStatusId  TINYINT                       NOT NULL,
    GeneratedAt        DATETIME2(3)  NOT NULL CONSTRAINT DF_AIContent_GeneratedAt DEFAULT (SYSUTCDATETIME()),
    ReviewedAt         DATETIME2(3)  NULL,
    CONSTRAINT PK_AIContent PRIMARY KEY CLUSTERED (AIContentId)
);
GO