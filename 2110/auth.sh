#!/bin/bash
exec 2> log_error
DATABASE=./database
PHOTOS=./photos
auth=0
while [ $auth -ne 1 ]
do
auth=0

echo "Введите ваш логин "
read  login

if [[ $login == *' '* ]]
then
  echo пользователь не найден
else
    if [[ -f $DATABASE ]]
    then
      while read line

      do
        user=($line)
        if [[ ${user[0]} == $login ]]
        then
          i=1
          while [[ i -lt 4 ]]
           do
            echo Введите ваш пароль
            read  -s -t 10 pass <&1
            input=$(echo -n $pass | md5sum)
            pass=($input)
            password="${pass[0]}"
            if [[ "$password" == "${user[1]}" ]]
            then
                echo Вы вошли
                i=4
                auth=1
            else
              echo Не верный пароль. Попробуйте еще раз. Осталось попыток $((3-$i))

            fi
          i=$(( $i + 1))
          done
          if [[ $auth -eq 0 ]]
          then
            echo не удачная попытка входа в аккаунт $login >&2
            echo улыбочку
            date="$(echo date)"
            if [[ ! -d $PHOTOS ]]
            then
              mkdir $PHOTOS
            fi
            path=$login-"$(date)"
            fswebcam -r 640x480 --jpeg 85 -D 1 ./photos/"$path".jpg ./photos/last.jpg
            python3 ./.send.py 
            auth=2
          fi

        fi
      done < $DATABASE
  else
    echo пользователь не найден
    auth=4
  fi
  if [[ $auth -eq 0 ]]
  then
    echo пользователь не найден
  fi
fi
done
