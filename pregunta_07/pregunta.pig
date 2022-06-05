/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            mayus:chararray,
            minus:chararray,
            claves:chararray          
        ); 

sep_data = FOREACH data GENERATE mayus, TOKENIZE(minus,',') as minu, TOKENIZE(claves,',') as clave; 

count_data = FOREACH sep_data GENERATE mayus, (INT)COUNT(minu) as minu, (INT)COUNT(clave) as clave; 

ordered_data= ORDER count_data BY mayus asc, minu asc, clave asc; 


STORE ordered_data INTO 'output/' USING PigStorage(',');