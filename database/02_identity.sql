/* =====================================================================
   FILE        : 02_identity.sql
   MODULE      : Identity Domain
   PURPOSE     : Quản lý người dùng của hệ thống.
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 3
   DEPENDS ON  : 01_lookup.sql (Level) — FK thực tế được thêm ở 08_constraints.sql
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   [identity].User — Người học
   --------------------------------------------------------------------- */
CREATE TABLE [identity].[User]
(
    UserId              INT             IDENTITY(1,1)   NOT NULL,
    Email               VARCHAR(256)                    NOT NULL,
    PasswordHash        VARBINARY(256)                  NOT NULL,
    FullName            NVARCHAR(150)                   NOT NULL,
    LevelId             TINYINT                         NULL,
    TimeZone            VARCHAR(50)                     NULL CONSTRAINT DF_User_TimeZone DEFAULT ('UTC'),
    DailyGoalMinutes    SMALLINT                        NULL CONSTRAINT DF_User_DailyGoalMinutes DEFAULT (15),
    LastLoginAt         DATETIME2(3)                    NULL,
    CreatedAt           DATETIME2(3)    NOT NULL CONSTRAINT DF_User_CreatedAt DEFAULT (SYSUTCDATETIME()),
    UpdatedAt           DATETIME2(3)    NULL,
    IsActive            BIT             NOT NULL CONSTRAINT DF_User_IsActive DEFAULT (1),
    CONSTRAINT PK_User PRIMARY KEY CLUSTERED (UserId),
    CONSTRAINT UQ_User_Email UNIQUE (Email),
    CONSTRAINT CK_User_DailyGoalMinutes CHECK (DailyGoalMinutes IS NULL OR DailyGoalMinutes > 0)
);
GO