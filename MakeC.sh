#!/bin/bash

# --- CONFIGURATION ---

FILE="Makefile"

# Demande à l’utilisateur le nom du programme
echo "Quel est le nom du programme (ex: a.out): "
read NAME

# Demande le dossier contenant les sources
echo "Quel est le dossier contenant les sources (ex: src): "
read SRC_DIR

# Vérifie si le dossier existe
if [ ! -d "$SRC_DIR" ]; then
  echo "Erreur: Le dossier '$SRC_DIR' n'existe pas !"
  exit 1
fi

# Demande le dossier des includes (optionnel)
echo "Quel est le dossier contenant les includes (ex: include) [appuyez sur Entrée si aucun]: "
read INC_DIR

# Demande le langage (C ou C++)
echo "Quel langage ? (c/cpp) : "
read LANG

# Définit le compilateur et les flags
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

# Ajoute les includes s’ils existent
if [ -n "$INC_DIR" ]; then
  if [ ! -d "$INC_DIR" ]; then
    echo "Erreur: Le dossier '$INC_DIR' n'existe pas !"
    exit 1
  fi
  FLAGS="$FLAGS -I./$INC_DIR"
fi

# Trouve les sources
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

