/* =====================================================================
   FILE        : 00_database.sql
   MODULE      : Database & Schema Initialization
   PURPOSE     : Tạo database EnglishLearningDB và các schema theo Domain
                 (Lookup, Identity, Learning, Assessment, Study, AI, System)
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 1 (phải chạy đầu tiên)
   NOTE        : Mỗi CREATE SCHEMA phải là câu lệnh đầu tiên trong batch
                 nên mỗi statement được tách riêng bằng GO.
   ===================================================================== */

IF DB_ID(N'EnglishLearningDB') IS NULL
BEGIN
    CREATE DATABASE EnglishLearningDB;
END
GO

USE EnglishLearningDB;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

/* ---------------------------------------------------------------------
   Schema: lookup — chứa toàn bộ bảng danh mục dùng chung (Level, Topic...)
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'lookup')
    EXEC(N'CREATE SCHEMA lookup AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: identity — quản lý người dùng
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'identity')
    EXEC(N'CREATE SCHEMA [identity] AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: learning — Lesson / LessonItem / Vocabulary / Grammar
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'learning')
    EXEC(N'CREATE SCHEMA learning AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: assessment — Quiz / QuizOption / QuizAttempt
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'assessment')
    EXEC(N'CREATE SCHEMA assessment AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: study — StudySession / StudySessionItem / StudyProgress /
                   ReviewSchedule (Study Engine)
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'study')
    EXEC(N'CREATE SCHEMA study AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: ai — AIPrompt / AIContent
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'ai')
    EXEC(N'CREATE SCHEMA ai AUTHORIZATION dbo;');
GO

/* ---------------------------------------------------------------------
   Schema: system — LearningLog
   --------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'system')
    EXEC(N'CREATE SCHEMA system AUTHORIZATION dbo;');
GO