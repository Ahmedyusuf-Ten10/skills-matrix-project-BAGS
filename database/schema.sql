-- Table for tech roles
CREATE TABLE roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Table for skills
CREATE TABLE skills (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

-- Table linking roles to skills
CREATE TABLE role_skills (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_id INTEGER,
    skill_id INTEGER,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);

-- Table for users (if you want tracking)
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT
);

-- Table for user progress
CREATE TABLE user_progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    skill_id INTEGER,
    level INTEGER DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);

-- Table for SMART targets
CREATE TABLE smart_targets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    skill_id INTEGER,
    target TEXT,
    deadline DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (skill_id) REFERENCES skills(id)
);
