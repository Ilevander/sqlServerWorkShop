use GestionC;
GO


--Application 1----------PS sans/avec paramètres en entrée-----------------------
--Question 1:
Create or alter Procedure Liste_Articles as 
Select NumArt, DesArt from Article ;
--Exécuter cette procédure : 
Exec Liste_Articles 
GO

--Question 2:
Create or alter Procedure NbrArt_ParCom as 
Select C.NumCom, DatCom, Count(NumArt) as 'Nbre Articles'
	From Commande C inner join Com_Art CA On C.NumCom = CA.NumCom 
	Group by C.NumCom, DatCom 
--Exécuter cette procédure : 
Exec NbrArt_ParCom
GO

--Question 3 :
Create or alter Procedure Com_Periode (@DateD Date, @DateF Date) as 
Select * from Commande Where datcom between @dateD and @DateF 
--Exécution pour afficher la liste des commandes effectuées entre le 
--10/1/2020 et le 10/1/2021 : 
Exec Com_Periode '10/1/2020', '10/1/2021' 

--Ou bien : en déclarant des variables à passer en exécution
Declare @dd Date, @df Date 
Set @dd='10/1/2020' 
Set @df='10/1/2021' 
Exec Com_Periode @dd, @df
GO

--Question 4 :
Create or alter Procedure TypeCom_Periode (@DateD Date, @DateF Date) as 
Exec Com_Periode @DateD, @DateF 
Declare @nbr int 
Set @nbr=(Select count(NumCom) from Commande Where DatCom between @dateD and @DateF) 
	If @nbr >100 
	 Print 'Période Rouge' 
	Else if @nbr<50 
	 Print 'Période blanche' 
	Else 
	 Print 'Période Jaune' 
/*Exécution*/
Exec TypeCom_Periode '10/1/2020', '10/1/2021' 
GO

--Autre manière de faire l'exercice 4: Avec la variable système ROWCOUNT
Create or alter Procedure TypeCom_Periode1 @DateD Date, @DateF Date as 
Exec Com_Periode @DateD, @DateF 
	If @@ROWCOUNT >100 
	Print 'Période Rouge' 
		Else if @@ROWCOUNT<50
		Print 'Période blanche' 
			Else 
			Print 'Période Jaune' 
go
Exec TypeCom_Periode1 '10/1/2020', '10/1/2021' 
go



------------------------------------------------------------------------
-----------Exemple d'utilisation de Procédures Système
sp_help liste_commandes ;
go
sp_helptext liste_commandes ; 
go
sp_depends SP_NbrArtParCom ; 
go
sp_depends Commande ; 
GO










