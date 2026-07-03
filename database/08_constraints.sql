/* =====================================================================
   FILE        : 08_constraints.sql
   MODULE      : Foreign Key Constraints
   PURPOSE     : Toàn bộ Foreign Key liên bảng của hệ thống. Được tách
                 riêng khỏi các file tạo bảng (01-07) vì một số bảng có
                 quan hệ "forward reference" (vd assessment.QuizAttempt
                 tham chiếu study.StudySession vốn được tạo SAU nó) —
                 tách FK ra file riêng giúp thứ tự chạy 01→07 không bị
                 phụ thuộc vòng và dễ soát toàn bộ quan hệ trong 1 file.
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 9 (chạy sau khi TẤT CẢ bảng ở 01-07 đã được tạo)
   NAMING      : FK_{ChildTable}_{ParentTable}
                 (thêm hậu tố cột khi 1 bảng có 2 FK tới cùng 1 bảng)
   ===================================================================== */

USE EnglishLearningDB;
GO

/* ---------------------------------------------------------------------
   Identity
   --------------------------------------------------------------------- */
ALTER TABLE [identity].[User]
    ADD CONSTRAINT FK_User_Level
        FOREIGN KEY (LevelId) REFERENCES lookup.Level (LevelId);
GO

/* ---------------------------------------------------------------------
   Learning
   --------------------------------------------------------------------- */
ALTER TABLE learning.Lesson
    ADD CONSTRAINT FK_Lesson_Topic
        FOREIGN KEY (TopicId) REFERENCES lookup.Topic (TopicId);
GO
ALTER TABLE learning.Lesson
    ADD CONSTRAINT FK_Lesson_Level
        FOREIGN KEY (LevelId) REFERENCES lookup.Level (LevelId);
GO
ALTER TABLE learning.Lesson
    ADD CONSTRAINT FK_Lesson_LessonType
        FOREIGN KEY (LessonTypeId) REFERENCES lookup.LessonType (LessonTypeId);
GO

ALTER TABLE learning.Vocabulary
    ADD CONSTRAINT FK_Vocabulary_PartOfSpeech
        FOREIGN KEY (PartOfSpeechId) REFERENCES lookup.PartOfSpeech (PartOfSpeechId);
GO

ALTER TABLE learning.LessonItem
    ADD CONSTRAINT FK_LessonItem_Lesson
        FOREIGN KEY (LessonId) REFERENCES learning.Lesson (LessonId);
GO
ALTER TABLE learning.LessonItem
    ADD CONSTRAINT FK_LessonItem_LessonItemType
        FOREIGN KEY (LessonItemTypeId) REFERENCES lookup.LessonItemType (LessonItemTypeId);
GO
ALTER TABLE learning.LessonItem
    ADD CONSTRAINT FK_LessonItem_Vocabulary
        FOREIGN KEY (VocabularyId) REFERENCES learning.Vocabulary (VocabularyId);
GO
ALTER TABLE learning.LessonItem
    ADD CONSTRAINT FK_LessonItem_Grammar
        FOREIGN KEY (GrammarId) REFERENCES learning.Grammar (GrammarId);
GO

/* ---------------------------------------------------------------------
   Assessment
   --------------------------------------------------------------------- */
ALTER TABLE assessment.Quiz
    ADD CONSTRAINT FK_Quiz_LessonItem
        FOREIGN KEY (LessonItemId) REFERENCES learning.LessonItem (LessonItemId);
GO
ALTER TABLE assessment.Quiz
    ADD CONSTRAINT FK_Quiz_QuizType
        FOREIGN KEY (QuizTypeId) REFERENCES lookup.QuizType (QuizTypeId);
GO
ALTER TABLE assessment.Quiz
    ADD CONSTRAINT FK_Quiz_Difficulty
        FOREIGN KEY (DifficultyId) REFERENCES lookup.Difficulty (DifficultyId);
GO

ALTER TABLE assessment.QuizOption
    ADD CONSTRAINT FK_QuizOption_Quiz
        FOREIGN KEY (QuizId) REFERENCES assessment.Quiz (QuizId);
GO

ALTER TABLE assessment.QuizAttempt
    ADD CONSTRAINT FK_QuizAttempt_Quiz
        FOREIGN KEY (QuizId) REFERENCES assessment.Quiz (QuizId);
