USE food_delivery_service;

SELECT o.id ,c.phone ,p.title  FROM  partners p
	INNER JOIN positions p2 ON p.id = p2.partner_id 
	INNER JOIN positions_orders po ON po.position_id = p2.id 
	INNER JOIN orders o ON o.id = po.order_id 
	INNER JOIN clients c ON c.id = o.client_id;

SELECT p.id, p.title FROM partners p
	WHERE NOT EXISTS (SELECT * FROM positions_orders po INNER JOIN positions p2 ON p2.id = po.position_id WHERE p2.partner_id = p.id);

SELECT p.title FROM clients c 
	INNER JOIN orders o on o.client_id = c.id 
	INNER JOIN positions_orders po on po.order_id = o.id 
	INNER JOIN positions p on p.id = po.position_id 
	WHERE c.id = 1 AND o.id = 3;
	