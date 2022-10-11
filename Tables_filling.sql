USE food_delivery_service;

INSERT INTO partners (title, description, address) VALUES
	('Burger King', 'Home of the whopper', '050060 Almaty, Nazarbayev prospect 100/4'),
	('Dodo', 'pizza chain No. 1 in Kazakhstan', 'Rozybakiev Street 247A, Almaty 050060'),
	('Bisquit', 'Confectionery house', '050000 Almaty, Makataev street 28/1');

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	('Meat mix', '30 cm, traditional dough, 550 g', 4500, 'https://cdn-irec.r-99.com/sites/default/files/product-images/1388923/ADQuq2g9wy1MyUmKrLBw.jpg', (SELECT id FROM partners WHERE title = 'Dodo')),
	('Cheese and ham', '35 cm, fluffy dough, 680 g', 6500, 'https://cdn-irec.r-99.com/sites/default/files/product-images/1388923/ADQuq2g9wy1MyUmKrLBw.jpg', (SELECT id FROM partners WHERE title = 'Dodo')),
	('Vegetables and mushrooms', '32 cm, traditional dough, 590 g', 4200, 'https://cdn-irec.r-99.com/sites/default/files/product-images/1388923/ADQuq2g9wy1MyUmKrLBw.jpg', (SELECT id FROM partners WHERE title = 'Dodo')),
	('Big King', 'burger with 2 beef patties, pickles and Iceberg lettuce leaves under the signature royal sauce.', 2600, 'https://burgerking.kz/uploads/menuproducts/image/big_1628580655.png', (SELECT id FROM partners WHERE title = 'Burger King')),
	('Steakhouse', 'Hearty beef burger with cheese and crispy onions in a corn bun with barbecue sauce.', 2300, 'https://burgerking.kz/uploads/menuproducts/image/big_1628580764.png', (SELECT id FROM partners WHERE title = 'Burger King')),
	('Long chicken', 'A hearty burger with crispy lettuce leaves and tender chicken fillet.', 1900, 'https://burgerking.kz/uploads/menuproducts/image/big_1628581076.png', (SELECT id FROM partners WHERE title = 'Burger King')),
	('Milk girl cake', 'An amazing combination of air cakes based on condensed milk and a delicate layer of Cream Cheese with natural whipped cream.', 6500, 'https://www.biscuit.kz/image/catalog/28.08.2020/IMG_7509.jpg', (SELECT id FROM partners WHERE title = 'Bisquit')),
	('Honey cake', 'Fragrant, incredibly soft honey cakes are salted with cream from natural whipped cream, combined to create a delicious taste.', 5500, 'https://www.biscuit.kz/image/catalog/31.08.2020/IMG_6477.jpg', (SELECT id FROM partners WHERE title = 'Bisquit')),
	('Napoleon Cake', 'Airy, crispy puff pastry made of high-grade flour and sour-butter of the French line is layered with delicious custard with vanilla.', 8000, 'https://www.biscuit.kz/image/catalog/31.08.2020/IMG_6463.jpg', (SELECT id FROM partners WHERE title = 'Bisquit'));

INSERT INTO clients (phone, name, surname) VALUES
	('+77071231235', 'Bruce', 'Vylez'),
	('+77010079412', 'Steven', 'S sigoi'),
	('+77279340231', 'Jean-Claude', 'Vandal');

INSERT INTO orders (
	create_at,
	address,
	latitude,
	longitude,
	status,
	client_id
) VALUES (
	NOW(),
	'Markov St 30',
	43.230762,
	76.928872,
	'new',
	(SELECT id FROM clients WHERE name = 'Bruce')
), (
	NOW(),
	'Markov St 30',
	43.230762,
	76.928872,
	'completed',
	(SELECT id FROM clients WHERE name = 'Bruce')
), (
	NOW(),
	'Markov St 30',
	43.230762,
	76.928872,
	'completed',
	(SELECT id FROM clients WHERE name = 'Bruce')
), (
	NOW(),
	'Satpaev St 100',
	42.23234,
	76.12341,
	'delivered',
	(SELECT id FROM clients WHERE name = 'Steven')
), (
	NOW(),
	'Satpaev St 100',
	42.23234,
	76.12341,
	'new',
	(SELECT id FROM clients WHERE name = 'Steven')
), (
	NOW(),
	'Abay Pr 210',
	42.352233,
	75.234523,
	'delivered',
	(SELECT id FROM clients WHERE name = 'Jean-Claude')
), (
	NOW(),
	'Abay Pr 210',
	42.352233,
	75.234523,
	'in_processing',
	(SELECT id FROM clients WHERE name = 'Jean-Claude')
), (
	NOW(),
	'Abay Pr 210',
	42.352233,
	75.234523,
	'delivered',
	(SELECT id FROM clients WHERE name = 'Jean-Claude')
);

INSERT INTO positions_orders (order_id, position_id) VALUES
	(1, 2),
	(1, 3),
	(1, 1),
	(2, 4),
	(2, 5),
	(3, 1),
	(3, 3),
	(4, 5),
	(4, 4),
	(5, 9),
	(5, 7),
	(6, 9),
	(6, 8),
	(7, 6),
	(8, 1),
	(8, 3);

INSERT INTO partners (title, description, address) VALUES
	('Test partner', 'Test desctiption', 'test address');

INSERT INTO positions (title, description, price, photo_url, partner_id) VALUES 
	('test position', 'Test desctiption', 0, 'test url', (SELECT id FROM partners WHERE title = 'Test partner'));