/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

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

filtered_data = FOREACH data GENERATE claves;

sep_clave = FOREACH filtered_data GENERATE FLATTEN(TOKENIZE(claves)) as clave; 

filtered_claves = FOREACH sep_clave GENERATE REPLACE (clave,'([^a-zA-Z\\s]+)','') as clave;

grouped_clave = GROUP filtered_claves BY clave; 

count_claves= FOREACH grouped_clave GENERATE group, COUNT(filtered_claves); 


STORE count_claves INTO 'output/' USING PigStorage(',');
