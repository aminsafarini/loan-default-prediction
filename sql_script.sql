		create database if not exists bank;
 
		use bank;
 
		Accounts Table
		create table if not exists accounts(
		        account_id          int,
		        district_id         int,
		        frequency           varchar(255),
		        dt                  date,
		        PRIMARY KEY(account_id)
		);
 
		truncate table accounts;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/account.asc'
		into table accounts
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\n'
		ignore 1 lines
		(account_id,district_id,frequency, @dt)
		SET dt = str_to_date(@dt, '%y%m%d');
 
 
		Clients Table
		drop table if exists clients;
		create table if not exists clients(
		        client_id           int,
		        birth_date          date,
		        district_id         int,
		        gender              varchar(10),
		        PRIMARY KEY(client_id)
		);
		truncate table clients;
 
		create table if not exists clients_0(
		        client_id           int,
		        birth_date          varchar(255),
		        district_id         int
		);
		truncate table clients_0;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/client.asc'
		into table clients_0
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\r\n'
		ignore 1 lines;
 
		;
		insert into clients(client_id,
		                        birth_date,
		                        district_id,
		                        gender)
		select client_id,
		       case when substr(birth_date,3,2) <=12 then str_to_date(concat('19',birth_date),'%Y%m%d')
		       else str_to_date(concat('19',substr(birth_date,1,2),
		                               lpad(substr(birth_date,3,2)-50,2,'0'),substr(birth_date,5,2)),'%Y%m%d') end,
		       district_id,
		       case when substr(birth_date,3,2) <=12 then 'Male' else 'Female' end
		from clients_0;
 
		select * from clients;
 
 
		Disp Table
		create table if not exists disps(
		        disp_id             int,
		        client_id           int,
		        account_id          int,
		        type                varchar(255),
		        PRIMARY KEY(disp_id)
		);
		truncate table disps;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/disp.asc'
		into table disps
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\r\n'
		ignore 1 lines;
 
 
		Orders Table
		create table if not exists orders(
		        order_id            int,
		        account_id          int,
		        bank_to             varchar(255),
		        account_to          int,
		        amount              decimal(10,2),
		        k_symbol            varchar(255),
		        PRIMARY KEY(order_id)
		);
		truncate table orders;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/order.asc'
		into table orders
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\r\n'
		ignore 1 lines;
 
 
		Loans Table
		create table if not exists loans(
		        loan_id             int,
		        account_id          int,
		        loan_date           date,
		        amount              int,
		        duration            int,
		        payments            decimal(10,2),
		        status              varchar(255),
		        PRIMARY KEY(loan_id)
		);
		truncate table loans;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/loan.asc'
		into table loans
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\r\n'
		ignore 1 lines
		(loan_id,account_id, @loan_date, amount,duration,payments,status)
		SET loan_date = str_to_date(@loan_date,'%y%m%d');
 
 
		Cards Table
		create table if not exists cards(
		        card_id             int,
		        disp_id             int,
		        `type`              varchar(255),
		        issue_date          date,
		        PRIMARY KEY(card_id)
		);
		truncate table cards;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/card.asc'
		into table cards
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\n'
		ignore 1 lines
		(card_id,disp_id,`type`,@issue_date)
		SET issue_date = str_to_date(@issue_date, '%y%m%d');
 
		District Table
		create table if not exists districts(
		        district_id         int,
		        A2                  varchar(225),
		        A3                  varchar(255),
		        A4                  int,
		        A5                  int,
		        A6                  int,
		        A7                  int,
		        A8                  int,
		        A9                  int,
		        A10                 decimal(5,2),
		        A11                 int,
		        A12                 decimal(5,2),
		        A13                 decimal(5,2),
		        A14                 int,
		        A15                 int,
		        A16                 int,
		        PRIMARY KEY(district_id)
		);
		truncate table districts;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/district.asc'
		into table districts
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\n'
		ignore 1 lines;
 
 
		Transaction Table
		create table if not exists trans(
		        trans_id            int,
		        account_id          int,
		        trans_date          date,
		        type                varchar(255),
		        operation           varchar(255),
		        amount              int,
		        balance             int,
		        k_symbol            varchar(255),
		        bank                varchar(255),
		        account             int,
		        PRIMARY KEY(trans_id)
		);
		truncate table trans;
 
		load data local infile '/Users/aminsafarini/Desktop/Midterm/bank_loan_data_files/trans.asc'
		into table trans
		character set 'latin1'
		fields terminated by ';'Enclosed by '"'
		lines terminated by '\r\n'
		ignore 1 lines
		(trans_id,account_id,@trans_date,type, operation,amount,balance,k_symbol,bank,account)
		SET trans_date = str_to_date(@trans_date, '%y%m%d');
 
		Foreign Keys
		ALTER TABLE accounts ADD FOREIGN KEY (district_id) REFERENCES districts(district_id);
		ALTER TABLE cards ADD FOREIGN KEY (disp_id) REFERENCES disps(disp_id);
		ALTER TABLE clients ADD FOREIGN KEY (district_id) REFERENCES districts(district_id);
		ALTER TABLE disps ADD FOREIGN KEY (account_id) REFERENCES accounts(account_id);
		ALTER TABLE disps ADD FOREIGN KEY (client_id) REFERENCES clients(client_id);
		ALTER TABLE loans ADD FOREIGN KEY (account_id) REFERENCES accounts(account_id);
		ALTER TABLE orders ADD FOREIGN KEY (account_id) REFERENCES accounts(account_id);
		ALTER TABLE trans ADD FOREIGN KEY (account_id) REFERENCES accounts(account_id);
 
 
		-- Viewing/Testing tables
		SELECT * FROM accounts LIMIT 5;
		SELECT * FROM cards LIMIT 5;
		SELECT * FROM clients LIMIT 5;
		SELECT * FROM disps LIMIT 5;
		SELECT * FROM districts LIMIT 5;
		SELECT * FROM loans LIMIT 5;
		SELECT * FROM orders LIMIT 5;
		SELECT * FROM trans LIMIT 5;
 
		SELECT *
		FROM loans l -- 682 rows = number of loans
		JOIN
		    (select a.account_id as account_id,
		           a.district_id as district_id,
		           a.frequency,
		           a.dt,
		           d.disp_id as disp_id,
		           d.type,
		           c.client_id,
		           c.gender,
		           c.birth_date
		    FROM clients c
		        JOIN disps d
		            ON c.client_id =d.client_id
		        JOIN accounts a
		            ON a.account_id = d.account_id
		    WHERE d.type = 'OWNER') AS table_1 -- table combining account, disp and client
		    ON l.account_id = table_1.account_id
		JOIN districts d2 ON d2.district_id = table_1.district_id
		-- COMBINING now with trans table for all transactions BEFORE the loan was issued!!!
		JOIN(
		select l.account_id,
		       SUM(CASE WHEN type = 'PRIJEM' AND t.trans_date < l.loan_date
		           THEN t.amount ELSE 0 END) AS sum_of_credits_before_loan,
		       SUM(CASE WHEN type = 'PRIJEM' AND t.trans_date < l.loan_date
		           THEN t.amount ELSE 0 END) AS sum_of_withdrawals_before_loan,
		       MIN(CASE WHEN t.trans_date < l.loan_date
		           THEN t.balance END) AS MIN_balance_before_loan,
		       MAX(CASE WHEN t.trans_date < l.loan_date
		           THEN t.balance END) AS MAX_balance_before_loan,
		       COUNT(CASE WHEN t.trans_date < l.loan_date AND t.balance < 100
		           THEN t.balance END) AS num_times_balance_below_100,
		       AVG(CASE WHEN t.trans_date < l.loan_date AND
		                     t.trans_date BETWEEN (l.loan_date - INTERVAL 30 DAY) AND (l.loan_date - INTERVAL 1 DAY)
		           THEN t.balance END) AS avg_balance_30days_before_loan,
		       AVG(CASE WHEN t.trans_date < l.loan_date
		           THEN t.amount END) AS avg_amount_before_loan
		from trans t
		JOIN loans l on t.account_id = l.account_id
		GROUP BY l.account_id) new_trans_table
		ON new_trans_table.account_id = l.account_id;