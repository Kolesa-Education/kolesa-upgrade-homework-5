/*

1

*/

INSERT INTO Partners(id, title, address)
VALUES(0, "Partner1", "Partner1 st.");

INSERT INTO Partners(id, title, address)
VALUES(1, "Partner2", "Partner2 st.");

INSERT INTO Partners(id, title, address)
VALUES(2, "Partner3", "Partner3 st.");
--

INSERT INTO Positions(id, title, partner_id)
VALUES(0, "Pos1 Partner1", 0);

INSERT INTO Positions(id, title, partner_id)
VALUES(1, "Pos2 Partner1", 0);

INSERT INTO Positions(id, title, partner_id)
VALUES(2, "Pos3 Partner1", 0);


INSERT INTO Positions(id, title, partner_id)
VALUES(3, "Pos1 Partner2", 1);

INSERT INTO Positions(id, title, partner_id)
VALUES(4, "Pos2 Partner2", 1);

INSERT INTO Positions(id, title, partner_id)
VALUES(5, "Pos3 Partner2", 1);


INSERT INTO Positions(id, title, partner_id)
VALUES(6, "Pos1 Partner3", 2);

INSERT INTO Positions(id, title, partner_id)
VALUES(7, "Pos2 Partner3", 2);

INSERT INTO Positions(id, title, partner_id)
VALUES(8, "Pos3 Partner3", 2);

--


INSERT INTO Clients(id, phone)
VALUES(0 ,'123456789012');

INSERT INTO Clients(id, phone)
VALUES(1, '098765432109');

INSERT INTO Clients(id, phone)
VALUES(2, '123098745609');


--



INSERT INTO Orders(id, client_id)
VALUES(0, 0);

INSERT INTO Orders(id, client_id)
VALUES(1, 1);
INSERT INTO Orders(id, client_id)
VALUES(2, 1);


INSERT INTO Orders(id, client_id)
VALUES(3, 2);
INSERT INTO Orders(id, client_id)
VALUES(4, 2);


INSERT INTO PositionsOrders(id, position_id, order_id)
VALUES(0, 3, 0);

INSERT INTO PositionsOrders(id, position_id, order_id)
VALUES(1, 1, 0);

INSERT INTO PositionsOrders(id, position_id, order_id)
VALUES(2, 4, 1);

INSERT INTO PositionsOrders(id, position_id, order_id)
VALUES(3, 8, 2);


/*

2

*/

SELECT po.order_id, c.phone, p.title FROM PositionsOrders as po
INNER JOIN Orders as o ON po.order_id = o.id
INNER JOIN Clients as c ON o.client_id = c.id
INNER JOIN Positions as p ON po.position_id = p.id;



/*

3

*/

INSERT INTO Partners(id, title, address)
VALUES(3, "Partner4", "Partner4 st.");

INSERT INTO Positions(id, title, partner_id)
VALUES(9, "Pos1 Partner4", 3);

INSERT INTO Positions(id, title, partner_id)
VALUES(10, "Pos2 Partner4", 3);

SELECT id FROM Partners
WHERE id NOT IN (
SELECT p.id FROM PositionsOrders as po
INNER JOIN Positions as pos on po.position_id = pos.id
INNER JOIN Partners as p on pos.partner_id = p.id);


/*

4

*/

SELECT pos.title FROM PositionsOrders as po
INNER JOIN Orders as o ON po.order_id = o.id
INNER JOIN Clients as c ON o.client_id = c.id
INNER JOIN Positions as pos ON po.position_id = pos.id
WHERE c.id = 1 AND o.id = 2;