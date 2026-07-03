/* =====================================================================
   FILE        : 10_seed_data.sql
   MODULE      : Seed Data
   PURPOSE     : Seed dữ liệu khởi tạo cho toàn bộ bảng Lookup, để hệ
                 thống có thể chạy được ngay sau khi dựng xong database.
   TARGET      : Microsoft SQL Server 2022
   RUN ORDER   : 11
   ===================================================================== */

USE EnglishLearningDB;
GO

/* lookup.Level — chuẩn CEFR */
INSERT INTO lookup.Level (Code, Name, Description, DisplayOrder) VALUES
    (N'A1', N'Beginner',            N'Người mới bắt đầu',                     1),
    (N'A2', N'Elementary',          N'Sơ cấp',                                2),
    (N'B1', N'Intermediate',        N'Trung cấp',                             3),
    (N'B2', N'Upper Intermediate',  N'Trung cấp trên',                        4),
    (N'C1', N'Advanced',            N'Nâng cao',                              5),
    (N'C2', N'Proficiency',         N'Thành thạo gần như người bản ngữ',      6);
GO

/* lookup.LessonType */
INSERT INTO lookup.LessonType (Code, Name, Description, DisplayOrder) VALUES
    (N'VOCAB',   N'Vocabulary Lesson', N'Bài học tập trung từ vựng',       1),
    (N'GRAMMAR', N'Grammar Lesson',    N'Bài học tập trung ngữ pháp',      2),
    (N'MIXED',   N'Mixed Lesson',      N'Bài học kết hợp từ vựng + ngữ pháp', 3),
    (N'READING', N'Reading Lesson',    N'Bài học đọc hiểu (mở rộng sau)',  4),
    (N'LISTENING', N'Listening Lesson', N'Bài học nghe (mở rộng sau)',     5);
GO

/* lookup.LessonItemType — hiện tại chỉ 2 loại theo arc pattern đang dùng */
INSERT INTO lookup.LessonItemType (Code, Name, Description, DisplayOrder) VALUES
    (N'VOCABULARY', N'Vocabulary Item', N'Item là 1 từ vựng',       1),
    (N'GRAMMAR',     N'Grammar Item',    N'Item là 1 điểm ngữ pháp', 2);
GO

/* lookup.PartOfSpeech */
INSERT INTO lookup.PartOfSpeech (Code, Name, DisplayOrder) VALUES
    (N'NOUN',        N'Noun',        1),
    (N'VERB',        N'Verb',        2),
    (N'ADJECTIVE',   N'Adjective',   3),
    (N'ADVERB',      N'Adverb',      4),
    (N'PREPOSITION', N'Preposition', 5),
    (N'PRONOUN',     N'Pronoun',     6),
    (N'CONJUNCTION', N'Conjunction', 7),
    (N'INTERJECTION',N'Interjection',8);
GO

/* lookup.Topic */
INSERT INTO lookup.Topic (Code, Name, DisplayOrder) VALUES
    (N'DAILY_LIFE', N'Daily Life', 1),
    (N'TRAVEL',     N'Travel',     2),
    (N'BUSINESS',   N'Business',   3),
    (N'FOOD',       N'Food & Drink', 4),
    (N'TECHNOLOGY', N'Technology', 5),
    (N'HEALTH',     N'Health',     6),
    (N'EDUCATION',  N'Education',  7),
    (N'FAMILY',     N'Family',     8);
GO

/* lookup.QuizType */
INSERT INTO lookup.QuizType (Code, Name, DisplayOrder) VALUES
    (N'MCQ',        N'Multiple Choice', 1),
    (N'FILL_BLANK', N'Fill in the Blank', 2),
    (N'TRUE_FALSE', N'True / False', 3),
    (N'LISTENING',  N'Listening Question', 4);
GO

/* lookup.Difficulty */
INSERT INTO lookup.Difficulty (Code, Name, DisplayOrder) VALUES
    (N'EASY',   N'Easy',   1),
    (N'MEDIUM', N'Medium', 2),
    (N'HARD',   N'Hard',   3);
GO

/* lookup.SessionStatus */
INSERT INTO lookup.SessionStatus (Code, Name, DisplayOrder) VALUES
    (N'NOT_STARTED', N'Not Started', 1),
    (N'IN_PROGRESS', N'In Progress', 2),
    (N'COMPLETED',   N'Completed',   3),
    (N'SKIPPED',     N'Skipped',     4);
GO

/* lookup.ReviewRating — SM-2 style */
INSERT INTO lookup.ReviewRating (Code, Name, DisplayOrder) VALUES
    (N'AGAIN', N'Again', 1),
    (N'HARD',  N'Hard',  2),
    (N'GOOD',  N'Good',  3),
    (N'EASY',  N'Easy',  4);
GO

/* lookup.AIContentStatus */
INSERT INTO lookup.AIContentStatus (Code, Name, DisplayOrder) VALUES
    (N'PENDING',  N'Pending Review', 1),
    (N'APPROVED', N'Approved',       2),
    (N'REJECTED', N'Rejected',       3);
GO

/* lookup.LogEventType */
INSERT INTO lookup.LogEventType (Code, Name, DisplayOrder) VALUES
    (N'SESSION_STARTED',    N'Study Session Started',   1),
    (N'SESSION_COMPLETED',  N'Study Session Completed', 2),
    (N'ITEM_COMPLETED',     N'Lesson Item Completed',   3),
    (N'AI_CONTENT_GENERATED', N'AI Content Generated',  4),
    (N'QUIZ_ATTEMPTED',     N'Quiz Attempted',          5),
    (N'USER_LOGIN',         N'User Login',              6);
GO