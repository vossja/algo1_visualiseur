with Ada.Text_IO, Ada.Command_Line;
use Ada.Text_IO, Ada.Command_Line ;

package body SeqCarM1 is

   Interactif: Boolean ;
   -- Interactif = True <=> on lit sur l'entree standard

   Texte: File_Type ;
   Car : Character ;
   Est_Fin : Boolean := True ;

   Anomalie: exception ;

   procedure SelectInput is
   begin
      if Argument_Count=0 then
         Interactif := True ;
         return ;
      end if ;
      if Argument_Count > 1 then
         Put_Line("### Attention: trop d'arguments sur la ligne de commandes") ;
      end if ;
      Open(Texte, In_File, Argument(1)) ;
      Set_Input(Texte) ;
      Interactif:=False ;
   exception
      when Status_Error => Put_Line("### Fichier """ &  Argument(1) & """ deja ouvert") ;
         raise ;
      when Name_Error => Put_Line("### Fichier """ &  Argument(1) & """ inexistant") ;
         raise ;
      when Use_Error => Put_Line("### Fichier """ &  Argument(1) & """ interdit en lecture") ;
         raise ;
   end ;

   procedure DemCar is
   begin
      if not Est_Fin then
         raise Anomalie ;
      end if ;
      Est_Fin := False ;
      SelectInput ;
      AvCar;
   end ;

   procedure AvCar is
   begin
      if Est_Fin then
         raise Anomalie ;
      end if ;
      Get_Immediate(Car) ;
      if Interactif then
         Put(Car) ;
      end if ;
      Est_Fin := False ;
   exception
      when End_Error =>
         if Interactif then
            Put_Line("<EOF>") ;
         end if ;
	 Est_Fin :=True ;   
   end ;

   function CarCour return Character is
   begin
      if Est_Fin then
         raise Anomalie ;
      end if ;
      return Car ;
   end ;

   function FinCar return Boolean is
   begin
      return Est_Fin ;
   end ;

   procedure StopCar is
   begin
      if not Interactif then
         Close(Texte) ;
         Set_Input(Standard_Input) ;
      end if;
      Est_Fin := True ;
   end ;

end SeqCarM1 ;
