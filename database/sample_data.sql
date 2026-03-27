INSERT INTO roles (name) VALUES ('Junior Manual Tester'), ('Business Analyst'), ('Java Developer');

INSERT INTO skills (name) VALUES ('Test case Design'), ('bug reporting'), ('Regression Testing'), ('Process modelling/BPMN'), ('User Story Writing/Jira'), ('Requirements Gathering'), ('Spring Boot'), ('Unit Testing'), ('SQL & Databse Design');

-- Example linking roles to skills
INSERT INTO role_skills (role_id, skill_id) VALUES 
(1, 1), (1, 2), (1, 3), (2, 4),
(2, 5), (2, 6), (3, 7), (3, 8), (3, 9);
