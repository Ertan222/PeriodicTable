#! /bin/bash

PSQL="psql -X -U freecodecamp -d periodic_table -t -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
  RESULT_FOR_USER=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius 
    FROM elements INNER JOIN properties 
    USING(atomic_number) 
    INNER JOIN types USING(type_id) 
    WHERE atomic_number = $1 ")
    if [[ -z $RESULT_FOR_USER ]]
    then
      echo "I could not find that element in the database."
    else
    NAME=$(echo $RESULT_FOR_USER | awk '{print $3}')
    SYMBOL=$(echo $RESULT_FOR_USER | awk '{print $5}')
    TYPE=$(echo $RESULT_FOR_USER | awk '{print $7}')
    ATOMIC_MASS=$(echo $RESULT_FOR_USER | awk '{print $9}')
    MELT_POINT_CELS=$(echo $RESULT_FOR_USER | awk '{print $11}')
    BOL_POINT_CELS=$(echo $RESULT_FOR_USER | awk '{print $13}')
    echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT_CELS celsius and a boiling point of $BOL_POINT_CELS celsius."
    fi
  else
  RESULT_FOR_USER=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius 
    FROM elements INNER JOIN properties 
    USING(atomic_number) 
    INNER JOIN types USING(type_id) 
    WHERE name='$1' OR symbol='$1' ")
    if [[ -z $RESULT_FOR_USER ]]
    then
      echo "I could not find that element in the database."
    else
    ATOMIC_NUMBER=$(echo $RESULT_FOR_USER | awk '{print $1}')
    NAME=$(echo $RESULT_FOR_USER | awk '{print $3}')
    SYMBOL=$(echo $RESULT_FOR_USER | awk '{print $5}')
    TYPE=$(echo $RESULT_FOR_USER | awk '{print $7}')
    ATOMIC_MASS=$(echo $RESULT_FOR_USER | awk '{print $9}')
    MELT_POINT_CELS=$(echo $RESULT_FOR_USER | awk '{print $11}')
    BOL_POINT_CELS=$(echo $RESULT_FOR_USER | awk '{print $13}')
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT_CELS celsius and a boiling point of $BOL_POINT_CELS celsius."
    fi
  fi
fi
