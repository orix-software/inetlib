
ORICUTRON_PATH="/mnt/c/Users/plifp/OneDrive/oric/oricutron_wsl/oricutron"
# mkdir build/bin/ -p
# cl65 -o build/bin/file -ttelestrat src/file.c
# cl65 -o 1000 -ttelestrat src/file.c --start-addr \$800
# cl65 -o 1256 -ttelestrat src/file.c --start-addr \$900
# deps/orix-sdk/bin/relocbin.py3 -o build/bin/file -2 1000 1256

cl65 -ttelestrat --include-dir src/include tests/inet_aton.c inet.lib -o 1000 --start-addr \$800
cl65 -ttelestrat --include-dir src/include tests/inet_aton.c inet.lib -o 1256 --start-addr \$900
dependencies/orix-sdk/bin/relocbin.py3 -o inetaton -2 1000 1256

#cl65 -ttelestrat --include-dir src/include tests/inet_aton.c  inet.lib -o inetaton

cp inetaton $ORICUTRON_PATH/SDCARD/BIN/inetaton
cp tests/test.sub $ORICUTRON_PATH/SDCARD//etc/autoboot
cd $ORICUTRON_PATH
./oricutron
cd -

