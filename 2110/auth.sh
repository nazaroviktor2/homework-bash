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
            fswebcam -r 640x480 --jpeg 85 -D 1 ./photos/$login-"$(date)".jpg
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

#if [[ $login == *' '* ]]
#then
#  echo в логине не может быть пробела
#else
#  if [[ $password == *' '* ]]
#  then
#      echo в пароле не может быть пробела
#  else
#    echo none
#  fi
#
#fi



#
#if [[ -f $DATABASE ]]
#then
#  echo $DATABASE exist
#  cat $DATABASE
#else
#  echo $login $password >> database
#fi

# dev/video/0


#exec 2> log_error
#DATABASE=./database
#auth=0
#echo "Введите ваш логин "
#read   login
#
#if [[ $login == *' '* ]]
#then
#  echo пользователь не найден +
#else
#    if [[ -f $DATABASE ]]
#    then
#      IFO="\n"
#      while read line
#      do
#        user=($line)
#        if [[ ${user[0]} == $login ]]
#        then
#          i=1
#          while [[ i -lt 4 ]]
#
#           do
#            echo "Введите ваш пароль"
#            read -p "dsadsa" password
#            if [[ $password == ${user[1]} ]]
#            then
#                i=4
#                echo Вы вошли
#            else
#              echo Не верный пароль. Попробуйте еще раз. Осталось попыток $((3-$i))
#
#            fi
#          i=$(( $i + 1))
#          done
#          if [[ $auth -eq 0 ]]
#          then
#            echo улыбочку
#          fi
#          break
#        fi
#      done < $DATABASE
#  else
#    echo пользователь не найден
#  fi
#  if [[ $auth -eq 0 ]]
#  then
#    echo пользователь не найден -
#  fi
#fi