GO
ALTER TABLE assessment.QuizAttempt
    ADD CONSTRAINT FK_QuizAttempt_User
        FOREIGN KEY (UserId) REFERENCES [identity].[User] (UserId);
GO
ALTER TABLE assessment.QuizAttempt
    ADD CONSTRAINT FK_QuizAttempt_StudySession
        FOREIGN KEY (StudySessionId) REFERENCES study.StudySession (StudySessionId);
GO
ALTER TABLE assessment.QuizAttempt
    ADD CONSTRAINT FK_QuizAttempt_QuizOption
        FOREIGN KEY (SelectedOptionId) REFERENCES assessment.QuizOption (QuizOptionId);
GO

/* ---------------------------------------------------------------------
   Study
   --------------------------------------------------------------------- */
ALTER TABLE study.StudySession
    ADD CONSTRAINT FK_StudySession_User
        FOREIGN KEY (UserId) REFERENCES [identity].[User] (UserId);
GO
ALTER TABLE study.StudySession
    ADD CONSTRAINT FK_StudySession_SessionStatus
        FOREIGN KEY (SessionStatusId) REFERENCES lookup.SessionStatus (SessionStatusId);
GO

ALTER TABLE study.StudySessionItem
    ADD CONSTRAINT FK_StudySessionItem_StudySession
        FOREIGN KEY (StudySessionId) REFERENCES study.StudySession (StudySessionId);
GO
ALTER TABLE study.StudySessionItem
    ADD CONSTRAINT FK_StudySessionItem_LessonItem
        FOREIGN KEY (LessonItemId) REFERENCES learning.LessonItem (LessonItemId);
GO
ALTER TABLE study.StudySessionItem
    ADD CONSTRAINT FK_StudySessionItem_SessionStatus
        FOREIGN KEY (SessionStatusId) REFERENCES lookup.SessionStatus (SessionStatusId);
GO

ALTER TABLE study.StudyProgress
    ADD CONSTRAINT FK_StudyProgress_User
        FOREIGN KEY (UserId) REFERENCES [identity].[User] (UserId);
GO
ALTER TABLE study.StudyProgress
    ADD CONSTRAINT FK_StudyProgress_Lesson
        FOREIGN KEY (LessonId) REFERENCES learning.Lesson (LessonId);
GO

ALTER TABLE study.ReviewSchedule
    ADD CONSTRAINT FK_ReviewSchedule_User
        FOREIGN KEY (UserId) REFERENCES [identity].[User] (UserId);
GO
ALTER TABLE study.ReviewSchedule
    ADD CONSTRAINT FK_ReviewSchedule_Vocabulary
        FOREIGN KEY (VocabularyId) REFERENCES learning.Vocabulary (VocabularyId);
GO
ALTER TABLE study.ReviewSchedule
    ADD CONSTRAINT FK_ReviewSchedule_Grammar
        FOREIGN KEY (GrammarId) REFERENCES learning.Grammar (GrammarId);
GO
ALTER TABLE study.ReviewSchedule
    ADD CONSTRAINT FK_ReviewSchedule_ReviewRating
        FOREIGN KEY (LastReviewRatingId) REFERENCES lookup.ReviewRating (ReviewRatingId);
GO

/* ---------------------------------------------------------------------
   AI
   --------------------------------------------------------------------- */
ALTER TABLE ai.AIContent
    ADD CONSTRAINT FK_AIContent_AIPrompt
        FOREIGN KEY (AIPromptId) REFERENCES ai.AIPrompt (AIPromptId);
GO
ALTER TABLE ai.AIContent
    ADD CONSTRAINT FK_AIContent_Lesson
        FOREIGN KEY (LessonId) REFERENCES learning.Lesson (LessonId);
GO
ALTER TABLE ai.AIContent
    ADD CONSTRAINT FK_AIContent_AIContentStatus
        FOREIGN KEY (AIContentStatusId) REFERENCES lookup.AIContentStatus (AIContentStatusId);
GO

/* ---------------------------------------------------------------------
   System
   --------------------------------------------------------------------- */
ALTER TABLE system.LearningLog
    ADD CONSTRAINT FK_LearningLog_User
        FOREIGN KEY (UserId) REFERENCES [identity].[User] (UserId);
GO
ALTER TABLE system.LearningLog
    ADD CONSTRAINT FK_LearningLog_LogEventType
        FOREIGN KEY (LogEventTypeId) REFERENCES lookup.LogEventType (LogEventTypeId);
GO