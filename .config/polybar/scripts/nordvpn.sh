#!/bin/bash


regex="Status: (\w+)"
status=`nordvpn status`
if [[ $status =~ $regex ]]; then
	if [[ ${BASH_REMATCH[1]} == "Connected" ]]; then
		OPTIONS="\tDisconnect"
		LINES=1
	else
		OPTIONS="\tAlbania\n\tGreece\n\tPortugal\n\tArgentina\n\tHong_Kong\n\tRomania\n\tAustralia\n\tHungary\n\tRussia\n\tAustria\n\tIceland\n\tSerbia\n\tBelgium\n\tIndia\n\tSingapore\n\tBosnia_And_Herzegovina\n\tIndonesia\n\tSlovakia\n\tBrazil\n\tIreland\n\tSlovenia\n\tBulgaria\n\tIsrael\n\tSouth_Africa\n\tCanada\n\tItaly\n\tSouth_Korea\n\tChile\n\tJapan\n\tSpain\n\tCosta_Rica\n\tLatvia\n\tSweden\n\tCroatia\n\tLuxembourg\n\tSwitzerland\n\tCyprus\n\tMacedonia\n\tTaiwan\n\tCzech_Republic\n\tMalaysia\n\tThailand\n\tDenmark\n\tMexico\n\tTurkey\n\tEstonia\n\tMoldova\n\tUkraine\n\tFinland\n\tNetherlands\n\tUnited_Kingdom\n\tFrance\n\tNew_Zealand\n\tUnited_States\n\tGeorgia\n\tNorway\n\tVietnam\n\tGermany\n\tPoland"
		LINES=20
	fi
fi

ROFI=`echo -e $OPTIONS | rofi -dmenu -i -lines $LINES -font "Roboto Mono for Powerline 9" -columns 1 -width 18 -location 3 -yoffset 56 -dpi 180 -p NordVPN -color-window '#ff282c34, #00000000, #00000000' -color-normal '#ff282c34, #99666666, #ff282c34, #22ffffff, #99e5c07b' | awk '{print $1}'`

echo $ROFI

if [ ${#ROFI} -gt 0 ]; then
    case $ROFI in
    Disconnect)
        nordvpn disconnect
        ;;
	Albania)
		nordvpn c Albania
		;;
	Greece)
		nordvpn c Greece
		;;
	Portugal)
		nordvpn c Portugal
		;;
	Argentina)
		nordvpn c Argentina
		;;
	Hong_Kong)
		nordvpn c Hong_Kong
		;;
	Romania)
		nordvpn c Romania
		;;
	Australia)
		nordvpn c Australia
		;;
	Hungary)
		nordvpn c Hungary
		;;
	Russia)
		nordvpn c Russia
		;;
	Austria)
		nordvpn c Austria
		;;
	Iceland)
		nordvpn c Iceland
		;;
	Serbia)
		nordvpn c Serbia
		;;
	Belgium)
		nordvpn c Belgium
		;;
	India)
		nordvpn c India
		;;
	Singapore)
		nordvpn c Singapore
		;;
	Bosnia_And_Herzegovina)
		nordvpn c Bosnia_And_Herzegovina
		;;
	Indonesia)
		nordvpn c Indonesia
		;;
	Slovakia)
		nordvpn c Slovakia
		;;
	Brazil)
		nordvpn c Brazil
		;;
	Ireland)
		nordvpn c Ireland
		;;
	Slovenia)
		nordvpn c Slovenia
		;;
	Bulgaria)
		nordvpn c Bulgaria
		;;
	Israel)
		nordvpn c Israel
		;;
	South_Africa)
		nordvpn c South_Africa
		;;
	Canada)
		nordvpn c Canada
		;;
	Italy)
		nordvpn c Italy
		;;
	South_Korea)
		nordvpn c South_Korea
		;;
	Chile)
		nordvpn c Chile
		;;
	Japan)
		nordvpn c Japan
		;;
	Spain)
		nordvpn c Spain
		;;
	Costa_Rica)
		nordvpn c Costa_Rica
		;;
	Latvia)
		nordvpn c Latvia
		;;
	Sweden)
		nordvpn c Sweden
		;;
	Croatia)
		nordvpn c Croatia
		;;
	Luxembourg)
		nordvpn c Luxembourg
		;;
	Switzerland)
		nordvpn c Switzerland
		;;
	Cyprus)
		nordvpn c Cyprus
		;;
	Macedonia)
		nordvpn c Macedonia
		;;
	Taiwan)
		nordvpn c Taiwan
		;;
	Czech_Republic)
		nordvpn c Czech_Republic
		;;
	Malaysia)
		nordvpn c Malaysia
		;;
	Thailand)
		nordvpn c Thailand
		;;
	Denmark)
		nordvpn c Denmark
		;;
	Mexico)
		nordvpn c Mexico
		;;
	Turkey)
		nordvpn c Turkey
		;;
	Estonia)
		nordvpn c Estonia
		;;
	Moldova)
		nordvpn c Moldova
		;;
	Ukraine)
		nordvpn c Ukraine
		;;
	Finland)
		nordvpn c Finland
		;;
	Netherlands)
		nordvpn c Netherlands
		;;
	United_Kingdom)
		nordvpn c United_Kingdom
		;;
	France)
		nordvpn c France
		;;
	New_Zealand)
		nordvpn c New_Zealand
		;;
	United_States)
		nordvpn c United_States
		;;
	Georgia)
		nordvpn c Georgia
		;;
	Norway)
		nordvpn c Norway
		;;
	Vietnam)
		nordvpn c Vietnam
		;;
	Germany)
		nordvpn c Germany
		;;
	Poland)
		nordvpn c Poland
		;;
    esac
fi

