#Q = https://datalemur.com/questions/alibaba-compressed-mean

SELECT 
ROUND(SUM(ITEM_COUNT:: DECIMAL*ORDER_OCCURRENCES)/SUM(ORDER_OCCURRENCES),1) AS MEAN
FROM items_per_order;
