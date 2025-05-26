mkdir -p ~/.maker/
cp maker.sh ~/.maker/maker.sh
chmod +x ~/.maker/maker.sh

echo "alias maker='bash ~/.maker/maker.sh'" >> ~/.zshrc
source ~/.zshrc