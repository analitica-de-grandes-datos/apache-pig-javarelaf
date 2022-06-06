/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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

sep_data = FOREACH data GENERATE mayus, FLATTEN(TOKENIZE(minus,',')) as minu, FLATTEN(TOKENIZE(claves,',')) as clave; 

clean_data = FOREACH sep_data GENERATE REPLACE (minu,'([^a-zA-Z\\s]+)','') as minu, REPLACE (clave,'([^a-zA-Z\\s]+)','') as clave;

tuple_data = FOREACH clean_data GENERATE TOTUPLE(minu,clave) as tupla; 

grouped_data = GROUP tuple_data BY tupla; 

count_data = FOREACH grouped_data GENERATE group, COUNT(tuple_data); 


STORE count_data INTO 'output/' USING PigStorage(',');
