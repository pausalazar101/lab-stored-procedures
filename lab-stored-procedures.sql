USE sakila;
-- 1.

DELIMITER //

CREATE PROCEDURE GetCustomersRentingActionMovies()
BEGIN
  SELECT
    c.first_name,
    c.last_name,
    c.email
  FROM
    customer c
  JOIN
    rental r ON c.customer_id = r.customer_id
  JOIN
    inventory i ON r.inventory_id = i.inventory_id
  JOIN
    film f ON f.film_id = i.film_id
  JOIN
    film_category fc ON fc.film_id = f.film_id
  JOIN
    category cat ON cat.category_id = fc.category_id
  WHERE
    cat.name = 'Action'
  GROUP BY
    c.first_name,
    c.last_name,
    c.email;
END //

DELIMITER ;

CALL GetCustomersRentingActionMovies();

-- 2.
DELIMITER //

CREATE PROCEDURE GetCustomersByCategory(IN categoryName VARCHAR(255))
BEGIN
  SELECT
    c.first_name,
    c.last_name,
    c.email
  FROM
    customer c
  JOIN
    rental r ON c.customer_id = r.customer_id
  JOIN
    inventory i ON r.inventory_id = i.inventory_id
  JOIN
    film f ON f.film_id = i.film_id
  JOIN
    film_category fc ON fc.film_id = f.film_id
  JOIN
    category cat ON cat.category_id = fc.category_id
  WHERE
    cat.name = categoryName
  GROUP BY
    c.first_name,
    c.last_name,
    c.email;
END //

DELIMITER ;

CALL GetCustomersByCategory('Action');

-- 3.1
SELECT
  c.name AS category_name,
  COUNT(f.film_id) AS movie_count
FROM
  category c
JOIN
  film_category fc ON c.category_id = fc.category_id
JOIN
  film f ON fc.film_id = f.film_id
GROUP BY
  c.name;
  
-- 3.2
DELIMITER //

CREATE PROCEDURE GetCategoriesByMovieCount(IN minMovieCount INT)
BEGIN
  SELECT
    c.name AS category_name,
    COUNT(f.film_id) AS movie_count
  FROM
    category c
  JOIN
    film_category fc ON c.category_id = fc.category_id
  JOIN
    film f ON fc.film_id = f.film_id
  GROUP BY
    c.name
  HAVING
    COUNT(f.film_id) > minMovieCount;
END //

DELIMITER ;

CALL GetCategoriesByMovieCount(60);



