create database ecommerce ;
use ecommerce ;
--------------------------------------------------Clients---------------------------------------------------------------------------
--creation table clients :
create table client (
id_clt int identity(1,1) ,
prenom varchar(15),
nom varchar(15),
tél varchar(13),
email  varchar(50),
rue  varchar(40),
ville  varchar(20),
etat varchar(30) , 
code_postal varchar(30),
constraint pk_client primary key(id_clt));

--Constraint sur la table client
ALTER TABLE client
ADD CONSTRAINT CK_client 
CHECK (LEN(code_postal) = 5 AND code_postal LIKE '[0-9][0-9][0-9][0-9][0-9]');
go
ALTER TABLE client
ADD CONSTRAINT CK_client_tél CHECK (LEFT(tél, 4) = '+212' AND LEN(tél) = 13);

--l'insertion a la table client
INSERT INTO client (prenom, nom, tél, email, rue, ville, etat, code_postal)
    VALUES ('Rania', 'AKOURROU', '+212601234565', 'Rania.akourrou@gmail.com', 'Rue 1', 'Agadir', 'Sous-Massa', '80000'),
           ('Meryem', 'Iantrine', '+212098765432', 'Meryem.iantrin@gmail.com', 'Rue2', 'Marseille', 'Provence-Alpes-Côte d Azur', '13000'),
           ('Salma', 'Faouzi', '+212701234567', 'salma.faouzi@gmail.com', 'Rue 3', 'Nice', 'Provence-Alpes-Côte d Azur', '06000');

select * from client
---------------------------------------------------Magasins----------------------------------------------------------------------------
--table Magasin :
create table magasins (
id_mgs int identity(1,1),
nom_mgs varchar(20),
tel_mgs varchar(13),
email_mgs varchar(30),
rue_mgs varchar(30),
ville_mgs varchar(30),
etat_mgs varchar(20),
code_postal_mgs varchar(30),
constraint pk_magasins  primary key(id_mgs));

--constraint sur le code postal + tel  :
ALTER TABLE magasins
ADD CONSTRAINT CK_magasins 
CHECK (LEN(code_postal_mgs) = 5 AND code_postal_mgs LIKE '[0-9][0-9][0-9][0-9][0-9]');
go
ALTER TABLE magasins
ADD CONSTRAINT CK_magasins_tél CHECK (LEFT(tel_mgs, 4) = '+212' AND LEN(tel_mgs) = 13);

--l'insertion sur la table magasins :
INSERT INTO magasins (nom_mgs, tel_mgs, email_mgs, rue_mgs, ville_mgs, etat_mgs, code_postal_mgs)
VALUES
('Magasin A', '+212601234567', 'magasina@gmail.com', 'Rue 4', 'Agadir', 'Actif', '12345'),
('Magasin B', '+212709876543', 'magasinb@gmail.com', 'Rue 5', 'Rabat', 'Actif', '54321');

select * from magasins
--------------------------------------------------Employés----------------------------------------------------------------------------------
--creation de la table employé :
CREATE TABLE employé (
 id_emp INT identity(1,1),
  nom_emp VARCHAR(50),
  prenom_emp VARCHAR(50),
  email_emp VARCHAR(50),
  tel_emp VARCHAR(13),
  active bit,
  id_mgs INT,
  manager_id INT,
  photo_emp varchar(100),
  constraint pk_employé  primary key(id_emp),
  constraint fk1_employé  foreign key(id_mgs)references magasins(id_mgs));
--constrainte sur tel : 

  Alter table employé
ADD CONSTRAINT CK_employé_tél CHECK (LEFT(tel_emp, 4) = '+212' AND LEN(tel_emp) = 13);

