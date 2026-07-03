/* =====================================================================
   FILE        : run_all.sql
   PURPOSE     : Chạy toàn bộ script theo đúng thứ tự để dựng hoàn chỉnh
                 database EnglishLearningDB chỉ bằng 1 lần chạy.
   TARGET      : Microsoft SQL Server 2022
   HOW TO RUN  : Mở file này trong SSMS/Azure Data Studio, BẬT SQLCMD
                 Mode (SSMS: menu Query > SQLCMD Mode), rồi Execute.
                 Nếu không dùng SQLCMD Mode, mở và chạy tuần tự từng
                 file 00 → 10 theo đúng thứ tự bên dưới.
   NOTE        : Đường dẫn :r là tương đối theo thư mục chứa run_all.sql
                 — đảm bảo toàn bộ 12 file nằm cùng 1 thư mục.
   ===================================================================== */

:r .\00_database.sql
:r .\01_lookup.sql
:r .\02_identity.sql
:r .\03_learning.sql
:r .\04_assessment.sql
:r .\05_study.sql
:r .\06_ai.sql
:r .\07_system.sql
:r .\08_constraints.sql
:r .\09_indexes.sql
:r .\10_seed_data.sql

PRINT N'EnglishLearningDB đã được dựng xong đầy đủ: schema, bảng, foreign key, index, seed data.';
GO