USE sakila;
SELECT actor_id,first_name
FROM actor; # câu lệnh lấy ra 2 cột của bảng actor

SELECT *
FROM address; # lấy ra tất cả các cột của bảng
SELECT distinct *
FROM city; # lấy ra các giá trị duy nhất của tất cả các cột của bảng city

SELECT *
FROM address
WHERE city_id>200; # lấy dữ liệu với điều kiện

#lấy dữ liệu trong bảng payment với điều kiện giá trị amount >1.99 và sắp xếp theo thứ tự tăng dần
SELECT rental_id,amount,payment_date
FROM payment
WHERE amount >1.99
ORDER BY payment_date ASC; # nếu giảm dần thì thay ASC-> DESC

# Thêm một cột mới không có sẵn trong bảng file
SELECT amount, amount*10
FROM payment;

# Gán tên cho cột mới
SELECT *,
(amount*10) AS "AM"
FROM payment;

# Toán tử "AND" "OR" "NOT"
SELECT *
FROM rental
WHERE (customer_id >100) AND  NOT (inventory_id >1000 OR inventory_id < 10);

# Toán tử IN lấy ra dữ liệu với nhiều đk đồng thời
SELECT *
FROM rental
WHERE rental_id IN ( 4364,15788,6999);

# LIKE được sử dụng trong các biểu thức điều kiện của biến dạng ký tự
#(string). Giả sử bạn không nhớ chính xác tên mã sản phẩm, chỉ nhớ mã sản phẩm bắt đầu bằng ‘BA

Select *
from film
where (release_year =2006) and title like "BA%";
 
# có chứa OON
Select *
from film
where (release_year =2006) and title like "BA%" and title like "%OON%";

# toán tử LIMIT : giới hạn số dòng khi lấy dữ liệu
Select *
from film
limit 20; #20 dòng đầu tiên

Select *
from film
limit 10,20; # 20 dòng từ dòng thứ 10