#Q = https://datalemur.com/questions/cards-issued-difference

SELECT 
CARD_NAME,
MAX(ISSUED_AMOUNT) -MIN(ISSUED_AMOUNT) AS DIFFERENCE
FROM monthly_cards_issued
GROUP BY CARD_NAME
ORDER BY DIFFERENCE DESC;
