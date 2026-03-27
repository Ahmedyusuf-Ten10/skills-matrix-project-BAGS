INSERT INTO roles (name) VALUES ('Frontend Developer'), ('Backend Developer');

INSERT INTO skills (name) VALUES ('HTML'), ('CSS'), ('JavaScript'), ('React'), ('Node.js'), ('SQL');

-- Example linking roles to skills
INSERT INTO role_skills (role_id, skill_id) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4),
(2, 3), (2, 5), (2, 6);
