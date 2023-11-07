CREATE TABLE clilent (
    NumCli INT PRIMARY KEY,
    AdrCli VARCHAR(255)
);
CREATE TABLE produits (
    NumProd INT PRIMARY KEY,
    Price DECIMAL(10,2)
);
CREATE TABLE commandes (
    NumCom INT PRIMARY KEY,
    DateCom DATE
);

CREATE TABLE conteneur_assoc (
    NumCom INT,
    NumProd INT,
    Qty INT,
    PRIMARY KEY (NumCom, NumProd),
    FOREIGN KEY (NumCom) REFERENCES commandes(NumCom),
    FOREIGN KEY (NumProd) REFERENCES produits(NumProd)
);

SELECT *
FROM clilent;

SELECT *
FROM produits;

SELECT *
FROM commandes;

SELECT ca.NumCom, c.NumCli, c.AdrCli, p.NumProd, p.Price, ca.Qty
FROM conteneur_assoc ca
JOIN clilent c ON c.NumCli = ca.NumCli
JOIN produits p ON p.NumProd = ca.NumProd;