--insertion dans la table employé :
INSERT INTO employé (nom_emp, prenom_emp, email_emp, tel_emp, active, id_mgs, manager_id,photo_emp)
VALUES ('Ayoub', 'Salim', 'ayoub.salim@gmail.com', '+212601234565', 1, 2, NULL,'employe/i1.avif'),
       ('Mehdi', 'Abdel', 'Mehdi.abdel.com', '+212098765432', 1, 2, 1,'employe/i2.avif'),
       ('Mery', 'Seham', 'Mery.Seham@gmail.com', '+212701234567', 0, 2, 1,'employe/i3.jpg');


select * from employé ;
-----------------------------------------------Commandes-------------------------------------------------------------------------------------
--creation de la table commande :
create table commande (
  id_cmd int identity(1,1),
  statut varchar(20),
  date_commande  date,
  date_requise date ,
  date_expedition date,
  id_mgs int,
   id_emp int,
   id_clt int,
   constraint pk_commande  primary key(id_cmd),
   constraint fk1_commande  foreign key(id_mgs)references magasins(id_mgs),
   constraint fk2_commande  foreign key(id_emp)references employé(id_emp),
   constraint fk3_commande  foreign key(id_clt)references client(id_clt));

--constraint check sur le statut de la commande
alter table commande
add constraint CK_commande CHECK (statut IN ('En cours', 'Livré', 'Annulé'))
--constraint check sur les dates de la table commande

alter table commande
add CONSTRAINT ck_date_commande CHECK (date_commande <= date_requise)

  alter table commande
  add CONSTRAINT ck_date_expedition CHECK (date_commande <= date_expedition)

  --insertion 
  INSERT INTO commande (statut, date_commande, date_requise, date_expedition, id_mgs, id_emp, id_clt)
VALUES 
('En cours', '2024-05-16', '2024-05-20', NULL, 1, 1, 1),
('En cours', '2024-05-17', '2024-05-21', NULL, 2, 2, 2),
('Livré', '2024-05-18', '2024-05-22', '2024-05-20', 1, 3, 3),
('Annulé', '2024-05-19', Null, NULL, 2, 1, 1);
select *from commande
  --------------------------------------------Catégories ---------------------------------------------------------------------------------
  --creation de la table catégorie :
   create table catégorie (
   id_cat int identity(1,1) ,
   nom_cat varchar(20),
  constraint pk_catégorie primary key(id_cat)
   );
--insertion a la table catégorie
INSERT INTO catégorie (nom_cat) VALUES
('Rouge à levre'),
('Mascara'),
('Fond de teint'),
('Fard à paupieres'),
('Eyeliner'),
('Gloss'),
('Crayon à levres'),
('Correcteur'),
('Poudre'),
('Vernis à ongles');
select * from catégorie ;
--------------------------------------------Marque-------------------------------------------------------------------------------------
--creation de la table marque
     create table marque (
   id_mrq int identity (1,1),
   nom_mrq varchar(30),
   constraint pk_marquee primary key(id_mrq)
  );
--insertion a la table marque

insert into marque values('Flormar'),('Mac'),('Yan one'),('Channel'),('Essence'),('Dior');

select * from marque
-------------------------------------------Produits----------------------------------------------------------------------------------
--creation de la table  produit
   create table produit (
   id_pdt int identity(1,1),
   nom_pdt varchar(20),
   id_mrq int ,
   id_cat int ,
   année_modele date,
   liste_prix decimal(6,2),
   photo varchar(100),
   constraint pk_produit primary key(id_pdt),
   constraint fk1_produit foreign key(id_mrq)references marque(id_mrq),
   constraint fk2_produit foreign key(id_cat)references catégorie(id_cat)
)
--insertion :
INSERT INTO produit (nom_pdt, id_mrq, id_cat, année_modele, liste_prix,photo)
VALUES
('Rouge a levre ', 1, 1, '2001-01-01', 100,'maquillage/1.webp'),
('Mascara ', 5, 2, '2000-02-01', 50,'maquillage/2.jpg'),
('Fond de teint visage', 6, 3, '2001-01-01', 600,'maquillage/3.jpg'),
('Verni ', 3,10 , '2000-02-01', 15,'maquillage/17.jpg');

