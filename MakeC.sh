#!/bin/bash

FILE=Makefile

# Nom du programme à compiler (modifiable)
# NAME=my_program
echo "Quel est le nom du programme (ex: a.out): "
read NAME

# Dossier contenant les sources
# SRC_DIR=src
echo "Quel est le dossier contenant les sources (ex: src): "
read SRC_DIR

# Cherche les fichiers .c dans SRC_DIR (récursif)
SRC=$(find $SRC_DIR -name "*.c" | tr '\n' ' ')

# Crée le Makefile
cat << EOF > $FILE
NAME = $NAME
SRC = $SRC
OBJ = \$(SRC:.c=.o)
CC = cc
CFLAGS = -Wall -Wextra -Werror

all: \$(NAME)

\$(NAME): \$(OBJ)
	\$(CC) \$(CFLAGS) \$(OBJ) -o \$(NAME)

clean:
	rm -f \$(OBJ)

fclean: clean
	rm -f \$(NAME)

re: fclean all

.PHONY: all clean fclean re
EOF

echo "Makefile créé avec succès !"

