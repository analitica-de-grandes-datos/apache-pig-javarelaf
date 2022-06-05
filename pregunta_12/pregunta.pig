/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.csv' USING PigStorage(',')
    AS (
            index:int,
            name:chararray,
            lastn:chararray,
            birth:chararray,
            color:chararray,
            num:int          
        ); 

filtered_data = FILTER data BY STARTSWITH(lastn,'D') OR 
 STARTSWITH(lastn,'E') OR 
 STARTSWITH(lastn,'F') OR
 STARTSWITH(lastn,'G') OR
 STARTSWITH(lastn,'H') OR
 STARTSWITH(lastn,'I') OR
 STARTSWITH(lastn,'J') OR
 STARTSWITH(lastn,'K'); 

selected_data = FOREACH filtered_data GENERATE index, TOTUPLE(lastn) as lastn;

ordered_data = ORDER filtered_data BY index asc;

final_data = FOREACH ordered_data GENERATE lastn;

STORE final_data INTO 'output/' USING PigStorage(',');
