use GestionC;
GO


--Application 2----------------Procédure Stockée avec paramètres en sortie/Valeur de retour----------------
--Question 1
Create or alter Procedure Nbr_ArtCom @NumCom int, @Nbr int output 
as 
Set @Nbr = (Select count(NumArt) from Com_Art where NumCom=@NumCom) 
--Exécuter cette procédure pour afficher le nombre d'articles de la commande numéro 1 : 
Declare @n int 
Exec Nbr_ArtCom 1, @n Output 
Print 'Le nombre d''articles de la commande numéro 1 est : ' + convert(varchar,@n)

--Ou bien
Declare @nc int, @nb int 
Set @nc=1 
Exec Nbr_ArtCom @nc, @nb Output 
Print 'Le nombre d''articles de la commande numéro ' + convert(varchar,@nc) + ' est : ' + 
convert(varchar,@nb)
go

---Question 2, Après ajout de l'attribut MtArt dans la table Com_Art
Create OR alter Procedure Montant_C @NumCom int, @MontantC float output  
as 
Select  @MontantC  =sum(MtArt) from Com_Art CA where @NumCom= NumCom;
Print concat ('Le Montant de la commande : ', @NumCom, ' est : ',@MontantC)
--Exécuter cette procédure pour afficher le montant de chaque commande : 
Declare @v1 int =1, @v2 float;  
Exec Montant_C @v1, @v2 Output 
go

--Ou bien avec Valeur de retour (Cas Montant de type INT absolument)
create or alter procedure Montant_C1 @NumCom1 int 
as
begin
	return (select sum(MtArt) from Com_Art CA where @NumCom1= NumCom);
end
/*Exécution*/
declare @c1 int;
exec @c1 =Montant_C1 1
select @c1 as 'Montant'
go


---Question 3: En calculant la somme
Create or alter Procedure Type_Montant @NumCom int as 
Declare @MntCom1 int 
Set @MntCom1 = (select sum(MtArt) from Com_Art where @NumCom= NumCom) 
	If @MntCom1 >=10000 
	Return 1
	If @MntCom1 <=10000 
	Return 2 
	If @@ERROR <>0  --@@ERROR renvoie 0 si l'instruction n'a rencontré aucune erreur.
	Return 3 

--Exécution 
Declare @v3 int;
Exec @v3= Type_Montant 1 ;
print @v3 
 go

--Ou bien: En faisant appel à la procédure de la Q2
Create or alter Procedure Type_Montant1 @NumCom1 int as 
Declare @Montant float
	Execute Montant_C @NumCom1, @Montant output -- ou bien Execute @Montant = Montant_C1 @NumCom1 (Absolument le montant doit être de type INT)
		If @Montant >=10000 
			Return 1
		If @Montant <=10000 
			Return 2 
		If @@ERROR <>0  
			Return 3 

--Exécution 
Declare @v5 int;
Exec @v5= Type_Montant1 1 ;
print @v5 
go





