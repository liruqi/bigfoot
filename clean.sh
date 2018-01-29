#Clean up for mage branch
rm -rfv Interface/AddOns/BigFootBank
rm -rfv Interface/AddOns/TheBurningTrade
rm -rfv Interface/AddOns/MySlot
rm -rfv Interface/AddOns/TUnitFrame
rm -rfv Interface/AddOns/BagBrother
rm -rfv Interface/AddOns/Bagnon*
rm -rfv Interface/AddOns/Combuctor
git add -A Interface/AddOns/
git commit -m "Clean up"

git clone https://github.com/Tga123/premade-filter
rm -rfv premade-filter/.git
rm -rfv Interface/AddOns/premade-filter
mv premade-filter Interface/AddOns
git add -A Interface/AddOns/
#git commit -m "Update premade-filter"
#git push


