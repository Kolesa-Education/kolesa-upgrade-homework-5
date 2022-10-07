CREATE TABLE Partners (
  id INTEGER PRIMARY KEY NOT NULL,
  title varchar(150) NOT NULL,
  description TEXT,
  address varchar(255) NOT NULL
);

CREATE TABLE Positions (
  id INTEGER PRIMARY KEY NOT NULL,
  title varchar(255) NOT NULL,
  description TEXT,
  price INTEGER NOT NULL default(0),
  photo_url varchar(255),
  partner_id INTEGER,
  FOREIGN KEY (partner_id) REFERENCES Partners(id)
);

CREATE TABLE Clients(
  id INTEGER PRIMARY KEY NOT NULL,
  phone char(12),
  fullname varchar(255)
);

CREATE TABLE Orders (
  id INTEGER PRIMARY KEY NOT NULL,
  created_at datetime,
  address varchar(255),
  latitude float,
  longitude float,
  status enum('New', 'Accepted', 'In process', 'Finished'),
  client_id INTEGER,
  FOREIGN KEY (client_id) REFERENCES Clients(id)
);

CREATE TABLE PositionsOrders(
  id INTEGER PRIMARY KEY NOT NULL,
  position_id int,
  order_id int,
  FOREIGN KEY (position_id) REFERENCES Positions(id),
  FOREIGN KEY (order_id) REFERENCES Orders(id)
  
);