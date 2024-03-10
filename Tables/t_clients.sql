--клиенты/покупатели
CREATE TABLE clients
(
	client_id SERIAL PRIMARY KEY,
	client_name VARCHAR,
	age SMALLINT,
	json_data JSONB
);