select * from produit ;
---------------------------------------Stocke ----------------------------------------------------------------------------------------
--creation de la table stocke :
create table stocke (
id_mgs int,
id_pdt int ,
qte int,
constraint pk_stocke primary key(id_mgs,id_pdt),
constraint fk1_stocke foreign key(id_mgs)references magasins(id_mgs),
constraint fk2_stocke foreign key(id_pdt)references produit(id_pdt));

--constraint sur la quantité  :
Alter table stocke
add constraint ck_stocke_qte  CHECK (qte >= 0)

--l'insertion :
INSERT INTO stocke (id_mgs, id_pdt, qte) VALUES
(2, 1, 200), 
(1, 2, 180),
(2,3,150),
(1,4,100);

select * from stocke ;
-------------------------------------Articles Commandés-------------------------------------------------------------------------------

-- Créer une fonction pour calculer le prix total de l'article
CREATE FUNCTION montant_produit (@id_pdt int, @qte int)
RETURNS decimal(6,2)
AS
BEGIN
    DECLARE @prix decimal(6,2);
    SELECT @prix = liste_prix * @qte
    FROM produit
    WHERE id_pdt = @id_pdt;

    RETURN @prix;
END;
GO
--creation de la table article commandé  :

CREATE TABLE article_commandé(
    id_cmd int,
    id_article int identity(1,1),
    id_pdt int,
    qte_article int,
    montant_produit as dbo.montant_produit(id_pdt, qte_article),
    remise decimal(6,2),
    constraint pk_article_commandé primary key(id_cmd,id_article),
    constraint fk1_article_commandé foreign key(id_cmd) references commande(id_cmd),
    constraint fk2_article_commandé foreign key(id_pdt) references produit(id_pdt)
);
--constrainte sur la quntité
Alter table article_commandé
add constraint ck_stocke_qte_ar  CHECK (qte_article >= 0)
--insertion :
INSERT INTO article_commandé (id_cmd, id_pdt, qte_article, remise)
VALUES 
(1, 1, 2, 0.00), 
(1, 2, 1, 0.00),
(2, 3, 3, 0.00),
(3, 3, 3, 0.00), 
(3, 4, 1, 0.00),
(4, 1, 1, 0.00);
select * from article_commandé

----------------------------------------Admin --------------------------------------------------------------------------------------------------
--creation de la table admin 
CREATE TABLE admine (
    id_adm INT IDENTITY(1,1) PRIMARY KEY,
    nom_adm VARCHAR(50),
    prenom_adm VARCHAR(50),
    email_adm VARCHAR(50),
    mot_de_passe VARCHAR(50),
   
);

----constraint de mdp : 
ALTER TABLE admine
ADD CONSTRAINT chk_password1 CHECK (LEN(mot_de_passe)<= 8 );
ALTER TABLE admine
ADD CONSTRAINT chk_password2 CHECK (mot_de_passe LIKE '%[A-Z]%' AND
                                              mot_de_passe LIKE '%[a-z]%' AND
                                              mot_de_passe LIKE '%[0-9]%' AND
                                              mot_de_passe LIKE '%[^A-Za-z0-9]%');

----insertion :
Insert into admine values ('Jhone','Paul','jhone@gmail.com','Paul123!');
select * from admine

---------------------------------------------------------Trigers ---------------------------------------------------------------------------------------
--trigger sur la quantité stock : 
	CREATE TRIGGER update_stock
ON article_commandé
AFTER INSERT
AS
BEGIN
    DECLARE @id_pdt INT;
    DECLARE @qte_article INT;
    
    SELECT @id_pdt = id_pdt, @qte_article = qte_article
    FROM inserted;
    
    UPDATE stocke
    SET qte = qte - @qte_article
    WHERE id_pdt = @id_pdt;
