#!/bin/bash

# Nom du fichier Makefile
FILE=Makefile

# Nom du programme à compiler (modifiable)
NAME=my_program

# Dossier contenant les sources
SRC_DIR=src

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

