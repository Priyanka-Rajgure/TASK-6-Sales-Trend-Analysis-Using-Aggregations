mysql> CREATE DATABASE online_sales;
Query OK, 1 row affected (0.13 sec)

mysql> USE online_sales;
Database changed
mysql> CREATE TABLE orders (
    ->     order_id INT AUTO_INCREMENT PRIMARY KEY,   
    ->     order_date DATE NOT NULL,                  
    ->     amount DECIMAL(10,2) NOT NULL,             
    ->     product_id INT NOT NULL                    
    ->     );
Query OK, 0 rows affected (1.31 sec)

mysql> desc orders;
+------------+---------------+------+-----+---------+----------------+
| Field      | Type          | Null | Key | Default | Extra          |
+------------+---------------+------+-----+---------+----------------+
| order_id   | int(11)       | NO   | PRI | NULL    | auto_increment |
| order_date | date          | NO   |     | NULL    |                |
| amount     | decimal(10,2) | NO   |     | NULL    |                |
| product_id | int(11)       | NO   |     | NULL    |                |
+------------+---------------+------+-----+---------+----------------+
4 rows in set (0.22 sec)

mysql> INSERT INTO orders (order_date, amount, product_id)
    -> VALUES
    -> ('2023-01-05', 250.00, 101),
    -> ('2023-01-12', 180.50, 102),
    -> ('2023-02-03', 320.00, 103),
    -> ('2023-02-15', 150.75, 101),
    -> ('2023-03-07', 500.00, 104),
    -> ('2023-03-18', 275.25, 105),
    -> ('2023-04-10', 420.00, 106),
    -> ('2023-04-22', 350.00, 103),
    -> ('2023-05-05', 600.00, 107),
    -> ('2023-05-19', 210.40, 101);
Query OK, 10 rows affected (0.15 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> select * from orders;
+----------+------------+--------+------------+
| order_id | order_date | amount | product_id |
+----------+------------+--------+------------+
|        1 | 2023-01-05 | 250.00 |        101 |
|        2 | 2023-01-12 | 180.50 |        102 |
|        3 | 2023-02-03 | 320.00 |        103 |
|        4 | 2023-02-15 | 150.75 |        101 |
|        5 | 2023-03-07 | 500.00 |        104 |
|        6 | 2023-03-18 | 275.25 |        105 |
|        7 | 2023-04-10 | 420.00 |        106 |
|        8 | 2023-04-22 | 350.00 |        103 |
|        9 | 2023-05-05 | 600.00 |        107 |
|       10 | 2023-05-19 | 210.40 |        101 |
+----------+------------+--------+------------+
10 rows in set (0.00 sec)

mysql> SELECT
    ->     YEAR(order_date) AS order_year,
    ->     EXTRACT(MONTH FROM order_date) AS order_month,
    ->     SUM(amount) AS total_revenue,
    ->     COUNT(DISTINCT order_id) AS order_volume
    -> FROM
    ->     online_sales.orders
    -> WHERE
    ->     order_date BETWEEN '2023-01-01' AND '2023-12-31'   
    -> GROUP BY
    ->     YEAR(order_date), EXTRACT(MONTH FROM order_date)
    -> ORDER BY
    ->     order_year ASC, order_month ASC;
+------------+-------------+---------------+--------------+
| order_year | order_month | total_revenue | order_volume |
+------------+-------------+---------------+--------------+
|       2023 |           1 |        430.50 |            2 |
|       2023 |           2 |        470.75 |            2 |
|       2023 |           3 |        775.25 |            2 |
|       2023 |           4 |        770.00 |            2 |
|       2023 |           5 |        810.40 |            2 |
+------------+-------------+---------------+--------------+
5 rows in set (0.08 sec)

mysql>