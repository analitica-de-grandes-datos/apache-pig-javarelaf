/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT
       firstname,
       color
   FROM 
       u 
   WHERE 
       color REGEXP '^b';

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

color_data = FILTER data BY STARTSWITH(color,'b'); 

selected_data = FOREACH color_data GENERATE name, color; 

STORE selected_data INTO 'output/' USING PigStorage(',');