END;
-----------------------------------
--Trigger si la commande est annulé
CREATE TRIGGER annulation1_commande
ON commande
AFTER INSERT, UPDATE
AS
BEGIN
    IF UPDATE(statut)
    BEGIN
        -- Si le nouveau statut est 'Annulé'
        IF EXISTS (SELECT 1 FROM inserted WHERE statut = 'Annulé')
        BEGIN
            -- Mise à jour des dates d'expédition et requise à NULL pour les commandes annulées
            UPDATE commande
            SET date_expedition = NULL, date_requise = NULL
            FROM commande c
            JOIN inserted i ON c.id_cmd = i.id_cmd
            WHERE i.statut = 'Annulé';
        END
        -- Si le nouveau statut est 'Livré'
        ELSE IF EXISTS (SELECT 1 FROM deleted WHERE statut = 'Livré')
        BEGIN
            PRINT 'Modification du statut de "Livré" en "Annulé" non autorisée.';
        END
    END
END;
---Test:
insert into commande values ('En cours','2024-05-15','2024-05-20','2024-05-22',2,1,3)
INSERT INTO article_commandé (id_cmd, id_pdt, qte_article, remise) VALUES (5, 1, 2, 0.00)
select * from commande

update commande 
set statut='Annulé'
where id_cmd=5
select * from commande
-----------------------
--trigger de la remise :





--trigger qui check le stock  + insertion si la condition et vrai :
CREATE TRIGGER trg_check_stock
ON article_commandé
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @id_pdt INT, @qte_article INT, @qte_stock INT;
    SELECT @id_pdt = id_pdt, @qte_article = qte_article FROM inserted;
    SELECT @qte_stock = qte FROM stocke WHERE id_pdt = @id_pdt;
    IF @qte_article > @qte_stock
    BEGIN
        print('Quantité en stock insuffisante');
    END
    ELSE
    BEGIN
        INSERT INTO article_commandé (id_cmd, id_pdt, qte_article, remise)
        SELECT id_cmd, id_pdt, qte_article, remise FROM inserted
    END
END
 --test :
