#!/bin/bash
exec 2> log_error
DATABASE=./database


reg=false
while [ $reg == false ];
do
space=true
exist=false
while [ $space == true ]
do
    echo "Введите логин (нельзя использовать пробел)"
    read login

    if [[ $login == *' '* ]]
    then
      echo Нельзя использовать пробел
    else
      space=false
    fi
done


if [[ -f $DATABASE ]]
then
  while read line
  do
    user=($line)
    if [[ ${user[0]} == $login ]]
    then
      exist=true
    fi
  done < $DATABASE
fi

if [[ $exist == false ]]
then
  echo Введите пароль
  read -s password
  pass=$(echo -n $password | md5sum)
  echo $login $pass >> $DATABASE
  echo Вы успешно зарегистрировались
  reg=true
else
  echo такой пользователь уже существует
fi
done