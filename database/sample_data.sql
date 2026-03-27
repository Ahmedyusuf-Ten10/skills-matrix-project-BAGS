-- ==========================================================
-- SKILLS MATRIX DATABASE SETUP
-- Includes: Roles, Skills, Users, Targets, and Current Levels
-- ==========================================================

-- 1. CLEANUP (Optional: Un-comment these if you want to reset the tables)
-- DROP TABLE IF EXISTS User_Skills;
-- DROP TABLE IF EXISTS Role_Skills;
-- DROP TABLE IF EXISTS Users;
-- DROP TABLE IF EXISTS Skills;
-- DROP TABLE IF EXISTS Roles;

-- 2. CREATE CORE TABLES
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(100) NOT NULL
);

CREATE TABLE Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    role_id INT,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- 3. CREATE JUNCTION TABLES (The Matrix Logic)
-- Targets: What the role requires (1-3)
CREATE TABLE Role_Skills (
    role_id INT,
    skill_id INT,
    target_level INT CHECK (target_level BETWEEN 1 AND 3),
    PRIMARY KEY (role_id, skill_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

-- Actuals: What the user currently has (0-3)
CREATE TABLE User_Skills (
    user_id INT,
    skill_id INT,
    current_level INT CHECK (current_level BETWEEN 0 AND 3),
    last_updated DATE,
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

-- 4. INSERT DATA: ROLES
INSERT INTO Roles (role_name) VALUES 
('Java Developer'), 
('Business Analyst'), 
('Junior Manual Tester');

-- 5. INSERT DATA: SKILLS
INSERT INTO Skills (skill_name) VALUES 
('Spring Boot'), ('Unit Testing'), ('SQL'),           -- IDs 1, 2, 3
('Requirements Gathering'), ('User Story Writing'),    -- IDs 4, 5
('Bug Reporting'), ('Test Case Design');              -- IDs 6, 7

-- 6. INSERT DATA: USERS
-- (Assuming IDs match the order of insertion above)
INSERT INTO Users (full_name, role_id) VALUES 
('Ahmed', 1),    -- Java Developer
('Barkesu', 2),  -- Business Analyst
('Selena', 2),   -- Business Analyst
('Genna', 3);    -- Junior Manual Tester

-- 7. INSERT DATA: ROLE TARGETS (The Benchmarks)
-- Java Developer (Role 1)
INSERT INTO Role_Skills (role_id, skill_id, target_level) VALUES (1, 1, 3), (1, 2, 2), (1, 3, 2);
-- Business Analyst (Role 2)
INSERT INTO Role_Skills (role_id, skill_id, target_level) VALUES (2, 4, 3), (2, 5, 3), (2, 3, 1);
-- Junior Manual Tester (Role 3)
INSERT INTO Role_Skills (role_id, skill_id, target_level) VALUES (3, 6, 2), (3, 7, 2);

-- 8. INSERT DATA: USER ACTUALS (Current Proficiency)
-- Ahmed (Met targets)
INSERT INTO User_Skills (user_id, skill_id, current_level, last_updated) VALUES 
(1, 1, 3, '2026-03-27'), (1, 2, 2, '2026-03-27'), (1, 3, 2, '2026-03-27');
-- Barkesu (High performer)
INSERT INTO User_Skills (user_id, skill_id, current_level, last_updated) VALUES 
(2, 4, 3, '2026-03-27'), (2, 5, 3, '2026-03-27'), (2, 3, 2, '2026-03-27');
-- Selena (New BA with gaps)
INSERT INTO User_Skills (user_id, skill_id, current_level, last_updated) VALUES 
(3, 4, 1, '2026-03-27'), (3, 5, 2, '2026-03-27'), (3, 3, 1, '2026-03-27');
-- Genna (Junior learning)
INSERT INTO User_Skills (user_id, skill_id, current_level, last_updated) VALUES 
(4, 6, 1, '2026-03-27'), (4, 7, 2, '2026-03-27');

-- 9. VERIFICATION QUERY (Gap Analysis)
SELECT 
    u.full_name AS Name,
    r.role_name AS Role,
    s.skill_name AS Skill,
    rs.target_level AS Target,
    COALESCE(us.current_level, 0) AS Current,
    (rs.target_level - COALESCE(us.current_level, 0)) AS Gap
FROM Users u
JOIN Roles r ON u.role_id = r.role_id
JOIN Role_Skills rs ON r.role_id = rs.role_id
JOIN Skills s ON rs.skill_id = s.skill_id
LEFT JOIN User_Skills us ON u.user_id = us.user_id AND s.skill_id = us.skill_id
ORDER BY Gap DESC; 
