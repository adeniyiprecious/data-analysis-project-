CREATE table users_customer (
customer_id INT primary key,
first_name Varchar(60),
last_name Varchar(60),
email Varchar(100),
phone_number Varchar(20)
);

Alter table users_customer
Add gender Varchar(10);

ALTER table users_customer
Add (owner_id INT,
date_of_birth Date);

ALTER table users_customer
RENAME TO users_customuser;


CREATE table savings_savingsaccount (
account_id INT primary key,
owner_id INT,
transaction_date Date,
transaction_type Varchar(20),
amount Decimal(10,2),
foreign key (owner_id) references users_customer(customer_id)
);

Alter table savings_savingsaccount
Add account_number Varchar(150) Not Null;

Alter table savings_savingsaccount
Add balance Decimal(10,2) Not Null;


CREATE table plans_plan (
plan_id INT primary key,
customer_id INT,
plan_name Varchar(70),
plan_type Varchar(70),
description Varchar(100),
duration int,
foreign key (customer_id) references users_customer(customer_id)
);

ALTER table plans_plan
Add owner_id INT;


CREATE table withdrawals_withdrawal
transaction_id INT primary key,
account_id INT,
customer_id INT,
transaction_date Date,
transaction_type Varchar(50),
amount Decimal(10,2)
status Varchar(80),
foreign key (customer_id) references users_customer(customer_id)
);


-- 1. Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

Select 
u.owner_id,
U.first_name,
U.last_name,
SUM(IF(p.plan_type = 'savings', 1, 0)) As savings_count,
SUM(IF(p.plan_type = 'investment', 1, 0)) As investment_count,
IFNULL(SUM(s.balance), 0) As total_deposits
FROM
users_customuser u
JOIN savings_savingsaccount s ON u.owner_id = s.owner_id
JOIN plans_plan p ON s.owner_id = p.owner_id
WHERE
p.plan_type IN ('savings', 'investment')
GROUP BY
u.owner_id,
U.first_name,
U.last_name
HAVING
SUM(IF(p.plan_type = 'savings', 1, 0)) >= 1
AND SUM(IF(p.plan_type = 'investment', 1, 0)) >= 1
ORDER BY
total_deposits DESC;


Select * from users_customuser
Where first_name like 'D%';