/* Напишите запрос, который будет выводить номера заказов(их ИД), 
номер телефонов клиентов, название партнера.*/

SELECT o.id, c.phone, pa.title FROM positions_orders po 
LEFT JOIN Positions p on p.id = po.position_id
LEFT JOIN Partners pa on pa.id = p.partner_id
LEFT JOIN Orders o on o.id = po.order_id
LEFT JOIN Clients c on c.id = o.client_id;


/*Добавьте еще одного партнера и минимум 1 позицию для него. Но 
не создавайте заказы. Сделайте запрос, который выведет
таких партнеров, у которых еще не было ни одного заказа*/
INSERT INTO Partners (title, description, address)
VALUES 
    ("McDonalds", "Fast food restaurant chain, main focus burgers", "Kabanbay batyr 58, Astana"),
    ("Perchini", "Italian pasta center", "Turan 25, Astana");



INSERT INTO Positions (title, description, price, photo_url, partner_id)
VALUES 
    ("Cheesburger", "Steak frombeef, cheese, caramelized bun, seasoned mustard", 950, 
    "https://mcdonalds.kz/storage/2500/84a1faa6bd4b2721096a9d777b0f575cd490505b.png", 
    (SELECT id FROM Partners WHERE title = "McDonalds")),
    ("Bolognese", "Slow cooked with a soffritto of onions, carrots, and celery, tomatoes, and milk ", 1565, 
    "https://hips.hearstapps.com/hmg-prod/images/delish-bolognese-horizontal-1-1540572556.jpg", 
    (SELECT id FROM Partners WHERE title = "Perchini"));


SELECT pa.* FROM Partners pa 
WHERE pa.id NOT IN (
    SELECT pa.id FROM positions_orders po 
    LEFT JOIN Positions p on p.id = po.position_id
    LEFT JOIN Partners pa on pa.id = p.partner_id
);

/*Напишите запрос, который по ID пользователя и ID 
заказа выведет названия всех позиций из этого заказа.*/

SELECT p.title FROM positions_orders po 
INNER JOIN Orders o on o.id = po.order_id and o.id = 1  -- ID заказа
INNER JOIN Clients c on c.id = o.client_id and c.id = 1 -- ID клиента
INNER JOIN Positions p on p.id = po.position_id;


