/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            mayus:chararray,
            minus:chararray,
            claves:int          
        ); 

filtered_data = FOREACH data GENERATE minus;

filtered_minus = FOREACH filtered_data GENERATE FLATTEN(TOKENIZE(minus)) as letra; 

filtered_letras = FILTER filtered_minus BY (letra MATCHES '.*[a-z].*');

grouped_letra = GROUP filtered_letras BY letra; 

count_letras= FOREACH grouped_letra GENERATE group, COUNT(filtered_letras); 


STORE count_letras INTO 'output/' USING PigStorage(',');