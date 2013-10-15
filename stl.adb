
with Ada.Text_IO,Ada.Integer_Text_IO,Ada.Float_Text_IO,Algebre;
use Ada.Text_IO,Ada.Integer_Text_IO,Ada.Float_Text_IO , Algebre;

package body STL is


	-- true si on trouve le mot M dans S
   	-- false sinon
   	function TrouveMot (S : String ; M : String) return boolean is
   		IndexM : Natural := 0 ; -- indice de M
   		UnMot : String(1 .. 30) ;
   		LongeurMot : Natural := 0 ;
   		Trouve : boolean := false ;
		subtype lettre is Character range 'A' .. 'z';
   	begin
   		for I in Natural range 1 .. S'Length loop
   			if S(I) in lettre then
   				IndexM := IndexM +1 ;
   				UnMot(IndexM) := S(I) ;
   				--Put(" lette ") ;
   			end if ;
   			if S(I) not in lettre or I = S'Length then
   				LongeurMot := IndexM ;
				IndexM := 0 ;
				--Put(" non lettre ") ;
				if UnMot(1 .. LongeurMot) = M then
					-- Put(" trouve le mot ") ;
					Trouve := true ;
				end if ;
   			end if ;

   			
   		end loop;
   		return Trouve ;
   	end;


	function Nombre_Facettes(Nom_Fichier : String) return Natural is
		F : File_Type;
		Nb : Natural := 0;
   	begin
		Open(File => F, Mode => In_File, Name => Nom_Fichier);
		-- a faire : compter les facettes (p.ex. chercher les "endloop")...
		while not End_Of_File (F) loop
			declare 
				uneLigne : String := Get_Line(F);
			begin
				if TrouveMot(uneLigne, "endloop") then
					Nb := Nb + 1 ;
				end if;
			end;
		end loop;
		Close(F);
		return Nb;
   	end;


   	function litVertex (S: String) return Vecteur is
   		Car : Character ;
		TrouveChiffre : boolean := false ;
		Val : float := 0.0 ;
		IndexV : Natural := 0 ; --indice de vecteur
		Vec : Vecteur(1..3);
		Negative : boolean := false ;
		PartieDecimal : boolean := false ;
		puissanceDecimal : Natural := 0 ;
   		subtype chiffre is Character range '0' .. '9' ;
   	begin
   		for j in Natural range 1 .. S'Length loop
			Car := S(j) ;
			case Car is
				when chiffre =>
					TrouveChiffre := true ;
					if PartieDecimal then
					puissanceDecimal := puissanceDecimal + 1 ;
						Val := Val + (float(Character'Pos(Car) - Character'Pos('0')))*(0.1**puissanceDecimal);
					else
						Val := Val*10.0 + float(Character'Pos(Car) - Character'Pos('0'));
					end if;

				when '-' =>
					Negative := true ;
					
				when '.' =>
					PartieDecimal := true ;
					
				when others =>
					null;
			end case;

			if TrouveChiffre then
				if Car = ' ' or j = S'Length then
					if Negative then
						Val := 0.0 - Val ;
					end if;
					IndexV := IndexV + 1;
					Vec(IndexV) := Val ;

					--Reinitialiser les variables
					Val := 0.0 ;
					puissanceDecimal := 0 ;
					TrouveChiffre := false;
					Negative := false ;
					PartieDecimal := false ;
				end if ;
			end if;

		end loop;
		return Vec ;
   	end;



	function Chargement_ASCII(Nom_Fichier : String) return Maillage is
		Nb_Facettes : Natural;
		M : Maillage;
		F : File_Type;
		IndexF : Natural := 0 ; -- indice de tableau_facette
		IndexV : Natural := 0 ; -- indice de vertex d'un facette . 1:P1, 2:P2, 3:P3
	begin
		Nb_Facettes := Nombre_Facettes(Nom_Fichier);
		-- une fois qu'on a le nombre de facettes on connait la taille du maillage
		M := new Tableau_Facette(1..Nb_Facettes);
		-- on ouvre de nouveau le fichier pour parcourir les facettes
		-- et remplir le maillage
		Open(File => F, Mode => In_File, Name => Nom_Fichier);
		while not End_Of_File(F) loop
			
			declare 
				Vec : Vecteur(1..3) ;
				
				L : String := Get_Line(F);
				
				
				
			begin
				if TrouveMot(L,"facet") then

					IndexF := IndexF + 1 ;
					--facette IndexF

				end if ;

				if TrouveMot(L, "vertex") then
					IndexV := IndexV +1 ;
					Vec := litVertex(L);
					case IndexV is
						when 1 =>
							M(IndexF).P1 := Vec;
						when 2 =>
							M(IndexF).P2 := Vec;
						when others =>
							M(IndexF).P3 := Vec;
							IndexV:= 0;
					end case;
				
				end if;
			end;
		end loop;
		Close (F);
		return M;
	end;

end;
