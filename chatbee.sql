CREATE DATABASE chatbee;
USE chatbee;

-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    preferred_chatbot ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') DEFAULT 'custom',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Chat History Table
CREATE TABLE Chat_History (
    chat_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    chatbot_used ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') DEFAULT 'custom',
    user_message TEXT NOT NULL,
    bot_response TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE FAQs (
    faq_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,  -- New column to track which user asked the question
    chatbot_type ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- User Settings Table
CREATE TABLE User_Settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    preferred_chatbot ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') DEFAULT 'custom',
    notifications_enabled BOOLEAN DEFAULT TRUE,
    theme ENUM('light', 'dark') DEFAULT 'light',
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

INSERT INTO Users (name, email, password_hash, preferred_chatbot) VALUES
('Pooja Yadav', 'pooja.com', '1234', 'custom'),
('Piyush khachane', 'piyush.com', '678', 'chatgpt'),
('shravani kadu', 'shravani.com', '546', 'deepseek'),
('rushabh kirad', 'rushabh.com', '987', 'perplexity'),
('riddhi sathe', 'riddhi.com', '234', 'custom');

INSERT INTO Chat_History (user_id, chatbot_used, user_message, bot_response) VALUES
(1, 'custom', 'Hello, how are you?', 'I am fine. How can I assist you?'),
(2, 'chatgpt', 'What is AI?', 'AI stands for Artificial Intelligence.'),
(3, 'deepseek', 'Tell me a joke.', 'Why don’t scientists trust atoms? Because they make up everything!'),
(4, 'perplexity', 'Who won the last FIFA World Cup?', 'The last FIFA World Cup was won by Argentina in 2022.'),
(5, 'custom', 'How do I reset my password?', 'You can reset your password from the settings page.');

INSERT INTO FAQs (user_id, chatbot_type, question, answer) VALUES
(1, 'custom', 'How do I use this chatbot?', 'Simply type your query, and I will respond.'),
(2, 'chatgpt', 'What is ChatGPT?', 'ChatGPT is an AI chatbot developed by OpenAI.'),
(3, 'deepseek', 'What makes DeepSeek different?', 'DeepSeek focuses on in-depth AI-powered search responses.'),
(4, 'perplexity', 'How does Perplexity AI work?', 'Perplexity AI is a research-driven chatbot with advanced search capabilities.'),
(5, 'custom', 'Can I change my preferred chatbot?', 'Yes, you can change it in your settings.');


INSERT INTO User_Settings (user_id, preferred_chatbot, notifications_enabled, theme) VALUES
(1, 'custom', TRUE, 'dark'),
(2, 'chatgpt', FALSE, 'light'),
(3, 'deepseek', TRUE, 'dark'),
(4, 'perplexity', TRUE, 'light'),
(5, 'custom', FALSE, 'dark');

select * from FAQs;

select * from User_settings;

INSERT INTO Users (name, email, password_hash, preferred_chatbot) VALUES
('Aarav Sharma', 'aarav.sharma@example.com', 'hashed_password_1', 'custom'),
('Vikram Iyer', 'vikram.iyer@example.com', 'hashed_password_2', 'chatgpt'),
('Neha Gupta', 'neha.gupta@example.com', 'hashed_password_3', 'deepseek'),
('Rajesh Verma', 'rajesh.verma@example.com', 'hashed_password_4', 'perplexity'),
('Pooja Nair', 'pooja.nair@example.com', 'hashed_password_5', 'custom'),
('Sanjay Mehta', 'sanjay.mehta@example.com', 'hashed_password_6', 'chatgpt'),
('Priya Desai', 'priya.desai@example.com', 'hashed_password_7', 'deepseek'),
('Rohan Kulkarni', 'rohan.kulkarni@example.com', 'hashed_password_8', 'perplexity'),
('Meera Choudhary', 'meera.choudhary@example.com', 'hashed_password_9', 'custom'),
('Aniket Joshi', 'aniket.joshi@example.com', 'hashed_password_10', 'chatgpt'),
('Simran Kaur', 'simran.kaur@example.com', 'hashed_password_11', 'deepseek'),
('Arjun Singh', 'arjun.singh@example.com', 'hashed_password_12', 'perplexity'),
('Kavita Mishra', 'kavita.mishra@example.com', 'hashed_password_13', 'custom'),
('Rahul Patil', 'rahul.patil@example.com', 'hashed_password_14', 'chatgpt'),
('Sneha Saxena', 'sneha.saxena@example.com', 'hashed_password_15', 'deepseek');

DROP TABLE IF EXISTS FAQs;

CREATE TABLE FAQs (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    chatbot_type ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    asked_count INT DEFAULT 1,
    last_asked TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO FAQs (chatbot_type, question, answer, asked_count) VALUES
('custom', 'How do I use this chatbot?', 'Simply type your query, and I will respond.', 15),
('chatgpt', 'What is ChatGPT?', 'ChatGPT is an AI chatbot developed by OpenAI.', 10),
('deepseek', 'What makes DeepSeek different?', 'DeepSeek focuses on in-depth AI-powered search responses.', 7),
('perplexity', 'How does Perplexity AI work?', 'Perplexity AI is a research-driven chatbot with advanced search capabilities.', 5),
('custom', 'Can I change my preferred chatbot?', 'Yes, you can change it in your settings.', 12),
('custom', 'How do I reset my password?', 'You can reset your password from the settings page.', 20),
('chatgpt', 'What is the best programming language?', 'The best programming language depends on your needs. Python is great for AI, C++ is great for performance.', 14),
('deepseek', 'How does deep learning work?', 'Deep learning uses neural networks to learn from data.', 9),
('perplexity', 'Who won the last FIFA World Cup?', 'The last FIFA World Cup was won by Argentina in 2022.', 6),
('custom', 'What is data science?', 'Data science involves analyzing and interpreting complex data to make decisions.', 18);

INSERT INTO User_Settings (user_id, preferred_chatbot, notifications_enabled, theme) VALUES
(1, 'custom', TRUE, 'dark'),
(2, 'chatgpt', FALSE, 'light'),
(3, 'deepseek', TRUE, 'dark'),
(4, 'perplexity', TRUE, 'light'),
(5, 'custom', FALSE, 'dark'),
(6, 'chatgpt', TRUE, 'light'),
(7, 'deepseek', TRUE, 'dark'),
(8, 'perplexity', FALSE, 'light'),
(9, 'custom', TRUE, 'dark'),
(10, 'chatgpt', FALSE, 'light'),
(11, 'deepseek', TRUE, 'dark'),
(12, 'perplexity', TRUE, 'light'),
(13, 'custom', FALSE, 'dark'),
(14, 'chatgpt', TRUE, 'light'),
(15, 'deepseek', FALSE, 'dark');

-- Retrieve all users
SELECT * FROM Users;

-- Retrieve chat history of a specific user (e.g., Aarav Sharma)
SELECT * FROM Chat_History WHERE user_id = 1;

-- Retrieve chatbot preferences for all users
SELECT user_id, name, preferred_chatbot FROM Users ORDER BY preferred_chatbot;

-- Retrieve chatbot responses along with user messages
SELECT ch.chat_id, u.name AS user_name, ch.chatbot_used, ch.user_message, ch.bot_response, ch.timestamp 
FROM Chat_History ch 
JOIN Users u ON ch.user_id = u.user_id 
ORDER BY ch.timestamp DESC;

DROP TABLE IF EXISTS FAQs;

CREATE TABLE FAQs (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    chatbot_type ENUM('custom', 'deepseek', 'chatgpt', 'perplexity') NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    asked_count INT DEFAULT 1,
    last_asked TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

INSERT INTO FAQs (user_id, chatbot_type, question, answer, asked_count) VALUES
(1, 'custom', 'How do I use this chatbot?', 'Simply type your query, and I will respond.', 15),
(2, 'chatgpt', 'What is ChatGPT?', 'ChatGPT is an AI chatbot developed by OpenAI.', 10),
(3, 'deepseek', 'What makes DeepSeek different?', 'DeepSeek focuses on in-depth AI-powered search responses.', 7),
(4, 'perplexity', 'How does Perplexity AI work?', 'Perplexity AI is a research-driven chatbot with advanced search capabilities.', 5),
(1, 'custom', 'Can I change my preferred chatbot?', 'Yes, you can change it in your settings.', 12),
(5, 'custom', 'How do I reset my password?', 'You can reset your password from the settings page.', 20),
(2, 'chatgpt', 'What is the best programming language?', 'The best programming language depends on your needs. Python is great for AI, C++ is great for performance.', 14),
(3, 'deepseek', 'How does deep learning work?', 'Deep learning uses neural networks to learn from data.', 9),
(4, 'perplexity', 'Who won the last FIFA World Cup?', 'The last FIFA World Cup was won by Argentina in 2022.', 6),
(5, 'custom', 'What is data science?', 'Data science involves analyzing and interpreting complex data to make decisions.', 18);

SELECT * FROM FAQs WHERE user_id = 1 ORDER BY asked_count DESC;
