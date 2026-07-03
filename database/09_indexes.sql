/* =====================================================================
   FILE        : 09_indexes.sql
   MODULE      : Indexes
   PURPOSE     : Non-Clustered Index cho toàn bộ Foreign Key (tránh table
                 scan khi JOIN) và cho các cột được truy vấn thường xuyên
                 (vd ReviewSchedule.NextReviewAt chạy mỗi ngày để lấy
                 "cần ôn hôm nay").
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 10 (chạy sau 08_constraints.sql)
   NAMING      : IX_{Table}_{Column(s)}
   ===================================================================== */

USE EnglishLearningDB;
GO

/* Identity */
CREATE NONCLUSTERED INDEX IX_User_LevelId ON [identity].[User] (LevelId);
GO

/* Learning */
CREATE NONCLUSTERED INDEX IX_Lesson_TopicId ON learning.Lesson (TopicId);
GO
CREATE NONCLUSTERED INDEX IX_Lesson_LevelId ON learning.Lesson (LevelId);
GO
CREATE NONCLUSTERED INDEX IX_Lesson_LessonTypeId ON learning.Lesson (LessonTypeId);
GO
CREATE NONCLUSTERED INDEX IX_Vocabulary_PartOfSpeechId ON learning.Vocabulary (PartOfSpeechId);
GO
CREATE NONCLUSTERED INDEX IX_LessonItem_LessonId ON learning.LessonItem (LessonId, DisplayOrder);
GO
CREATE NONCLUSTERED INDEX IX_LessonItem_LessonItemTypeId ON learning.LessonItem (LessonItemTypeId);
GO
CREATE NONCLUSTERED INDEX IX_LessonItem_VocabularyId ON learning.LessonItem (VocabularyId);
GO
CREATE NONCLUSTERED INDEX IX_LessonItem_GrammarId ON learning.LessonItem (GrammarId);
GO

/* Assessment */
CREATE NONCLUSTERED INDEX IX_Quiz_LessonItemId ON assessment.Quiz (LessonItemId);
GO
CREATE NONCLUSTERED INDEX IX_Quiz_QuizTypeId ON assessment.Quiz (QuizTypeId);
GO
CREATE NONCLUSTERED INDEX IX_Quiz_DifficultyId ON assessment.Quiz (DifficultyId);
GO
CREATE NONCLUSTERED INDEX IX_QuizOption_QuizId ON assessment.QuizOption (QuizId);
GO
CREATE NONCLUSTERED INDEX IX_QuizAttempt_QuizId ON assessment.QuizAttempt (QuizId);
GO
CREATE NONCLUSTERED INDEX IX_QuizAttempt_UserId ON assessment.QuizAttempt (UserId);
GO
CREATE NONCLUSTERED INDEX IX_QuizAttempt_StudySessionId ON assessment.QuizAttempt (StudySessionId);
GO
CREATE NONCLUSTERED INDEX IX_QuizAttempt_SelectedOptionId ON assessment.QuizAttempt (SelectedOptionId);
GO

/* Study */
CREATE NONCLUSTERED INDEX IX_StudySession_UserId_StartedAt ON study.StudySession (UserId, StartedAt DESC);
GO
CREATE NONCLUSTERED INDEX IX_StudySession_SessionStatusId ON study.StudySession (SessionStatusId);
GO
CREATE NONCLUSTERED INDEX IX_StudySessionItem_StudySessionId ON study.StudySessionItem (StudySessionId, DisplayOrder);
GO
CREATE NONCLUSTERED INDEX IX_StudySessionItem_LessonItemId ON study.StudySessionItem (LessonItemId);
GO
CREATE NONCLUSTERED INDEX IX_StudyProgress_UserId ON study.StudyProgress (UserId);
GO
CREATE NONCLUSTERED INDEX IX_StudyProgress_LessonId ON study.StudyProgress (LessonId);
GO
CREATE NONCLUSTERED INDEX IX_ReviewSchedule_UserId_NextReviewAt ON study.ReviewSchedule (UserId, NextReviewAt);
GO
CREATE NONCLUSTERED INDEX IX_ReviewSchedule_VocabularyId ON study.ReviewSchedule (VocabularyId);
GO
CREATE NONCLUSTERED INDEX IX_ReviewSchedule_GrammarId ON study.ReviewSchedule (GrammarId);
GO

/* AI */
CREATE NONCLUSTERED INDEX IX_AIContent_AIPromptId ON ai.AIContent (AIPromptId);
GO
CREATE NONCLUSTERED INDEX IX_AIContent_LessonId ON ai.AIContent (LessonId);
GO
CREATE NONCLUSTERED INDEX IX_AIContent_AIContentStatusId ON ai.AIContent (AIContentStatusId);
GO

/* System */
CREATE NONCLUSTERED INDEX IX_LearningLog_UserId ON system.LearningLog (UserId);
GO
CREATE NONCLUSTERED INDEX IX_LearningLog_LogEventTypeId ON system.LearningLog (LogEventTypeId);
GO
CREATE NONCLUSTERED INDEX IX_LearningLog_CreatedAt ON system.LearningLog (CreatedAt DESC);
GO