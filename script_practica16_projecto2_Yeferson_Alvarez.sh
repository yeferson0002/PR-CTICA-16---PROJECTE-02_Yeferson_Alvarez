#!/bin/bash
# Asegúrese de que el script se ejecute con privilegios de superusuario.
if [[ "${UID}" -eq 0 ]]
then
	echo "Tienes privilegios"
		# Si el usuario no proporciona al menos un argumento, bríndele ayuda.
		if [[ "$1" = '' ]]
		then
			echo  "ayuda de uso : ./script_practica16.sh pepe (Esto añadira el nombre)"
		exit
		fi

		# El primer parámetro es el nombre de usuario.
		if [[ -n $1 ]]
		then
			echo "Este es el nombre de usuario : "$1

		fi
		user=$1
	# El resto de los parámetros son para los comentarios de la cuenta.
	coment=$2

	# Genera una contraseña.
	password=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10)
	# Crear el usuario con la contraseña.
	useradd -m {$user} -p {$password} -c {$coment}
	echo "tu contraseña es :"$password
	# Verifique si el comando useradd tuvo éxito.
	cat /etc/passwd | grep ${user}
	if [[ $? -eq 0 ]]
	then
		echo "La creacion del usuario y la introduccion de la contraseña es correcta"
	else
		echo "La creacion no ha sido satisfactoria"
		exit 1
	fi
	# Establecer la contraseña.
	echo "Dame la contraseña"
	read -s password2
	echo {$user}":"{$password2} | chpasswd
	# Verifique si el comando passwd tuvo éxito.
	if [[ $? -eq 0 ]]
        then
                echo "La contraseña se ha establecido de forma correcta"
        else
                echo "La creacion no ha sido satisfactoria"
        	exit 1
        fi

	# Forzar cambio de contraseña en el primer inicio de sesión.
	echo "En el primer inicio te hemos dado la contraseña, pero has de cambiarla"
	read -s password3
	echo {$user}":"{$password3} | chpasswd
	# Mostrar th
else
	echo "No tienes privilegios"

fi
