with STL, Algebre, Ada.Float_Text_IO, Ada.Text_IO ; use STL, Algebre, Ada.Text_IO, Ada.Float_Text_IO ; 
procedure lireF is
fichier : String := "cubeTest.stl";
nb : Natural ;
M : Maillage ;
v :Vecteur(1..3);
f: Facette ;
s : String := "vertex -44.438179 0.000000 0.250926";

begin

	--nb := Nombre_Facettes(fichier);
M := Chargement_ASCII(fichier);

For i in Natural range 1 .. M'Length loop
	f:= M(i);
	
	Put ("Facette");
	New_Line;
	v := f.P1 ;
	Put(" Vecteur P1 " & Float'Image(v(1)) & " " & Float'Image(v(2)) & " " & Float'Image(v(3)));
	New_Line;
	v := f.P2 ;
	Put(" Vecteur P2 " & Float'Image(v(1)) & " " & Float'Image(v(2)) & " " & Float'Image(v(3)));
	New_Line;
	v := f.P3 ;
	Put(" Vecteur P3 " & Float'Image(v(1)) & " " & Float'Image(v(2)) & " " & Float'Image(v(3)));
	New_Line;
end loop;

-- v := litVertex(s);
-- Put(" float trouve : " & Float'Image(v(1)));
-- New_Line;
-- Put(" float trouve : " & Float'Image(v(2)));
-- New_Line;
-- Put(" float trouve : " & Float'Image(v(3)));
-- New_Line;
end;
