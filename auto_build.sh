#! /bin/bash

echo -e "\n-------------------------------"
echo -e "| remove build & dependency... |"
echo -e "-------------------------------\n"
flutter clean
flutter pub get

echo -e "\n--------------------------"
echo -e "| build and run server... |"
echo -e "--------------------------\n"
flutter build web --release
python3 -m http.server 8080 -d ./build/web

exit 0