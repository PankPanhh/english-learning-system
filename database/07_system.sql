/* =====================================================================
   FILE        : 07_system.sql
   MODULE      : System Domain
   PURPOSE     : Ghi log các sự kiện học tập quan trọng (phục vụ audit,
                 debug và thống kê). Domain này quan sát toàn hệ thống,
                 không domain nào khác phụ thuộc ngược lại System.
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 8
   DEPENDS ON  : 01_lookup.sql, 02_identity.sql
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   system.LearningLog — Log sự kiện học tập
   --------------------------------------------------------------------- */
CREATE TABLE system.LearningLog
(
    LearningLogId    BIGINT         IDENTITY(1,1)   NOT NULL,
    UserId           INT                            NULL,
    LogEventTypeId   TINYINT                        NOT NULL,
    Message          NVARCHAR(500)                  NULL,
    MetadataJson     NVARCHAR(MAX)                  NULL,
    CreatedAt        DATETIME2(3)   NOT NULL CONSTRAINT DF_LearningLog_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_LearningLog PRIMARY KEY CLUSTERED (LearningLogId)
);
GO