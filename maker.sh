#!/bin/bash

FILE="Makefile"

echo "Quel est le nom du programme (ex: a.out) :"
read NAME

echo "Quel est le dossier contenant les sources (ex: src) :"
read SRC_DIR

if [ ! -d "$SRC_DIR" ]; then
  echo "Erreur : Le dossier '$SRC_DIR' n'existe pas !"
  exit 1
fi

echo "Quel est le dossier contenant les includes (ex: include) [laisser vide si aucun] :"
read INC_DIR

echo "Quel langage ? (c/cpp) :"
read LANG

if [ "$LANG" = "c" ]; then
  COMPILER="cc"
  FLAGS="-Wall -Wextra -Werror"
  EXT="c"
elif [ "$LANG" = "cpp" ]; then
  COMPILER="c++"
  FLAGS="-Wall -Wextra -Werror -std=c++98 -MD -MP"
  EXT="cpp"
else
  echo "Langage invalide. Choisissez 'c' ou 'cpp'."
  exit 1
fi

if [ -n "$INC_DIR" ]; then
  if [ ! -d "$INC_DIR" ]; then
    echo "Erreur : Le dossier '$INC_DIR' n'existe pas !"
    exit 1
  fi

  for dir in $(find "$INC_DIR" -type d); do
    FLAGS="$FLAGS -I$dir"
  done
fi

SRC=$(find "$SRC_DIR" -name "*.$EXT" | tr '\n' ' ')
OBJ_DIR="obj"

# Crée le Makefile
cat << EOF > $FILE
NAME = $NAME
SRC = $SRC
OBJ_DIR = $OBJ_DIR
OBJS = \$(SRC:%.${EXT}=\$(OBJ_DIR)/%.o)
CC = $COMPILER
CFLAGS = $FLAGS

all: \$(NAME)

\$(NAME): \$(OBJS)
	\$(CC) \$(OBJS) -o \$(NAME)

\$(OBJ_DIR)/%.o: %.${EXT}
	@mkdir -p \$(@D)
	\$(CC) \$(CFLAGS) -c \$< -o \$@

EOF

# Ajoute la gestion des dépendances pour le C++
if [ "$LANG" = "cpp" ]; then
  echo "-include \$(OBJS:.o=.d)" >> $FILE
fi

# Ajoute les règles clean, fclean et re
cat << EOF >> $FILE

clean:
	rm -rf \$(OBJ_DIR)

fclean: clean
	rm -f \$(NAME)

re: fclean all

.PHONY: all clean fclean re
EOF

echo "✅ Makefile créé avec succès dans le répertoire : $(pwd)/$FILE"
