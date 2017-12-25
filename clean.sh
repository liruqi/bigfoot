rm -rfv Interface/AddOns/BigFootBank
rm -rfv Interface/AddOns/TheBurningTrade
rm -rfv Interface/AddOns/MySlot
rm -rfv Interface/AddOns/TUnitFrame
rm -rfv Interface/AddOns/BagBrother
rm -rfv Interface/AddOns/Bagnon*
rm -rfv Interface/AddOns/Combuctor
git add -A Interface/AddOns/
git commit -m "Clean up"

#https://www.curseforge.com/wow/addons/premade-filter
wget https://addons-origin.cursecdn.com/files/2497/976/premade-filter-2.1.0.zip
unzip premade-filter-2.1.0.zip
rm Interface/AddOns/premade-filter
mv premade-filter Interface/AddOns
git add -A Interface/AddOns/
git commit -m "Add suggested"
git push