INSERT INTO article_commandé (id_cmd, id_pdt, qte_article, remise) VALUES (1, 4, 200, 0.00);
-----------------------------------------------------------------Procedure : ------------------------------------------------------------------------
-----------------------------------------------
--------Procedure de gestion Employé :---------
create PROCEDURE GestionE (
    @Action VARCHAR(10), -- Action à effectuer (Ajouter, Update, Désactiver, Supprimer)
    @IdEmp INT = NULL, 
    @NomEmp VARCHAR(50) = NULL,
    @PrenomEmp VARCHAR(50) = NULL,
    @EmailEmp VARCHAR(50) = NULL,
    @TelEmp VARCHAR(15) = NULL,
    @Active BIT = NULL,
    @IdMgs INT = NULL ,
	@photo_emp varchar(100)=Null
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Ajouter'
    BEGIN
        INSERT INTO employé (nom_emp, prenom_emp, email_emp, tel_emp, active, id_mgs,photo_emp)
        VALUES (@NomEmp, @PrenomEmp, @EmailEmp, @TelEmp, @Active, @IdMgs,@photo_emp);
    END
    ELSE IF @Action = 'Update'
    BEGIN
        UPDATE employé
        SET nom_emp = @NomEmp,
            prenom_emp = @PrenomEmp,
            email_emp = @EmailEmp,
            tel_emp = @TelEmp,
            active = @Active,
            id_mgs = @IdMgs,
			photo_emp=@photo_emp
        WHERE id_emp = @IdEmp;
    END
    ELSE IF @Action = 'Désactiver'
    BEGIN
        UPDATE employé
        SET active = 0
        WHERE id_emp = @IdEmp;
    END
    ELSE IF @Action = 'Supprimer'
    BEGIN
        DELETE FROM employé
        WHERE id_emp = @IdEmp;
    END
    ELSE
    BEGIN
       PRINT 'Action non valide.';
        RETURN;
    END
END;
--test : 
-- Ajouter un nouvel employé :
EXEC GestionE 'Ajouter', @NomEmp = 'Smith', @PrenomEmp = 'Alice', @EmailEmp = 'alice.smith@gmail.com', @TelEmp = '+212609876543', @Active = 1, @IdMgs = 2,@photo_emp='employe/i1.jpg';
-- Désactiver un employé
EXEC GestionE'Désactiver', @IdEmp = 4;
--Mettre a jour un employé
EXEC GestionE 'Update', 4, 'Doe', 'Jane', 'jane.doe@gmail.com', '+212609876543', 1, 2,'employe/i2.jpg';
-- Supprimer un employé
EXEC GestionE 'Supprimer', @IdEmp = 4;

select * from employé;

-----------------------------------------------
--------Procedure de gestion Clients :---------
select * from client
go
create PROCEDURE GestionClient (
    @Action VARCHAR(10), -- Action à effectuer (Ajouter, Update, Désactiver, Supprimer)
    @IdClient INT = NULL, 
    @Prenom VARCHAR(15)= NULL,
    @Nom VARCHAR(15)= NULL,
    @Tel VARCHAR(15)= NULL,
    @Email VARCHAR(50)= NULL,
    @Rue VARCHAR(40)= NULL,
    @Ville VARCHAR(20)= NULL,
    @Etat VARCHAR(30)= NULL,
    @CodePostal VARCHAR(30)= NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Ajouter'
    BEGIN
        INSERT INTO client (prenom, nom, tél, email, rue, ville, etat, code_postal)
        VALUES (@Prenom, @Nom, @Tel, @Email, @Rue, @Ville, @Etat, @CodePostal);
    END
    ELSE IF @Action = 'update'
    BEGIN
        UPDATE client
        SET prenom = @Prenom,
            nom = @Nom,
            tél = @Tel,
            email = @Email,
            rue = @Rue,
            ville = @Ville,
            etat = @Etat,
            code_postal = @CodePostal
        WHERE id_clt = @IdClient;
    END
    
    ELSE IF @Action = 'Supprimer'
    BEGIN
        DELETE FROM client
        WHERE id_clt = @IdClient;
    END
    ELSE
    BEGIN
        PRINT 'Action non valide.';
        RETURN;
    END
END;
go

--Test :
-- Ajouter un nouveau client :
EXEC GestionClient 'Ajouter', NULL, 'Salim', 'Hunter', '+212701234555','Salim.Hunter@gmail.com' , '15 Rue ', 'Paris', 'Provence-Alpes-Côte d Azur', '67890';
select * from client
-- Mettre à jour les informations :
EXEC GestionClient 'update', 4, 'Salima', 'Hunter',  '+212609876543','Salim.Hunter@gmail.com', '25 Rue ', 'Tanger', 'Tanger', '09876';
-- Supprimer un client :
EXEC GestionClient 'Supprimer', 4;


select * from client


-----------------------------------------------
--------Procedure de gestion Produits :---------
create PROCEDURE GestionProduit
    @Action VARCHAR(10), 
    @IdPdt INT = NULL, 
    @NomPdt VARCHAR(50)= NULL,
    @IdMrq INT= NULL, 
    @IdCat INT= NULL, 
    @AnneeModele DATE= NULL,
	@liste_prix decimal(6,2)= NULL,
    @photo varchar(100)= NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Ajouter'
    BEGIN
        INSERT INTO produit (nom_pdt, id_mrq, id_cat, année_modele, liste_prix,photo)
        VALUES (@NomPdt, @IdMrq, @IdCat, @AnneeModele, @liste_prix, @photo);
    END
    ELSE IF @Action = 'update'
    BEGIN
        UPDATE produit
        SET nom_pdt = @NomPdt,
            id_mrq = @IdMrq,
            id_cat = @IdCat,
            année_modele = @AnneeModele,
            liste_prix = @Liste_Prix,
           photo=@photo
        WHERE id_pdt = @IdPdt;
    END
  
    ELSE IF @Action = 'Supprimer'
    BEGIN
        DELETE FROM produit
        WHERE id_pdt = @IdPdt;
    END
    ELSE
    BEGIN
        PRINT 'Action non valide.';
        RETURN;
    END
END;

--Test :
-- Ajouter un nouveau produit
EXEC GestionProduit 'Ajouter', NULL, 'Gloss repulpant', 6, 6, '2024-01-01', 100.00,'maquillage/14.jpg'
select* from produit
-- Mettre à jour un produit existant
EXEC GestionProduit 'update', 5, 'Glosse repulpant', 6, 6, '2024-02-02', 90.00,'maquillage/14.jpg'
select* from produit


-- Supprimer un produit
EXEC GestionProduit 'Supprimer', 5;
select* from produit


-----------------------------------------------
--------Procedure de gestion Marque :---------
CREATE PROCEDURE GestionMarque
    @Action VARCHAR(10), 
    @IdMrq INT = NULL, 
    @NomMrq VARCHAR(50) = NULL 
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Ajouter'
    BEGIN
        INSERT INTO marque (nom_mrq)
        VALUES (@NomMrq);
    END
    ELSE IF @Action = 'update'
    BEGIN
        UPDATE marque
        SET nom_mrq = @NomMrq
        WHERE id_mrq = @IdMrq;
    END
  
    ELSE IF @Action = 'Supprimer'
    BEGIN
        DELETE FROM marque
        WHERE id_mrq = @IdMrq;
    END
    ELSE
    BEGIN
        PRINT 'Action non valide.';
        RETURN;
    END
END;

--Test :
-- Ajouter une marque
EXEC GestionMarque 'Ajouter', NULL, 'Fenty1';
select * from marque
-- Mettre à jour une marque
EXEC GestionMarque 'update', 7, 'Fenty Beauty';
select * from marque

-- Supprimer une marque
EXEC GestionMarque 'Supprimer', 7;
select * from marque




-----------------------------------------------
--------Procedure de gestion Catégorie  :---------
CREATE PROCEDURE GestionCatégorie
    @Action VARCHAR(10), 
    @IdCat INT = NULL, 
    @NomCat VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Action = 'Ajouter'
    BEGIN
        INSERT INTO catégorie (nom_cat)
        VALUES (@NomCat);
    END
    ELSE IF @Action = 'update'
  

    BEGIN
        UPDATE catégorie
        SET nom_cat=@NomCat
        WHERE id_cat = @IdCat;
    END
    ELSE IF @Action = 'Supprimer'
    BEGIN
        DELETE FROM catégorie
        WHERE id_cat = @IdCat;
    END
    ELSE
    BEGIN
        PRINT 'Action non valide.';
        RETURN;
    END
END;

--test :
-- Ajouter une catégorie
EXEC GestionCatégorie 'Ajouter', NULL, 'Catégorie1';
select * from catégorie
-- Mettre à jour une catégorie
EXEC GestionCatégorie 'update', 11, 'NouvelleCatégorie';
select * from catégorie

-- Supprimer une catégorie
EXEC GestionCatégorie 'Supprimer', 11;
select * from catégorie



-------------------------------------------------------------Functions : ----------------------------------------------------------------------------------------
--1 -montant total de la commande :
CREATE FUNCTION montant_total_commande (@id_commande INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @montant_total DECIMAL(10, 2);
    SELECT @montant_total = SUM(ac.montant_produit)
    FROM article_commandé ac
    WHERE ac.id_cmd = @id_commande;
    RETURN @montant_total;
END;
select  dbo.montant_total_commande (1) as 'Montant totale'

--2 - Verifier stock :
CREATE FUNCTION VerifierStock(@id_pdt INT, @qte_demandee INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @message VARCHAR(100);

    DECLARE @qte_en_stock INT;
    
    SELECT @qte_en_stock = qte
    FROM stocke
    WHERE id_pdt = @id_pdt;

    IF @qte_en_stock >= @qte_demandee
        SET @message = 'La quantité en stock est suffisante.';
    ELSE
        SET @message = 'La quantité en stock est insuffisante.';

    RETURN @message;
END;
go

DECLARE @message VARCHAR(100);
SET @message = dbo.VerifierStock(3, 200);
SELECT @message AS Message;
--3- nombre total de commande passer pas le client :

CREATE FUNCTION nombre_cmd_clt (@id_client INT)
RETURNS INT
AS
BEGIN
    DECLARE @nombre_commandes INT;
    SELECT @nombre_commandes = COUNT(*)
    FROM commande
    WHERE id_clt = @id_client;
    RETURN @nombre_commandes;
END;
select  dbo.nombre_cmd_clt (1) as 'Nombre Commandes'
----------------------------------------------Views---------------------------------------------------------------------
--Vue pour afficher le stock des produits dans chaque magasin :
CREATE VIEW vue_stock AS
SELECT s.id_mgs, s.id_pdt, p.nom_pdt, s.qte,
       m.nom_mgs, m.ville_mgs
FROM stocke s
JOIN produit p ON s.id_pdt = p.id_pdt
JOIN magasins m ON s.id_mgs = m.id_mgs;
select * from vue_stock ;

--vue detaile des commandes :
create VIEW Details_commandes AS
SELECT cmd.id_cmd, cmd.statut, cmd.date_commande, cmd.date_requise, cmd.date_expedition,
       clt.nom +'  '+ clt.prenom AS 'Client',
       emp.nom_emp +'  '+emp.prenom_emp AS 'Employé',
       mgs.nom_mgs AS nom_magasin,
       dbo.montant_total_commande(cmd.id_cmd) AS montant_total_commande
FROM commande cmd
JOIN client clt ON cmd.id_clt = clt.id_clt
JOIN employé emp ON cmd.id_emp = emp.id_emp
JOIN magasins mgs ON cmd.id_mgs = mgs.id_mgs;

select * from  Details_commandes ;
--vue pour afficher plus de detaille sur commande :
create VIEW commande_client as
SELECT 
    cmd.id_cmd,
    clt.nom+'  '+clt.prenom as nom_client,
    p.nom_pdt AS nom_produit,
    ac.qte_article AS quantité,
    dbo.montant_produit(ac.id_pdt, ac.qte_article) AS prix_total
FROM commande cmd
JOIN client clt ON cmd.id_clt = clt.id_clt
JOIN article_commandé ac ON cmd.id_cmd = ac.id_cmd
JOIN produit p ON ac.id_pdt = p.id_pdt;

SELECT * FROM commande_client;
--vue pour afficher les produits :
CREATE VIEW vue_produits AS
SELECT 
    p.id_pdt,
    p.nom_pdt AS nom_produit,
    c.nom_cat AS catégorie,
    m.nom_mrq AS marque,
    s.qte AS quantité_stockée,
    p.liste_prix AS prix
FROM produit p
JOIN catégorie c ON p.id_cat = c.id_cat
JOIN marque m ON p.id_mrq = m.id_mrq
JOIN stocke s ON p.id_pdt = s.id_pdt;

SELECT * FROM vue_produits;
--total des ventes pour chaque employé :
CREATE VIEW ventes_employes AS
SELECT emp.id_emp, emp.nom_emp, emp.prenom_emp,
       SUM(ac.montant_produit) AS montant_total_ventes
FROM employé emp
LEFT JOIN commande cmd ON emp.id_emp = cmd.id_emp
LEFT JOIN article_commandé ac ON cmd.id_cmd = ac.id_cmd
                               AND cmd.statut != 'Annulé'
GROUP BY emp.id_emp, emp.nom_emp, emp.prenom_emp;

select * from ventes_employes ;



